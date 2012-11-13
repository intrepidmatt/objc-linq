//
//  NSArray+LINQ.h
//  linqtest
//
//  Created by Matt Bridges on 11/10/12.
//  Copyright (c) 2012 Matt Bridges. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^SelectLambda)(id elem);
typedef NSArray *(^SelectPropertyType)(SelectLambda block);
typedef BOOL (^BoolLambda)(id elem);
typedef NSArray *(^WherePropertyType)(BoolLambda block);
typedef BOOL (^AnyPropertyType)();
typedef BOOL (^AnyWithBlockPropertyType)();
typedef id (^FirstPropertyType)();
typedef id (^FirstWithBlockPropertyType)(BoolLambda block);
typedef id (^LastPropertyType)();
typedef id (^LastWithBlockPropertyType)(BoolLambda block);
typedef BOOL (^AllPropertyType)(BoolLambda block);
typedef NSArray *(^DistinctPropertyType)();
typedef NSArray *(^TakePropertyType)(NSUInteger n);
typedef NSArray *(^TakeWhilePropertyType)(BoolLambda block);
typedef NSArray *(^SkipPropertyType)(NSUInteger n);
typedef NSArray *(^SkipWhilePropertyType)(BoolLambda block);
typedef id (^ZipLambda)(id elem1, id elem2);
typedef NSArray *(^ZipPropertyType)(NSArray *second, ZipLambda block);
typedef id<NSCopying> (^GroupByLambda)(id obj);
typedef NSDictionary *(^GroupByPropertyType)(GroupByLambda block);

@interface NSArray (LINQ)

@property (readonly) SelectPropertyType Select;
@property (readonly) WherePropertyType Where;
@property (readonly) AnyPropertyType Any;
@property (readonly) AnyWithBlockPropertyType AnyWithBlock;
@property (readonly) FirstPropertyType First;
@property (readonly) FirstWithBlockPropertyType FirstWithBlock;
@property (readonly) LastPropertyType Last;
@property (readonly) LastWithBlockPropertyType LastWithBlock;
@property (readonly) AllPropertyType All;
@property (readonly) DistinctPropertyType Distinct;
@property (readonly) TakePropertyType Take;
@property (readonly) TakeWhilePropertyType TakeWhile;
@property (readonly) SkipPropertyType Skip;
@property (readonly) SkipWhilePropertyType SkipWhile;
@property (readonly) ZipPropertyType Zip;
@property (readonly) GroupByPropertyType GroupBy;

@end
