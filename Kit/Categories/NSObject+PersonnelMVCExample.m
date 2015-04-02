//
//  NSObject+PersonnelMVCExample.m
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 4/1/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import "NSObject+PersonnelMVCExample.h"

@implementation NSObject (PersonnelMVCExample)

+ (u_int32_t)randomByIndex:(u_int32_t)index {
    return arc4random() % index;
}

+ (BOOL)randomOneToNumber:(u_int32_t)number {
    u_int32_t i = [self randomByIndex:number] + 1;
    
    if (0 == i % number) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)randomOneToThree {
    return [self randomOneToNumber:3];
}

@end
