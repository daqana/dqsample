context("normal operation")

test_that("Same results with replacement", {
  set.seed(42, kind = "Mersenne-Twister")
  x <- dqsample::sample(6, 100, replace = TRUE)
  set.seed(42, kind = "Mersenne-Twister")
  y <- base::sample(6, 100, replace = TRUE)
  expect_equal(x, y)
})

test_that("Same results with replacement from vector", {
  set.seed(42, kind = "Mersenne-Twister")
  x <- dqsample::sample(1:6, 100, replace = TRUE)
  set.seed(42, kind = "Mersenne-Twister")
  y <- base::sample(1:6, 100, replace = TRUE)
  expect_equal(x, y)
})

test_that("Same results without replacement", {
  set.seed(42, kind = "Mersenne-Twister")
  x <- dqsample::sample(100, replace = FALSE)
  set.seed(42, kind = "Mersenne-Twister")
  y <- base::sample(100, replace = FALSE)
  expect_equal(x, y)
})

test_that("Same results without replacement from vector", {
  set.seed(42, kind = "Mersenne-Twister")
  x <- dqsample::sample(1:100, replace = FALSE)
  set.seed(42, kind = "Mersenne-Twister")
  y <- base::sample(1:100, replace = FALSE)
  expect_equal(x, y)
})
