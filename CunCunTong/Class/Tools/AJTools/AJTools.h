//
//  AJTools.h
//  TourAbroad
//
//  Created by wuweijian on 15/12/19.
//  Copyright © 2015年 wuweijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AJTools : NSObject <UIAlertViewDelegate>

//label
+ (UILabel *)createLabelWithFrame:(CGRect)frame
                            text:(NSString *)text ;

+ (UILabel *)createLabelWithFrame:(CGRect)frame    //frame
                            Text :(NSString *)text //标题
                          BgColor:(UIColor *)backgroundColor //背景色
                           Color :(UIColor *)color //字体颜色，默认为黑色
                           Font  :(UIFont *)font  ;  //字体大小，默认为15

//创建button可以创建 标题按钮和 图片按钮
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                             target:(id)target
                                sel:(SEL)sel
                                tag:(NSInteger)tag
                              image:(NSString *)name //背景图
                              title:(NSString *)title; //标题
//创建UIImageView
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame
                               imageName:(NSString *)name;
//创建UITextField
+ (UITextField *)createTextFieldWithFrame:(CGRect)frame
                             placeHolder:(NSString *)string
                                delegate:(id <UITextFieldDelegate>)delegate
                                     tag:(NSInteger)tag;

/**判断字符串是否全部为空格或者换行*/
+ (BOOL)isAllReturn:(NSString *)str;


/**获取当前时间以及时间段**/
+ (NSArray *)getCurrentTime;

/**
 判断输入的文字中是否包含emoji

 @param string string
 @return BOOL
 */
+ (BOOL)isContainsEmoji:(NSString *)string;

/**
 替换输入文本中的emoji

 @param text text
 @return NSString
 */
+ (NSString *)disable_emoji:(NSString *)text;


/**
 *  16进制色值转换成color
 *
 *  @param hex hex
 *
 *  @return color
 */
+ (UIColor *)colorWithHex:(NSString *)hex;

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;
/**
 *  银行卡
 *
 *  @return BOOL parameters
 */
//
+ (BOOL) IsBankCard:(NSString *)cardNumber;

@end
