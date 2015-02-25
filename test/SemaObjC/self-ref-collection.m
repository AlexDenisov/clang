// RUN: %clang_cc1 -triple x86_64-apple-darwin11 -fsyntax-only -fobjc-arc -verify -Wno-objc-root-class %s

typedef long int NSUInteger;
#define nil 0

@interface NSMutableArray

- (void)addObject:(id)object;
- (void)insertObject:(id)object atIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object;
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

@end

@interface Wrapper

@property NSMutableArray *array;

@end

void checkNSMutableArray() {
  NSMutableArray *array = nil;

  [array addObject:array]; // expected-warning {{attempt to insert array into itself}}
  [array insertObject:array atIndex:0]; // expected-warning {{attempt to insert array into itself}}
  [array replaceObjectAtIndex:0 withObject:array]; // expected-warning {{attempt to insert array into itself}}
  [array setObject:array atIndexedSubscript:0]; // expected-warning {{attempt to insert array into itself}}
  array[0] = array; // expected-warning {{attempt to insert array into itself}}
}

