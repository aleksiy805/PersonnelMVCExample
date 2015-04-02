//
//  HumanInformationViewController.h
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 1/18/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HumanModel;
@class HumanInformationView;

@interface HumanInformationViewController : UIViewController

@property (nonatomic, strong)   HumanModel            *humanModel;
@property (nonatomic, readonly) HumanInformationView  *selfView;

- (void)setUpController;

@end
