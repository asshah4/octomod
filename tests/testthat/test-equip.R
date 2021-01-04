library(magrittr)
library(parsnip)

df <- mtcars
df$am <- factor(df$am)

om <-
	octomod() %>%
	core(df) %>%
  arm(
  	title = "log_model",
  	f = am ~ mpg,
  	pattern = "direct",
  	approach = logistic_reg() %>% set_engine("glm")
  )

equipped <- om %>% equip()

test_that("equip() should error if octomod isn't ready", {
	expect_error(
		octomod() %>%
			equip()
	)
	expect_error(
		octomod() %>%
			core(iris) %>%
			equip()
	)
})

test_that("equip() should have correct input", {
	expect_length(om$outft, 0)
})

test_that("equip() should have correct output", {
	expect_true(inherits(equipped$outfit, "list"))
	expect_true(inherits(equipped$outfit[[1]], "tbl_df"))
	expect_true(inherits(equipped$outfit[[1]]$tidied, "list"))
	expect_true(inherits(equipped$outfit[[1]]$tidied[[1]], "tbl_df"))
})
