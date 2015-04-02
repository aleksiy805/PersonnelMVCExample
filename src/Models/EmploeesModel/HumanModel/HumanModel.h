//
//  HumanModel.h
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 1/21/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleObservableModel.h"
#import "NSObject+PersonnelMVCExample.h"

// EmployerModel's and EmployeeModel's metaclass
@interface HumanModel : SimpleObservableModel

@property (nonatomic, copy)     NSString  *firstName;
@property (nonatomic, copy)     NSString  *lastName;
@property (nonatomic, copy)     NSString  *position;

@property (nonatomic, readonly) UIImage   *thumbnailImage;
@property (nonatomic, copy)     NSString  *thumbnailName;

+ (instancetype)humanModel;
+ (NSString *)generatePosition;

@end
