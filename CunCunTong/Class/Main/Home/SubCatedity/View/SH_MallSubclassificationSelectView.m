//
//  SH_MallSubclassificationSelectView.m
//  XiYuanPlus
//
//  Created by xy on 2018/4/10.
//  Copyright © 2018年 Hoping. All rights reserved.
//

#import "SH_MallSubclassificationSelectView.h"
#import "SH_MallSubclassificationSelectButton.h"
@interface SH_MallSubclassificationSelectView ()

@property (nonatomic,strong) NSMutableArray *categoryArray;
@property (nonatomic,strong) NSMutableArray *buttonArr;
@property (assign, nonatomic) int price;
@property (assign, nonatomic) int sales;
@property (assign, nonatomic) BOOL ischange;
@end

@implementation SH_MallSubclassificationSelectView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self buildView];
    }
    return self;
}

- (void)buildView {
    self.selectedType = SelectedTypeComprehensive;
    self.price = 0;
    self.sales = 0;
    self.buttonArr = [NSMutableArray array];
    for (int i = 0; i < self.categoryArray.count; i ++) {
        NSString *imageName = self.categoryArray[i][0];
        NSString *titleName = self.categoryArray[i][1];

        SH_MallSubclassificationSelectButton *button = [[SH_MallSubclassificationSelectButton alloc] initWithFrame:CGRectMake(0+Window_W/_categoryArray.count*i, 0, Window_W/_categoryArray.count,  RationHeight(48))];
        [button setBackgroundColor:kWhiteColor];
        [button.imgView setImage:IMAGE_NAME(imageName)];
        [button.tLabel setText:titleName];
        button.tLabel.textColor = COLOR_333333;
        button.tag = i + 100;
        [button addTarget:self action:@selector(selctButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.buttonArr addObject:button];
    }
    SH_MallSubclassificationSelectButton *button1 = self.buttonArr[0];
    button1.tLabel.textColor = kMainColor;
    UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(0, RationHeight(48)-0.5, Window_W, 0.5)];
    [self addSubview:lineview];
    lineview.backgroundColor = COLOR_e5e5e5;

}

#pragma mark -

- (NSMutableArray *)categoryArray {
    if (!_categoryArray) {
        _categoryArray = [[NSMutableArray alloc] initWithObjects:
                          @[@"",@"综合"],
                          @[@"",@"销量"],
                          @[@"灰",@"价格"],
                          @[@"goods_classification_grid",@""],
                          @[@"筛选图标",@"筛选"],nil];
    }
    return _categoryArray;
}

- (void)selctButtonClick:(SH_MallSubclassificationSelectButton *)button {
    SH_MallSubclassificationSelectButton *comprehensiveButton = self.buttonArr[0];
    SH_MallSubclassificationSelectButton *salesButton = self.buttonArr[1];
    SH_MallSubclassificationSelectButton *priceButton = self.buttonArr[2];
//    SH_MallSubclassificationSelectButton *changeButton = self.buttonArr[3];
    if (button.tag == 100) {
        button.tLabel.textColor = kMainColor;
        self.selectedType = SelectedTypeComprehensive;
        self.sales = 0;
        [salesButton.tLabel setTextColor:COLOR_333333];
        self.price = 0;
        [priceButton.tLabel setTextColor:COLOR_333333];

    }else if (button.tag == 101) {
        self.price = 0;
        [priceButton.tLabel setTextColor:COLOR_333333];
        [comprehensiveButton.tLabel setTextColor:COLOR_333333];

        if (self.sales == 0) {
            button.tLabel.textColor = kMainColor;
            self.selectedType = SelectedTypeSalesVolumeUp;
            self.sales = 1;
        }else if (self.sales == 1) {
            button.tLabel.textColor = kMainColor;
            self.selectedType = SelectedTypeSalesVolumeDown;
            self.sales = 0;
        }
        
    }else if (button.tag == 102) {
        self.sales = 0;
        [salesButton.tLabel setTextColor:COLOR_333333];
        [comprehensiveButton.tLabel setTextColor:COLOR_333333];

        if (self.price == 0) {
            button.tLabel.textColor = kMainColor;
            [button.imgView setImage:IMAGE_NAME(@"上绿下灰")];
            self.selectedType = SelectedTypePriceUp;
            self.price = 1;
        }else if (self.price == 1) {
            button.tLabel.textColor = kMainColor;
            [button.imgView setImage:IMAGE_NAME(@"上灰下绿(1)")];
            self.selectedType = SelectedTypePriceDown;
            self.price = 0;
        }
    } else if (button.tag == 103){
        self.selectedType = SelectedTypeChange;
        if (_ischange) {
            [button.imgView setImage:IMAGE_NAME(@"goods_classification_grid")];
            _ischange = NO;
        } else {
            [button.imgView setImage:IMAGE_NAME(@"goods_classification_list")];
            _ischange = YES;
        }
    } else if (button.tag == 104){
        
        self.selectedType = MallSelectedTypeShaiXuan;
    }
    
    if (self.selctButtonClickBlock) {
        self.selctButtonClickBlock(self.selectedType);
    }
}

@end
