// RUN: %clang_cc1 -I %S/Inputs -triple x86_64-apple-darwin10 -emit-llvm -fobjc-arc -O2 -disable-llvm-optzns -o - %s | FileCheck %s

#import "nsvalue-boxed-expressions-support.h"

// CHECK:      [[CLASS:@.*]]        = external global %struct._class_t
// CHECK:      [[NSVALUE:@.*]]      = {{.*}}[[CLASS]]{{.*}}

// CHECK:      [[METH:@.*]]         = private global{{.*}}valueWithRange:{{.*}}
// CHECK-NEXT: [[RANGE_SEL:@.*]]    = {{.*}}[[METH]]{{.*}}
// CHECK:      [[METH:@.*]]         = private global{{.*}}valueWithPoint:{{.*}}
// CHECK-NEXT: [[POINT_SEL:@.*]]    = {{.*}}[[METH]]{{.*}}
// CHECK:      [[METH:@.*]]         = private global{{.*}}valueWithSize:{{.*}}
// CHECK-NEXT: [[SIZE_SEL:@.*]]     = {{.*}}[[METH]]{{.*}}
// CHECK:      [[METH:@.*]]         = private global{{.*}}valueWithRect:{{.*}}
// CHECK-NEXT: [[RECT_SEL:@.*]]     = {{.*}}[[METH]]{{.*}}

// CHECK:      [[METH:@.*]]         = private global{{.*}}valueWithPointer:{{.*}}
// CHECK-NEXT: [[POINTER_SEL:@.*]]  = {{.*}}[[METH]]{{.*}}

// CHECK:      [[METH:@.*]]         = private global{{.*}}valueWithNonretainedObject:{{.*}}
// CHECK-NEXT: [[NONRET_SEL:@.*]]   = {{.*}}[[METH]]{{.*}}

// CHECK-LABEL: define void @doRange()
void doRange() {
  // CHECK:      [[RANGE:%.*]]     = bitcast %struct._NSRange* {{.*}}
  // CHECK:      [[RECV_PTR:%.*]]  = load {{.*}} [[NSVALUE]]
  // CHECK:      [[SEL:%.*]]       = load i8** [[RANGE_SEL]]
  // CHECK:      [[RECV:%.*]]      = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  // CHECK:      [[RANGE_PTR:%.*]] = bitcast %struct._NSRange* {{.*}}
  // CHECK-NEXT: [[P1_PTR:%.*]]    = getelementptr {{.*}} [[RANGE_PTR]], i32 0, i32 0
  // CHECK-NEXT: [[P1:%.*]]        = load i64* [[P1_PTR]], align 1
  // CHECK-NEXT: [[P2_PTR:%.*]]    = getelementptr {{.*}} [[RANGE_PTR]], i32 0, i32 1
  // CHECK-NEXT: [[P2:%.*]]        = load i64* [[P2_PTR]], align 1
  NSRange ns_range = { .location = 0, .length = 42 };
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], i64 [[P1]], i64 [[P2]])
  // CHECK:      call i8* @objc_retainAutoreleasedReturnValue
  NSValue *range = @(ns_range);
  // CHECK:      call void @objc_release
  // CHECK-NEXT: ret void
}

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
  NSValue *point = @(ns_point);
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
  NSValue *size = @(ns_size);
  // CHECK:      call void @objc_release
  // CHECK-NEXT: ret void
}

// CHECK-LABEL: define void @doRect()
void doRect() {
  // CHECK:      [[RECT:%.*]]     = alloca %struct._NSRect{{.*}}
  // CHECK:      [[RECV_PTR:%.*]] = load {{.*}} [[NSVALUE]]
  // CHECK:      [[SEL:%.*]]      = load i8** [[RECT_SEL]]
  // CHECK:      [[RECV:%.*]]     = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  NSPoint ns_point = { .x = 42, .y = 24 };
  NSSize ns_size = { .width = 42, .height = 24 };
  NSRect ns_rect = { .origin = ns_point, .size = ns_size };
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], %struct._NSRect* byval align 8 [[RECT]])
  // CHECK:      call i8* @objc_retainAutoreleasedReturnValue
  NSValue *rect = @(ns_rect);
  // CHECK:      call void @objc_release
  // CHECK-NEXT: ret void
}

// CHECK-LABEL: define void @doVoidPointer()
void doVoidPointer() {
  // CHECK:      [[POINTER:%.*]]  = alloca i8*{{.*}}
  // CHECK:      [[RECV_PTR:%.*]] = load {{.*}} [[NSVALUE]]
  // CHECK:      [[PARAM:%.*]]    = load i8** [[POINTER]]
  // CHECK:      [[SEL:%.*]]      = load i8** [[POINTER_SEL]]
  // CHECK:      [[RECV:%.*]]     = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  const void *pointer = 0;
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], i8* [[PARAM]])
  // CHECK:      call i8* @objc_retainAutoreleasedReturnValue
  NSValue *value = @(pointer);
  // CHECK:      call void @objc_release
  // CHECK-NEXT: ret void
}

// CHECK-LABEL: define void @doNonretainedObject()
void doNonretainedObject() {
  // CHECK:      [[OBJ:%.*]]      = alloca i8*{{.*}}
  // CHECK:      [[RECV_PTR:%.*]] = load {{.*}} [[NSVALUE]]
  // CHECK:      [[PARAM:%.*]]    = load i8** [[OBJ]]
  // CHECK:      [[SEL:%.*]]      = load i8** [[NONRET_SEL]]
  // CHECK:      [[RECV:%.*]]     = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  id obj;
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], i8* [[PARAM]])
  // CHECK:      call i8* @objc_retainAutoreleasedReturnValue
  NSValue *object = @(obj);
  // CHECK:      call void @objc_release
  // CHECK:      call void @objc_release
  // CHECK-NEXT: ret void
}

