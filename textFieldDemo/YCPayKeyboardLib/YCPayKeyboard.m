//
//  YCPayKeyboard.m
//  SWWH
//
//  Created by 尚往文化 on 17/1/16.
//  Copyright © 2017年 cy. All rights reserved.
//

#import "YCPayKeyboard.h"
#import "UIImage+BlurGlass.h"
#import <AVFoundation/AVFoundation.h>

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#define BTN_HIGHLIGHTED_COLOR   UIColorFromRGB(0x50c9f6)
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



@implementation YCPayKeyboard{
    SystemSoundID soundFileObject;
}

+ (instancetype)keyboard{
    return [[self alloc] init];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView
{
    self.backgroundColor = [UIColor whiteColor];
    for (int i=0; i<16; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.adjustsImageWhenHighlighted = NO;
        btn.adjustsImageWhenDisabled = NO;
        if (i<10) {
            [btn setTitle:[@(i) stringValue] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:31.3];
            if (SCREEN_HEIGHT == 480) {
                btn.titleLabel.font = [UIFont systemFontOfSize:25];
            }
            
        } else {
            if (i == 10) {
                [btn setTitle:@"00" forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:31.3];
            } else if (i==11) {
                [btn setTitle:@"0" forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:31.3];
            }else if (i==12) {
                [btn setTitle:@"." forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:31.3];
            }else if (i==13) {
                [btn setTitle:@"退格" forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:17.4];
                
            }else if (i==14) {
                [btn setTitle:@"清空" forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:17.4];
            }else {
                [btn setTitle:@"收款" forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:17.4];
                
            }
            if (SCREEN_HEIGHT == 480) {
                btn.titleLabel.font = [UIFont systemFontOfSize:25];
                if (i>12) {
                    btn.titleLabel.font = [UIFont systemFontOfSize:14];
                }
                
            }
        }
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageWithColor:BTN_HIGHLIGHTED_COLOR size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
        if ([btn.currentTitle isEqualToString:@"收款"]) {
            [btn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xe8eaee) size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
            //[btn setTitleColor:UIColor.whiteColor  forState:UIControlStateNormal];
            
        }
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 10+i;
        [self addSubview:btn];
    }
    //    [self loadSound];
}

//- (void)loadSound
//{
//    //得到音效文件的地址
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSString*soundFilePath =[[NSBundle mainBundle]pathForResource:@"SFX_ZGB" ofType:@"wav"];
//        
//        //将地址字符串转换成url
//        NSURL*soundURL = [NSURL fileURLWithPath:soundFilePath];
//        
//        //生成系统音效id
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundFileObject);
//    });
//    //播放系统音效
//
//}
//- (void)playSound
//
//{
//   AudioServicesPlaySystemSound(soundFileObject);
//    
//}
- (void)click:(UIButton *)btn{
    //    [self playSound];
    if (self.clickBlock) {
        //self.clickBlock(btn.tag-10);
    }
    
    NSInteger number = btn.tag-10;
    if (nil == _delegate){
        return;
    }
    if (number <= 9 && number >= 0){
        [_delegate numberKeyBoardInput:[NSString stringWithFormat:@"%ld",(long)number]];
        return;
    }
    if (10 == number){
        [_delegate numberKeyBoardInput:@"00"];
        return;
    }
    
    if (11 == number){
        [_delegate numberKeyBoardInput:@"0"];
        return;
    }
    if (12 == number){
        [_delegate numberKeyBoardInput:@"."];
        return;
    }
    if (13 == number){
        [_delegate numberKeyBoardInput:@"退格"];
        return;
    }
    if (14 == number){
        [_delegate numberKeyBoardInput:@"清空"];
        return;
    }
    if (15 == number){
        //[_delegate numberKeyBoardInput:@"收款"];
        self.YCPayKeyboardClick();
        return;
    }
    
}

//规划实线
- (void)drawRect:(CGRect)rect{
    //    CGFloat w = self.width/4;
    //    CGFloat h = self.height/4;
    //    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    //    for (int i=0; i<5; i++) {
    //        [bezierPath moveToPoint: CGPointMake(0, h*i)];
    //        //[bezierPath addLineToPoint: CGPointMake(self.width, h*i)];
    //        [bezierPath addLineToPoint: CGPointMake(self.width-w*(i==3), h*i)];
    //    }
    //    for (int i=1; i<=3; i++) {
    //        [bezierPath moveToPoint: CGPointMake(w*i, 0)];
    //        //[bezierPath addLineToPoint: CGPointMake(w*i, self.height-h*(i==1))];
    //        [bezierPath addLineToPoint: CGPointMake(w*i, self.height)];
    //    }
    //    [[UIColor lightGrayColor] setStroke];
    //    bezierPath.lineWidth = 1;
    //    [bezierPath stroke];
}

//规划各个按钮的frame
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.width/4;
    CGFloat h = self.height/4;
    for (int i=1; i<=9; i++) {
        UIView *view = [self viewWithTag:i+10];
        view.originX = w*((i-1)%3);
        view.originY = h*((i-1)/3);
        view.width = w;
        view.height = h;
    }
    //20 21 22 23 24 25
    [self viewWithTag:20].frame = CGRectMake(0, h*3, w, h);
    [self viewWithTag:21].frame = CGRectMake(w, h*3, w, h);
    [self viewWithTag:22].frame = CGRectMake(w*2, h*3, w, h);
    [self viewWithTag:23].frame = CGRectMake(w*3, 0, w, h);
    [self viewWithTag:24].frame = CGRectMake(w*3, h, w, h);
    [self viewWithTag:25].frame = CGRectMake(w*3, h*2, w, h*2);
}

@end
