//
//  HumanInformationView.h
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 1/18/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HumanInformationView : UIView

@property (nonatomic, weak) IBOutlet UILabel      *firstNameLabel;
@property (nonatomic, weak) IBOutlet UILabel      *lastNameLabel;
@property (nonatomic, weak) IBOutlet UILabel      *positionLabel;
@property (nonatomic, weak) IBOutlet UILabel      *carLabel;
@property (nonatomic, weak) IBOutlet UILabel      *noPhotoLabel;
@property (nonatomic, weak) IBOutlet UIImageView  *photoImageView;

- (void)showNoPhotoLabel;

@end
