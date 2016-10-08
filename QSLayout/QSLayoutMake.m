//
//  QLayoutMake.m
//  BaseControl
//
//  Created by storecode  on 16-8-5.
//  Copyright © 2016年 mypxq. All rights reserved.
//

#import "QSLayoutMake.h"

@implementation QSLayoutMake

- (instancetype)init:(UIView*)view;
{
    self = [super init];
    if (!self)  return nil;
    layoutView = view;
    listLayout = [[NSMutableArray alloc]init];
    if(layoutView.translatesAutoresizingMaskIntoConstraints) {
        layoutView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (QSLayoutConstraint*)createLayout {
    QSLayoutConstraint *layout = [[QSLayoutConstraint alloc]init:layoutView];
    [listLayout addObject:layout];
    return layout;
}

- (QSLayoutConstraint*)width {
    return [self createLayout].width;
}

- (QSLayoutConstraint*)height {
    return [self createLayout].height;
}

- (QSLayoutConstraint*)top {
    return [self createLayout].top;
}

- (QSLayoutConstraint*)left {
    return [self createLayout].left;
}

- (QSLayoutConstraint*)right {
    return [self createLayout].right;
}

- (QSLayoutConstraint*)bottom {
    return [self createLayout].bottom;
}

- (QSLayoutConstraint*)leading {
    return [self createLayout].leading;
}

- (QSLayoutConstraint*)trailing {
    return [self createLayout].trailing;
}

- (QSLayoutConstraint*)centerX {
    return [self createLayout].centerX;
}

- (QSLayoutConstraint*)centerY {
    return [self createLayout].centerY;
}

- (QSLayoutConstraint*)center {
    return [self createLayout].center;
}

- (QSLayoutConstraint * (^)(UIEdgeInsets))edge {
    return ^id(UIEdgeInsets _edge) {
        return [self createLayout].edge(_edge);
    };
}

- (QSLayoutConstraint * (^)(CGSize))size {
    return ^id(CGSize _size) {
        return [self createLayout].size(_size);
    };
}

- (QSLayoutConstraint * (^)(CGPoint))point {
    return ^id(CGPoint _point) {
       return [self createLayout].point(_point);
    };
}

- (void)install {
    for (QSLayoutConstraint *layout in listLayout) {
        [layout install];
    }
}

@end