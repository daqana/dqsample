context("normal operation")

test_that("Same results with replacement", {
  set.seed(42)
  x <- dqsample::sample(6, 100, replace = TRUE)
  set.seed(42)
  y <- base::sample(6, 100, replace = TRUE)
  expect_equal(x, y)
})

test_that("Same results without replacement", {
  set.seed(42)
  x <- dqsample::sample(100, 6, replace = FALSE)
  set.seed(42)
  y <- base::sample(100, 6, replace = FALSE)
  expect_equal(x, y)
})
