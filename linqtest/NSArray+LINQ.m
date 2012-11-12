//
//  NSArray+LINQ.m
//  linqtest
//
//  Created by Matt Bridges on 11/10/12.
//  Copyright (c) 2012 Matt Bridges. All rights reserved.
//

#import "NSArray+LINQ.h"

@implementation NSArray (LINQ)

- (SelectPropertyType) Select
{
    SelectPropertyType t = ^(SelectLambda f) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:[self count]];
        
        for (id obj in self) {
            [arr addObject:f(obj)];
        }
        
        return arr;
    };
    
    return t;
}

- (WherePropertyType) Where
{
    WherePropertyType t = ^(BoolLambda f) {
        NSMutableArray *arr = [NSMutableArray array];
        
        for (id obj in self) {
            if (f(obj)) {
                [arr addObject:obj];
            }
        }
        
        return arr;
    };
    
    return t;
}

- (AnyPropertyType) Any
{
    AnyPropertyType t = ^{
        if ([self count] > 0) {
            return YES;
        } else {
            return NO;
        }
    };
    
    return t;
}

- (AnyWithBlockPropertyType) AnyWithBlock
{
    AnyWithBlockPropertyType t = ^(BoolLambda f) {
        for (id obj in self) {
            if (f(obj)) {
                return YES;
            }
        }
        
        return NO;
    };
    
    return t;
}

- (FirstPropertyType) First
{
    FirstPropertyType t = ^{
        if ([self count] > 0) {
            return [self objectAtIndex:0];
        } else {
            return (id)nil;
        }
    };
    
    return t;
}

- (FirstWithBlockPropertyType) FirstWithBlock
{
    FirstWithBlockPropertyType t = ^(BoolLambda f) {
        for (id obj in self) {
            if (f(obj)) {
                return obj;
            }
        }
        
        return (id)nil;
    };
    
    return t;
}

- (AllPropertyType) All
{
    AllPropertyType t = ^(BoolLambda f) {
        for (id obj in self) {
            if (!f(obj)) {
                return NO;
            }
        }
        
        return YES;
    };
    
    return t;
}

- (DistinctPropertyType) Distinct
{
    DistinctPropertyType t = ^{
        NSSet *set = [NSSet setWithArray:self];
        return [set allObjects];
    };
    
    return t;
}

- (TakePropertyType) Take
{
    TakePropertyType t = ^(NSUInteger n){
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:n];
        NSUInteger c = MIN(n, [self count]);
        for (NSUInteger i = 0; i < c; i++) {
            [arr addObject:[self objectAtIndex:i]];
        }
        
        return arr;
    };
    
    return t;
}

- (TakeWhilePropertyType) TakeWhile
{
    TakeWhilePropertyType t = ^(BoolLambda f) {
        NSMutableArray *arr = [NSMutableArray array];
        for (id obj in self) {
            if (!f(obj)) {
                break;
            }
            
            [arr addObject:obj];
        }
        
        return arr;
    };
    
    return t;
}

- (SkipPropertyType) Skip
{
    SkipPropertyType t = ^(NSUInteger n)
    {
        NSMutableArray *arr = [NSMutableArray array];
        
        for (NSUInteger i = n; i < [self count]; i++) {
            [arr addObject: [self objectAtIndex: i]];
        }
        
        return arr;
    };
    
    return t;
}

- (SkipWhilePropertyType) SkipWhile
{
    SkipWhilePropertyType t = ^(BoolLambda f) {
        NSMutableArray *arr = [NSMutableArray array];
        BOOL skip = YES;
        for (id obj in self) {
            if (skip && !f(obj)) {
                skip = NO;
            }
            if (!skip) {
                [arr addObject:obj];
            }
        }
        
        return arr;
    };
    
    return t;
}


@end
