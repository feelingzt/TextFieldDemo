//
//  YCPayKeyboard.h
//  SWWH
//
//  Created by 尚往文化 on 17/1/16.
//  Copyright © 2017年 cy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@protocol CustomNumberKeyBoardDelegate <NSObject>
-(void)numberKeyBoardInput:(NSString*) number;
-(void)numberKeyBoardBackspace:(NSString*) number;
-(void)numberKeyBoardFinish;
@end

@interface YCPayKeyboard : UIView
+(instancetype)keyboard;
@property(nonatomic,copy)void(^clickBlock)(NSInteger index);
@property(nonatomic,copy)void(^YCPayKeyboardClick)();
@property(nonatomic, assign) id<CustomNumberKeyBoardDelegate> delegate;
@end
