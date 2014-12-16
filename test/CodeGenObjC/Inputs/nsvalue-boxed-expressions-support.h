#ifndef NSVALUE_BOXED_EXPRESSIONS_SUPPORT_H
#define NSVALUE_BOXED_EXPRESSIONS_SUPPORT_H

typedef unsigned long NSUInteger;
typedef double CGFloat;

typedef struct _NSRange {
    NSUInteger location;
    NSUInteger length;
} NSRange;

typedef struct _NSPoint {
    CGFloat x;
    CGFloat y;
} NSPoint __attribute__((availability(macosx,introduced=10.0)));

typedef struct _NSSize {
    CGFloat width;
    CGFloat height;
} NSSize __attribute__((availability(macosx,introduced=10.0)));

typedef struct _NSRect {
    NSPoint origin;
    NSSize size;
} NSRect __attribute__((availability(macosx,introduced=10.0)));

struct CGPoint {
  CGFloat x;
  CGFloat y;
} __attribute__((availability(ios,introduced=2.0)));
typedef struct CGPoint CGPoint;

struct CGSize {
  CGFloat width;
  CGFloat height;
} __attribute__((availability(ios,introduced=2.0)));
typedef struct CGSize CGSize;

struct CGRect {
  CGPoint origin;
  CGSize size;
} __attribute__((availability(ios,introduced=2.0)));
typedef struct CGRect CGRect;

@interface NSValue
+ (NSValue *)valueWithRange:(NSRange)range;

+ (NSValue *)valueWithPoint:(NSPoint)point __attribute__((availability(macosx, introduced=10.0)));
+ (NSValue *)valueWithSize:(NSSize)size __attribute__((availability(macosx, introduced=10.0)));
+ (NSValue *)valueWithRect:(NSRect)rect __attribute__((availability(macosx, introduced=10.0)));

+ (NSValue *)valueWithCGPoint:(CGPoint)point __attribute__((availability(ios, introduced=2.0)));
+ (NSValue *)valueWithCGSize:(CGSize)size __attribute__((availability(ios, introduced=2.0)));
+ (NSValue *)valueWithCGRect:(CGRect)rect __attribute__((availability(ios, introduced=2.0)));

+ (NSValue *)valueWithPointer:(const void *)pointer;
+ (NSValue *)valueWithNonretainedObject:(id)object;
@end

#endif // NSVALUE_BOXED_EXPRESSIONS_SUPPORT_H
