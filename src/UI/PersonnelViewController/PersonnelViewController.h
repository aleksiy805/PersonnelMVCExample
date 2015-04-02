//
//  PersonnelViewController.h
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 1/17/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonnelView;

@interface PersonnelViewController : UIViewController

@property (nonatomic, readonly) PersonnelView  *selfView;

- (IBAction)onRefresh:(id)sender;
- (IBAction)onEdit:(id)sender;

@end

