% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calculate_pe.R
\name{calculate_pe}
\alias{calculate_pe}
\title{Calculate permutation entropy (PE) and weighted permutation entropy (WPE) of a time series.}
\usage{
calculate_pe(x, m = 3, tau = 1)
}
\arguments{
\item{x}{A numeric vector.}

\item{m}{Word length.}

\item{tau}{Time lag.}
}
\value{
a numeric vector with WPE, PE, and number of permutations (NP) used to calculate WPE and PE.
}
\description{
Calculate permutation entropy (PE) and weighted permutation entropy (WPE) of a time series.
}
\examples{
x <- rnorm(50)
calculate_pe(x)
}
