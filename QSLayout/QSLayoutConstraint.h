//
//  QSLayoutConstraint.h
//  BaseControl
//
//  Created by storecode  on 16-8-5.
//  Copyright © 2016年 mypxq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSLayoutAttribute.h"

@interface QSLayoutConstraint : NSObject
{
    UIView *layoutView;
    NSMutableArray *listAttribute;
    NSLayoutRelation relation;
    CGFloat multiplied;
    CGFloat offset;
    UIView *secondView;
    NSLayoutAttribute secondAttribute;
    UIEdgeInsets edge;
    CGSize size;
    CGPoint point;
    int typeAttribute;
    int change_type;
}
- (instancetype)init:(UIView*)view;
- (UIView*)view;
- (NSLayoutAttribute)layoutAttribute;
- (QSLayoutConstraint*)width;
- (QSLayoutConstraint*)height;
- (QSLayoutConstraint*)top;
- (QSLayoutConstraint*)left;
- (QSLayoutConstraint*)right;
- (QSLayoutConstraint*)bottom;
- (QSLayoutConstraint*)leading;
- (QSLayoutConstraint*)trailing;
- (QSLayoutConstraint*)centerX;
- (QSLayoutConstraint*)centerY;
- (QSLayoutConstraint*)center;
- (QSLayoutConstraint * (^)())remove;
- (QSLayoutConstraint * (^)())change;
- (QSLayoutConstraint * (^)(UIView*))equal;
- (QSLayoutConstraint * (^)(UIView*))lessThanOrEqual;
- (QSLayoutConstraint * (^)(UIView*))greaterThanOrEqual;
- (QSLayoutConstraint * (^)(CGFloat))multiplied;
- (QSLayoutConstraint * (^)(CGFloat))offset;
- (QSLayoutConstraint * (^)(UIEdgeInsets))edge;
- (QSLayoutConstraint * (^)(CGSize))size;
- (QSLayoutConstraint * (^)(CGPoint))point;
- (void)install;
+ (NSLayoutConstraint*)GetLayoutConstraint:(UIView*)layoutView :(NSLayoutAttribute)attribute;
@end
