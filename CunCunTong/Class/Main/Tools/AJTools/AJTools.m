//
//  AJTools.m
//  TourAbroad
//
//  Created by wuweijian on 15/12/19.
//  Copyright © 2015年 wuweijian. All rights reserved.
//

#import "AJTools.h"
#import <UIKit/UIKit.h>


@implementation AJTools

//创建只有标题的label
+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.backgroundColor = kClearColor;
//    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15.0];
    return label;
}
//创建带有背景、颜色lable
+ (UILabel *)createLabelWithFrame:(CGRect)frame Text:(NSString *)text BgColor:(UIColor *)backgroundColor Color:(UIColor *)color Font:(UIFont *)font {
   
    UILabel *lable = [[UILabel alloc] initWithFrame:frame];
    lable.text = text;
    lable.numberOfLines = 0;
    if (backgroundColor) {//有设背景色
        
        lable.backgroundColor =  backgroundColor;
    }else {
        
        lable.backgroundColor = kClearColor;
    }
    if (color) {//有设字体颜色
        
        lable.textColor = color;
    }else {
        
        lable.textColor = [UIColor blackColor];
    }
    if (font) {//有设字体大小
        
        lable.font = font;
    }else {
        
        lable.font = [UIFont systemFontOfSize:15.0];
    }
    
    return lable;
}
+ (UIButton *)createButtonWithFrame:(CGRect)frame target:(id)target sel:(SEL)sel tag:(NSInteger)tag image:(NSString *)name title:(NSString *)title {
    
    UIButton *button = nil;
    if (name) {
        //创建图片按钮
        //创建背景图片 按钮
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        if (title) {//图片标题按钮
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
        
    }else if (title) {
        //创建标题按钮
        button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    button.frame = frame;
    button.tag = tag;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)name {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image  = [UIImage imageNamed:name];
    return imageView;
}

+ (UITextField *)createTextFieldWithFrame:(CGRect)frame placeHolder:(NSString *)string delegate:(id<UITextFieldDelegate>)delegate tag:(NSInteger)tag {
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    //设置风格类型
    textField.borderStyle = UITextBorderStyleNone;
    textField.placeholder = string;
    //设置代理
    textField.delegate = delegate;
    //设置tag值
    textField.tag = tag;
    return textField;
}

+ (BOOL)isAllReturn:(NSString *)str{
    
    for (int i = 0; i < str.length; i++) {
        NSRange range = {i,1};
        NSString *s = [str substringWithRange:range];
        if (![s isEqualToString:@"\n"] && ![s isEqualToString:@" "]) {
            return NO;
        }
    }
    return YES;
}

+ (NSArray *)getCurrentTime {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *dateStr = [formatter stringFromDate:date];
    
    NSArray  *array  = [dateStr componentsSeparatedByString:@":"];
    NSString *hour   = array[0];
    NSString *minute = array[1];
    
    int min = [minute intValue] + 40;
    int hou = [hour intValue];
    if (min >= 60) {
        
        min -= 60;
        hou += 1;
        
        if (min % 5 != 0) {
            
            min = (int)(min / 5) * 5 + 5;
        }
        
    } else if (min > 55 && min < 60) {
    
        min = 0;
        hou += 1;
    } else {
    
        if (min % 5 != 0) {
            
            min = (int)(min / 5) * 5 + 5;
        }
    }
    
    NSString *minstr;
    if (min < 10) {
        
        minstr = [NSString stringWithFormat:@"0%d",min];
    } else {
    
        minstr = [NSString stringWithFormat:@"%d",min];
    }
    
    NSString *dateString = [NSString stringWithFormat:@"%d : %@",hou,minstr];
    
    NSMutableArray *muarray = [[NSMutableArray alloc] initWithObjects:minstr, nil];
    for (int i = 0; i < 11; i ++) {
        
        min += 5;
        if (min < 60) {
            
            NSString *str1;
            if (min < 10) {
                
                str1 = [NSString stringWithFormat:@"0%d",min];
            } else {
                
                str1 = [NSString stringWithFormat:@"%d",min];
            }
            [muarray addObject:str1];
        } else {
         
            break;
        }
    }
    NSDictionary *dic = @{[NSString stringWithFormat:@"%d",hou]:muarray};
    NSMutableArray *middle = [NSMutableArray new];
    [middle addObject:dic];
    
    for (int j = 0; j < 12; j ++) {
        
        hou += 1;
        if (hou <= 20) {
            
            NSDictionary *dictionary = @{[NSString stringWithFormat:@"%d",hou]:@[@"00",@"05",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",]};
            [middle addObject:dictionary];
        } else {
        
            break;
        }
    }
    
    NSArray *resultArray = @[dateString,middle];
    return resultArray;
}
/**
 *  
 *
 *  @param string
 *
 *  @return 是否包含emoji
 */
+ (BOOL)isContainsEmoji:(NSString *)string {
    
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}

/**
 *  替换emoji为@""
 *
 *  @param text
 *
 *  @return
 */
+ (NSString *)disable_emoji:(NSString *)text {
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

+ (UIColor *)colorWithHex:(NSString *)hex {

    NSMutableString *color = [[NSMutableString alloc] initWithString:hex];
    
    // 转换成标准16进制数
    [color replaceCharactersInRange:[color rangeOfString:@"#"] withString:@"0x"];
    
    // 十六进制字符串转成整形。
    long colorLong = strtoul([color cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
   
    // 通过位与方法获取三色值
    int R = (colorLong & 0xFF0000 )>> 16;
    int G = (colorLong & 0x00FF00 )>> 8;
    int B =  colorLong & 0x0000FF;
    
    //string转color
    UIColor *wordColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
    
    return wordColor;
}

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

+ (BOOL) IsBankCard:(NSString *)cardNumber
{
    if(cardNumber.length==0)
    {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++)
    {
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}
@end
