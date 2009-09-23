# symmetrize and keep line values
# only for rule="weak" or rule="strong", otherwise use symmetrize(sna)
# by Angela Bohn

# Arguments
# network: a valued adjacency matrix
# rule: "weak" or "strong"
# mode: "max" or "sum"

# Value
# a valued symmetric adjacency matrix

symmetrize.valued <- function (vnetwork, mode="max"){
  if (!is.matrix(vnetwork)){
    stop("Input data must be an adjacency matrix (square).")
  }
  if (is.matrix(vnetwork)&(dim(vnetwork)[1]!=dim(vnetwork)[2])){
    stop("Input data must be an adjacency matrix (square).")
  }
  n <- m <- dim(vnetwork)[1]
  newmat <- vnetwork
  for (i in 1:n) {
    for (j in 1:m){
      if (mode=="max"){
        newmat[i,j] <- newmat[j,i] <- max(vnetwork[i,j],vnetwork[j,i])
      }
      if (mode=="sum"){
        newmat[i,j] <- newmat[j,i] <- vnetwork[i,j]+vnetwork[j,i]
        diag(newmat) <- diag(vnetwork)
      }
    }
  }
  newmat
}

# Example:
#a <- rbind(c(1,2),c(3,4))
#symmetrize.valued(a,rule="weak",mode="max")
#b <- rbind(c(0,1),c(0,0))
#symmetrize.valued(a,rule="weak",mode="max")