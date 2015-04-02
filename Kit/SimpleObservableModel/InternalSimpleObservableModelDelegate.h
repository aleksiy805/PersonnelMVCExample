//
//  InternalSimpleObservableModelDelegate.h
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 4/2/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InternalSimpleObservableModelDelegate <NSObject>
- (void)didLoad;
- (void)loading;
- (void)didFailToLoad;
- (void)didDump;

@end
