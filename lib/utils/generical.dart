import 'dart:math';

int numeroRandomicoDentrUmRange(int min, int max) {
  Random rnd;
  rnd = new Random();
  int r = min + rnd.nextInt(max - min);
  print("\n numeroRandomicoDentrUmRange - $r is in the range of $min and $max");
  return r;
}
