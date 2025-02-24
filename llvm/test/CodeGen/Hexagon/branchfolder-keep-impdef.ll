; RUN: llc -mtriple=hexagon -verify-machineinstrs < %s | FileCheck %s
;
; Check that the testcase compiles successfully. Expect that if-conversion
; took place.
; CHECK-LABEL: fred:
; CHECK: if (!p0) r{{[0-9]+}} = memw(r{{[0-9]+}}+#0)

target triple = "hexagon"

define void @fred(i32 %p0) local_unnamed_addr align 2 {
b0:
  br i1 undef, label %b1, label %b2

b1:                                               ; preds = %b0
  %t0 = load ptr, ptr undef, align 4
  br label %b2

b2:                                               ; preds = %b1, %b0
  %t1 = phi ptr [ %t0, %b1 ], [ undef, %b0 ]
  %t2 = getelementptr inbounds i8, ptr %t1, i32 %p0
  tail call void @llvm.memmove.p0.p0.i32(ptr undef, ptr %t2, i32 undef, i1 false) #1
  ret void
}

declare void @llvm.memmove.p0.p0.i32(ptr nocapture, ptr nocapture readonly, i32, i1) #0

attributes #0 = { argmemonly nounwind }
attributes #1 = { nounwind }

