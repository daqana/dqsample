// [[Rcpp::plugins(cpp11)]]
#include <cstdint>
#include <Rcpp.h>

/* Daniel Lemire
 Fast Random Integer Generation in an Interval
 https://arxiv.org/abs/1805.10941
 */
uint32_t  nearlydivisionless32(uint32_t s, uint32_t (*random32)(void)) {
  uint32_t x = random32();
  uint64_t m = (uint64_t) x * (uint64_t) s;
  uint32_t l = (uint32_t) m;
  if (l < s) {
    uint32_t t = -s % s;
    while (l < t) {
      x = random32();
      m = (uint64_t) x * (uint64_t) s;
      l = (uint32_t) m;
    }
  }
  return m >> 32;
}

uint32_t random32() {
  return R::runif(0, 1) * 4294967296; /* 2^32 */
}

// [[Rcpp::export]]
Rcpp::IntegerVector sample_int(int n, int size, bool replace = false) {
  Rcpp::IntegerVector result(Rcpp::no_init(size));
  if (replace) {
    for (int i = 0; i < size; ++i)
      result[i] = nearlydivisionless32(n, random32) + 1;
  } else {
    Rcpp::IntegerVector tmp(Rcpp::no_init(n));
    for (int i = 0; i < n; ++i)
      tmp[i] = i;
    for (int i = 0; i < size; ++i) {
      int j = nearlydivisionless32(n, random32);
      result[i] = tmp[j] + 1;
      tmp[j] = tmp[--n];
    }
  }
  return result;
}
