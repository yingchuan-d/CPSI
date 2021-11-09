; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -target-abi=ilp32d -mattr=+experimental-v,+experimental-zfh,+f,+d -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=8 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX8
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -mattr=+experimental-v,+experimental-zfh,+f,+d -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=8 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX8
; RUN: llc -mtriple=riscv32 -target-abi=ilp32d -mattr=+experimental-v,+experimental-zfh,+f,+d -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -mattr=+experimental-v,+experimental-zfh,+f,+d -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1

define void @gather_const_v8f16(<8 x half>* %x) {
; CHECK-LABEL: gather_const_v8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, a0, 10
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, mu
; CHECK-NEXT:    vlse16.v v8, (a1), zero
; CHECK-NEXT:    vse16.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <8 x half>, <8 x half>* %x
  %b = extractelement <8 x half> %a, i32 5
  %c = insertelement <8 x half> undef, half %b, i32 0
  %d = shufflevector <8 x half> %c, <8 x half> undef, <8 x i32> zeroinitializer
  store <8 x half> %d, <8 x half>* %x
  ret void
}

define void @gather_const_v4f32(<4 x float>* %x) {
; CHECK-LABEL: gather_const_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, a0, 8
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, mu
; CHECK-NEXT:    vlse32.v v8, (a1), zero
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <4 x float>, <4 x float>* %x
  %b = extractelement <4 x float> %a, i32 2
  %c = insertelement <4 x float> undef, float %b, i32 0
  %d = shufflevector <4 x float> %c, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %d, <4 x float>* %x
  ret void
}

define void @gather_const_v2f64(<2 x double>* %x) {
; CHECK-LABEL: gather_const_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, mu
; CHECK-NEXT:    vlse64.v v8, (a0), zero
; CHECK-NEXT:    vse64.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <2 x double>, <2 x double>* %x
  %b = extractelement <2 x double> %a, i32 0
  %c = insertelement <2 x double> undef, double %b, i32 0
  %d = shufflevector <2 x double> %c, <2 x double> undef, <2 x i32> zeroinitializer
  store <2 x double> %d, <2 x double>* %x
  ret void
}

define void @gather_const_v64f16(<64 x half>* %x) {
; LMULMAX8-LABEL: gather_const_v64f16:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    addi a1, a0, 94
; LMULMAX8-NEXT:    addi a2, zero, 64
; LMULMAX8-NEXT:    vsetvli zero, a2, e16, m8, ta, mu
; LMULMAX8-NEXT:    vlse16.v v8, (a1), zero
; LMULMAX8-NEXT:    vse16.v v8, (a0)
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: gather_const_v64f16:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    addi a6, a0, 16
; LMULMAX1-NEXT:    addi a7, a0, 48
; LMULMAX1-NEXT:    addi a3, a0, 32
; LMULMAX1-NEXT:    addi a4, a0, 80
; LMULMAX1-NEXT:    addi a5, a0, 94
; LMULMAX1-NEXT:    vsetivli zero, 8, e16, m1, ta, mu
; LMULMAX1-NEXT:    vlse16.v v8, (a5), zero
; LMULMAX1-NEXT:    addi a5, a0, 64
; LMULMAX1-NEXT:    addi a1, a0, 112
; LMULMAX1-NEXT:    addi a2, a0, 96
; LMULMAX1-NEXT:    vse16.v v8, (a2)
; LMULMAX1-NEXT:    vse16.v v8, (a1)
; LMULMAX1-NEXT:    vse16.v v8, (a5)
; LMULMAX1-NEXT:    vse16.v v8, (a4)
; LMULMAX1-NEXT:    vse16.v v8, (a3)
; LMULMAX1-NEXT:    vse16.v v8, (a7)
; LMULMAX1-NEXT:    vse16.v v8, (a0)
; LMULMAX1-NEXT:    vse16.v v8, (a6)
; LMULMAX1-NEXT:    ret
  %a = load <64 x half>, <64 x half>* %x
  %b = extractelement <64 x half> %a, i32 47
  %c = insertelement <64 x half> undef, half %b, i32 0
  %d = shufflevector <64 x half> %c, <64 x half> undef, <64 x i32> zeroinitializer
  store <64 x half> %d, <64 x half>* %x
  ret void
}

