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

- (LastPropertyType) Last
{
    LastPropertyType t = ^{
        return [self lastObject];
    };
    
    return t;
}

- (LastWithBlockPropertyType) LastWithBlock
{
    LastWithBlockPropertyType t = ^(BoolLambda f) {
        for (int i = [self count] - 1; i >= 0; i--) {
            id obj = [self objectAtIndex:i];
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

- (ZipPropertyType) Zip
{
    ZipPropertyType t = ^(NSArray *second, ZipLambda f) {
        NSMutableArray *arr = [NSMutableArray array];
        
        for (int i = 0; i < [self count] && i < [second count]; i++) {
            id firstObj = [self objectAtIndex:i];
            id secondObj = [second objectAtIndex:i];
            id outObj = f(firstObj, secondObj);
            [arr addObject:outObj];
        }
        
        return arr;
    };
    
    return t;
}

- (GroupByPropertyType) GroupBy
{
    GroupByPropertyType t = ^(GroupByLambda f) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        for (id obj in self) {
            id<NSCopying> key = f(obj);
            id arr = [dict objectForKey:key];
            if (!arr) {
                arr = [NSMutableArray array];
                [dict setObject:arr forKey:key];
            }
            [arr addObject:obj];
        }
        
        return dict;
    };
    
    return t;
}

- (MaxPropertyType) Max
{
    MaxPropertyType t = ^{
        NSNumber *max = nil;
        for (id obj in self) {
            if ([obj isKindOfClass:[NSNumber class]]) {
                if (!max || [max compare:obj] == NSOrderedAscending) {
                    max = obj;
                }
            }
        }
        
        return max;
    };
    
    return t;
}

- (MinPropertyType) Min
{
    MinPropertyType t = ^{
        NSNumber *min = nil;
        for (id obj in self) {
            if ([obj isKindOfClass:[NSNumber class]]) {
                if (!min || [min compare:obj] == NSOrderedDescending) {
                    min = obj;
                }
            }
        }
        
        return min;
    };
    
    return t;
}

- (AveragePropertyType) Average
{
    AveragePropertyType t = ^{

        double sum;
        int count = 0;
        
        for (id obj in self) {
            if ([obj isKindOfClass:[NSNumber class]]) {
                sum += [obj doubleValue];
                count++;
            }
        }
        
        if (!count) {
            return (NSNumber *)nil; // Maybe [NSDecimalNumber notANumber]?
        }
        
        return [NSNumber numberWithDouble:(sum / (double)count)];
    };
    
    return t;
}

@end
