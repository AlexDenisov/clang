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

@interface NSCountedSet : NSMutableSet

@end

@interface NSMutableOrderedSet

- (void)addObject:(id)object;
- (void)insertObject:(id)object atIndex:(NSUInteger)index;
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object;
- (void)setObject:(id)object atIndex:(NSUInteger)index;

@end

@interface SelfRefClass 
{
  NSMutableArray *_array;
  NSMutableDictionary *_dictionary;
  NSMutableSet *_set;
  NSCountedSet *_countedSet;
  NSMutableOrderedSet *_orderedSet;
}
@end

@implementation SelfRefClass

- (void)check {
  [_array addObject:_array]; // expected-warning {{attempt to insert array into itself}}
  [_dictionary setObject:_dictionary forKey:@"key"]; // expected-warning {{attempt to insert dictionary into itself}}
  [_set addObject:_set]; // expected-warning {{attempt to insert set into itself}}
  [_countedSet addObject:_countedSet]; // expected-warning {{attempt to insert counted set into itself}}
  [_orderedSet addObject:_orderedSet]; // expected-warning {{attempt to insert ordered set into itself}}
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

- (void)checkNSCountedSet:(NSCountedSet *)s {
  [s addObject:s]; // expected-warning {{attempt to insert counted set into itself}}
}

- (void)checkNSMutableOrderedSet:(NSMutableOrderedSet *)s {
  [s addObject:s]; // expected-warning {{attempt to insert ordered set into itself}}
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

void checkNSCountedSetParam(NSCountedSet *s) {
  [s addObject:s]; // expected-warning {{attempt to insert counted set into itself}}
}

void checkNSMutableOrderedSetParam(NSMutableOrderedSet *s) {
  [s addObject:s]; // expected-warning {{attempt to insert ordered set into itself}}
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

void checkNSCountedSet() {
  NSCountedSet *s = nil;

  [s addObject:s]; // expected-warning {{attempt to insert counted set into itself}}
}

void checkNSMutableOrderedSet() {
  NSMutableOrderedSet *s = nil;

  [s addObject:s]; // expected-warning {{attempt to insert ordered set into itself}}
  [s insertObject:s atIndex:0]; // expected-warning {{attempt to insert ordered set into itself}}
  [s setObject:s atIndex:0]; // expected-warning {{attempt to insert ordered set into itself}}
  [s setObject:s atIndexedSubscript:0]; // expected-warning {{attempt to insert ordered set into itself}}
  [s replaceObjectAtIndex:0 withObject:s]; // expected-warning {{attempt to insert ordered set into itself}}
}

