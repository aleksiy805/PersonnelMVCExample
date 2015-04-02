//
//  EmployeeModel.m
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 1/21/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import "EmployeeModel.h"

@implementation EmployeeModel

+ (NSString *)generatePosition {
    NSUInteger index = [self randomByIndex:3];
    NSString *position = nil;
    
    switch (index) {
        case 0:
            position = @"Engineer";
            break;
        
        case 1:
            position = @"Manager";
            break;
            
        case 2:
            position = @"Secretary";
            break;
            
        default:
            break;
    }
    
    return position;
}

@end
