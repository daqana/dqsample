context("test-bias")

test_that("unbiased sample.int", {
  set.seed(42)
  a <- 2 # or 3, 4, ..
  m <- (2/(1 + 2 * a))*2^32
  x <- sample.int(m, 1000000, replace = TRUE)
  odd_even <- table(x %% 2)
  expect_lt(diff(odd_even) / sum(odd_even), 0.01)
})

test_that("unbiased sample", {
  set.seed(42)
  a <- 2 # or 3, 4, ..
  m <- (2/(1 + 2 * a))*2^32
  x <- sample(m, 1000000, replace = TRUE)
  odd_even <- table(x %% 2)
  expect_lt(diff(odd_even) / sum(odd_even), 0.01)
})
