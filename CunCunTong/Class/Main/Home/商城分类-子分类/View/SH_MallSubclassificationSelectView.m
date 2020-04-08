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

@end

@implementation SH_MallSubclassificationSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
                          @[@"store_screen_nor",@"销量"],
                          @[@"排序图标灰",@"价格"],
                          @[@"筛选图标",@"筛选"],nil];
    }
    return _categoryArray;
}

- (void)selctButtonClick:(SH_MallSubclassificationSelectButton *)button {
    SH_MallSubclassificationSelectButton *comprehensiveButton = self.buttonArr[0];
    SH_MallSubclassificationSelectButton *salesButton = self.buttonArr[1];
    SH_MallSubclassificationSelectButton *priceButton = self.buttonArr[2];

    if (button.tag == 100) {
        button.tLabel.textColor = kMainColor;
        self.selectedType = SelectedTypeComprehensive;
        self.sales = 0;
        [salesButton.imgView setImage:IMAGE_NAME(@"store_screen_nor")];
        [salesButton.tLabel setTextColor:COLOR_333333];
        self.price = 0;
        [priceButton.imgView setImage:IMAGE_NAME(@"store_screen_nor")];
        [priceButton.tLabel setTextColor:COLOR_333333];

    }else if (button.tag == 101) {
        self.price = 0;
        [priceButton.imgView setImage:IMAGE_NAME(@"store_screen_nor")];
        [priceButton.tLabel setTextColor:COLOR_333333];
        [comprehensiveButton.tLabel setTextColor:COLOR_333333];

        if (self.sales == 0) {
            button.tLabel.textColor = kMainColor;
            [button.imgView setImage:IMAGE_NAME(@"store_screen_up")];
            self.selectedType = SelectedTypeSalesVolumeUp;
            self.sales = 1;
        }else if (self.sales == 1) {
            button.tLabel.textColor = kMainColor;
            [button.imgView setImage:IMAGE_NAME(@"store_screen_down")];
            self.selectedType = SelectedTypeSalesVolumeDown;
            self.sales = 0;
        }
        
    }else if (button.tag == 102) {
        self.sales = 0;
        [salesButton.imgView setImage:IMAGE_NAME(@"store_screen_nor")];
        [salesButton.tLabel setTextColor:COLOR_333333];
        [comprehensiveButton.tLabel setTextColor:COLOR_333333];

        if (self.price == 0) {
            button.tLabel.textColor = kMainColor;
            [button.imgView setImage:IMAGE_NAME(@"store_screen_up")];
            self.selectedType = SelectedTypePriceUp;
            self.price = 1;
        }else if (self.price == 1) {
            button.tLabel.textColor = kMainColor;
            [button.imgView setImage:IMAGE_NAME(@"store_screen_down")];
            self.selectedType = SelectedTypePriceDown;
            self.price = 0;
        }
    } else if (button.tag == 103){
        self.selectedType = MallSelectedTypeShaiXuan;
    }
    
    if (self.selctButtonClickBlock) {
        self.selctButtonClickBlock(self.selectedType);
    }
}

@end
