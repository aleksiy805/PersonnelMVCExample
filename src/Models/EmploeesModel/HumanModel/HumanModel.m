//
//  HumanModel.m
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 1/21/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import "HumanModel.h"

@interface HumanModel ()
@property (nonatomic, strong) UIImage  *thumbnailImage;
@end

@implementation HumanModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)humanModel {
    return [[self class] new];
}

+ (NSString *)generatePosition {
    return nil;
}

// Use this for image loading from doc directory of your app
/*
+ (NSString *)documentsDirectoryURL {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                NSUserDomainMask, YES) firstObject];
}

+ (NSString *)documentsDirectoryURLWithPathComponent:(NSString *)pathComponent {
    return [[self documentsDirectoryURL] stringByAppendingPathComponent:pathComponent];
}

+ (NSString *)resourceFullPathWithPathComponent:(NSString *)pathComponent name:(NSString *)name {
    NSString *fullPath = [self documentsDirectoryURLWithPathComponent:pathComponent];
    
    return [fullPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", name]];
}
*/

#pragma mark -
#pragma mark Public Methods

- (BOOL)load {
    if (SimpleObservableModelNotLoaded == self.state) {
        [super load];
        SEL selector = @selector(loadAfterDelay:);
        
        [self performSelector:selector
                   withObject:self
                   afterDelay:[[self class] randomByIndex:4]];
        
        return NO;
    }
    
    return YES;
}

- (void)dump {
    self.thumbnailImage = nil;
    [super dump];
}

#pragma mark -
#pragma mark Private Methods

- (void)loadAfterDelay:(id)sender {
    /*
     NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
     NSUserDomainMask, YES) firstObject];
     NSString *imagePath = [documentsPath stringByAppendingPathComponent:self.thumbnailName];
     UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
     */
    if (SimpleObservableModelNotLoaded == self.state) {
        return;
    }
    self.thumbnailImage = [UIImage imageNamed:self.thumbnailName];
    [self didLoad];
}

@end
