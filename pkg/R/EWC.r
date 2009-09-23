# Edge-Weighted Closeness
# by Angela Bohn and Norbert Walchhofer

# Arguments
# vnetwork: a valued adjacency matrix. Network must be recursively connected.
# transform: binary. If TRUE: If network is not recursively connected, closeness.dist will only be calculated for largest component.
  #If largest component is not recursively connected, it will be symmetrized with symmetrize.valued(network,rule="weak",mode="sum")

# Value:
# a vector of length n, where n is the number of nodes contained in vnetwork

library(sna)
source("symmetrize.valued.r")

ewc <- function(vnetwork,transform=TRUE){
  if (!is.matrix(vnetwork)){
    stop("Input data must be an adjacency matrix.")
  }
  if (is.matrix(vnetwork)&(dim(vnetwork)[1]!=dim(vnetwork)[2])){
    stop("Input data must be an adjacency matrix (square).")
  }
  if (transform==FALSE){
    if (!sna::is.connected(vnetwork,connected="recursive")){
      stop("Input network is not (recursively) connected. closeness.dist works only for (recursively) connected networks.","\n",
      "See ?component.dist(sna) or choose transform=TRUE.")
    }
  }
  if (transform==TRUE){
    if (!sna::is.connected(vnetwork,connected="recursive")){
      if (sna::is.connected(vnetwork,connected="weak")&!sna::is.connected(vnetwork,connected="recursive")){
        network <- symmetrize.valued(vnetwork,rule="weak",mode="sum")
        warning("As vnetwork is not recursively connected, it was symmetrized using the sum of line values")
      }
      if (!sna::is.connected(vnetwork,connected="weak")){
        a <- dim(vnetwork)[1]
        vnetwork <- component.largest(vnetwork,connected="weak",result="graph")
        b <- dim(vnetwork)[1]
        warning("As vnetwork is not recursively connected, closeness.dist was calculated only for largest component:","\n",
                "  ",a-b," of ",a," nodes were omitted.")
        if (!sna::is.connected(vnetwork,connected="recursive")){
          vnetwork <- symmetrize.valued(vnetwork,rule="weak",mode="sum")
          warning("As largest component of vnetwork is not recursively connected, it was symmetrized using the sum of line values")
        }
      }
    }
  }
  if (sum(unique(as.vector(vnetwork))==1)){
    warning("network is binary. Output will not be identical to closeness(sna).")
  }
  network <- vnetwork
  network[network>0] <- 1
  n <- dim(network)[1]

  # working matrices
  W <- network      # number of walks for distance i
  Sigma <- network  # last line values for ditance i-1

  # distance 1
  wd <- colSums(vnetwork, na.rm=TRUE)

  # higher distances
  i <- 2
  while(min(Sigma)==0){    # finishes when the last shortest path is taken into account
    Y <- vnetwork %*% W    # last line values for distance i
    X <- network  %*% W    # number of walks between two vertices

    # Elaboration of the no.of shortest paths for distance i
    TM <- X                # temp matrix to extract the shortest paths with length i
    TM[TM>0] <- 1
    TM <- TM-Sigma         # substract the no. of shortest paths till distance i-1
    TM[TM<0] <- 0
    # multiply the no. of shortest paths with the an indicator matrix for the shortest paths of distance
    X <- TM * X

    diag(Y) <- 0
    Z <- (Y/X)/i           # calculate the ewc for distance i
    Z[Z == "Inf" | Z == "-Inf"] <- 0

    wd <- rbind(wd,colSums(Z, na.rm=TRUE))

    Sigma <- Sigma + TM    # update no. of shortest paths till distance i for (the next cycle)
    W <- W %*% network
    i <- i + 1
  }
  wd <- wd/(max(vnetwork)*(n-1))  # standardization of centralities
  colSums(wd)
}

# Example:
#vnetwork <- rbind(c(0,2),c(3,0))
#ewc(vnetwork)
