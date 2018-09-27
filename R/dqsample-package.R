##' @useDynLib dqsample, .registration = TRUE
##' @importFrom Rcpp evalCpp
"_PACKAGE"

.onUnload <- function(libpath) {
  library.dynam.unload("dqsample", libpath)
}
