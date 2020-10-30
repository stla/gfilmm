test_that("multiplication works", {
  test_that("getCovariates", {
    dat <- data.frame(
      x = 1:3,
      f = c("a", "a", "b"),
      g = c("x", "y", "y")
    )
    #
    cvrts <- getCovariates(dat, ~ 1, NULL)
    expect_identical(cvrts$continuous, NULL)
    expect_identical(cvrts$categorical, list())
    #
    cvrts <- getCovariates(dat, ~ x, NULL)
    expect_identical(cvrts$continuous, "x")
    expect_identical(unname(cvrts$categorical), list())
    #
    cvrts <- getCovariates(dat, ~ f, NULL)
    expect_identical(cvrts$continuous, character(0L))
    expect_identical(cvrts$categorical, list(f = c("a", "b")))
    #
    cvrts <- getCovariates(dat, ~ x, ~ f)
    expect_identical(cvrts$continuous, "x")
    expect_identical(cvrts$categorical, list(f = c("a", "b")))
    #
    cvrts <- getCovariates(dat, ~ 0, ~ f)
    expect_identical(cvrts$continuous, character(0L))
    expect_identical(cvrts$categorical, list(f = c("a", "b")))
    #
    cvrts <- getCovariates(dat, ~ 1, ~ f*g)
    expect_identical(cvrts$continuous, character(0L))
    expect_identical(cvrts$categorical, list(f = c("a", "b"), g = c("x", "y")))
    #
    cvrts <- getCovariates(dat, ~ f*x, NULL)
    expect_identical(cvrts$continuous, "x")
    expect_identical(cvrts$categorical, list(f = c("a", "b")))
    #
    cvrts <- getCovariates(dat, ~ f*x, ~ f)
    expect_identical(cvrts$continuous, "x")
    expect_identical(cvrts$categorical, list(f = c("a", "b")))
  })
})