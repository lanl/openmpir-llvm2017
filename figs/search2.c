void search(int low, int high) {
  if (low == high) search_base(low);
  else {
    int mid = (low+high)/2;
    #pragma omp task
    search(low, mid);
    #pragma omp task
    search(mid + 1, high);
    #pragma omp taskwait
  }
}
