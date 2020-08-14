//
//  CCPriceShaixuanView.m
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCShopBottomView.h"
#import "CCTextCustomTableViewCell.h"
#import "CCSelectPinPaViewController.h"
#import "CCSelectCatediyViewController.h"
#import "BRDatePickerView.h"
#import "BRPickerView.h"
#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "CCPriceShaixuanView.h"


@interface CCPriceShaixuanView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) UITextField *productNameTextField;
@property (strong, nonatomic) NSArray *titleArray;
@property (copy, nonatomic) NSString *beginTime;
@property (nonatomic,copy) NSString *endTime;
@property (nonatomic,copy) NSString *createStr;
@end

@implementation CCPriceShaixuanView

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleArray = @[@"单据编号",@"盘点日期起",@"盘点日期止",@"盘点分类"];
        self.productNameTextField.text = @"";
        self.beginTime = @"";
        self.endTime = @"";
        self.createStr = @"";
        self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame) - 41);
        [self.tableView registerNib:CCTextCustomTableViewCell.loadNib forCellReuseIdentifier:@"cell1234"];
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.tag = 11;
        [rightBtn setTitle:@"重置" forState:UIControlStateNormal];
        [rightBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
        [rightBtn setTitleColor:kMainColor forState:UIControlStateHighlighted];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.layer.masksToBounds = YES;
        rightBtn.layer.cornerRadius = 23;
        [self addSubview:rightBtn];
        rightBtn.frame = CGRectMake(0, CGRectGetHeight(frame) - 41, CGRectGetWidth(frame)/2, 41);
        
        UIButton *rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn2.tag = 12;
        [rightBtn2 setTitle:@"确定" forState:UIControlStateNormal];
        [rightBtn2 setTitleColor:kMainColor forState:UIControlStateNormal];
        rightBtn2.titleLabel.font = [UIFont systemFontOfSize:16];
        [rightBtn2 addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn2.layer.masksToBounds = YES;
        rightBtn2.layer.cornerRadius = 23;
        [self addSubview:rightBtn2];
        rightBtn2.frame = CGRectMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame) - 41, CGRectGetWidth(frame)/2, 41);
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = COLOR_333333;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    if (indexPath.row == 0) {
        for (UIView *view in cell.contentView.subviews) {
            if (view.tag == 100+indexPath.row) {
                [view removeFromSuperview];
            }
        }
        UITextField *titleTextField = [UITextField new];
        titleTextField.font = FONT_13;
        titleTextField.textAlignment = NSTextAlignmentLeft;
        titleTextField.textColor = COLOR_999999;
//        [titleTextField setValue:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        titleTextField.userInteractionEnabled = YES;
        [cell.contentView addSubview:titleTextField];
        titleTextField.frame = CGRectMake(Window_W-94-15, 10, 94, 30);
        titleTextField.tag = 100+indexPath.row;
        NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:@"请输入单据编号"];
        [textColor addAttribute:NSForegroundColorAttributeName
                          value:COLOR_999999
                          range:[@"请输入单据编号" rangeOfString:@"请输入单据编号"]];
        titleTextField.attributedPlaceholder = textColor;
        self.productNameTextField = titleTextField;
    } else {
        for (UIView *view in cell.contentView.subviews) {
            if (view.tag == 100+indexPath.row) {
                [view removeFromSuperview];
            }
        }
        UILabel *nameLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_999999;
            view.font = STFont(14);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentRight;
            view.tag = 100+indexPath.row;
            view.userInteractionEnabled = YES;
            view.text = @"请选择";
            view ;
        });
        [cell.contentView addSubview:nameLab];
        [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.contentView).mas_offset(-10);
            make.size.mas_equalTo(CGSizeMake(177, 14));
            make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
        }];
        [nameLab addTapGestureWithBlock:^(UIView *gestureView) {
            [self timeSelect:(UILabel *)gestureView];
        }];
    }
    UIView *line = [[UIView alloc] init];
    [cell.contentView addSubview:line];
    line.backgroundColor = COLOR_e5e5e5;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(cell.contentView);
        make.height.mas_equalTo(1);
    }];
    return cell;
}

- (void)botBtnClick:(UIButton *)btn
{
    if (btn.tag == 11) {
        self.productNameTextField.text = @"";
        self.beginTime = @"";
        self.endTime = @"";
        self.createStr = @"";
        [self.tableView reloadData];
    } else {
        if (self.productNameAndCodeBlack) {
            self.productNameAndCodeBlack(self.productNameTextField.text, self.beginTime, self.endTime, self.createStr);
        }
        NKAlertView *alertView = (NKAlertView *)self.superview;
        [alertView hide];
    }
}
- (void)timeSelect:(UILabel *)label {
    if (label.tag == 101 || label.tag == 102) {
        NSString *str = [NSString getCurrentTime:@"YYYY-MM-dd"];
        [BRDatePickerView showDatePickerWithTitle:@"请选择" dateType:BRDatePickerModeYMD defaultSelValue:str resultBlock:^(NSString *selectValue) {
            label.text = selectValue;
            if (label.tag == 101) {
                self.beginTime = selectValue;
            } else {
                self.endTime = selectValue;
            }
        }];
    } else {
        XYWeakSelf;
        NSDictionary *params = @{
        };
        NSString *path = @"/app0/category1/";
        [[STHttpResquest sharedManager] requestWithMethod:GET
                                                 WithPath:path
                                               WithParams:params
                                         WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            NSInteger status = [[dic objectForKey:@"errno"] integerValue];
            NSString *msg = [[dic objectForKey:@"errmsg"] description];
            if(status == 0){
                NSArray *data = dic[@"data"];
                NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *dic in data) {
                    [array addObject:dic[@"name"]];
                }
                [BRStringPickerView showStringPickerWithTitle:@"" dataSource:array defaultSelValue:@"" isAutoSelect:NO themeColor:kMainColor resultBlock:^(id selectValue) {
                    label.text = selectValue;
                    for (NSDictionary *dic in data) {
                        NSString *str = dic[@"name"];
                        if ([selectValue isEqualToString:str]) {
                            weakSelf.createStr = [NSString stringWithFormat:@"%ld",[dic[@"id"] integerValue]];
                        }
                    }
                } cancelBlock:^{

                }];
            }else {
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
            }
        } WithFailurBlock:^(NSError * _Nonnull error) {
        }];
    }

}

@end
