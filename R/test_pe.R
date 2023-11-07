#' Calculate PE of a time series and its statistical significance.
#'
#' Calculate PE of a time series and its statistical significance against the null hypothesis that the target time series is not more predictable than white noise.
#'
#' @param x A numeric vector.
#' @param m Word length.
#' @param tau Time lag.
#' @param n_random Number of random permutations of the time series to use in randomzied permutation test.
#'
#' @return a numeric vector with PE, number of permutations (NP) used to calculate PE, and the statistical significance of PE.
#' @export
#'
#' @examples
#' x <- rnorm(50)
#' test_pe(x)
test_pe <- function(x, m = 3, tau = 1, n_random = 100) {

  x2 <-  replicate(n_random, sample(x))

  y <- calculate_pe(x, m, tau)

  x_pe <- y[2]
  x_np <- y[3]

  null_pe <- apply(x2, 2, function(z) calculate_pe(z, m = m, tau = tau)[2])
  null_diff_pe <- x_pe - null_pe
  p_pe <- length(which(null_diff_pe > 0)) / length(null_diff_pe)
  res <- c(x_pe, x_np, p_pe)
  names(res) <- c("PE", "NP", "p-value(PE)")

  return(res)
}
