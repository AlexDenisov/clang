// RUN: rm -rf %t
// RUN: %clang_cc1 -fobjc-arc -objcmt-migrate-literals -mt-migrate-directory %t %s -x objective-c
// RUN: c-arcmt-test -mt-migrate-directory %t | arcmt-test -verify-transformed-files %s.result
// R_UN: %clang_cc1 -triple x86_64-apple-darwin10 -fsyntax-only -x objective-c %s.result

typedef unsigned long NSUInteger;
typedef double CGFloat;

typedef struct _NSRange {
    NSUInteger location;
    NSUInteger length;
} NSRange;

typedef struct CATransform3D
{
  CGFloat m11, m12, m13, m14;
  CGFloat m21, m22, m23, m24;
  CGFloat m31, m32, m33, m34;
  CGFloat m41, m42, m43, m44;
} CATransform3D;

typedef struct CGPoint {
    CGFloat x;
    CGFloat y;
} CGPoint;

typedef struct CGSize {
    CGFloat width;
    CGFloat height;
} CGSize;

typedef struct CGVector {
    CGFloat dx;
    CGFloat dy;
} CGVector;

typedef struct CGRect {
    CGPoint origin;
    CGSize size;
} CGRect;

typedef struct UIEdgeInsets {
    CGFloat top, left, bottom, right;
} UIEdgeInsets;

typedef struct UIOffset {
    CGFloat horizontal, vertical;
} UIOffset;

typedef struct CGAffineTransform {
  CGFloat a, b, c, d;
  CGFloat tx, ty;
} CGAffineTransform;

typedef CGPoint NSPoint;
typedef CGSize NSSize;
typedef CGRect NSRect;

typedef struct NSEdgeInsets {
    CGFloat top;
    CGFloat left;
    CGFloat bottom;
    CGFloat right;
} NSEdgeInsets;

typedef struct CustomStruct {
    int dummy;
} CustomStruct;

typedef struct AnotherCustomStruct {
    int dummy;
} AnotherCustomStruct;

@interface NSObject @end

@interface NSValue : NSObject

+ (NSValue *)valueWithCGPoint:(CGPoint)point;
+ (NSValue *)valueWithCGVector:(CGVector)vector;
+ (NSValue *)valueWithCGSize:(CGSize)size;
+ (NSValue *)valueWithCGRect:(CGRect)rect;
+ (NSValue *)valueWithCGAffineTransform:(CGAffineTransform)transform;
+ (NSValue *)valueWithUIEdgeInsets:(UIEdgeInsets)insets;
+ (NSValue *)valueWithUIOffset:(UIOffset)insets;

+ (NSValue *)valueWithRange:(NSRange)range;
+ (NSValue *)valueWithCATransform3D:(CATransform3D)t;

+ (NSValue *)valueWithPoint:(NSPoint)point;
+ (NSValue *)valueWithSize:(NSSize)size;
+ (NSValue *)valueWithRect:(NSRect)rect;
+ (NSValue *)valueWithEdgeInsets:(NSEdgeInsets)insets;

+ (NSValue *)valueWithBytes:(const void *)value objCType:(const char *)type;

@end

static CGPoint cg_point;
static CGVector cg_vector;
static CGSize cg_size;
static CGRect cg_rect;
static CGAffineTransform ca_affineTransform;
static UIEdgeInsets ui_edgeInsets;
static UIOffset ui_offset;
static NSRange ns_range;
static CATransform3D ca_transform3D;
static NSPoint ns_point;
static NSSize ns_size;
static NSRect ns_rect;
static NSEdgeInsets ns_edgeInsets;
static CustomStruct customStruct;
static AnotherCustomStruct anotherCustomStruct;

void noBoxableStructsAvailableYet() {
  [NSValue valueWithCGPoint:cg_point];
  [NSValue valueWithCGVector:cg_vector];
  [NSValue valueWithCGSize:cg_size];
  [NSValue valueWithCGRect:cg_rect];
  [NSValue valueWithCGAffineTransform:ca_affineTransform];
  [NSValue valueWithUIEdgeInsets:ui_edgeInsets];
  [NSValue valueWithUIOffset:ui_offset];

  [NSValue valueWithRange:ns_range];
  [NSValue valueWithCATransform3D:ca_transform3D];

  [NSValue valueWithPoint:ns_point];
  [NSValue valueWithSize:ns_size];
  [NSValue valueWithRect:ns_rect];
  [NSValue valueWithEdgeInsets:ns_edgeInsets];

  [NSValue valueWithBytes:&customStruct objCType:@encode(CustomStruct)];
  [NSValue valueWithBytes:&anotherCustomStruct objCType:@encode(AnotherCustomStruct)];
}

#define BOXABLE __attribute__((objc_boxable))

typedef struct BOXABLE _NSRange NSRange;
typedef struct BOXABLE CATransform3D CATransform3D;
typedef struct BOXABLE CGPoint CGPoint;
typedef struct BOXABLE CGSize CGSize;
typedef struct BOXABLE CGVector CGVector;
typedef struct BOXABLE CGRect CGRect;
typedef struct BOXABLE UIEdgeInsets UIEdgeInsets;
typedef struct BOXABLE UIOffset UIOffset;
typedef struct BOXABLE CGAffineTransform CGAffineTransform;
typedef struct BOXABLE CGPoint NSPoint;
typedef struct BOXABLE CGSize NSSize;
typedef struct BOXABLE CGRect NSRect;
typedef struct BOXABLE NSEdgeInsets NSEdgeInsets;
typedef struct BOXABLE CustomStruct CustomStruct;

void boxableStructsAvailable() {
  [NSValue valueWithCGPoint:cg_point];
  [NSValue valueWithCGVector:cg_vector];
  [NSValue valueWithCGSize:cg_size];
  [NSValue valueWithCGRect:cg_rect];
  [NSValue valueWithCGAffineTransform:ca_affineTransform];
  [NSValue valueWithUIEdgeInsets:ui_edgeInsets];
  [NSValue valueWithUIOffset:ui_offset];

  [NSValue valueWithRange:ns_range];
  [NSValue valueWithCATransform3D:ca_transform3D];

  [NSValue valueWithPoint:ns_point];
  [NSValue valueWithSize:ns_size];
  [NSValue valueWithRect:ns_rect];
  [NSValue valueWithEdgeInsets:ns_edgeInsets];

  [NSValue valueWithBytes:&customStruct objCType:@encode(CustomStruct)];
  [NSValue valueWithBytes:&anotherCustomStruct objCType:@encode(AnotherCustomStruct)];
}

