// RUN: %clang_cc1  -fsyntax-only -triple x86_64-apple-macosx10.9 -verify %s

typedef struct _NSPoint {
  int dummy;
} NSPoint;

typedef struct _NSSize {
  int dummy;
} NSSize;

typedef struct _NSRect {
  int dummy;
} NSRect;

@interface NSValue
+ (NSValue *)valueWithPoint:(NSPoint)point __attribute__((availability(macosx, deprecated=10.8, message=""))); // expected-note {{'valueWithPoint:' has been explicitly marked deprecated here}}
+ (NSValue *)valueWithSize:(NSSize)size __attribute__((availability(macosx, unavailable))); // expected-note {{'valueWithSize:' has been explicitly marked unavailable here}}
+ (NSValue *)valueWithRect:(NSRect)rect __attribute__((availability(macosx, introduced=10.10)));
@end

int main() {
  NSPoint ns_point;
  id ns_point_value = @(ns_point); // expected-warning {{'valueWithPoint:' is deprecated: first deprecated in OS X 10.8}}

  NSSize ns_size;
  id ns_size_value = @(ns_size); // expected-error {{'valueWithSize:' is unavailable: not available on OS X}}

  NSRect ns_rect;
  id ns_rect_value = @(ns_rect);
}
