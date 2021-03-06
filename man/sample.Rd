% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sample.R
\name{sample}
\alias{sample}
\alias{sample.int}
\title{Unbiased Random Samples and Permutations}
\usage{
sample(x, size, replace = FALSE, prob = NULL)

sample.int(n, size = n, replace = FALSE, prob = NULL)
}
\arguments{
\item{x}{either a vector of one or more elements from which to choose, or a positive integer.}

\item{size}{a non-negative integer giving the number of items to choose.}

\item{replace}{should sampling be with replacement?}

\item{prob}{a vector of probability weights for obtaining the elements of the vector being sampled.}

\item{n}{a positive number, the number of items to choose from.}
}
\description{
These functions provide an unbiased alternative to the corresponding
  \code{base} functions.
}
\details{
Currently there is no support for weighted sampling and for long vectors.
  If such situations are encountered, the functions fall back to the equivalent functions
  in \code{base}.
}
\note{
The used algorithm needs a random 32bit unsigned integer as input. R does
  not provide an interface for such a random number. Instead \code{unif_rand()}
  returns a random double in \eqn{(0, 1)}. Internally, the result of \code{unif_rand()}
  is multiplied with \eqn{2^{32}} to produce a 32bit unsigned integer. This
  works correctly for the default generator Mersenne-Twister, since that produces
  a 32bit unsigned integer which is then devided by \eqn{2^{32}}. However, other
  generators in R do not follow this pattern so that this procedure might introduce
  a new bias.
}
\examples{
  # base::sample produces very different amount of odd an even numbers
  m <- 2/5 * 2^32
  x <- sample(m, 1000000, replace = TRUE)
  table(x \%\% 2)
}
\references{
Daniel Lemire (2018), Fast Random Integer Generation in an Interval,
  \url{https://arxiv.org/abs/1805.10941}.
}
\seealso{
\code{\link[base]{sample}} and \code{\link[base]{sample.int}}
}
