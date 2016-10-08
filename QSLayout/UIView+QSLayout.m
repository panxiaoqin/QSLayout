//
//  UIView+QSLayout.m
//  BaseControl
//
//  Created by storecode  on 16-8-5.
//  Copyright © 2016年 mypxq. All rights reserved.
//

#import "UIView+QSLayout.h"

IB_DESIGNABLE
@implementation UIView(Extension)

- (void)setQSLayout:(void(^)(QSLayoutMake *make))block {
    QSLayoutMake *make = [[QSLayoutMake alloc]init:self];
    block(make);
    [make install];
}

- (void)setQSLayout:(UIViewController*)viewControl :(void(^)(QSLayoutMake *make,UIViewController *viewControl))block {
    QSLayoutMake *make = [[QSLayoutMake alloc]init:self];
    block(make,viewControl);
    [make install];
    
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (UIColor*)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (borderWidth < 0) return;
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (CGFloat)left {
    if(self.translatesAutoresizingMaskIntoConstraints) {
        return [self GetQSValue:NSLayoutAttributeLeft];
    } else {
        if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeLeft] != nil) {
            return [self GetQSValue:NSLayoutAttributeLeft];
        }
        if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeLeading] != nil) {
            return [self GetQSValue:NSLayoutAttributeLeading];
        }
        if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeCenterX] != nil) {
            return (self.superview.width - self.width) / 2;
        }
        return -1;
    }
}

- (CGFloat)top {
    if(self.translatesAutoresizingMaskIntoConstraints) {
        return [self GetQSValue:NSLayoutAttributeTop];
    } else {
        if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeTop] != nil) {
            return [self GetQSValue:NSLayoutAttributeTop];
        }
        if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeCenterY] != nil) {
            return (self.superview.height - self.height) / 2;
        }
        return -1;
    }
}

- (CGFloat)width {
    if(self.translatesAutoresizingMaskIntoConstraints) {
        return [self GetQSValue:NSLayoutAttributeWidth];
    } else {
        if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeWidth] != nil) {
            return [self GetQSValue:NSLayoutAttributeWidth];
        }
        if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeRight] != nil) {
           return self.superview.width - [self GetQSValue:NSLayoutAttributeLeft] + [self GetQSValue:NSLayoutAttributeRight];
        }
        if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeTrailing] != nil) {
            return self.superview.width - [self GetQSValue:NSLayoutAttributeLeading] + [self GetQSValue:NSLayoutAttributeTrailing];
        }
        return -1;
    }
}

- (CGFloat)height {
    if(self.translatesAutoresizingMaskIntoConstraints) {
        return [self GetQSValue:NSLayoutAttributeHeight];
    } else {
        if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeHeight] != nil) {
            return [self GetQSValue:NSLayoutAttributeHeight];
        }
        if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeBottom] != nil) {
            return self.superview.height - [self GetQSValue:NSLayoutAttributeTop] + [self GetQSValue:NSLayoutAttributeBottom];
        }
        return -1;
    }
}

- (CGFloat)GetQSValue:(NSLayoutAttribute) attribute {
    if(self.translatesAutoresizingMaskIntoConstraints) {
        if(attribute == NSLayoutAttributeLeft) {
            return self.frame.origin.x;
        }
        if(attribute == NSLayoutAttributeTop) {
            return self.frame.origin.y;
        }
        if(attribute == NSLayoutAttributeWidth) {
            return self.frame.size.width;
        }
        if(attribute == NSLayoutAttributeHeight) {
            return self.frame.size.height;
        }
    }
    NSLayoutConstraint *constraint = [QSLayoutConstraint GetLayoutConstraint:self :attribute];
    if(constraint == nil) {
        return -1;
    }
    return constraint.constant;
}

- (void)setLeft:(CGFloat)left {
    if(self.translatesAutoresizingMaskIntoConstraints) {
        [self SetQSValue:NSLayoutAttributeLeft :left];
    } else {
        if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeLeft] != nil) {
            [self SetQSValue:NSLayoutAttributeLeft :left];
        } else if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeLeading] != nil) {
            [self SetQSValue:NSLayoutAttributeLeading :left];
        } else if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeCenterX] != nil) {
            [self SetQSValue:NSLayoutAttributeWidth :self.superview.width - left * 2];
        } else {
            QSLayoutMake *make = [[QSLayoutMake alloc]init:self];
            make.left.equal(self.superview).offset(left);
            [make install];

        }
    }
}

