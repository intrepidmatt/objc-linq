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

typedef BOOL (^AllPropertyType)(BoolLambda block);

typedef NSArray *(^DistinctPropertyType)();

@interface NSArray (LINQ)

@property (readonly, nonatomic) SelectPropertyType Select;
@property (readonly, nonatomic) WherePropertyType Where;
@property (readonly, nonatomic) AnyPropertyType Any;
@property (readonly, nonatomic) AnyWithBlockPropertyType AnyWithBlock;
@property (readonly, nonatomic) FirstPropertyType First;
@property (readonly, nonatomic) FirstWithBlockPropertyType FirstWithBlock;
@property (readonly, nonatomic) AllPropertyType All;
@property (readonly, nonatomic) DistinctPropertyType Distinct;

@end
