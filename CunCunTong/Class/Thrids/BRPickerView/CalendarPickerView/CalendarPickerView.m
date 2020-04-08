//
//  CalendarPickerView.m
//  YueYanPlus
//
//  Created by lijie lijie on 2019/5/28.
//  Copyright © 2019 lijie lijie. All rights reserved.
//

#import "CalendarPickerView.h"
#import "BRPickerViewMacro.h"
#import "FSCalendar.h"

@interface CalendarPickerView ()<FSCalendarDataSource,FSCalendarDelegate>{
    NSString *_title;
    UIDatePickerMode _datePickerMode;
}
/** 选中后的回调 */
@property (nonatomic, copy) BRDateResultBlock resultBlock;
/** 当前选择的日期 */
@property (nonatomic, strong) NSDate *selectDate;
/*
 日历
 */
@property (nonatomic, strong) FSCalendar *calendar;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSMutableArray *dateArray;


@end
@implementation CalendarPickerView

#pragma mark - 2.显示时间选择器（支持 设置自动选择 和 自定义主题颜色）
+ (void)showDatePickerWithTitle:(NSString *)title
                defaultSelValue:(NSDate *)defaultSelValueDate
                   unSelectDate:(NSMutableArray *)dateArray
                    resultBlock:(BRDateResultBlock)resultBlock {
    CalendarPickerView *calendarPickerView = [[CalendarPickerView alloc] initWithTitle:title defaultSelValue:defaultSelValueDate unSelectDate:dateArray resultBlock:resultBlock ];
    [calendarPickerView showWithAnimation:YES];
}

- (instancetype)initWithTitle:(NSString *)title
              defaultSelValue:(NSDate *)defaultSelValueDate
                 unSelectDate:(NSMutableArray *)dateArray
                  resultBlock:(BRDateResultBlock)resultBlock
                 {
    if (self = [super init]) {
        self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = @"yyyy-MM-dd";
        _dateArray = dateArray;
        _title = title;
        _resultBlock = resultBlock;
        _selectDate = defaultSelValueDate;
        [self initUI];
     
    }
    return self;
}

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation {
    //1. 获取当前应用的主窗口
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    if (animation) {
        // 动画前初始位置
        CGRect rect = self.alertView.frame;
        rect.origin.y = kScreenHeight;
        self.alertView.frame = rect;
        // 浮现动画
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.alertView.frame;
           // rect.origin.y -= kScreenHeight + 44 + BR_BOTTOM_MARGIN;
            self.alertView.frame = rect;
        }];
    }
}



#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation {
    // 关闭动画
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - 视图创建

- (void)initUI {
    [super initUI];
    self.titleLabel.text = _title;
    // 添加时间选择器
    [self loadView];//加载视图
}

- (void)loadView
{
    CGFloat aa = IS_PAD ? 432 : kWidth(432);
    CGFloat bb =  kScreenHeight- HOME_INDICATOR_HEIGHT- aa;
    UILabel *nameLabel = [UILabel new];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.frame = CGRectMake(0, bb, kScreenWidth, 55);
    [self addSubview:nameLabel];
    nameLabel.backgroundColor = kWhiteColor;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"开始时间"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    nameLabel.attributedText = string;
    
    UIView *line = [UIView new];
    [self addSubview:line];
    line.frame = CGRectMake(0,CGRectGetMaxY(nameLabel.frame) , kScreenWidth, 1);
    line.backgroundColor = COLOR_e5e5e5;
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(line.frame), kScreenWidth , IS_PAD ?  376: kWidth(376))];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.appearance.headerMinimumDissolvedAlpha = 0;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase | FSCalendarCaseOptionsWeekdayUsesUpperCase;
    calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    calendar.appearance.headerDateFormat = @"yyyy年MM月";
    calendar.appearance.todayColor = kWhiteColor;
    calendar.appearance.subtitleTodayColor = kRedColor;
    calendar.appearance.headerTitleColor = COLOR_333333;
    calendar.appearance.selectionColor = kRedColor;
    calendar.appearance.todayColor = [UIColor colorWithRed:255/255.0 green:235/255.0 blue:242/255.0 alpha:1.0];
    [self addSubview:calendar];
    self.calendar = calendar;
    
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    previousButton.backgroundColor = [UIColor whiteColor];
    previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [previousButton setImage:[UIImage imageNamed:@"list_more_left"] forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:previousButton];

    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.backgroundColor = [UIColor whiteColor];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton setImage:[UIImage imageNamed:@"list_more_right"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nextButton];
    
    previousButton.sd_layout.topSpaceToView(line, 20).leftSpaceToView(self, 15).widthIs(10).heightIs(14);
    nextButton.sd_layout.topSpaceToView(line, 20).rightSpaceToView(self, 15).widthIs(10).heightIs(14);
}


- (void)previousClicked:(id)sender {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:previousMonth animated:YES];
}

- (void)nextClicked:(id)sender {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:2 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}


