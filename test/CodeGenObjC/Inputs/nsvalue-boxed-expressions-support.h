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

struct NSEdgeInsets {
  CGFloat top;
  CGFloat left;
  CGFloat bottom;
  CGFloat right;
};
typedef struct NSEdgeInsets NSEdgeInsets;

@interface NSValue
@end

#endif // NSVALUE_BOXED_EXPRESSIONS_SUPPORT_H
