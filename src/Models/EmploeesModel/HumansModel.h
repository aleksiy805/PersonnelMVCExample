//
//  HumansModel.h
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 1/21/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EmployerModel.h"
#import "EmployeeModel.h"

/* Model that generates random humans for tableView filling */
@interface HumansModel : NSObject

@property (nonatomic, readonly) NSArray  *emploees;
@property (nonatomic, readonly) NSArray  *emploers;

- (void)generateModels;
- (void)removeEmploeeAtIndex:(NSUInteger)index;
- (void)removeEmployerAtIndex:(NSUInteger)index;
- (void)replaceEmploeePositionFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
- (void)replaceEmployerPositionFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end
