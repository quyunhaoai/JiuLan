//
//  CalendarPickerView.h
//  YueYanPlus
//
//  Created by lijie lijie on 2019/5/28.
//  Copyright © 2019 lijie lijie. All rights reserved.
//

#import "BRBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CalendarPickerView : BRBaseView
typedef void(^BRDateResultBlock)(NSString *selectValue);

/**
 *  2.显示时间选择器（支持 设置自动选择 和 自定义主题颜色）
 *
 *  @param title            标题
 *  @param resultBlock      选择结果的回调
 *
 */
+ (void)showDatePickerWithTitle:(NSString *)title
                defaultSelValue:(NSDate *)defaultSelValueDate
                   unSelectDate:(NSMutableArray *)dateArray
                    resultBlock:(BRDateResultBlock)resultBlock;

- (instancetype)initWithTitle:(NSString *)title
              defaultSelValue:(NSDate *)defaultSelValueDate
                 unSelectDate:(NSMutableArray *)dateArray
                  resultBlock:(BRDateResultBlock)resultBlock;
@end

NS_ASSUME_NONNULL_END
