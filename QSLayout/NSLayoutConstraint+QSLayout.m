//
//  NSLayoutAttribute+QSLayout.m
//  BaseControl
//
//  Created by storecode  on 16-8-23.
//  Copyright © 2016年 mypxq. All rights reserved.
//

#import "NSLayoutConstraint+QSLayout.h"

IB_DESIGNABLE
@implementation NSLayoutConstraint(Extension)

- (BOOL)isLine {
    return self.constant < 1;
}

- (void)setIsLine:(BOOL)isLine {
    if(isLine) {
        self.constant = 1 / [UIScreen mainScreen].scale;
    }
}
@end
