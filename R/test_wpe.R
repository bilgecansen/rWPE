
#' Calculate WPE of a time series and its statistical significance.
#'
#' Calculate WPE of a time series and its statistical significance against the null hypothesis that the target time series is not more predictable than white noise.
#'
#' @param x A numeric vector.
#' @param m Word length.
#' @param tau Time lag.
#' @param n_random Number of random permutations of the time series to use in randomized permutation test.
#'
#' @return a numeric vector with WPE, number of permutations (NP) used to calculate WPE, and the statistical significance of WPE.
#' @export
#'
#' @examples
#' x <- rnorm(50)
#' test_wpe(x)
test_wpe <- function(x, m = 3, tau = 1, n_random = 100) {

  x2 <-  replicate(n_random, sample(x))

  y <- calculate_pe(x, m, tau)

  x_wpe <- y[1]
  x_np <- y[3]

  null_wpe <- apply(x2, 2, function(z) calculate_pe(z, m = m, tau = tau)[1])
  null_diff_wpe <- x_wpe - null_wpe
  p_wpe <- length(which(null_diff_wpe > 0)) / length(null_diff_wpe)
  res <- c(x_wpe, x_np, p_wpe)
  names(res) <- c("WPE", "NP", "p-value(WPE)")

  return(res)
}
