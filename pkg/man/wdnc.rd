\name{wdnc}
\alias{wdnc}
\title{Weighted Distance to Nearest Center}
\description{
  Calculates the weighted distance of a node to the nearest center in a network.
}
\usage{
wdnc(vnetwork,transform=TRUE)
}
\arguments{
  \item{vnetwork}{A valued adjacency matrix.}
  \item{transform}{(not implemented) Logical. If TRUE: If \code{vnetwork} is not strongly connected but weakly connected (see ?component.dist(sna)),
  \code{vnetwork} will be symmetrized using the sum of line values (see ?symmetrize.valued(ewc)).
  If \code{vnetwork} is not even weakly connected, the EWC will only be calculated for the largest weak component.
  If the largest weak component is not strongly connected, it will be symmetrized using the sume of line values.
}
\value{A vector of length \code{dim(vnetwork)[1]} (if not transformed) containing the EWC values.}
\details{The WDNC is defined as:
\deqn{\mathit{WDNC}(i)=\left(\inf\argmax_p \sum_{j \in J_p(i)} {\rm llv}(i, j)/d(i, j)\right)-1},
$J_p(i)$
is the set of all nodes $j$ which can be reached from
vertex $i$ by a path of length $p$.
In words: The {\it WDNC} of a vertex $i$ is the neighborhood $p$ in which it gains
the maximum {\it EWC} minus 1.
If the maximum is not unique, infimum chooses the smallest $p$.
The result may be interpreted as a line-weighted distance to the nearest center.
The centers are vertices whose {\it WDNC} is 0.
}
\author{Angela Bohn \email{angela.bohn@gmail.com} and Norbert Walchhofer}
\examples{
vnetwork <- cbind(c(0,2),c(3,0))
wdnc(vnetwork)
}
