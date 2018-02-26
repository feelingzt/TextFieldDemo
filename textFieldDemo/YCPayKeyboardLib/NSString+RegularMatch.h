//
//  NSString+RegularMatch.h
//  InputKitDemo_OC
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 tingxins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegularMatch)
//整数小数个数匹配
- (BOOL)matchLimitedTextTypePriceWithlimitedPrefix:(NSInteger)limitedPrefix limitedSuffix:(NSInteger)limitedSuffix;
- (NSString *)handleInputAmountWithWidgetTitle:(NSString *)title;
@end
