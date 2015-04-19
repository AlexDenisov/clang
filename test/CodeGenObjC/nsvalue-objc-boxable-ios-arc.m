// RUN: %clang_cc1 -I %S/Inputs -triple armv7-apple-ios8.0.0 -emit-llvm -fobjc-arc -O2 -disable-llvm-optzns -o - %s | FileCheck %s

#import "nsvalue-boxed-expressions-support.h"

// CHECK:      [[CLASS:@.*]]        = external global %struct._class_t
// CHECK:      [[NSVALUE:@.*]]      = {{.*}}[[CLASS]]{{.*}}
// CHECK:      [[RANGE_STR:.*]]     = {{.*}}_NSRange=II{{.*}}
// CHECK:      [[METH:@.*]]         = private global{{.*}}valueWithBytes:objCType:{{.*}}
// CHECK:      [[VALUE_SEL:@.*]]    = {{.*}}[[METH]]{{.*}}
// CHECK:      [[POINT_STR:.*]]     = {{.*}}CGPoint=dd{{.*}}
// CHECK:      [[SIZE_STR:.*]]      = {{.*}}CGSize=dd{{.*}}
// CHECK:      [[RECT_STR:.*]]      = {{.*}}CGRect={CGPoint=dd}{CGSize=dd}}{{.*}}
// CHECK:      [[EDGE_STR:.*]]      = {{.*}}NSEdgeInsets=dddd{{.*}}

// CHECK-LABEL: define void @doRange()
void doRange() {
  // CHECK:      [[RANGE:%.*]]      = bitcast %struct._NSRange* {{.*}}
  // CHECK:      call void @llvm.memcpy{{.*}}[[RANGE]]{{.*}}
  // CHECK:      [[RECV_PTR:%.*]]   = load {{.*}} [[NSVALUE]]
  // CHECK:      [[RANGE_CAST:%.*]] = bitcast %struct._NSRange* {{.*}}
  // CHECK:      [[SEL:%.*]]        = load i8*, i8** [[VALUE_SEL]]
  // CHECK:      [[RECV:%.*]]       = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  NSRange ns_range = { .location = 0, .length = 42 };
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], i8* [[RANGE_CAST]], i8* {{.*}}[[RANGE_STR]]{{.*}})
  // CHECK:      call i8* @objc_retainAutoreleasedReturnValue
  NSValue *range = @(ns_range);
  // CHECK:      call void @objc_release
  // CHECK-NEXT: ret void
}

// CHECK-LABEL: define void @doPoint()
void doPoint() {
  // CHECK:      [[POINT:%.*]]      = bitcast %struct.CGPoint* {{.*}}
  // CHECK:      call void @llvm.memcpy{{.*}}[[POINT]]{{.*}}
  // CHECK:      [[RECV_PTR:%.*]]   = load {{.*}} [[NSVALUE]]
  // CHECK:      [[POINT_CAST:%.*]] = bitcast %struct.CGPoint* {{.*}}
  // CHECK:      [[SEL:%.*]]        = load i8*, i8** [[VALUE_SEL]]
  // CHECK:      [[RECV:%.*]]       = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  CGPoint cg_point = { .x = 42, .y = 24 };
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], i8* [[POINT_CAST]], i8* {{.*}}[[POINT_STR]]{{.*}})
  // CHECK:      call i8* @objc_retainAutoreleasedReturnValue
  NSValue *point = @(cg_point);
  // CHECK:      call void @objc_release
  // CHECK-NEXT: ret void
}

// CHECK-LABEL: define void @doSize()
void doSize() {
  // CHECK:      [[SIZE:%.*]]      = bitcast %struct.CGSize* {{.*}}
  // CHECK:      call void @llvm.memcpy{{.*}}[[SIZE]]{{.*}}
  // CHECK:      [[RECV_PTR:%.*]]  = load {{.*}} [[NSVALUE]]
  // CHECK:      [[SIZE_CAST:%.*]] = bitcast %struct.CGSize* {{.*}}
  // CHECK:      [[SEL:%.*]]       = load i8*, i8** [[VALUE_SEL]]
  // CHECK:      [[RECV:%.*]]      = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  CGSize cg_size = { .width = 42, .height = 24 };
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], i8* [[SIZE_CAST]], i8* {{.*}}[[SIZE_STR]]{{.*}})
  // CHECK:      call i8* @objc_retainAutoreleasedReturnValue
  NSValue *size = @(cg_size);
  // CHECK:      call void @objc_release
  // CHECK-NEXT: ret void
}

// CHECK-LABEL: define void @doRect()
void doRect() {
  // CHECK:      [[RECT:%.*]]      = alloca %struct.CGRect{{.*}}
  // CHECK:      [[RECV_PTR:%.*]]  = load {{.*}} [[NSVALUE]]
  // CHECK:      [[RECT_CAST:%.*]] = bitcast %struct.CGRect* [[RECT]] to i8*
  // CHECK:      [[SEL:%.*]]       = load i8*, i8** [[VALUE_SEL]]{{.*}}
  // CHECK:      [[RECV:%.*]]      = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  CGPoint cg_point = { .x = 42, .y = 24 };
  CGSize cg_size = { .width = 42, .height = 24 };
  CGRect cg_rect = { .origin = cg_point, .size = cg_size };
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], i8* [[RECT_CAST]], i8*{{.*}}[[RECT_STR]]{{.*}})
  // CHECK:      call i8* @objc_retainAutoreleasedReturnValue
  NSValue *rect = @(cg_rect);
  // CHECK:      call void @objc_release
  // CHECK-NEXT: ret void
}

// CHECK-LABEL: define void @doNSEdgeInsets()
void doNSEdgeInsets() {
  // CHECK:      [[EDGE:%.*]]      = alloca %struct.NSEdgeInsets{{.*}}
  // CHECK:      [[RECV_PTR:%.*]]  = load {{.*}} [[NSVALUE]]
  // CHECK:      [[EDGE_CAST:%.*]] = bitcast %struct.NSEdgeInsets* {{.*}}
  // CHECK:      [[SEL:%.*]]       = load i8*, i8** [[VALUE_SEL]]
  // CHECK:      [[RECV:%.*]]      = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  NSEdgeInsets ns_edge_insets;
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], i8* [[EDGE_CAST]], i8*{{.*}}[[EDGE_STR]]{{.*}})
  // CHECK:      call i8* @objc_retainAutoreleasedReturnValue
  NSValue *edge_insets = @(ns_edge_insets);
  // CHECK:      call void @objc_release
  // CHECK-NEXT: ret void
}

// CHECK-LABEL: define void @doRangeRValue() 
void doRangeRValue() {
  // CHECK:     [[COERCE:%.*]]          = alloca %struct._NSRange{{.*}}
  // CHECK:     [[RECV_PTR:%.*]]        = load {{.*}} [[NSVALUE]]
  // CHECK:     call {{.*}} @getRange {{.*}} [[COERCE]]{{.*}}
  // CHECK:     [[COERCE_CAST:%.*]]     = bitcast %struct._NSRange* [[COERCE]]{{.*}}
  // CHECK:     [[SEL:%.*]]             = load i8*, i8** [[VALUE_SEL]]
  // CHECK:     [[RECV:%.*]]            = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  // CHECK:     call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], i8* [[COERCE_CAST]], i8* {{.*}}[[RANGE_STR]]{{.*}})
  // CHECK:     call i8* @objc_retainAutoreleasedReturnValue
  NSValue *range_rvalue = @(getRange());
  // CHECK:     call void @objc_release
  // CHECK: ret void
}

