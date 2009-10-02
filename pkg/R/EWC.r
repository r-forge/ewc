ewc <- function(vnetwork){
  if (!is.matrix(vnetwork)){
    stop("Input data must be an adjacency matrix.")
  }
  if (is.matrix(vnetwork)&(dim(vnetwork)[1]!=dim(vnetwork)[2])){
    stop("Input data must be an adjacency matrix (square).")
  }
  if (sum(unique(as.vector(vnetwork)))==1){
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
