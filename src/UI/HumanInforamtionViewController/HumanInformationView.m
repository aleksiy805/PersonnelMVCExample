//
//  HumanInformationView.m
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 1/18/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import "HumanInformationView.h"
#import "UIImageView+PersonnelMVCExample.h"

@implementation HumanInformationView

- (void)awakeFromNib {
    [self.photoImageView roundCorners];
}

- (void)showNoPhotoLabel {
    self.noPhotoLabel.hidden = NO;
}

@end
