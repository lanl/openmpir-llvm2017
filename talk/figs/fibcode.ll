; ModuleID = 'fibcode.c'
source_filename = "fibcode.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }
%struct.kmp_task_t_with_privates = type { %struct.kmp_task_t, %struct..kmp_privates.t }
%struct.kmp_task_t = type { i8*, i32 (i32, i8*)*, i32, %union.kmp_cmplrdata_t, %union.kmp_cmplrdata_t }
%union.kmp_cmplrdata_t = type { i32 (i32, i8*)* }
%struct..kmp_privates.t = type { i32, i32 }
%struct.kmp_task_t_with_privates.1 = type { %struct.kmp_task_t, %struct..kmp_privates.t.2 }
%struct..kmp_privates.t.2 = type { i32, i32 }

@.str = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8

; Function Attrs: nounwind sspstrong uwtable
define i32 @fib(i32) local_unnamed_addr #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = tail call i32 @__kmpc_global_thread_num(%ident_t* nonnull @0) #2
  store i32 %0, i32* %2, align 4, !tbaa !4
  %6 = icmp slt i32 %0, 2
  br i1 %6, label %34, label %7

; <label>:7:                                      ; preds = %1
  %8 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %8) #2
  %9 = bitcast i32* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %9) #2
  %10 = tail call i8* @__kmpc_omp_task_alloc(%ident_t* nonnull @0, i32 %5, i32 1, i64 48, i64 16, i32 (i32, i8*)* bitcast (i32 (i32, %struct.kmp_task_t_with_privates*)* @.omp_task_entry. to i32 (i32, i8*)*)) #2
  %11 = bitcast i8* %10 to i8**
  %12 = load i8*, i8** %11, align 8, !tbaa !8
  %13 = bitcast i8* %12 to i32**
  store i32* %3, i32** %13, align 8
  %14 = getelementptr inbounds i8, i8* %12, i64 8
  %15 = bitcast i8* %14 to i32**
  store i32* %2, i32** %15, align 8
  %16 = getelementptr inbounds i8, i8* %10, i64 44
  %17 = bitcast i8* %16 to i32*
  %18 = load i32, i32* %2, align 4, !tbaa !4
  store i32 %18, i32* %17, align 4, !tbaa !13
  %19 = call i32 @__kmpc_omp_task(%ident_t* nonnull @0, i32 %5, i8* %10) #2
  %20 = call i8* @__kmpc_omp_task_alloc(%ident_t* nonnull @0, i32 %5, i32 1, i64 48, i64 16, i32 (i32, i8*)* bitcast (i32 (i32, %struct.kmp_task_t_with_privates.1*)* @.omp_task_entry..3 to i32 (i32, i8*)*)) #2
  %21 = bitcast i8* %20 to i8**
  %22 = load i8*, i8** %21, align 8, !tbaa !8
  %23 = bitcast i8* %22 to i32**
  store i32* %4, i32** %23, align 8
  %24 = getelementptr inbounds i8, i8* %22, i64 8
  %25 = bitcast i8* %24 to i32**
  store i32* %2, i32** %25, align 8
  %26 = getelementptr inbounds i8, i8* %20, i64 44
  %27 = bitcast i8* %26 to i32*
  %28 = load i32, i32* %2, align 4, !tbaa !4
  store i32 %28, i32* %27, align 4, !tbaa !13
  %29 = call i32 @__kmpc_omp_task(%ident_t* nonnull @0, i32 %5, i8* %20) #2
  %30 = call i32 @__kmpc_omp_taskwait(%ident_t* nonnull @0, i32 %5) #2
  %31 = load i32, i32* %3, align 4, !tbaa !4
  %32 = load i32, i32* %4, align 4, !tbaa !4
  %33 = add nsw i32 %32, %31
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %9) #2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %8) #2
  br label %34

; <label>:34:                                     ; preds = %1, %7
  %35 = phi i32 [ %33, %7 ], [ %0, %1 ]
  ret i32 %35
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1

; Function Attrs: nounwind sspstrong uwtable
define internal i32 @.omp_task_entry.(i32, %struct.kmp_task_t_with_privates* noalias nocapture) #0 {
  %3 = getelementptr inbounds %struct.kmp_task_t_with_privates, %struct.kmp_task_t_with_privates* %1, i64 0, i32 1, i32 0
  %4 = getelementptr inbounds %struct.kmp_task_t_with_privates, %struct.kmp_task_t_with_privates* %1, i64 0, i32 1, i32 1
  %5 = load i32, i32* %4, align 4, !tbaa !4
  %6 = add nsw i32 %5, -1
  %7 = tail call i32 @fib(i32 %6) #2
  store i32 %7, i32* %3, align 4, !tbaa !4
  ret i32 0
}

declare i32 @__kmpc_global_thread_num(%ident_t*) local_unnamed_addr

declare i8* @__kmpc_omp_task_alloc(%ident_t*, i32, i32, i64, i64, i32 (i32, i8*)*) local_unnamed_addr

declare i32 @__kmpc_omp_task(%ident_t*, i32, i8*) local_unnamed_addr

; Function Attrs: nounwind sspstrong uwtable
define internal i32 @.omp_task_entry..3(i32, %struct.kmp_task_t_with_privates.1* noalias nocapture) #0 {
  %3 = getelementptr inbounds %struct.kmp_task_t_with_privates.1, %struct.kmp_task_t_with_privates.1* %1, i64 0, i32 1, i32 0
  %4 = getelementptr inbounds %struct.kmp_task_t_with_privates.1, %struct.kmp_task_t_with_privates.1* %1, i64 0, i32 1, i32 1
  %5 = load i32, i32* %4, align 4, !tbaa !4
  %6 = add nsw i32 %5, -2
  %7 = tail call i32 @fib(i32 %6) #2
  store i32 %7, i32* %3, align 4, !tbaa !4
  ret i32 0
}

declare i32 @__kmpc_omp_taskwait(%ident_t*, i32) local_unnamed_addr

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

attributes #0 = { nounwind sspstrong uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!4 = !{!5, !5, i64 0}
!5 = !{!"int", !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
!8 = !{!9, !11, i64 0}
!9 = !{!"kmp_task_t_with_privates", !10, i64 0, !12, i64 40}
!10 = !{!"kmp_task_t", !11, i64 0, !11, i64 8, !5, i64 16, !6, i64 24, !6, i64 32}
!11 = !{!"any pointer", !6, i64 0}
!12 = !{!".kmp_privates.t", !5, i64 0, !5, i64 4}
!13 = !{!9, !5, i64 44}
