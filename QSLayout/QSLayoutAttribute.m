//
//  QSLayoutAttribute.m
//  BaseControl
//
//  Created by storecode  on 16-8-5.
//  Copyright © 2016年 mypxq. All rights reserved.
//

#import "QSLayoutAttribute.h"

@implementation QSLayoutAttribute

- (instancetype)init:(NSLayoutAttribute)attr
{
    self = [super init];
    if (self) {
        _layoutAttribute = attr;
    }
    return self;
}

- (instancetype)init:(NSLayoutAttribute)attr :(UIView*)view
{
    self = [super init];
    if (self) {
        _layoutAttribute = attr;
        _view = view;
    }
    return self;
}
@end


