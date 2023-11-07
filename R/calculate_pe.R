
#' Calculate permutation entropy (PE) and weighted permutation entropy (WPE) of a time series.
#'
#' @param x A numeric vector.
#' @param m Word length.
#' @param tau Time lag.
#'
#' @return a numeric vector with WPE, PE, and number of permutations (NP) used to calculate WPE and PE.
#' @export
#'
#' @examples
#' x <- rnorm(50)
#' calculate_pe(x)
calculate_pe <- function(x, m = 3, tau = 1) {

  if (m == 1 | m == 0) stop("m cannot be 1 or 0")
  if (tau == 0) stop("tau cannot be 0")

  eff_m <- (m-1)*(tau-1) + m

  if (eff_m >= length(x)) stop("Combination of m and tau is too large for the time series length")

  np <- length(x) - eff_m + 1

  idx_mat <- matrix(seq(1, eff_m, by = tau), ncol = m, nrow = np, byrow = T)
  idx_mat <- apply(idx_mat, 2, function(z) z + (0:(np-1)))

  ts_mat <- t(apply(idx_mat, 1, function(y) x[y]))
  idx_NA <- apply(ts_mat, 1, function(z) any(is.na(z)))
  ts_mat <- ts_mat[!idx_NA,]

  if (is.vector(ts_mat)) stop("Too many NAs in the time series realive to its length")
  if (nrow(ts_mat) == 0) stop("Too many NAs in the time series realive to its length")

  create_word <- function(y) {
    paste(rank(y, ties.method = "first"), collapse = "-")
  }

  wd <- apply(ts_mat, 1, create_word)

  wd_dis <- table(wd)

  p <- wd_dis/sum(wd_dis)

  pe <- -sum(p*log2(p))/log2(factorial(m))

  word_var <- apply(ts_mat, 1, function(x) stats::var(x))
  word_df <- data.frame(words = wd, var = word_var)
  pw <- tapply(word_var, wd, sum)/sum(word_var)

  wpe <- -sum(pw*log2(pw))/log2(factorial(m))

  res <- c(wpe, pe, nrow(ts_mat))
  names(res) <- c("WPE", "PE", "NP")

  return(res)
}
