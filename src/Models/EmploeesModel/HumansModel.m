//
//  HumansModel.m
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 1/21/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import "HumansModel.h"

@interface HumansModel ()
@property (nonatomic, strong) NSMutableArray  *emploeesMutable;
@property (nonatomic, strong) NSMutableArray  *emploersMutable;
@end

@implementation HumansModel

@dynamic emploees;
@dynamic emploers;

#pragma mark -
#pragma mark Accessors

- (NSArray *)emploees {
    return [self.emploeesMutable copy];
}

- (NSArray *)emploers {
    return [self.emploersMutable copy];
}

#pragma mark -
#pragma mark Public Methods

- (void)generateModels {
    NSUInteger emploersCount = 5;
    NSUInteger emploeesCount = 20;
    NSMutableArray *emploers = [NSMutableArray array];
    NSMutableArray *emploees = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < emploersCount; i ++) {
        EmployerModel *model = [EmployerModel new];
        
        model.firstName = [NSString stringWithFormat:@"First Name %lu", i + 1];
        model.lastName = [NSString stringWithFormat:@"Last Name %lu", i + 1];
        model.thumbnailName = ([NSObject randomOneToThree]) ? nil : @"thumbnail_emploer.png";
        model.position = [EmployerModel generatePosition];
        model.carModel = @"Mercedes";
        [emploers addObject:model];
    }
    for (NSUInteger i = 0; i < emploeesCount; i ++) {
        EmployeeModel *model = [EmployeeModel new];
        
        model.firstName = [NSString stringWithFormat:@"First Name %lu", i + 1];
        model.lastName = [NSString stringWithFormat:@"Last Name %lu", i + 1];
        model.thumbnailName = ([NSObject randomOneToThree]) ? nil : @"thumbnail_emploee.png";
        model.position = [EmployeeModel generatePosition];
        [emploees addObject:model];
    }
    self.emploersMutable = emploers;
    self.emploeesMutable = emploees;
}

- (void)removeEmploeeAtIndex:(NSUInteger)index {
    [self.emploeesMutable removeObjectAtIndex:index];
}

- (void)removeEmployerAtIndex:(NSUInteger)index {
    [self.emploersMutable removeObjectAtIndex:index];
}

- (void)replaceEmploeePositionFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    [self replaceHumanPositionFromIndex:fromIndex
                                toIndex:toIndex
                               forArray:self.emploeesMutable];
}

- (void)replaceEmployerPositionFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    [self replaceHumanPositionFromIndex:fromIndex
                                toIndex:toIndex
                               forArray:self.emploersMutable];
}

#pragma mark -
#pragma mark Private Methods

- (void)replaceHumanPositionFromIndex:(NSUInteger)fromIndex
                              toIndex:(NSUInteger)toIndex
                             forArray:(NSMutableArray *)array
{
    HumanModel *humanModel = [array objectAtIndex:fromIndex];
    
    [array removeObject:humanModel];
    [array insertObject:humanModel atIndex:toIndex];
}

@end
