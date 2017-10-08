void search(int low, int high) {
  if (low == high) search_base(low);
  else {
    #pragma omp task
    search(low, (low+high)/2);
    #pragma omp task
    search((low+high)/2 + 1, high);
    #pragma omp taskwait
  }
}
