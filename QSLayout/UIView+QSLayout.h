//
//  UIView+QSLayout.h
//  BaseControl
//
//  Created by storecode  on 16-8-5.
//  Copyright © 2016年 mypxq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSLayoutMake.h"

@interface UIView(Extension)

@property(nonatomic, assign) CGFloat left;
@property(nonatomic, assign) CGFloat top;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, strong) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;

- (void)setQSLayout:(void(^)(QSLayoutMake *make))block;
- (void)setQSLayout:(UIViewController*)viewControl :(void(^)(QSLayoutMake *make,UIViewController *viewControl))block;
- (void)SetExtensionValue:(NSString*)name :(id)value;
- (id)GetExtensionValue:(NSString*)name;
- (void)addOnClick:(id)target :(SEL)action;
- (void) RemoveChildView:(UIView*)view;
- (void) RemoveChildView:(UIView*)view :(NSArray*)arr;
@end
