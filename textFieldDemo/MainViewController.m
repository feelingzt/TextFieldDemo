//
//  MainViewController.m
//  textFieldDemo
//
//  Created by uen on 2018/1/10.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "MainViewController.h"
#import "YCPayKeyboard.h"
#import "NSString+RegularMatch.h"
#import "UIButton+JKBackgroundColor.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MainViewController ()<CustomNumberKeyBoardDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *amountTextFieldCenter;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet YCPayKeyboard *keyboardView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"模拟余额宝转入输入框";
    self.view.backgroundColor = UIColorFromRGB(0xDCDCDC);
    self.navigationController.navigationBar.translucent = NO;
    [self KeyboardViewInital];
}

-(void)KeyboardViewInital{
    UIButton *button = (UIButton *)[self.keyboardView viewWithTag:25];
    button.userInteractionEnabled = NO;
    
    _keyboardView.delegate = self;
    _keyboardView.YCPayKeyboardClick = ^{
        [self collectionButtonClick];
    };
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.amountTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - CustomNumberKeyBoardDelegate
-(void)numberKeyBoardInput:(NSString*)number{
    NSLog(@"当前输入的值--%@",number);
    self.amountTextField.text = [self.amountTextField.text handleInputAmountWithWidgetTitle:number];
    
    UIButton *button = (UIButton *)[self.keyboardView viewWithTag:25];
    if (self.amountTextField.text.length>0) {
        button.userInteractionEnabled = YES;
        [button jk_setBackgroundColor:UIColorFromRGB(0x00aff0) forState:UIControlStateNormal];
        [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else{
        [button setUserInteractionEnabled:NO];
        [button jk_setBackgroundColor:UIColorFromRGB(0xe8eaee) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x3C3C3C) forState:UIControlStateNormal];
    }
}

-(void)numberKeyBoardBackspace:(NSString*)number{
    NSLog(@"当前退格的值--%@",number);
}

-(void)numberKeyBoardFinish{
    NSLog(@"当前退格的值完成");
}

#pragma mark - 收款按钮的点击事件
-(void)collectionButtonClick{
    NSLog(@"点击了收款安妮");
}

@end
