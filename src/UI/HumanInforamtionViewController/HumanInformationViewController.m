//
//  HumanInformationViewController.m
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 1/18/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import "HumanInformationViewController.h"
#import "HumanInformationView.h"
#import "EmployerModel.h"
#import "EmployeeModel.h"

@interface HumanInformationViewController () <SimpleObservableModelDelegate>
@property (nonatomic, assign) BOOL  configured;
@end

@implementation HumanInformationViewController

@dynamic selfView;

#pragma mark -
#pragma mark Initializations And Deallocations

- (void)dealloc {
//    [self.humanModel dump];
    [self.humanModel removeObserver:self];
}

#pragma mark -
#pragma mark View's Lifecircle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (NO == self.configured) {
        [self setUpController];
        self.configured = YES;
    }
}

#pragma mark -
#pragma mark Accessors

- (HumanInformationView *)selfView {
    if ([self.view isKindOfClass:[HumanInformationView class]]) {
        return (HumanInformationView *)self.view;
    }
    
    return nil;
}

#pragma mark -
#pragma mark Private Methods

- (void)setUpController {
    HumanModel *humanModel = self.humanModel;
    HumanInformationView *view = self.selfView;
    
    view.firstNameLabel.text = humanModel.firstName;
    view.lastNameLabel.text = humanModel.lastName;
    view.positionLabel.text = humanModel.position;
    view.carLabel.text = nil;
    if ([humanModel isMemberOfClass:[EmployerModel class]]) {
        EmployerModel *emploerModel = (EmployerModel *)humanModel;
        
        view.carLabel.text = emploerModel.carModel;
    }
    [humanModel addObserver:self];
    if (SimpleObservableModelLoaded == humanModel.state && nil == humanModel.thumbnailImage) {
        [self.selfView showNoPhotoLabel];
    } else if (SimpleObservableModelNotLoaded == humanModel.state) {
        [humanModel load];
    } else {
        view.photoImageView.image = humanModel.thumbnailImage;
    }
}

#pragma mark -
#pragma mark SimpleObservableModelDelegate

- (void)modelDidLoad:(id)model {
    UIImage *image = self.humanModel.thumbnailImage;
    
    if (image) {
        self.selfView.photoImageView.image = image;
    } else {
        [self.selfView showNoPhotoLabel];
    }
}

- (void)modelDidFailToLoad:(id)model {
    [self.selfView showNoPhotoLabel];
}

@end
