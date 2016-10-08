//
//  QLayoutMake.h
//  BaseControl
//
//  Created by storecode  on 16-8-5.
//  Copyright © 2016年 mypxq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSLayoutConstraint.h"

@interface QSLayoutMake : NSObject {
    UIView *layoutView;
    NSMutableArray *listLayout;
}
- (instancetype)init:(UIView*)view;
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
- (QSLayoutConstraint * (^)(UIEdgeInsets))edge;
- (QSLayoutConstraint * (^)(CGSize))size;
- (QSLayoutConstraint * (^)(CGPoint))point;
- (void)install;
@end