#pragma mark - FSCalendarDelegate
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    
    int aa = [self compareOneDay:[NSDate date] withAnotherDay:date];
    if (aa == 1) {
        return monthPosition == FSCalendarMonthPositionNotFound;
    } else {
            for (NSMutableDictionary *dict in self.dateArray) {
                if ([dict.allKeys containsObject:@"scheduleTime"]) {
                    NSString *string = dict[@"scheduleTime"];
                    NSDate *dateUnSelected = [self.dateFormatter dateFromString:string];
                    XYLog(@"%@++++++++++++%@",dateUnSelected,date);
                    if ([date isEqualToDate:dateUnSelected]) {
                       XYLog(@"3333");
                        return  monthPosition == FSCalendarMonthPositionNotFound;
                    }
                }
            }
        NSDate *date1 = [NSDate date];
        if (date1.year == date.year) {
            if (date1.month == date.month) {
                return monthPosition == FSCalendarMonthPositionCurrent;
            } else {
                return monthPosition = FSCalendarMonthPositionNext;
            }
        } else {
            return monthPosition = FSCalendarMonthPositionNext;
        }
    }
}

- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    return monthPosition == FSCalendarMonthPositionCurrent;
}

#pragma mark----- 在里面弹出其他视图,选择时间
- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date{
    if ( [date isToday]) {
       return @"今天";
    }
    return nil;
}

/*
 选择
 */
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"mm"];
    
    
//    customerModel *model1 = [XYToolManger shareManger].infoModel.customer;
    double timeIntervalEnd1 = 0;
    
    int a =  (timeIntervalEnd1 * 8)/28800000;

    NSDate *date2 = [NSDate date];
    NSDate *date1 = [date2 dateByAddingHours:a];
    NSString *time = [self.dateFormatter stringFromDate:date];
    if ([time containsString:@"-"]) {
        NSArray *arr = [time componentsSeparatedByString:@"-"];
        NSString *string = arr.lastObject;
        NSInteger aa = [string integerValue];
        if (aa == date2.day) {
            if (date1.day != aa) {
                NSString *tips = [NSString stringWithFormat:@"演出时间不能小于%@小时",@(a)];
                [self makeToast:tips duration:1.5 position:CSToastPositionCenter];
                return;
            } else {
                if (self.resultBlock) {
                    [self dismissWithAnimation:YES];
                    self.resultBlock([self.dateFormatter stringFromDate:date]);
                }
            }
        } else {
            if (self.resultBlock) {
                [self dismissWithAnimation:YES];
                self.resultBlock([self.dateFormatter stringFromDate:date]);
            }
        }
    }
}


//反选
- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
 
}

//- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date {
//    if ([self.gregorian isDateInToday:date]) {
//        return @[kRedColor];
//    }
//    return @[appearance.eventDefaultColor];
//}

#pragma mark - FSCalendarDataSource
//设置最小日期
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:[NSDate date] options:0];
}

//设置最大日期
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:2 toDate:[NSDate date] options:0];
}

#pragma mark FSCalendarDelegateAppearance

//设置当前月与非当前月字体颜色
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date {
    int aa = [self compareOneDay:[NSDate date] withAnotherDay:date];
    if (aa == 1) {
        return [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0];
        
    } else if ( aa == -1) {
        NSString *string = [self weekdayStringWithDate:date];
        if ([string isEqualToString:@"日"] || [string isEqualToString:@"六"]) {
            if (self.dateArray.count > 0) {
            for (NSMutableDictionary *dict in self.dateArray) {
                if ([dict.allKeys containsObject:@"scheduleTime"]) {
                    NSString *scheduleTime = dict[@"scheduleTime"];
                    NSDate *dateUnSelected = [self.dateFormatter dateFromString:scheduleTime];
                    if ([dateUnSelected isEqualToDate:date]) {
                        return [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0];
                    } else kRedColor;
                }
            } return kRedColor;
            }
          else  return kRedColor;
        } else {
            if (self.dateArray.count > 0) {
                for (NSMutableDictionary *dict in self.dateArray) {
                    if ([dict.allKeys containsObject:@"scheduleTime"]) {
                        NSString *string = dict[@"scheduleTime"];
                        NSDate *dateUnSelected = [self.dateFormatter dateFromString:string];
                        if ([dateUnSelected isEqualToDate:date]) {
                            return [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0];
                        } else COLOR_333333;
                    }
                } return COLOR_333333;
            }
            else return COLOR_333333;
        }
    } else {
        return kRedColor;
    }
}

/*
 日期比较
 */
- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay {
    NSString *oneDayStr = [self.dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [self.dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [self.dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [self.dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //在指定时间前面 过了指定时间 过期
        return 1;
    }
    else if (result == NSOrderedAscending){
        //没过指定时间 没过期
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //刚好时间一样.
    return 0;
}

/*
 判断是否是星期日
 */
- (NSString *)weekdayStringWithDate:(NSDate *)date {
    //获取星期几
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekday = [componets weekday];//1代表星期日，2代表星期一，后面依次
    NSArray *weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    NSString *weekStr = weekArray[weekday-1];
    return weekStr;
}


/** 点击背景遮罩图层事件 */
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    
    [self dismissWithAnimation:YES];
    
}
@end
