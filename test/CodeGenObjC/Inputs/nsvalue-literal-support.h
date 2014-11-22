#ifndef OBJC_NSVALUE_LITERAL_SUPPORT_H
#define OBJC_NSVALUE_LITERAL_SUPPORT_H

#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
typedef unsigned long NSUInteger;
typedef double CGFloat;
#else
typedef unsigned int NSUInteger;
typedef float CGFloat;
#endif

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

typedef struct _NSRange {
    NSUInteger location;
    NSUInteger length;
} NSRange;

@interface NSValue
+ (NSValue *)valueWithRange:(NSRange)range;

// OS X specific
+ (NSValue *)valueWithPoint:(NSPoint)point;
+ (NSValue *)valueWithSize:(NSSize)size;
+ (NSValue *)valueWithRect:(NSRect)rect;

// iOS specific
//+ (NSValue *)valueWithCGPoint:(CGPoint)point;
//+ (NSValue *)valueWithCGSize:(CGSize)size;
//+ (NSValue *)valueWithCGRect:(CGRect)rect;
@end

#endif // OBJC_NSVALUE_LITERAL_SUPPORT_H
