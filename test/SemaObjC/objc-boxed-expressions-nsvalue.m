// RUN: %clang_cc1  -fsyntax-only -triple x86_64-apple-macosx10.9 -verify %s

#define BOXABLE __attribute__((objc_boxable))

typedef struct _NSPoint {
  int dummy;
} NSPoint BOXABLE;

typedef struct _NSSize {
  int dummy;
} NSSize BOXABLE;

typedef struct _NSRect {
  int dummy;
} NSRect BOXABLE;

typedef struct _CGPoint {
  int dummy;
} CGPoint BOXABLE;

typedef struct _CGSize {
  int dummy;
} CGSize BOXABLE;

typedef struct _CGRect {
  int dummy;
} CGRect BOXABLE;

typedef struct _NSRange {
  int dummy;
} NSRange BOXABLE;

typedef struct _NSEdgeInsets {
  int dummy;
} NSEdgeInsets;

BOXABLE typedef struct _NSEdgeInsets NSEdgeInsets;

typedef struct _SomeStruct {
  double d;
} SomeStruct;

void checkNSValueDiagnostic() {
  NSRect rect;
  id value = @(rect); // expected-error{{NSValue must be available to use Objective-C boxed expressions}} \
                      // expected-error{{illegal type 'NSRect' (aka 'struct _NSRect') used in a boxed expression}}
}

@interface NSValue

+ (NSValue *)valueWithBytes:(const void *)value objCType:(const char *)type;

@end

int main() {
  NSPoint ns_point;
  id ns_point_value = @(ns_point);

  NSSize ns_size;
  id ns_size_value = @(ns_size);

  NSRect ns_rect;
  id ns_rect_value = @(ns_rect);

  CGPoint cg_point;
  id cg_point_value = @(cg_point);

  CGSize cg_size;
  id cg_size_value = @(cg_size);

  CGRect cg_rect;
  id cg_rect_value = @(cg_rect);

  NSRange ns_range;
  id ns_range_value = @(ns_range);

  NSEdgeInsets edge_insets;
  id edge_insets_object = @(edge_insets);

  SomeStruct s;
  id err = @(s); // expected-error{{illegal type 'SomeStruct' (aka 'struct _SomeStruct') used in a boxed expression}}
}
