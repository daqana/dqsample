// Copyright 2018 Ralf Stubner (daqana GmbH)
//
// This file is part of dqsample.
//
// dqsample is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 2 of the License, or
// (at your option) any later version.
//
// dqsample is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with dqsample.  If not, see <http://www.gnu.org/licenses/>.

#include <Rcpp.h>
#include <dqsample.h>

uint32_t random32() {
  return R::runif(0, 1) * 4294967296; /* 2^32 */
}

// [[Rcpp::export]]
Rcpp::IntegerVector sample_int(int n, int size, bool replace = false) {
  Rcpp::IntegerVector result(Rcpp::no_init(size));
  if (replace) {
    for (int i = 0; i < size; ++i)
        result[i] = bounded_rand32(random32, n) + 1;
  } else {
    Rcpp::IntegerVector tmp(Rcpp::no_init(n));
    for (int i = 0; i < n; ++i)
      tmp[i] = i;
    for (int i = 0; i < size; ++i) {
        int j = bounded_rand32(random32, n);
      result[i] = tmp[j] + 1;
      tmp[j] = tmp[--n];
    }
  }
  return result;
}
