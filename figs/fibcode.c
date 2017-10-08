int fib(int n)
{                    // A
  if (n < 2)
    return n;
  else
  {
    int x, y;
    #pragma omp task
      x = fib(n-1);  // B
    #pragma omp task
      y = fib(n-2);  // C
    #pragma omp taskwait
    return (x+y);    // D
  }
}
