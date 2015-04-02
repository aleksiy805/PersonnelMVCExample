//
//  EmployerModel.m
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 1/21/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import "EmployerModel.h"

@implementation EmployerModel

+ (NSString *)generatePosition {
    NSUInteger index = [self randomByIndex:2];
    NSString *position = nil;
    
    switch (index) {
        case 0:
            position = @"Division director";
            break;
            
        case 1:
            position = @"Head of department";
            break;
            
        default:
            break;
    }
    
    return position;
}

@end
