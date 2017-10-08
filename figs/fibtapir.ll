if.end:
  detach label %det.achd, label %det.cont

det.achd:
  %2 = load i32, i32* %n.addr, align 4
  %sub = sub nsw i32 %2, 1
  %call = call i32 @fib(i32 %sub)
  store i32 %call, i32* %x, align 4
  reattach label %det.cont

det.cont:
  detach label %det.achd1, label %det.cont4

det.achd1:
  %3 = load i32, i32* %n.addr, align 4
  %sub2 = sub nsw i32 %3, 2
  %call3 = call i32 @fib(i32 %sub2)
  store i32 %call3, i32* %y, align 4
  reattach label %det.cont4

det.cont4:
  sync label %sync.continue
