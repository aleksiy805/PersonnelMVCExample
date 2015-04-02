//
//  SimpleObservableModel.h
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 4/2/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InternalSimpleObservableModelDelegate.h"

/* Simple observable model that let you notify many objects when state of model did change */

typedef NS_ENUM(NSUInteger, SimpleObservableModelState) {
    SimpleObservableModelNotLoaded,
    SimpleObservableModelLoading,
    SimpleObservableModelLoaded,
};

@protocol SimpleObservableModelDelegate <NSObject>
@optional
- (void)modelDidLoad:(id)model;
- (void)modelLoading:(id)model;
- (void)modelDidFailToLoad:(id)model;
- (void)modelDidDump:(id)model;

@end

@interface SimpleObservableModel : NSObject <InternalSimpleObservableModelDelegate>

@property (nonatomic, readonly) SimpleObservableModelState  state;
@property (nonatomic, readonly) NSArray                    *observers;

/*
 You can add more than one observer for the model. This is useful in case of:
 1. Models for the each cell are loading.
 2. The user clicks on any cell (HumanViewCell).
 3. Appropriate model (from Cell) set in Controller (HumanInformationViewController)
 and then Controller is pushed.
 4. Model did load. Information about this should be available in cell and controller
 */
- (void)addObserver:(id<SimpleObservableModelDelegate>)observer;
- (void)removeObserver:(id<SimpleObservableModelDelegate>)observer;
/* Emulated asynchronous loading.
 You can best feel relationships between observable object with observer in this case */
- (BOOL)load;
- (void)dump;

@end
