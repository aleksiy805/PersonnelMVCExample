//
//  HumanViewCell.h
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 3/23/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HumanModel;

// ViewCell Abstract Class
@interface HumanViewCell : UITableViewCell

/* This is an exception when view (HumanViewCell) and model (HumanModel) can directly interact.
 This is so convenient if one cell will be maintain one model */
@property (nonatomic, strong) HumanModel            *model;

@property (nonatomic, weak)   IBOutlet UILabel      *nameLabel;
@property (nonatomic, weak)   IBOutlet UIImageView  *photoImageView;
@property (nonatomic, weak)   IBOutlet UILabel      *noPhotoLabel;

@end
