#ifndef NSVALUE_BOXED_EXPRESSIONS_SUPPORT_H
#define NSVALUE_BOXED_EXPRESSIONS_SUPPORT_H

#define BOXABLE __attribute__((objc_boxable))

typedef unsigned long NSUInteger;
typedef double CGFloat;

BOXABLE typedef struct _NSRange {
    NSUInteger location;
    NSUInteger length;
} NSRange;

BOXABLE typedef struct _NSPoint {
    CGFloat x;
    CGFloat y;
} NSPoint;

BOXABLE typedef struct _NSSize {
    CGFloat width;
    CGFloat height;
} NSSize;

BOXABLE typedef struct _NSRect {
    NSPoint origin;
    NSSize size;
} NSRect;

struct CGPoint {
  CGFloat x;
  CGFloat y;
};
BOXABLE typedef struct CGPoint CGPoint;

struct CGSize {
  CGFloat width;
  CGFloat height;
};
BOXABLE typedef struct CGSize CGSize;

struct CGRect {
  CGPoint origin;
  CGSize size;
};
BOXABLE typedef struct CGRect CGRect;

struct NSEdgeInsets {
  CGFloat top;
  CGFloat left;
  CGFloat bottom;
  CGFloat right;
};
BOXABLE typedef struct NSEdgeInsets NSEdgeInsets;

@interface NSValue

+ (NSValue *)valueWithBytes:(const void *)value objCType:(const char *)type;

@end

#endif // NSVALUE_BOXED_EXPRESSIONS_SUPPORT_H
