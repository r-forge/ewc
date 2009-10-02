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
