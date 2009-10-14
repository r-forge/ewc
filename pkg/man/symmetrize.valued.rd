\name{symmetrize.valued}
\alias{symmetrize.valued}
\title{Symmetrizes a valued matrix}
\description{
  Symmetrized a valued matrix. (\code{symmetrize(sna)} binarizes matrices).
}
\usage{
symmetrize.valued(vnetwork,mode="max")
}
\arguments{
  \item{vnetwork}{A valued adjacency matrix.}
  \item{mode}{\code{max} or \code{sum}. \code{max} takes the maximum of the two 
  line values between two nodes and \code{sum} takes the sum.}
}
\details{Corresponds to \code{symmetrize(sna)} with \code{rule="weak"}, only that result is a valued matrix.}
\value{A symmetric valued adjacency matrix.}
\author{Angela Bohn \email{angela.bohn@gmail.com} }
\examples{
a <- rbind(c(1,2),c(3,4))
symmetrize.valued(a,mode="max")
symmetrize.valued(a,mode="sum")
}
