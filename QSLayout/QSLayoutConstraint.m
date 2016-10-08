//
//  QSLayoutConstraint.m
//  BaseControl
//
//  Created by storecode  on 16-8-5.
//  Copyright © 2016年 mypxq. All rights reserved.
//

#import "QSLayoutConstraint.h"

@implementation QSLayoutConstraint
- (instancetype)init:(UIView*)view
{
    self = [super init];
    if (!self) return nil;
    layoutView = view;
    listAttribute = [[NSMutableArray alloc]init];
    relation = NSLayoutRelationEqual;
    multiplied = 1;
    offset = 0;
    secondView = nil;
    secondAttribute = NSLayoutAttributeNotAnAttribute;
    change_type = 0;
    typeAttribute = 0;
    return self;
}

- (UIView*)view {
    return layoutView;
}

- (NSLayoutAttribute)layoutAttribute {
    QSLayoutAttribute *att = listAttribute.firstObject;
    return att.layoutAttribute;
}

- (QSLayoutConstraint*)addAttribute:(NSLayoutAttribute)attribute {
    if(secondView == nil) {
        [listAttribute addObject:[[QSLayoutAttribute alloc]init:attribute]];
    } else {
        secondAttribute = attribute;
    }
    return self;
}

- (QSLayoutConstraint*)width {
    return [self addAttribute:NSLayoutAttributeWidth];
}

- (QSLayoutConstraint*)height {
    return [self addAttribute:NSLayoutAttributeHeight];
}

- (QSLayoutConstraint*)top {
    return [self addAttribute:NSLayoutAttributeTop];
}

- (QSLayoutConstraint*)left {
    return [self addAttribute:NSLayoutAttributeLeft];
}

- (QSLayoutConstraint*)right {
    return [self addAttribute:NSLayoutAttributeRight];
}

- (QSLayoutConstraint*)bottom {
    return [self addAttribute:NSLayoutAttributeBottom];
}

- (QSLayoutConstraint*)leading {
    return [self addAttribute:NSLayoutAttributeLeading];
}

- (QSLayoutConstraint*)trailing {
    return [self addAttribute:NSLayoutAttributeTrailing];
}

- (QSLayoutConstraint*)centerX {
    return [self addAttribute:NSLayoutAttributeCenterX];
}

- (QSLayoutConstraint*)centerY {
    return [self addAttribute:NSLayoutAttributeCenterY];
}

- (QSLayoutConstraint*)center {
    return self.centerX.centerY;
}

- (QSLayoutConstraint * (^)())remove {
    return ^id() {
        change_type = 2;
        return self;
    };
}

- (QSLayoutConstraint * (^)())change {
    return ^id() {
        return self;
    };
}

- (QSLayoutConstraint * (^)(UIView*))equal {
    return ^id(UIView* _attribute) {
        relation = NSLayoutRelationEqual;
        secondView = _attribute;
        return self;
    };
}

- (QSLayoutConstraint * (^)(UIView*))lessThanOrEqual {
    return ^id(UIView* _attribute) {
        relation = NSLayoutRelationLessThanOrEqual;
        secondView = _attribute;
        return self;
    };
}

- (QSLayoutConstraint * (^)(UIView*))greaterThanOrEqual {
    return ^id(UIView* _attribute) {
        relation = NSLayoutRelationGreaterThanOrEqual;
        secondView = _attribute;
        return self;
    };
}

- (QSLayoutConstraint * (^)(CGFloat))multiplied {
    return ^id(CGFloat _multiplied) {
        multiplied = _multiplied;
        return self;
    };
}

- (QSLayoutConstraint * (^)(CGFloat))offset {
    return ^id(CGFloat _offset) {
        offset = _offset;
        return self;
    };
}

- (QSLayoutConstraint * (^)(UIEdgeInsets))edge {
    return ^id(UIEdgeInsets _edge) {
        typeAttribute = 1;
        edge = _edge;
        return self;
    };
}

- (QSLayoutConstraint * (^)(CGSize))size {
    return ^id(CGSize _size) {
        typeAttribute = 2;
        size = _size;
        return self;
    };
}

- (QSLayoutConstraint * (^)(CGPoint))point {
    return ^id(CGPoint _point) {
        typeAttribute = 3;
        point = _point;
        return self;
    };
}

