//
//  QSLayoutAttribute.h
//  BaseControl
//
//  Created by storecode  on 16-8-5.
//  Copyright © 2016年 mypxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QSLayoutAttribute : NSObject
@property (nonatomic, assign, readonly) NSLayoutAttribute layoutAttribute;
@property (nonatomic, readonly) UIView *view;
- (instancetype)init:(NSLayoutAttribute)attr;
- (instancetype)init:(NSLayoutAttribute)attr :(UIView*)view;
@end
