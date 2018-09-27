#  This file is based on src/library/base/R/sample.R
#  Part of the R package, https://www.R-project.org
#
#  Copyright (C) 1995-2016 The R Core Team
#  Copyright (C) 2018 Ralf Stubner (daqana GmbH)
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  A copy of the GNU General Public License is available at
#  https://www.R-project.org/Licenses/


##' @title Unbiased Random Samples and Permutations
##' @description These functions provide an unbiased alternative to the corresponding
##'   \code{base} functions.
##' @details Currently there is no support for weighted sampling and for long vectors.
##'   If such situations are encountered, the functions fall back to the equivalent functions
##'   in \code{base}.
##' @note The used algorithm needs a random 32bit unsigned integer as input. R does
##'   not provide an interface for such a random number. Instead \code{unif_rand()}
##'   returns a random double in \eqn{(0, 1)}. Internally, the result of \code{unif_rand()}
##'   is multiplied with \eqn{2^{32}} to produce a 32bit unsigned integer. This
##'   works correctly for the default generator Mersenne-Twister, since that produces
##'   a 32bit unsigned integer which is then devided by \eqn{2^{32}}. However, other
##'   generators in R do not follow this pattern so that this procedure might introduce
##'   a new bias.
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
