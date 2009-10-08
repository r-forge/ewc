\name{wdnc}
\alias{wdnc}
\title{Weighted Distance to Nearest Center}
\description{
  Calculates the weighted distance of a node to the nearest center in a network.}
\usage{
wdnc(vnetwork)}
\arguments{\item{vnetwork}{A valued adjacency matrix.}}
\value{A vector of length \code{dim(vnetwork)[1]} (if not transformed) containing the EWC values.}
\details{The WDNC is defined as:
\deqn{WDNC(i)=\left(\inf\emph{argmax}_p \sum_{j \in J_p(i)} {\rm llv}(i, j)/d(i, j)\right)-1},
$J_p(i)$ is the set of all nodes $j$ which can be reached from
vertex $i$ by a path of length $p$.
In words: The WDNC of a vertex $i$ is the neighborhood $p$ in which it gains
the maximum EWC minus 1.
If the maximum is not unique, infimum chooses the smallest $p$.
The result may be interpreted as a line-weighted distance to the nearest center.
The centers are vertices whose  WDNC is 0.}
\author{Angela Bohn \email{angela.bohn@gmail.com} and Norbert Walchhofer}
\examples{
vnetwork <- cbind(c(0,2),c(3,0))
wdnc(vnetwork)}
