#ifndef OBJC_NSVALUE_LITERAL_SUPPORT_H
#define OBJC_NSVALUE_LITERAL_SUPPORT_H

typedef unsigned long NSUInteger;
typedef double CGFloat;

typedef struct _NSRange {
    NSUInteger location;
    NSUInteger length;
} NSRange;

// OS X Specific

typedef struct _NSPoint {
    CGFloat x;
    CGFloat y;
} NSPoint;

typedef struct _NSSize {
    CGFloat width;
    CGFloat height;
} NSSize;

typedef struct _NSRect {
    NSPoint origin;
    NSSize size;
} NSRect;

// iOS Specific

struct CGPoint {
  CGFloat x;
  CGFloat y;
};
typedef struct CGPoint CGPoint;

struct CGSize {
  CGFloat width;
  CGFloat height;
};
typedef struct CGSize CGSize;

struct CGRect {
  CGPoint origin;
  CGSize size;
};
typedef struct CGRect CGRect;

@interface NSValue
+ (NSValue *)valueWithRange:(NSRange)range;

// OS X Specific
+ (NSValue *)valueWithPoint:(NSPoint)point;
+ (NSValue *)valueWithSize:(NSSize)size;
+ (NSValue *)valueWithRect:(NSRect)rect;

// iOS Specific
+ (NSValue *)valueWithCGPoint:(CGPoint)point;
+ (NSValue *)valueWithCGSize:(CGSize)size;
+ (NSValue *)valueWithCGRect:(CGRect)rect;
@end

#endif // OBJC_NSVALUE_LITERAL_SUPPORT_H
