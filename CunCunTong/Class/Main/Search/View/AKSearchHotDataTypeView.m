//
//  AKSearchHotDataTypeView.m
//  zoneTry
//
//  Created by Zonetry on 16/7/19.
//  Copyright © 2016年 ZoneTry. All rights reserved.
//

#define bigVerticalMargin 15
#define smallVerticalMargin 8
#define bigHorizontalMargin 12
#define smallHorizontalMargin 8

#import "AKSearchHotDataTypeView.h"

@interface AKSearchHotDataTypeView() {
    /******运营数据分类数组*******/
    NSMutableArray *_categories;
    /******所有的选择按钮*******/
    
    /******最后一个选择按钮的位置*******/
    CGRect _lastFrame;
}

@property (nonatomic,strong) UIView *maskView;

@property (nonatomic,strong) UIView *bgView;

@property (strong, nonatomic) NSMutableArray *allBtns;;  // 全部button 数组

@end

@implementation AKSearchHotDataTypeView

#pragma mark Init Method
+ (id)searchHotDataTypeViewWithFrame:(CGRect)frame category:(NSArray *)category {
    return [[AKSearchHotDataTypeView alloc] initWithFrame:frame category:category];
}

- (id)initWithFrame:(CGRect)frame category:(NSArray *)category {
    if (self = [super initWithFrame:frame]) {
        _categories = (NSMutableArray *)category;
        _lastFrame = CGRectMake(0, 0, 0, 0);
        self.userInteractionEnabled = YES;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    @autoreleasepool {
        for (int i = 0; i < _categories.count; i++) {
            CGFloat windth = [NSString calculateFrameWidth:kScreenWidth-bigHorizontalMargin*2 text:_categories[i] height:30 fontsize:13.f];
            
            UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(bigHorizontalMargin + CGRectGetMaxX(_lastFrame),
                                                                           bigVerticalMargin+CGRectGetMaxY(_lastFrame),
                                                                           100,
                                                                           30.f)];
            if (windth + 20 + bigHorizontalMargin*2 + CGRectGetMaxX(_lastFrame) > Window_W - 20) {
                baseLabel.x = bigHorizontalMargin;
                baseLabel.y = CGRectGetMaxY(_lastFrame) + 15;
            }
            else {
                baseLabel.y = CGRectGetMinY(_lastFrame);
            }
            baseLabel.font = FONT_13;
            baseLabel.textColor = COLOR_333333;
            baseLabel.backgroundColor = kYellowColor;
            baseLabel.text = _categories[i];
            baseLabel.layer.cornerRadius = 8.f;
            baseLabel.clipsToBounds = YES;
            baseLabel.textAlignment = NSTextAlignmentCenter;
            baseLabel.userInteractionEnabled = YES;
            _lastFrame = baseLabel.frame;
            [self addSubview:baseLabel];
            baseLabel.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapLabel:)];
            baseLabel.tag = 1008611 + i;
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            [baseLabel addGestureRecognizer:tap];
        }
        self.height = CGRectGetMaxY(_lastFrame) + 30 + 15;
    }
}

- (void)onTapLabel:(UITapGestureRecognizer *)tap {
    if (self.searchHotCellLabelClickButton) {
        UILabel *label = (UILabel *)tap.view;
        self.searchHotCellLabelClickButton(label.tag - 1008611);
        XYLog(@"1111111111111111");
    }
}

@end
