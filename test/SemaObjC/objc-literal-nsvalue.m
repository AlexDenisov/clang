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

@interface NSValue
+ (NSValue *)valueWithPoint:(NSPoint)point;
+ (NSValue *)valueWithSize:(NSSize)size;
+ (NSValue *)valueWithRect:(NSRect)rect;

+ (NSValue *)valueWithCGPoint:(CGPoint)point;
+ (NSValue *)valueWithCGSize:(CGSize)size;
+ (NSValue *)valueWithCGRect:(CGRect)rect;

+ (NSValue *)valueWithRange:(NSRange)range;
@end

int main() {
  NSPoint p;
  id point = @(p); // no-warning

  NSSize sz;
  id size = @(sz); // no-warning

  NSRect re;
  id rect = @(re); // no-warning

  CGPoint cgp;
  id cgpoint = @(cgp); // no-warning

  CGSize cgsz;
  id cgsize = @(cgsz); // no-warning

  CGRect cgre;
  id cgrect = @(cgre); // no-warning

  NSRange rn;
  id range = @(rn); // no-warning

  SomeStruct s;
  id err = @(s); // expected-error{{illegal type 'SomeStruct' (aka 'struct _SomeStruct') used in a boxed expression}}
}

