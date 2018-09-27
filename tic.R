add_package_checks()

if (Sys.getenv("id_rsa") != "") {
  # pkgdown documentation can be built optionally. Other example criteria:
  # - `inherits(ci(), "TravisCI")`: Only for Travis CI
  # - `ci()$is_tag()`: Only for tags, not for branches
  # - `Sys.getenv("BUILD_PKGDOWN") != ""`: If the env var "BUILD_PKGDOWN" is set
  # - `Sys.getenv("TRAVIS_EVENT_TYPE") == "cron"`: Only for Travis cron jobs
  get_stage("before_deploy") %>%
    add_step(step_setup_ssh())

  get_stage("deploy") %>%
    add_step(step_build_pkgdown()) %>%
    add_step(step_push_deploy(path = "docs", branch = "gh-pages"))  %>%
    add_step(step_setup_push_deploy(
      path = "~/git/drat",
      branch = "gh-pages",
      remote = paste0("git@github.com:", gsub("/.*$", "/drat", ci()$get_slug()), ".git")
    )) %>%
    add_step(step_add_to_drat()) %>%
    add_step(step_do_push_deploy(path = "~/git/drat"))
}
