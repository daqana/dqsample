##' @title Unbiased Random Samples and Permutations
##' @description These functions provide an unbiased alternative to the corresponding
##'   \code{base} functions.
##' @param x  either a vector of one or more elements from which to choose, or a positive integer.
##' @param n  a positive number, the number of items to choose from.
##' @param size	 a non-negative integer giving the number of items to choose.
##' @param replace	should sampling be with replacement?
##' @param prob	 a vector of probability weights for obtaining the elements of the vector being sampled.
##' @references Daniel Lemire (2018), Fast Random Integer Generation in an Interval,
##'   \url{https://arxiv.org/abs/1805.10941}.
##' @examples
##'   # base::sample produces very different amount of odd an even numbers
##'   m <- 2/5 * 2^32
##'   x <- sample(m, 1000000, replace = TRUE)
##'   table(x %% 2)
##' @seealso \code{\link[base]{sample}} and \code{\link[base]{sample.int}}
##' @export
sample <- function(x, size, replace = FALSE, prob = NULL) {
    if (length(x) == 1L && is.numeric(x) && is.finite(x) && x >= 1) {
        if (missing(size)) size <- x
        sample.int(x, size, replace, prob)
    } else {
        if (missing(size)) size <- length(x)
        x[sample.int(length(x), size, replace, prob)]
    }
}

##' @rdname sample
##' @export
sample.int  <- function(n, size = n, replace = FALSE, prob = NULL) {
    use_base <- FALSE
    if (!is.null(prob)) {
        warning("Weighted sampling is not supported yet. Using biased 'base::sample.int'.")
        use_base <- TRUE
    } else if (n >= 2^31) {
        warning("Long vectors are not supported yet. Using biased 'base::sample.int'.")
        use_base <- TRUE
    }

    if (use_base) {
        base::sample.int(n, size, replace, prob)
    } else
        sample_int(n, size, replace)
}
