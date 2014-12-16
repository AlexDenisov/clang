// RUN: %clang_cc1  -fsyntax-only -fblocks -triple x86_64-apple-darwin10 -verify %s

typedef struct _NSPoint {
  int dummy;
} NSPoint;

typedef struct _NSSize {
  int dummy;
} NSSize;

typedef struct _NSRect {
  int dummy;
} NSRect;

typedef struct _CGPoint {
  int dummy;
} CGPoint;

typedef struct _CGSize {
  int dummy;
} CGSize;

typedef struct _CGRect {
  int dummy;
} CGRect;

typedef struct _NSRange {
  int dummy;
} NSRange;

typedef struct _SomeStruct {
  double d;
} SomeStruct;

@interface NSObject @end

@interface ObjCObject @end

void checkNSValueDiagnostic() {
  NSRect rect;
  id value = @(rect); // expected-error{{NSValue must be available to use Objective-C boxed expressions}} \
                      // expected-error{{illegal type 'NSRect' (aka 'struct _NSRect') used in a boxed expression}}
}

@interface NSValue
+ (NSValue *)valueWithPoint:(NSPoint)point;
+ (NSValue *)valueWithSize:(NSSize)size;
+ (NSValue *)valueWithRect:(NSRect)rect;

+ (NSValue *)valueWithCGPoint:(CGPoint)point;
+ (NSValue *)valueWithCGSize:(CGSize)size;
+ (NSValue *)valueWithCGRect:(CGRect)rect;

+ (NSValue *)valueWithRange:(NSRange)range;

+ (NSValue *)valueWithPointer:(const void *)pinter;
+ (NSValue *)valueWithNonretainedObject:(id)anObject;
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

  const void *void_pointer;
  id void_pointer_value = @(void_pointer);

  id id_object;
  id id_object_value = @(id_object);

  NSObject *ns_object;
  id ns_object_value = @(ns_object);

  ObjCObject *objc_object;
  id objc_object_value = @(objc_object);

  SomeStruct s;
  id err = @(s); // expected-error{{illegal type 'SomeStruct' (aka 'struct _SomeStruct') used in a boxed expression}}
}
