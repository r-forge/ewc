\name{ewc}
\alias{ewc}
\title{Edge-Weighted Closeness}
\description{
  Calculates edge-weighted closeness, a weighted version of closeness(sna).
}
\usage{
ewc(vnetwork,transform=TRUE)
}
\arguments{
  \item{vnetwork}{A valued adjacency matrix.}
  \item{transform}{(not implemented) Logical. If TRUE: If \code{vnetwork} is not strongly connected but weakly connected (see ?component.dist(sna)),
  \code{vnetwork} will be symmetrized using the sum of line values (see ?symmetrize.valued(ewc)).
  If \code{vnetwork} is not even weakly connected, the EWC will only be calculated for the largest weak component.
  If the largest weak component is not strongly connected, it will be symmetrized using the sume of line values.
}
\value{A vector of length \code{dim(vnetwork)[1]} (if not transformed) containing the EWC values.}
\details{The EWC is defined as:
\deqn{C_{ewc}(i)=\frac{\sum_{j}{\frac{{\rm llv}(i,j)}{d(i,j)}}}{\max(lv)(n-1)}},
where
\item{\eqn{llv(i,j)} is the average last line value on the path from node $i$ to node $j$,}
\item{\eqn{d(i,j)} is the distance from $i$ to $j$} and
\item{\eqn{\max(lv)} is the maximum of all line values in \code{vnetwork}}
}
\references{Angela Bohn, Norbert Walchhofer, Patrick Mair and Kurt Hornik.
Social Network Analysis of Weighted Telecommunications Graphs. 2009.
Research Report Series 84, Department of Statistics and Mathematics, Wirtschaftsuniversit&auml;t Wien.}
\author{Angela Bohn \email{angela.bohn@gmail.com} and Norbert Walchhofer}
\examples{
vnetwork <- rbind(c(0,2),c(3,0))
ewc(vnetwork)
}
