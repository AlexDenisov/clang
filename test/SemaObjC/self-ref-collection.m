// RUN: %clang_cc1 -triple x86_64-apple-darwin11 -fsyntax-only -fobjc-arc -verify -Wno-objc-root-class %s

typedef long int NSUInteger;
#define nil 0
@class NSString;

@interface NSMutableArray

- (void)addObject:(id)object;
- (void)insertObject:(id)object atIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object;
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

@end

@interface NSMutableDictionary

- (void)setObject:(id)object forKey:(id)key;
- (void)setObject:(id)object forKeyedSubscript:(id)key;
- (void)setValue:(id)value forKey:(NSString *)key;

@end

@interface NSMutableSet

- (void)addObject:(id)object;

@end

@interface SelfRefClass 
{
  NSMutableArray *_array;
  NSMutableDictionary *_dictionary;
  NSMutableSet *_set;
}
@end

@implementation SelfRefClass

- (void)check {
  [_array addObject:_array]; // expected-warning {{attempt to insert array into itself}}
  [_dictionary setObject:_dictionary forKey:@"key"]; // expected-warning {{attempt to insert dictionary into itself}}
  [_set addObject:_set]; // expected-warning {{attempt to insert set into itself}}
}

- (void)checkNSMutableArray:(NSMutableArray *)a {
  [a addObject:a]; // expected-warning {{attempt to insert array into itself}}
}

- (void)checkNSMutableDictionary:(NSMutableDictionary *)d {
  [d setObject:d forKey:@"key"]; // expected-warning {{attempt to insert dictionary into itself}}
}

- (void)checkNSMutableSet:(NSMutableSet *)s {
  [s addObject:s]; // expected-warning {{attempt to insert set into itself}}
}

@end

void checkNSMutableArrayParam(NSMutableArray *a) {
  [a addObject:a]; // expected-warning {{attempt to insert array into itself}}
}

void checkNSMutableDictionaryParam(NSMutableDictionary *d) {
  [d setObject:d forKey:@"key"]; // expected-warning {{attempt to insert dictionary into itself}}
}

void checkNSMutableSetParam(NSMutableSet *s) {
  [s addObject:s]; // expected-warning {{attempt to insert set into itself}}
}

void checkNSMutableArray() {
  NSMutableArray *a = nil;

  [a addObject:a]; // expected-warning {{attempt to insert array into itself}}
  [a insertObject:a atIndex:0]; // expected-warning {{attempt to insert array into itself}}
  [a replaceObjectAtIndex:0 withObject:a]; // expected-warning {{attempt to insert array into itself}}
  [a setObject:a atIndexedSubscript:0]; // expected-warning {{attempt to insert array into itself}}
  a[0] = a; // expected-warning {{attempt to insert array into itself}}
}

void checkNSMutableDictionary() {
  NSMutableDictionary *d = nil;

  [d setObject:d forKey:@"key"]; // expected-warning {{attempt to insert dictionary into itself}}
  [d setObject:d forKeyedSubscript:@"key"]; // expected-warning {{attempt to insert dictionary into itself}}
  [d setValue:d forKey:@"key"]; // expected-warning {{attempt to insert dictionary into itself}}
  d[@"key"] = d; // expected-warning {{attempt to insert dictionary into itself}}
}

void checkNSMutableSet() {
  NSMutableSet *s = nil;

  [s addObject:s]; // expected-warning {{attempt to insert set into itself}}
}

