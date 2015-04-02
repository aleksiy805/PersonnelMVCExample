//
//  HumanViewCell.m
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 3/23/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import "HumanViewCell.h"
#import "HumanModel.h"
#import "UIImageView+PersonnelMVCExample.h"

@interface HumanViewCell () <SimpleObservableModelDelegate>
@end

@implementation HumanViewCell

#pragma mark -
#pragma mark View's Lifecircle

- (void)awakeFromNib {
    [self.photoImageView roundCorners];
}

#pragma mark -
#pragma mark Accessors

- (void)setModel:(HumanModel *)model {
    if (_model != model) {
        [_model removeObserver:self];
        _model = model;
        if (model) {
            [model addObserver:self];
            if (SimpleObservableModelNotLoaded == self.model.state) {
                [self photoImageViewSetVisible:NO animated:NO];
                [model load];
            } else if (SimpleObservableModelLoaded == self.model.state) {
                UIImage *image = model.thumbnailImage;
                
                [self photoImageViewSetVisible:YES animated:NO];
                if (image) {
                    self.photoImageView.image = image;
                } else {
                    [self showNoPhotoLabel:YES];
                }
            }
        }
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)prepareForReuse {
    self.photoImageView.image = nil;
    [self showNoPhotoLabel:NO];
}

- (void)photoImageViewSetVisible:(BOOL)visible animated:(BOOL)animated {
    [UIView animateWithDuration:(animated) ? 0.2f : 0.f
                     animations:^{
                         self.photoImageView.alpha = (visible) ? 1.f : 0.f;
                     }];
}

- (void)showNoPhotoLabel:(BOOL)show {
    self.noPhotoLabel.hidden = !show;
}

#pragma mark -
#pragma mark SimpleObservableModelDelegate

- (void)modelDidLoad:(id)model {
    HumanModel *humanModel = model;
    UIImage *image = humanModel.thumbnailImage;
    UIImageView *photoImageView = self.photoImageView;
    
    photoImageView.image = image;
    [self photoImageViewSetVisible:YES animated:YES];
    if (!image) {
        [self showNoPhotoLabel:YES];
    }
}

- (void)modelDidFailToLoad:(id)model {
    [self showNoPhotoLabel:NO];
}

@end
