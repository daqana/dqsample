
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis build
status](https://travis-ci.org/daqana/dqsample.svg?branch=master)](https://travis-ci.org/daqana/dqsample)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/daqana/dqsample?branch=master&svg=true)](https://ci.appveyor.com/project/rstub/dqsample)
[![CRAN
status](https://www.r-pkg.org/badges/version/dqsample)](https://cran.r-project.org/package=dqsample)
[![Coverage
status](https://codecov.io/gh/daqana/dqsample/branch/master/graph/badge.svg)](https://codecov.io/github/daqana/dqsample?branch=master)

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

When sampling many random integers the number of odd and even numbers
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
