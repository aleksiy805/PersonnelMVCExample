//
//  NSObject+PersonnelMVCExample.h
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 4/1/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PersonnelMVCExample)

+ (u_int32_t)randomByIndex:(u_int32_t)index;
+ (BOOL)randomOneToNumber:(u_int32_t)number;
+ (BOOL)randomOneToThree;

@end
