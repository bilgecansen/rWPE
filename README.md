
# rWPE

rWPE is a simple pacakge with three functions that can calculate
permutation entropy (PE) and weighted permutation entropy (WPE) of time
series and can perform a randomized permutation test, which we also call
rWPE, to assign significance to the calculated PE and WPE values. PE and
WPE are used to measure the intrinsic predictability of a time series
and the result of the rWPE test can tell you whether your time series is
more preidctable than white noise.

## Installation

You can install the development version of rWPE from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("bilgecansen/rWPE")
```

## PE and WPE

rWPE has three functions, *calculate_pe*, test_pe, and test_wpe.
*calculate_pe* calculates both the PE and the WPE of a time series,
which are cosntrained between 0 and 1.

``` r
library(rWPE)

x <- rnorm(50)

calculate_pe(x)
#>        WPE         PE         NP 
#>  0.9975592  0.9985428 48.0000000
```

In addition to PE and WPE, calculate_pe will show NP which is the Number
of ordinal Patterns (NP) used to calculate PE and WPE. NP is a function
of word length (m) and tau, which are also arguments to calcualte_pe
function. Default m is 3 and tau is 1. NP is x - (m-1)\*(tau-1) - m + 1.
NP will be lower if there are NAs in the time series. We recommend NP to
be at least 28, which corresponds to a time series where t = 30, m = 3,
and tau = 1 when there are no NAs, if the goal is just to calculate_pe.

## Testing for significance of PE and WPE

*test_pe* and *test_wpe* will calculate the significance of each PE or
WPE estimate, respectively, in which case a significant result would
mean that the focal time series is intrinsically more predictable than
its own randomized versions (an approximation of white noise).

``` r
library(rWPE)

x <- rnorm(50)

test_wpe(x)
#>          WPE           NP p-value(WPE) 
#>    0.9894101   48.0000000    0.8600000
```

The additional argument here is n_random, which is the number of
randomizations to perform on the focal time series when conducting rWPE
test. the default for n_random is 100. We recommend NP to be at least 8
(t = 10, m = 3, and tau = 1 when there are no NAs), for rWPE test.
