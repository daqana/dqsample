context("missing features")

test_that("weighted sampling gives warning", {
  expect_warning(sample(6, 10, replace = TRUE, prob = c(rep(0.1, 5), 0.5)),
                 regexp = "Weighted sampling is not supported yet. Using biased 'base::sample.int'.")
})

test_that("long vectors gives warning", {
  expect_warning(sample(2^31, 10, replace = TRUE),
                 regexp = "Long vectors are not supported yet. Using biased 'base::sample.int'.")
})
