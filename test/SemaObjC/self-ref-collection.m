// RUN: %clang_cc1 -triple x86_64-apple-darwin11 -fsyntax-only -fobjc-arc -verify -Wno-objc-root-class %s

typedef long int NSUInteger;
#define nil 0

@interface NSMutableArray

- (void)addObject:(id)object;
- (void)insertObject:(id)object atIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object;
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

@end

@interface SelfRefClass 
{
  NSMutableArray *_array;
}
@end

@implementation SelfRefClass

- (void)check {
  [_array addObject:_array]; // expected-warning {{attempt to insert array into itself}}
}

- (void)checkNSMutableArray:(NSMutableArray *)array {
  [array addObject:array]; // expected-warning {{attempt to insert array into itself}}
}

@end

void checkNSMutableArrayParam(NSMutableArray *_param) {
  [_param addObject:_param]; // expected-warning {{attempt to insert array into itself}}
}

void checkNSMutableArray() {
  NSMutableArray *array = nil;

  [array addObject:array]; // expected-warning {{attempt to insert array into itself}}
  [array insertObject:array atIndex:0]; // expected-warning {{attempt to insert array into itself}}
  [array replaceObjectAtIndex:0 withObject:array]; // expected-warning {{attempt to insert array into itself}}
  [array setObject:array atIndexedSubscript:0]; // expected-warning {{attempt to insert array into itself}}
  array[0] = array; // expected-warning {{attempt to insert array into itself}}
}

