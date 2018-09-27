
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dqsample

The ‘base::sample’ function uses a slightly biased algorithm for
creating random integers within a given range. As an alternative the
algorithm suggested by Daniel Lemire (2018,
\<[arXiv:1805.1094](https://arxiv.org/abs/1805.10941)\>) is used.

## Installation

At the moment dqsample is not on CRAN, but you can install the current
version via [drat](https://cran.r-project.org/package=drat):

``` r
if (!requireNamespace("drat", quietly = TRUE)) install.packages("drat")
drat::addRepo("daqana")
install.packages("dqsample")
```

## Example

When sampling man random integers the number of odd and even numbers
should be about the same. This is not the case with `base::sample`:

``` r
m <- 2/5 * 2^32
x <- base::sample(m, 1000000, replace = TRUE)
table(x %% 2)
#> 
#>      0      1 
#> 400633 599367
```

While it is the case with `dqsample::sample`:

``` r
m <- 2/5 * 2^32
x <- dqsample::sample(m, 1000000, replace = TRUE)
table(x %% 2)
#> 
#>      0      1 
#> 498957 501043
```
