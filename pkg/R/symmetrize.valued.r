# symmetrize and keep line values
# only for rule="weak" or rule="strong", otherwise use symmetrize(sna)
# by Angela Bohn

# Arguments
# network: a valued adjacency matrix
# rule: "weak" or "strong"
# mode: "max" or "sum"

# Value
# a valued symmetric adjacency matrix

symmetrize.valued <- function (network, rule = "weak",mode="max"){
  if (!is.matrix(network)){
    stop("Input data must be an adjacency matrix (square).")
  }
  if (is.matrix(network)&(dim(network)[1]!=dim(network)[2])){
    stop("Input data must be an adjacency matrix (square).")
  }
  n <- dim(network)[1]
  m <- n
  newmat <- network
  for (i in 1:n) {
    for (j in 1:m){
      if (rule == "weak") {
        if (network[i,j]!=0|network[j,i]!=0){
          if (mode=="max"){
            newmat[i,j] <- newmat[j,i] <- max(network[i,j],network[j,i])
          }
          if (mode=="sum"){
            newmat[i,j] <- newmat[j,i] <- network[i,j]+network[j,i]
            diag(newmat) <- diag(network)
          }
        }
        if (network[i,j]==0&network[j,i]==0){
          newmat[i,j] <- newmat[j,i] <- 0
        }
      }
      if (rule == "strong") {
        if (network[i,j]!=0&network[j,i]!=0){
          if (mode=="max"){
            newmat[i,j] <- newmat[j,i] <- max(network[i,j],network[j,i])
          }
          if (mode=="sum"){
            newmat[i,j] <- newmat[j,i] <- sum(network[i,j],network[j,i])
            diag(newmat) <- diag(network)
          }
        }
        if (network[i,j]==0|network[j,i]==0){
          newmat[i,j] <- newmat[j,i] <- 0
        }
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