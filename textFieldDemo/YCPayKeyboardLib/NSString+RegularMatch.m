//
//  NSString+RegularMatch.m
//  InputKitDemo_OC
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 tingxins. All rights reserved.
//

#import "NSString+RegularMatch.h"
#define TXRegExHeader @"SELF MATCHES %@"

#define TXLimitedTextFieldTypePriceRegExZero @"^[0][0-9]+$"
#define TXLimitedTextFieldTypePriceRegExContentFormat(limitedPrefix, limitedSuffix) [NSString stringWithFormat:@"^\\d{0,%ld}$|^(\\d{0,%ld}[.][0-9]{0,%ld})$", limitedPrefix, limitedPrefix, limitedSuffix]

@implementation NSString (RegularMatch)

-(NSString *)handleInputAmountWithWidgetTitle:(NSString *)title{
    if ([title isEqualToString:@"清空"]) {
        return @"";
    }
    
    if ([title isEqualToString:@"退格"]) {
        if (self.length == 0) {
            return self;
        }
        return [self substringToIndex:self.length-1];
    }
    
    
    NSString *string = [self stringByAppendingString:title];
    
    BOOL match = [string matchLimitedTextTypePriceWithlimitedPrefix:6 limitedSuffix:2];//限制多少位数和多少位小数
    
    if (match) {
        
        if ([self isEqualToString:@"0."] && [title isEqualToString:@"00"]) {
            return self;
        }
        if ([string isEqualToString:@"."]) {
            return @"";
        }
        return string;
        
    } else{
        
        if ([self isEqualToString:@"0"] && ![title isEqualToString:@"00"] && ![title isEqualToString:@"0"]){
            return  title;
        }
        return  [string substringWithRange:NSMakeRange(0, string.length-title.length)];
    }
}

- (BOOL)matchLimitedTextTypePriceWithlimitedPrefix:(NSInteger)limitedPrefix limitedSuffix:(NSInteger)limitedSuffix{
    // 1.匹配以0开头的数字
    NSPredicate *matchZero = [NSPredicate predicateWithFormat:TXRegExHeader, TXLimitedTextFieldTypePriceRegExZero];
    // 2.匹配两位小数、整数
    NSPredicate *matchValue = [NSPredicate predicateWithFormat:TXRegExHeader,TXLimitedTextFieldTypePriceRegExContentFormat((long)limitedPrefix, (long)limitedSuffix)];
    BOOL isZero = ![matchZero evaluateWithObject:self];
    BOOL isCorrectValue = [matchValue evaluateWithObject:self];
    return isZero && isCorrectValue ? YES : NO;
}

@end
