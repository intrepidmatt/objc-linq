//
//  AppDelegate.m
//  linqtest
//
//  Created by Matt Bridges on 11/10/12.
//  Copyright (c) 2012 Matt Bridges. All rights reserved.
//

#import "AppDelegate.h"
#import "NSArray+LINQ.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSArray *arr = @[@"apple", @"banana", @"cherry", @"awesome"];
    NSArray *newArr = arr
        .Take(3)
        .SkipWhile(^(id obj) { return [obj hasPrefix:@"a"]; })
        .Select(^(id obj) { return [obj uppercaseString]; });
    
    NSLog(@"%@", newArr);
    
    BOOL hasWordThatStartsWithA = newArr.AnyWithBlock(^(id obj) {
        return [obj hasPrefix:@"A"];
    });
    
    NSLog(@"%@", hasWordThatStartsWithA ? @"YES" : @"NO");
    
    NSDictionary *grouped = arr.GroupBy(^(id obj) {
        return [obj substringToIndex:1];
    });
    
    NSLog(@"%@", grouped);
    
    NSNumber *avgLength = arr
    .Select(^(id obj) { return [NSNumber numberWithInt:[obj length]]; })
    .Average();
    
    NSLog(@"%@", avgLength);
    
    NSArray *numberArr = @[@1, @1, @2, @3, @5, @8, @13];
    int min = [numberArr.Min() intValue];
    int max = [numberArr.Max() intValue];
    double avg = [numberArr.Average() doubleValue];
    
    NSLog(@"Min: %d\nMax: %d\nAvg: %g", min, max, avg);
    
    NSNumber *maxEven = numberArr.Where(^(id obj) { return (BOOL)([obj intValue] % 2 == 0); }).Max();
    NSLog(@"%@", maxEven);
    
    
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
