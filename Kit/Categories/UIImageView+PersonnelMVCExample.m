//
//  UIImageView+PersonnelMVCExample.m
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 4/2/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import "UIImageView+PersonnelMVCExample.h"

@implementation UIImageView (PersonnelMVCExample)

- (void)roundCorners {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    
    shapeLayer.path = [path CGPath];
    self.layer.mask = shapeLayer;
}

@end
