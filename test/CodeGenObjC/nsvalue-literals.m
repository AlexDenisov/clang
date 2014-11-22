// RUN: %clang_cc1 -I %S/Inputs -triple x86_64-apple-darwin10 -emit-llvm -fblocks -fobjc-arc -fobjc-runtime-has-weak -O2 -disable-llvm-optzns -o - %s | FileCheck %s

#import "nsvalue-literal-support.h"

// CHECK:      [[CLASS:@.*]]      = external global %struct._class_t
// CHECK:      [[NSVALUE:@.*]]    = {{.*}}[[CLASS]]{{.*}}

// CHECK:      [[METH:@.*]]       = private global{{.*}}valueWithPoint:{{.*}}
// CHECK-NEXT: [[POINT_SEL:@.*]]  = {{.*}}[[METH]]{{.*}}
// CHECK:      [[METH:@.*]]       = private global{{.*}}valueWithSize:{{.*}}
// CHECK-NEXT: [[SIZE_SEL:@.*]]   = {{.*}}[[METH]]{{.*}}

// CHECK-LABEL: define void @doPoint()
void doPoint() {
  // CHECK:      [[POINT:%.*]]     = bitcast %struct._NSPoint* {{.*}}
  // CHECK:      [[RECV_PTR:%.*]]  = load {{.*}} [[NSVALUE]]
  // CHECK:      [[SEL:%.*]]       = load i8** [[POINT_SEL]]
  // CHECK:      [[RECV:%.*]]      = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  // CHECK:      [[POINT_PTR:%.*]] = bitcast %struct._NSPoint* {{.*}}
  // CHECK-NEXT: [[P1_PTR:%.*]]    = getelementptr {{.*}} [[POINT_PTR]], i32 0, i32 0
  // CHECK-NEXT: [[P1:%.*]]        = load double* [[P1_PTR]], align 1
  // CHECK-NEXT: [[P2_PTR:%.*]]    = getelementptr {{.*}} [[POINT_PTR]], i32 0, i32 1
  // CHECK-NEXT: [[P2:%.*]]        = load double* [[P2_PTR]], align 1
  NSPoint ns_point = { .x = 42, .y = 24 };
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], double [[P1]], double [[P2]])
  // CHECK:      call i8* @objc_retainAutoreleasedReturnValue
  NSValue *point = [NSValue valueWithPoint:ns_point];
  // CHECK:      call void @objc_release
  // CHECK-NEXT: ret void
}

// CHECK-LABEL: define void @doSize()
void doSize() {
  // CHECK:      [[SIZE:%.*]]     = bitcast %struct._NSSize* {{.*}}
  // CHECK:      [[RECV_PTR:%.*]] = load {{.*}} [[NSVALUE]]
  // CHECK:      [[SEL:%.*]]      = load i8** [[SIZE_SEL]]
  // CHECK:      [[RECV:%.*]]     = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  // CHECK:      [[SIZE_PTR:%.*]] = bitcast %struct._NSSize* {{.*}}
  // CHECK-NEXT: [[P1_PTR:%.*]]   = getelementptr {{.*}} [[SIZE_PTR]], i32 0, i32 0
  // CHECK-NEXT: [[P1:%.*]]       = load double* [[P1_PTR]], align 1
  // CHECK-NEXT: [[P2_PTR:%.*]]   = getelementptr {{.*}} [[SIZE_PTR]], i32 0, i32 1
  // CHECK-NEXT: [[P2:%.*]]       = load double* [[P2_PTR]], align 1
  NSSize ns_size = { .width = 42, .height = 24 };
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], double [[P1]], double [[P2]])
  // CHECK:      call i8* @objc_retainAutoreleasedReturnValue
  NSValue *size = [NSValue valueWithSize:ns_size];
  // CHECK:      call void @objc_release
  // CHECK-NEXT: ret void
}


/*void doStuff() {
  NSPoint ns_point = { .x = 42, .y = 24 };
  
  NSSize ns_size = { .width = 33, .height = 44 };
  NSValue *size = [NSValue valueWithSize:ns_size];

  NSRect ns_rect = { .origin = ns_point, .size = ns_size };
  NSValue *rect = [NSValue valueWithRect:ns_rect];

  NSRange ns_range = { .location = 0, .length = 14 };
  NSValue *range = [NSValue valueWithRange:ns_range];
}*/

