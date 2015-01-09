// RUN: %clang_cc1 -I %S/Inputs -triple armv7-apple-ios8.0.0 -emit-llvm -O2 -disable-llvm-optzns -o - %s | FileCheck %s

#import "nsvalue-boxed-expressions-support.h"

// CHECK:      [[CLASS:@.*]]        = external global %struct._class_t
// CHECK:      [[NSVALUE:@.*]]      = {{.*}}[[CLASS]]{{.*}}

// CHECK:      [[METH:@.*]]            = private global{{.*}}valueWithRange:{{.*}}
// CHECK-NEXT: [[RANGE_SEL:@.*]]       = {{.*}}[[METH]]{{.*}}
// CHECK:      [[METH:@.*]]            = private global{{.*}}valueWithCGPoint:{{.*}}
// CHECK-NEXT: [[CGPOINT_SEL:@.*]]     = {{.*}}[[METH]]{{.*}}
// CHECK:      [[METH:@.*]]            = private global{{.*}}valueWithCGSize:{{.*}}
// CHECK-NEXT: [[CGSIZE_SEL:@.*]]      = {{.*}}[[METH]]{{.*}}
// CHECK:      [[METH:@.*]]            = private global{{.*}}valueWithCGRect:{{.*}}
// CHECK-NEXT: [[CGRECT_SEL:@.*]]      = {{.*}}[[METH]]{{.*}}
// CHECK:      [[METH:@.*]]            = private global{{.*}}valueWithEdgeInsets:{{.*}}
// CHECK-NEXT: [[EDGE_INSETS_SEL:@.*]] = {{.*}}[[METH]]{{.*}}

// CHECK-LABEL: define void @doRange()
void doRange() {
  // CHECK:      [[RANGE:%.*]]     = bitcast %struct._NSRange* {{.*}}
  // CHECK:      [[RECV_PTR:%.*]]  = load {{.*}} [[NSVALUE]]
  // CHECK:      [[SEL:%.*]]       = load i8** [[RANGE_SEL]]
  // CHECK:      [[RECV:%.*]]      = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  // CHECK:      [[RANGE_PTR:%.*]] = bitcast %struct._NSRange* {{.*}}
  // CHECK:      [[PARAM:%.*]]     = load [2 x i32]* [[RANGE_PTR]]{{.*}}
  NSRange ns_range = { .location = 0, .length = 42 };
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], [2 x i32] [[PARAM]])
  NSValue *range = @(ns_range);
  // CHECK:      ret void
}

// CHECK-LABEL: define void @doCGPoint()
void doCGPoint() {
  // CHECK:      [[POINT:%.*]]     = bitcast %struct.CGPoint* {{.*}}
  // CHECK:      [[RECV_PTR:%.*]]  = load {{.*}} [[NSVALUE]]
  // CHECK:      [[SEL:%.*]]       = load i8** [[CGPOINT_SEL]]
  // CHECK:      [[RECV:%.*]]      = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  // CHECK:      [[POINT_PTR:%.*]] = bitcast %struct.CGPoint* {{.*}}
  // CHECK:      [[PARAM:%.*]]     = load [4 x i32]* [[POINT_PTR]]{{.*}}
  CGPoint cg_point = { .x = 42, .y = 24 };
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], [4 x i32] [[PARAM]])
  NSValue *point = @(cg_point);
  // CHECK:      ret void
}

// CHECK-LABEL: define void @doCGSize()
void doCGSize() {
  // CHECK:      [[SIZE:%.*]]     = bitcast %struct.CGSize* {{.*}}
  // CHECK:      [[RECV_PTR:%.*]] = load {{.*}} [[NSVALUE]]
  // CHECK:      [[SEL:%.*]]      = load i8** [[CGSIZE_SEL]]
  // CHECK:      [[RECV:%.*]]     = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  // CHECK:      [[SIZE_PTR:%.*]] = bitcast %struct.CGSize* {{.*}}
  // CHECK:      [[PARAM:%.*]]    = load [4 x i32]* [[SIZE_PTR]]{{.*}}
  CGSize cg_size = { .width = 42, .height = 24 };
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], [4 x i32] [[PARAM]])
  NSValue *size = @(cg_size);
  // CHECK:      ret void
}

// CHECK-LABEL: define void @doCGRect()
void doCGRect() {
  // CHECK:      [[RECT:%.*]]     = alloca %struct.CGRect{{.*}}
  // CHECK:      [[RECV_PTR:%.*]] = load {{.*}} [[NSVALUE]]
  // CHECK:      [[SEL:%.*]]      = load i8** [[CGRECT_SEL]]
  // CHECK:      [[RECV:%.*]]     = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  // CHECK:      [[RECT_PTR:%.*]] = bitcast %struct.CGRect* {{.*}}
  // CHECK:      [[PARAM:%.*]]    = load [8 x i32]* [[RECT_PTR]]{{.*}}
  CGPoint cg_point = { .x = 42, .y = 24 };
  CGSize cg_size = { .width = 42, .height = 24 };
  CGRect cg_rect = { .origin = cg_point, .size = cg_size };
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], [8 x i32] [[PARAM]])
  NSValue *rect = @(cg_rect);
  // CHECK:      ret void
}

// CHECK-LABEL: define void @doNSEdgeInsets()
void doNSEdgeInsets() {
  // CHECK:      [[EDGE_INSETS:%.*]]     = alloca %struct.NSEdgeInsets{{.*}}
  // CHECK:      [[RECV_PTR:%.*]]        = load {{.*}} [[NSVALUE]]
  // CHECK:      [[SEL:%.*]]             = load i8** [[EDGE_INSETS_SEL]]
  // CHECK:      [[RECV:%.*]]            = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  // CHECK:      [[EDGE_INSETS_PTR:%.*]] = bitcast %struct.NSEdgeInsets* {{.*}}
  // CHECK:      [[PARAM:%.*]]           = load [8 x i32]* [[EDGE_INSETS_PTR]]{{.*}}
  NSEdgeInsets ns_edge_insets;
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], [8 x i32] [[PARAM]])
  NSValue *edge_insets = @(ns_edge_insets);
  // CHECK:      ret void
}

