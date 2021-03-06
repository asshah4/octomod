proj <-
	project() %>%
	set_data(mtcars) %>%
	add_hypothesis(
		name = "weight",
		formula = wt ~ vs,
		test = "t.test",
		paired = TRUE,
		combination = "direct"
	) %>%
	build_models()


test_that("can expect a `project` as main input", {
	expect_s3_class(proj, "project")
})

test_that("findings are in table form", {
	res <- proj %>% collect_findings()
	expect_s3_class(res, "tbl")
})