- (void)setTop:(CGFloat)top {
    if(self.translatesAutoresizingMaskIntoConstraints) {
        [self SetQSValue:NSLayoutAttributeTop :top];
    } else {
        if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeTop] != nil) {
            [self SetQSValue:NSLayoutAttributeTop :top];
        } else if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeCenterY] != nil) {
            [self SetQSValue:NSLayoutAttributeHeight :self.superview.height - top * 2];
        } else {
            QSLayoutMake *make = [[QSLayoutMake alloc]init:self];
            make.top.equal(self.superview).offset(top);
            [make install];
            
        }
    }
}

- (void)setWidth:(CGFloat)width {
    width = width < 1 ? (1 / [UIScreen mainScreen].scale) : width;
    if(self.translatesAutoresizingMaskIntoConstraints) {
        [self SetQSValue:NSLayoutAttributeWidth :width];
    } else {
        if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeWidth] != nil) {
            [self SetQSValue:NSLayoutAttributeWidth :width];
        } else if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeRight] != nil) {
            [self SetQSValue:NSLayoutAttributeRight :- (self.superview.width - self.left - width)];
        } else if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeTrailing] != nil) {
            [self SetQSValue:NSLayoutAttributeTrailing :- (self.superview.width - self.left - width)];
        } else {
            QSLayoutMake *make = [[QSLayoutMake alloc]init:self];
            make.width.equal(self.superview).offset(width);
            [make install];
            
        }
    }
}

- (void)setHeight:(CGFloat)height {
    height = height < 1 ? (1 / [UIScreen mainScreen].scale) : height;
    if(self.translatesAutoresizingMaskIntoConstraints) {
        [self SetQSValue:NSLayoutAttributeHeight :height];
    } else {
         if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeWidth] != nil) {
             [self SetQSValue:NSLayoutAttributeHeight :height];
         } else if([QSLayoutConstraint GetLayoutConstraint:self :NSLayoutAttributeBottom] != nil) {
             [self SetQSValue:NSLayoutAttributeBottom :- (self.superview.height - self.top - height)];
         } else {
             QSLayoutMake *make = [[QSLayoutMake alloc]init:self];
             make.height.equal(self.superview).offset(height);
             [make install];
         }
    }
}

- (void)SetQSValue:(NSLayoutAttribute) attribute :(CGFloat)value {
    if(self.translatesAutoresizingMaskIntoConstraints) {
        if(attribute == NSLayoutAttributeLeft) {
            [self setFrame:CGRectMake(value, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
        }
        if(attribute == NSLayoutAttributeTop) {
            [self setFrame:CGRectMake(self.frame.origin.x, value, self.frame.size.width, self.frame.size.height)];
        }
        if(attribute == NSLayoutAttributeWidth) {
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, value, self.frame.size.height)];
        }
        if(attribute == NSLayoutAttributeHeight) {
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, value)];
        }
    }
    NSLayoutConstraint *constraint = [QSLayoutConstraint GetLayoutConstraint:self :attribute];
    if(constraint != nil) {
        constraint.constant = value;
    }
}

- (void)SetExtensionValue:(NSString *)name :(id)value {
    [self setValue:value forKey:name];
}

- (id)GetExtensionValue:(NSString *)name {
    id value;
    NSError *error;
    BOOL valid = [self validateValue:&value forKey:name error:&error];
    if (!valid) {
        return nil;
    }
    return value;
}

- (void)addOnClick:(id)target :(SEL)action {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void) RemoveChildView:(UIView*)view {
    [self RemoveChildView:view :nil];
}

- (void) RemoveChildView:(UIView*)view :(NSArray*)arr {
    if (arr == nil) {
        arr = [NSArray new];
    }
    NSMutableArray *child = [NSMutableArray new];
    for (UIView *cv in view.subviews) {
        [child addObject:cv];
    }
    for (UIView *cv in child) {
        if ([arr indexOfObject:cv] != NSNotFound) {
            continue;
        }
        [cv removeFromSuperview];
    }
}
@end
