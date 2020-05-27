//
//  CCReturnGoodsViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCReturnGoodsViewController.h"
#import "CCReturnGoodsFooterView.h"
@interface CCReturnGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) CCReturnGoodsFooterView *footerView;


@end

@implementation CCReturnGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = UIColorHex(0xf7f7f7);
    [self customNavBarWithTitle:@"申请退货"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, -10);
    self.footerView.frame = CGRectMake(0, 0, Window_W, 300);
    self.tableView.tableFooterView = self.footerView;
}

#pragma mark  - Get
- (CCReturnGoodsFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[CCReturnGoodsFooterView alloc] init];
    }
    return _footerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.accessibilityIdentifier = @"table_view";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;;
    } else if (section == 1){
        return [(NSArray *)self.titleArray[0] count];
    } else if (section == 2){
        return [(NSArray *)self.titleArray[1] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView removeAllSubviews];
    if (indexPath.section == 1 || indexPath.section == 2) {
        UILabel *titleLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(16);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
        [cell.contentView addSubview:titleLab];
        [titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
        }];
        titleLab.text = [NSString stringWithFormat:@"%@",[(NSArray *)self.titleArray[indexPath.section-1] objectAtIndex:indexPath.row]];
    }
    if (indexPath.section == 1 && indexPath.row ==0) {
        UILabel *subtitleLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_999999;
            view.font = STFont(13);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentRight;
            view.text = @"请选择";
            view.tag = 100;
            view ;
        });
        [cell.contentView addSubview:subtitleLab];
        [subtitleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.contentView).mas_offset(-27);
            make.size.mas_equalTo(CGSizeMake(237, 14));
            make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
        }];
        UIImageView *rightIcon = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.image = [UIImage imageNamed:@"右箭头灰"];
            view.userInteractionEnabled = YES;
            view.tag = 100+indexPath.row;
            view ;
        });
        [cell.contentView addSubview:rightIcon];
        [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.contentView).mas_offset(-10);
            make.centerY.mas_equalTo(cell.contentView);
            make.width.mas_equalTo(kWidth(7));
            make.height.mas_equalTo(kWidth(12));
        }];

    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(Window_W - 110, 10, 100, 30)];
        numberButton.shakeAnimation = YES;
        numberButton.increaseImage = [UIImage imageNamed:@"加号 1"];
        numberButton.decreaseImage = [UIImage imageNamed:@"减号"];
        numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
            NSLog(@"%f",number);
        };
        [cell.contentView addSubview:numberButton];
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        UITextField *titleTextField = [UITextField new];
        titleTextField.font = FONT_16;
        titleTextField.textAlignment = NSTextAlignmentLeft;
        titleTextField.textColor = COLOR_999999;
        [titleTextField setValue:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        titleTextField.userInteractionEnabled = YES;
        [cell.contentView addSubview:titleTextField];
        titleTextField.frame = CGRectMake(105, 10, Window_W - 115, 30);
        titleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        titleTextField.tag = 100+indexPath.row;
        [cell.contentView addSubview:titleTextField];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIImageView *iconIamgeView4 = ({
            UIImageView *view = [UIImageView new];
            view.userInteractionEnabled = YES;
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.image = [UIImage imageNamed:@"首页课程图片"];
            view.layer.masksToBounds = YES ;
            view ;
        });
        [cell.contentView addSubview:iconIamgeView4];
        [iconIamgeView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
            make.left.mas_equalTo(cell.contentView).mas_offset(15);
            make.height.width.mas_equalTo(76);
        }];
        UILabel *taRendaiFusumTextLab2 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(14);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"七色堇面包0蔗糖";
            view ;
        });
        [cell.contentView addSubview:taRendaiFusumTextLab2];
        [taRendaiFusumTextLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconIamgeView4.mas_right).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.top.mas_equalTo(10);
        }];
        UILabel *taRendaiFusumTextLab3 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(14);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"芒果味";
            view ;
        });
        [cell.contentView addSubview:taRendaiFusumTextLab3];
        [taRendaiFusumTextLab3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconIamgeView4.mas_right).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.top.mas_equalTo(taRendaiFusumTextLab2.mas_bottom).mas_offset(8);
        }];
        UILabel *taRendaiFusumTextLab1 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(12);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"共20件商品";
            view ;
        });
        [cell.contentView addSubview:taRendaiFusumTextLab1];
        [taRendaiFusumTextLab1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconIamgeView4.mas_right).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.bottom.mas_equalTo(iconIamgeView4.mas_bottom).mas_offset(-4);
        }];
    }
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0 && indexPath.section == 0) {
        return 95;
    }
    return 51;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = UIColorHex(0xf7f7f7);
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = UIColorHex(0xf7f7f7);
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0 && indexPath.section == 1) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UILabel *label = [cell viewWithTag:100];
        LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@"" cancelButtonTitle:@"取消" clicked:^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
                NSLog(@"%ld",buttonIndex);
                switch (buttonIndex) {
                    case 1:
                        label.text = @"购买错误";
                        break;
                    case 2:
                        label.text = @"商品质量与描述不符";
                        break;
                    case 3:
                        label.text = @"商品临期";
                        break;
                    default:
                        break;
                }
            } otherButtonTitles:@"购买错误", @"商品质量与描述不符",@"商品临期", nil];
            actionSheet.destructiveButtonColor = kMainColor;
            [actionSheet show];
    }
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@[@"请选择退货原因",@"请选择退货数量"],@[@"退货金额：",@"退款说明："]];
    }
    return _titleArray;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
