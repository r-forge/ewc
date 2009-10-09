\name{ewc}
\alias{ewc}
\title{Edge-Weighted Closeness}
\description{
  Calculates edge-weighted closeness, a weighted version of closeness(sna).
}
\usage{
ewc(vnetwork)
}
\arguments{\item{vnetwork}{A valued adjacency matrix. Must be weakly connected}}
\value{A vector of length \code{dim(vnetwork)[1]} containing the EWC values.}
\details{The EWC is defined as:
\eqn{EWC(i)=\frac{\sum_{j}{\frac{llv(i,j)}{d(i,j)}}}{\max(lv)(n-1)}},
where
\eqn{llv(i,j)} is the average last line value on the path from node $i$ to node $j$,
\eqn{d(i,j)} is the distance from $i$ to $j$ and
\eqn{\max(lv)} is the maximum of all line values in \code{vnetwork}
}
\references{Angela Bohn, Norbert Walchhofer, Patrick Mair and Kurt Hornik.
Social Network Analysis of Weighted Telecommunications Graphs. 2009.
Research Report Series 84, Department of Statistics and Mathematics, Wirtschaftsuniversität Wien.}
\author{Angela Bohn \email{angela.bohn@gmail.com} and Norbert Walchhofer}
\examples{
vnetwork <- rbind(c(0,2),c(3,0))
ewc(vnetwork)
}