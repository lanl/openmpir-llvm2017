void task_1(int* clos) {
  search(*clos[0], (*clos[0] + *clos[1])/2);
}

void task_2(int* clos) {
  search(*clos[0], (*clos[0] + *clos[1])/2);
}

void search(int low, int high) {
  if (low == high) search_base(low);
  else {
    int* closure_1[] = {&low, &high};
    omp_run_task(task_1, closure_1);
    int* closure_2[] = {&low, &high};
    omp_run_task(task_2, closure_2);
    omp_taskwait();
  }
}