define void @gather_const_v32f32(<32 x float>* %x) {
; LMULMAX8-LABEL: gather_const_v32f32:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    addi a1, a0, 68
; LMULMAX8-NEXT:    addi a2, zero, 32
; LMULMAX8-NEXT:    vsetvli zero, a2, e32, m8, ta, mu
; LMULMAX8-NEXT:    vlse32.v v8, (a1), zero
; LMULMAX8-NEXT:    vse32.v v8, (a0)
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: gather_const_v32f32:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    addi a6, a0, 16
; LMULMAX1-NEXT:    addi a7, a0, 48
; LMULMAX1-NEXT:    addi a3, a0, 32
; LMULMAX1-NEXT:    addi a4, a0, 80
; LMULMAX1-NEXT:    addi a5, a0, 68
; LMULMAX1-NEXT:    vsetivli zero, 4, e32, m1, ta, mu
; LMULMAX1-NEXT:    vlse32.v v8, (a5), zero
; LMULMAX1-NEXT:    addi a5, a0, 64
; LMULMAX1-NEXT:    addi a1, a0, 112
; LMULMAX1-NEXT:    addi a2, a0, 96
; LMULMAX1-NEXT:    vse32.v v8, (a2)
; LMULMAX1-NEXT:    vse32.v v8, (a1)
; LMULMAX1-NEXT:    vse32.v v8, (a5)
; LMULMAX1-NEXT:    vse32.v v8, (a4)
; LMULMAX1-NEXT:    vse32.v v8, (a3)
; LMULMAX1-NEXT:    vse32.v v8, (a7)
; LMULMAX1-NEXT:    vse32.v v8, (a0)
; LMULMAX1-NEXT:    vse32.v v8, (a6)
; LMULMAX1-NEXT:    ret
  %a = load <32 x float>, <32 x float>* %x
  %b = extractelement <32 x float> %a, i32 17
  %c = insertelement <32 x float> undef, float %b, i32 0
  %d = shufflevector <32 x float> %c, <32 x float> undef, <32 x i32> zeroinitializer
  store <32 x float> %d, <32 x float>* %x
  ret void
}

define void @gather_const_v16f64(<16 x double>* %x) {
; LMULMAX8-LABEL: gather_const_v16f64:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    addi a1, a0, 80
; LMULMAX8-NEXT:    vsetivli zero, 16, e64, m8, ta, mu
; LMULMAX8-NEXT:    vlse64.v v8, (a1), zero
; LMULMAX8-NEXT:    vse64.v v8, (a0)
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: gather_const_v16f64:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    addi a6, a0, 16
; LMULMAX1-NEXT:    addi a7, a0, 48
; LMULMAX1-NEXT:    addi a3, a0, 32
; LMULMAX1-NEXT:    addi a4, a0, 80
; LMULMAX1-NEXT:    vsetivli zero, 2, e64, m1, ta, mu
; LMULMAX1-NEXT:    vlse64.v v8, (a4), zero
; LMULMAX1-NEXT:    addi a5, a0, 64
; LMULMAX1-NEXT:    addi a1, a0, 112
; LMULMAX1-NEXT:    addi a2, a0, 96
; LMULMAX1-NEXT:    vse64.v v8, (a2)
; LMULMAX1-NEXT:    vse64.v v8, (a1)
; LMULMAX1-NEXT:    vse64.v v8, (a5)
; LMULMAX1-NEXT:    vse64.v v8, (a4)
; LMULMAX1-NEXT:    vse64.v v8, (a3)
; LMULMAX1-NEXT:    vse64.v v8, (a7)
; LMULMAX1-NEXT:    vse64.v v8, (a0)
; LMULMAX1-NEXT:    vse64.v v8, (a6)
; LMULMAX1-NEXT:    ret
  %a = load <16 x double>, <16 x double>* %x
  %b = extractelement <16 x double> %a, i32 10
  %c = insertelement <16 x double> undef, double %b, i32 0
  %d = shufflevector <16 x double> %c, <16 x double> undef, <16 x i32> zeroinitializer
  store <16 x double> %d, <16 x double>* %x
  ret void
}