- (void)install {
    if(typeAttribute == 1) {
        if(change_type != 2) {
            [self CreateLayout:NSLayoutAttributeLeft:edge.left];
            [self CreateLayout:NSLayoutAttributeTop:edge.top];
            [self CreateLayout:NSLayoutAttributeRight:edge.right];
            [self CreateLayout:NSLayoutAttributeBottom:edge.bottom];
        }
    } else if(typeAttribute == 2) {
        if(change_type != 2) {
            [self CreateLayout:NSLayoutAttributeWidth:size.width];
            [self CreateLayout:NSLayoutAttributeHeight:size.height];
        }
    } else if(typeAttribute == 3) {
        if(change_type != 2) {
            [self CreateLayout:NSLayoutAttributeLeft:point.x];
            [self CreateLayout:NSLayoutAttributeTop:point.y];
        }
    } else {
        if(change_type == 2) {
            for (QSLayoutAttribute *att in listAttribute) {
                [self RemoveLayout:att.layoutAttribute];
            }
        } else  {
            for (QSLayoutAttribute *att in listAttribute) {
                [self CreateLayout:att.layoutAttribute];
            }
        }
    }
}

- (void) CreateLayout:(NSLayoutAttribute)attribute {
    if([self setLayout:attribute :offset]) {
        return;
    }
    NSLayoutAttribute nowAtt = secondAttribute;
    if(secondView != nil && secondAttribute == NSLayoutAttributeNotAnAttribute) {
        nowAtt = attribute;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:layoutView
                                                                  attribute:attribute
                                                                  relatedBy:relation
                                                                     toItem:secondView
                                                                  attribute:nowAtt
                                                                 multiplier:multiplied
                                                                   constant:offset];
    if(secondView == nil) {
        [layoutView addConstraint:constraint];
    } else {
        [layoutView.superview addConstraint:constraint];
    }
}

- (void) CreateLayout:(NSLayoutAttribute)attribute :(CGFloat)value {
    if([self setLayout:attribute :value]) {
        return;
    }
    NSLayoutAttribute nowAtt = secondAttribute;
    if(secondView != nil && secondAttribute == NSLayoutAttributeNotAnAttribute) {
        nowAtt = attribute;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:layoutView
                                                                  attribute:attribute
                                                                  relatedBy:relation
                                                                     toItem: secondView
                                                                  attribute:nowAtt
                                                                 multiplier:multiplied
                                                                   constant:value];
    if(secondView == nil) {
        [layoutView addConstraint:constraint];
    } else {
        [secondView addConstraint:constraint];
    }
}

- (Boolean)setLayout:(NSLayoutAttribute)attribute :(CGFloat)value {
    NSLayoutConstraint *constraint = [QSLayoutConstraint GetLayoutConstraint:layoutView :attribute];
    if(constraint == nil) {
        return false;
    }

    Boolean bo = true;
    if(constraint.firstItem != layoutView) {
        bo = false;
    }
    if(constraint.secondItem != secondView) {
        bo = false;
    }
    if(constraint.secondAttribute != secondAttribute) {
        bo = false;
    }
    if(constraint.multiplier != multiplied) {
        bo = false;
    }
    if(constraint.relation != relation) {
        bo = false;
    }
    if(bo) {
        constraint.constant = value;
    } else {
        [self RemoveLayout:attribute];
    }
    return bo;
}

- (void)RemoveLayout:(NSLayoutAttribute)attribute {
    for (NSLayoutConstraint *constraint in layoutView.constraints) {
        if(constraint.firstAttribute == attribute) {
            [layoutView removeConstraint:constraint];
            break;
        }
    }
    for (NSLayoutConstraint *constraint in layoutView.superview.constraints) {
        if(constraint.firstItem == layoutView && constraint.firstAttribute == attribute) {
            [layoutView.superview removeConstraint:constraint];
            break;
        }
    }
}

+ (NSLayoutConstraint*)GetLayoutConstraint:(UIView*)layoutView :(NSLayoutAttribute)attribute {
    for (NSLayoutConstraint *constraint in layoutView.constraints) {
        if(constraint.firstAttribute == attribute) {
            return constraint;
        }
    }
    for (NSLayoutConstraint *constraint in layoutView.superview.constraints) {
        if(constraint.firstItem == layoutView && constraint.firstAttribute == attribute) {
            return constraint;
        }
    }
    return nil;
}
@end
