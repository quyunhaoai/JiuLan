//
//  CCKucunDetailFooterView.m
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCKucunDetailFooterView.h"
#import "CCGongHuoListModel.h"
@interface CCKucunDetailFooterView()

@end
@implementation CCKucunDetailFooterView

-(void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.stockView reloadStockView];
}

- (void)setSumDict:(NSDictionary *)sumDict{
    _sumDict = sumDict;
    [self.stockView reloadStockView];
}

- (void)setupUI {
    self.backgroundColor = kWhiteColor;
    [self initSegmentInView:self];
    UIImageView *areaIcon = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        [view setImage:IMAGE_NAME(@"日历图标")];
        view;
    });
    
    [self addSubview:areaIcon];
    [areaIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(13, 11));
        make.top.mas_equalTo(48);
    }];
    UILabel *nameLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.userInteractionEnabled = YES;
        view.tag = 11;
        view ;
    });
    self.dateLab = nameLab;
    [self addSubview:nameLab];
    [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(28);
        make.size.mas_equalTo(CGSizeMake(77, 14));
        make.centerY.mas_equalTo(areaIcon).mas_offset(0);
    }];
    UILabel *nameLab3 = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.userInteractionEnabled = YES;
        view.text = @"至";
        view ;
    });
    [self addSubview:nameLab3];
    [nameLab3 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab.mas_right).mas_offset(2);
        make.size.mas_equalTo(CGSizeMake(17, 14));
        make.centerY.mas_equalTo(areaIcon).mas_offset(0);
    }];
    UILabel *nameLab2 = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.userInteractionEnabled = YES;
        view.tag = 10;
        view ;
    });
    self.dateLab2 = nameLab2;
    [self addSubview:nameLab2];
    [nameLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab.mas_right).mas_offset(28);
        make.size.mas_equalTo(CGSizeMake(77, 14));
        make.centerY.mas_equalTo(areaIcon).mas_offset(0);
    }];
    self.stockView.frame = CGRectMake(10, 67, Window_W-40, self.frame.size.height-67);
    [self addSubview:self.stockView];
    self.titleArr =  @[@"进货价",@"进货数",@"进货金额"];
}
#pragma mark - Stock DataSource

- (NSUInteger)countForStockView:(JJStockView*)stockView{
    return self.dataArray.count+1;
}

- (UIView*)titleCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (Window_W-40)/5, 30)];
    bg.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (Window_W-40)/5, 30)];
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONT_10;
    if (row == 0) {
        label.text = @"合计";
    } else {
        CCGongHuoListModel *model = self.dataArray[row-1];
        label.text = [NSString stringWithFormat:@"%@",model.create_time];
    }
    [bg addSubview:label];
    UIView *line = [[UIView alloc] init];
    [bg addSubview:line];
    line.backgroundColor = COLOR_e5e5e5;
    line.frame = CGRectMake(0, 29, bg.size.width, 1);
    return bg;
}

