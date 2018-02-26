//
//  ZTTextField.m
//  textFieldDemo
//
//  Created by uen on 2018/1/10.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "ZTTextField.h"

@implementation ZTTextField

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpZTTextField];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpZTTextField];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setUpZTTextField];
}

//初始化代码
-(void)setUpZTTextField{
    [self modifyCustomizeColorCursor];
}

//修改UITextView/UITextField自定义光标的颜色
-(void)modifyCustomizeColorCursor{
    //方法1: 将影响所有UITextField
    //[[UITextField appearance] setTintColor:[UIColor blackColor]];
    
    //方法2: 如果在InterfaceBuilder中修改View的tintColor属性并不好用
    self.tintColor = [UIColor redColor];
}

//UITextView/UITextField自定义光标长度或高度
//可通过重写父类方法 caretRectForPosition: 实现
- (CGRect)caretRectForPosition:(UITextPosition *)position{
    CGRect originalRect = [super caretRectForPosition:position];
    //originalRect.size.height = self.font.lineHeight + 3;
    originalRect.size.height = 50;
    originalRect.size.width = 2;
    originalRect.origin.y = 0;
    originalRect.origin.x = originalRect.origin.x + 0;
    
    // (origin = (x = 0, y = 9), size = (width = 2, height = 60))
    // (origin = (x = 104, y = 9), size = (width = 2, height = 60))
    
    return originalRect;
}


// 这个函数是调整placeholder在placeholderLabel中绘制的位置以及范围
//重写此方法修改Placeholder颜色
-(void)drawPlaceholderInRect:(CGRect)rect {
    //计算占位文字的Size
    //CGSize placeholderSize = [self.placeholder sizeWithAttributes:@{NSFontAttributeName:self.font}];
    [self.placeholder drawInRect:CGRectMake(5, (rect.size.height - self.font.xHeight)/2-2, rect.size.width, rect.size.height)
                  withAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor],
                                   NSFontAttributeName:[UIFont systemFontOfSize:17]}];
}


// 返回placeholderLabel的bounds，改变返回值，是调整placeholderLabel的位置
//- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    //return CGRectMake(10, (bounds.size.height - self.font.xHeight)/2, bounds.size.width, bounds.size.height);
//}


@end
