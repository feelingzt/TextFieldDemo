//
//  UIView+Extension.m
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

// 最大的尺寸
#define ZCMAXSize CGSizeMake(MAXFLOAT, MAXFLOAT)

// 快速实例
#define Object(Class) [[Class alloc] init];

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setOriginX:(CGFloat)originX
{
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
}

- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (void)setOriginY:(CGFloat)originY
{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

/** 水平居中 */
- (void)alignHorizontal
{
    self.originX = (self.superview.width - self.width) * 0.5;
}

/** 垂直居中 */
- (void)alignVertical
{
    self.originY = (self.superview.height - self.height) * 0.5;
}

/** 添加子控件 */
- (void)addSubview:(Class)class propertyName:(NSString *)propertyName
{
    id subView = Object(class);
    if ([self isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = (UITableViewCell *)self;
        [cell.contentView addSubview:subView];
    } else {
        [self addSubview:subView];
    }
    [self setValue:subView forKeyPath:propertyName];
}
-(void)addAni:(UIView*)mainView addview:(UIView*)popView{
    CABasicAnimation*ani = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ani.duration = 0.25;
    // ani.removedOnCompletion = NO;
    ani.fromValue =@0.5;
    ani.toValue =@1.0;
    ani.repeatCount=1;
    ani.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [popView.layer addAnimation:ani forKey:nil];
    //[mainView addSubview:popView];
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
