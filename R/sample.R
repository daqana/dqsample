##' @title Unbiased Random Samples and Permutations
##' @param x  either a vector of one or more elements from which to choose, or a positive integer.
##' @param n  a positive number, the number of items to choose from.
##' @param size	 a non-negative integer giving the number of items to choose.
##' @param replace	should sampling be with replacement?
##' @param prob	 a vector of probability weights for obtaining the elements of the vector being sampled.
##' @seealso \code{link{sample}} and \code{\link{sample.int}}
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