- (UIView*)contentCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    NSLog(@"---%ld",row);
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (Window_W-40)-(Window_W-40)/5, 30)];
    bg.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
    if (row == 0) {
        for (int i = 0; i < 4; i++) {
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * (Window_W-40)/5, 0, (Window_W-40)/5, 30)];
            if (self.isJinHuo) {
                if (i == 0) {

                } else if (i == 1){
                    label.text = [NSString stringWithFormat:@"%ld",[self.sumDict[@"amount_sum"] integerValue]];
                } else if (i == 2){
                    label.text = [NSString stringWithFormat:@"%ld",[self.sumDict[@"total_play_price_sum"] integerValue]];
                }
            } else {
                if (i == 0) {

                } else if (i == 1){
                    label.text = [NSString stringWithFormat:@"%ld",[self.sumDict[@"amount_sum"] integerValue]];
                } else if (i == 2){
                    label.text = [NSString stringWithFormat:@"%ld",[self.sumDict[@"total_profit_sum"] integerValue]];
                } else {
                    label.text = [NSString stringWithFormat:@"%ld",[self.sumDict[@"total_retail_price_sum"] integerValue]];
                }
            }
            label.textAlignment = NSTextAlignmentCenter;
            label.font = FONT_10;
            [bg addSubview:label];
        }
    } else {
        CCGongHuoListModel *model = self.dataArray[row-1];
        for (int i = 0; i < 4; i++) {
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * (Window_W-40)/5, 0, (Window_W-40)/5, 30)];
            if (self.isJinHuo) {
                if (i == 0) {
                    label.text = [NSString stringWithFormat:@"%ld",model.play_price];
                } else if (i == 1){
                    label.text = [NSString stringWithFormat:@"%ld",model.amount];
                } else if (i == 2){
                    label.text = [NSString stringWithFormat:@"%ld",model.total_play_price];
                }
            } else {
                if (i == 0) {
                    label.text = [NSString stringWithFormat:@"%ld",model.retail_price];
                } else if (i == 1){
                    label.text = [NSString stringWithFormat:@"%ld",model.count];
                } else if (i == 2){
                    label.text = [NSString stringWithFormat:@"%ld",model.total_retail_price];
                } else {
                    label.text = [NSString stringWithFormat:@"%ld",model.profit];
                }
            }
            label.textAlignment = NSTextAlignmentCenter;
            label.font = FONT_10;
            [bg addSubview:label];
        }
    }
    UIView *line = [[UIView alloc] init];
    [bg addSubview:line];
    line.backgroundColor = COLOR_e5e5e5;
    line.frame = CGRectMake(0, 29, bg.size.width, 1);
    return bg;
}

#pragma mark - Stock Delegate

- (CGFloat)heightForCell:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    return 30.0f;
}

- (UIView*)headRegularTitle:(JJStockView*)stockView{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (Window_W-40)/5, 26)];
    label.text = @"日期";
    label.backgroundColor = [UIColor colorWithRed:223.0f/255.0 green:223.0f/255.0 blue:223.0f/255.0 alpha:1.0];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONT_12;
    return label;
}

- (UIView*)headTitle:(JJStockView*)stockView{
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (Window_W-40)-(Window_W-40)/5, 26)];
    bg.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f];
    for (int i = 0; i < _titleArr.count; i++) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * (Window_W-40)/5, 0, (Window_W-40)/5, 26)];
        label.text = [NSString stringWithFormat:@"%@",self.titleArr[i]];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        label.font = FONT_12;
        [bg addSubview:label];
    }
    return bg;
}

- (CGFloat)heightForHeadTitle:(JJStockView*)stockView{
    return 26.0f;
}

- (void)didSelect:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    NSLog(@"DidSelect Row:%ld",row);
}

#pragma mark - Button Action

- (void)buttonAction:(UIButton*)sender{
    NSLog(@"Button Row:%ld",sender.tag);
}

#pragma mark - Get

- (JJStockView*)stockView{
    if(_stockView != nil){
        return _stockView;
    }
    _stockView = [JJStockView new];
    _stockView.dataSource = self;
    _stockView.delegate = self;
    _stockView.layer.cornerRadius = 5;
    _stockView.layer.masksToBounds = YES;
    return _stockView;
}

-(void)initSegmentInView:(UIView *)view {

    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(10, 3, Window_W-40, 34) withDataArray:@[@"进货统计",@"销售统计"] withFont:14];
    self.segment.backgroundColor = kWhiteColor;
    self.segment.delegate = self;
    self.segment.textSelectedColor = kMainColor;
    self.segment.textNomalColor = COLOR_333333;
    self.segment.lineColor = kMainColor;
    [view addSubview:self.segment];
}
- (void)selectedIndex:(NSInteger)index {
    NSLog(@"%ld",(long )index);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setFrame:(CGRect)frame{
    CGFloat margin = 10;
    frame.origin.x = margin;
    frame.size.width = SCREEN_WIDTH - margin*2;
    [super setFrame:frame];
}
@end
