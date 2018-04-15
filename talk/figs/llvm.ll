define i32 @f(i32 %x) {
entry:
  %y = alloca i32, align 4
  store i32 10, i32* %y, align 4
  %cmp = icmp eq i32 %x, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:
  store i32 12, i32* %y, align 4
  br label %if.end

if.end:
  %1 = load i32, i32* %y, align 4
  ret i32 %1
}
