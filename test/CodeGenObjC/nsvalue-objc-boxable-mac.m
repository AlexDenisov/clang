// RUN: %clang_cc1 -I %S/Inputs -triple x86_64-apple-macosx -emit-llvm -O2 -disable-llvm-optzns -o - %s | FileCheck %s

#import "nsvalue-boxed-expressions-support.h"

// CHECK:      [[CLASS:@.*]]        = external global %struct._class_t
// CHECK:      [[NSVALUE:@.*]]      = {{.*}}[[CLASS]]{{.*}}
// CHECK:      [[RANGE_STR:.*]]     = {{.*}}_NSRange=QQ{{.*}}
// CHECK:      [[METH:@.*]]         = private global{{.*}}valueWithBytes:objCType:{{.*}}
// CHECK:      [[VALUE_SEL:@.*]]    = {{.*}}[[METH]]{{.*}}
// CHECK:      [[POINT_STR:.*]]     = {{.*}}_NSPoint=dd{{.*}}
// CHECK:      [[SIZE_STR:.*]]      = {{.*}}_NSSize=dd{{.*}}
// CHECK:      [[RECT_STR:.*]]      = {{.*}}_NSRect={_NSPoint=dd}{_NSSize=dd}}{{.*}}
// CHECK:      [[EDGE_STR:.*]]      = {{.*}}NSEdgeInsets=dddd{{.*}}

// CHECK-LABEL: define void @doRange()
void doRange() {
  // CHECK:      [[RANGE:%.*]]      = bitcast %struct._NSRange* {{.*}}
  // CHECK:      call void @llvm.lifetime.start{{.*}}
  // CHECK:      [[RANGE:%.*]]      = bitcast %struct._NSRange* {{.*}}
  // CHECK:      call void @llvm.memcpy{{.*}}[[RANGE]]{{.*}}
  // CHECK:      [[RECV_PTR:%.*]]   = load {{.*}} [[NSVALUE]]
  // CHECK:      [[RANGE_CAST:%.*]] = bitcast %struct._NSRange* {{.*}}
  // CHECK:      [[SEL:%.*]]        = load i8*, i8** [[VALUE_SEL]]
  // CHECK:      [[RECV:%.*]]       = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  NSRange ns_range = { .location = 0, .length = 42 };
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], i8* [[RANGE_CAST]], i8* {{.*}}[[RANGE_STR]]{{.*}})
  NSValue *range = @(ns_range);
  // CHECK:      ret void
}

// CHECK-LABEL: define void @doPoint()
void doPoint() {
  // CHECK:      [[POINT:%.*]]      = bitcast %struct._NSPoint* {{.*}}
  // CHECK:      call void @llvm.lifetime.start{{.*}}
  // CHECK:      [[POINT:%.*]]      = bitcast %struct._NSPoint* {{.*}}
  // CHECK:      call void @llvm.memcpy{{.*}}[[POINT]]{{.*}}
  // CHECK:      [[RECV_PTR:%.*]]   = load {{.*}} [[NSVALUE]]
  // CHECK:      [[POINT_CAST:%.*]] = bitcast %struct._NSPoint* {{.*}}
  // CHECK:      [[SEL:%.*]]        = load i8*, i8** [[VALUE_SEL]]
  // CHECK:      [[RECV:%.*]]       = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  NSPoint ns_point = { .x = 42, .y = 24 };
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], i8* [[POINT_CAST]], i8* {{.*}}[[POINT_STR]]{{.*}})
  NSValue *point = @(ns_point);
  // CHECK:      ret void
}

// CHECK-LABEL: define void @doSize()
void doSize() {
  // CHECK:      [[SIZE:%.*]]      = bitcast %struct._NSSize* {{.*}}
  // CHECK:      call void @llvm.lifetime.start{{.*}}
  // CHECK:      [[SIZE:%.*]]      = bitcast %struct._NSSize* {{.*}}
  // CHECK:      call void @llvm.memcpy{{.*}}[[SIZE]]{{.*}}
  // CHECK:      [[RECV_PTR:%.*]]  = load {{.*}} [[NSVALUE]]
  // CHECK:      [[SIZE_CAST:%.*]] = bitcast %struct._NSSize* {{.*}}
  // CHECK:      [[SEL:%.*]]       = load i8*, i8** [[VALUE_SEL]]
  // CHECK:      [[RECV:%.*]]      = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  NSSize ns_size = { .width = 42, .height = 24 };
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], i8* [[SIZE_CAST]], i8* {{.*}}[[SIZE_STR]]{{.*}})
  NSValue *size = @(ns_size);
  // CHECK:      ret void
}

// CHECK-LABEL: define void @doRect()
void doRect() {
  // CHECK:      [[RECT:%.*]]      = alloca %struct._NSRect{{.*}}
  // CHECK:      [[RECV_PTR:%.*]]  = load {{.*}} [[NSVALUE]]
  // CHECK:      [[RECT_CAST:%.*]] = bitcast %struct._NSRect* [[RECT]] to i8*
  // CHECK:      [[SEL:%.*]]       = load i8*, i8** [[VALUE_SEL]]{{.*}}
  // CHECK:      [[RECV:%.*]]      = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  NSPoint ns_point = { .x = 42, .y = 24 };
  NSSize ns_size = { .width = 42, .height = 24 };
  NSRect ns_rect = { .origin = ns_point, .size = ns_size };
  // CHECK:      call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], i8* [[RECT_CAST]], i8*{{.*}}[[RECT_STR]]{{.*}})
  NSValue *rect = @(ns_rect);
  // CHECK:      ret void
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
  NSValue *edge_insets = @(ns_edge_insets);
  // CHECK:      ret void
}

// CHECK-LABEL: define void @doRangeRValue() 
void doRangeRValue() {
  // CHECK:     [[COERCE:%.*]]          = alloca %struct._NSRange{{.*}}
  // CHECK:     [[RECV_PTR:%.*]]        = load {{.*}} [[NSVALUE]]
  // CHECK:     [[RVAL:%.*]]            = call {{.*}} @getRange()
  // CHECK:     [[COERCE_CAST:%.*]]     = bitcast %struct._NSRange* [[COERCE]]{{.*}}
  // CHECK:     [[COERCE_CAST_PTR:%.*]] = getelementptr {{.*}} [[COERCE_CAST]], {{.*}}
  // CHECK:     [[EXTR_RVAL:%.*]]       = extractvalue {{.*}} [[RVAL]]{{.*}}
  // CHECK:     store {{.*}}[[EXTR_RVAL]]{{.*}}[[COERCE_CAST_PTR]]{{.*}}
  // CHECK:     [[COERCE_CAST:%.*]]     = bitcast %struct._NSRange* [[COERCE]]{{.*}}
  // CHECK:     [[SEL:%.*]]             = load i8*, i8** [[VALUE_SEL]]
  // CHECK:     [[RECV:%.*]]            = bitcast %struct._class_t* [[RECV_PTR]] to i8*
  // CHECK:     call {{.*objc_msgSend.*}}(i8* [[RECV]], i8* [[SEL]], i8* [[COERCE_CAST]], i8* {{.*}}[[RANGE_STR]]{{.*}})
  NSValue *range_rvalue = @(getRange());
  // CHECK: ret void
}

