#include <stdio.h>

const int cups[] = { 3, 6, 4, 2, 8, 9, 7, 1, 5 }, cups_len = 9;
const int ncups = 1000000;
const int niter = 10000000;

int main() {
  int next[ncups+1];            /* +1 to be able to index from 1 for convenience */
  for (int i = 0; i < cups_len; ++i)
    if (i == cups_len - 1)
      next[cups[i]] = cups_len + 1;
    else
      next[cups[i]] = cups[i+1];
  for (int i = cups_len + 1; i < ncups; ++i)
    next[i] = i + 1;
  next[ncups] = cups[0];

  int current = cups[0];
  for (int iter = 1; iter <= niter; ++iter) {
    int taken1 = next[current], taken2 = next[taken1], taken3 = next[taken2];
    int dest = current;
    do {
      dest--;
      if (dest == 0)
        dest = ncups;
    } while (dest == taken1 || dest == taken2 || dest == taken3);
    next[current] = next[taken3];
    next[taken3] = next[dest];
    next[dest] = taken1;
    current = next[current];
  }

  long int star1 = next[1], star2 = next[star1];
  printf("%ld\n", star1 * star2);
}
