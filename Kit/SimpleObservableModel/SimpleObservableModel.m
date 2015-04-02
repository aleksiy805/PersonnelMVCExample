//
//  SimpleObservableModel.m
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 4/2/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import "SimpleObservableModel.h"

@interface SimpleObservableModel ()
@property (nonatomic, assign) SimpleObservableModelState  state;
@property (nonatomic, strong) NSPointerArray              *pointerArray;
@end

@implementation SimpleObservableModel

@dynamic observers;

#pragma mark -
#pragma mark Initializations And Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.state = SimpleObservableModelNotLoaded;
        self.pointerArray = [NSPointerArray weakObjectsPointerArray];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)observers {
    return self.pointerArray.allObjects;
}

#pragma mark -
#pragma mark Public Methods

- (void)addObserver:(id<SimpleObservableModelDelegate>)observer {
    NSPointerArray *pointerArray = self.pointerArray;
    BOOL shouldAdd = YES;
    NSUInteger index = 0;
    
    for (id<SimpleObservableModelDelegate> object in pointerArray.allObjects) {
        if (object == observer) {
            shouldAdd = NO;
            break;
        }
        index ++;
    }
    if (shouldAdd) {
        [pointerArray insertPointer:(__bridge void *)(observer) atIndex:index];
    }
}

- (void)removeObserver:(id<SimpleObservableModelDelegate>)observer {
    NSPointerArray *pointerArray = self.pointerArray;
    NSUInteger index = 0;
    
    for (id<SimpleObservableModelDelegate> object in pointerArray.allObjects) {
        if (object == observer) {
            break;
        }
        index ++;
    }
    if (index != pointerArray.allObjects.count) {
        [pointerArray removePointerAtIndex:index];
    }
    [pointerArray compact];
}

- (BOOL)load {
    if (SimpleObservableModelLoaded == self.state) {
        [self didLoad];
        
        return NO;
    } else if (SimpleObservableModelNotLoaded == self.state) {
        self.state = SimpleObservableModelLoading;
        [self loading];
        
        return NO;
    }
    
    return YES;
}

- (void)dump {
    if (SimpleObservableModelNotLoaded != self.state) {
        self.state = SimpleObservableModelNotLoaded;
        [self didDump];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)notifyObserversWithSelector:(SEL)selector {
    for (id<SimpleObservableModelDelegate> object in self.pointerArray.allObjects) {
        if ([object respondsToSelector:selector]) {
            [object performSelector:selector withObject:self];
        }
    }
}

#pragma mark -
#pragma mark SimpleObservableModelDelegate

- (void)didLoad {
    self.state = SimpleObservableModelLoaded;
    [self notifyObserversWithSelector:@selector(modelDidLoad:)];
}

- (void)loading {
    self.state = SimpleObservableModelLoading;
    [self notifyObserversWithSelector:@selector(modelLoading:)];
}

- (void)didFailToLoad {
    self.state = SimpleObservableModelLoaded;
    [self notifyObserversWithSelector:@selector(modelDidFailToLoad:)];
}

- (void)didDump {
    self.state = SimpleObservableModelNotLoaded;
    [self notifyObserversWithSelector:@selector(modelDidDump:)];
}

@end
