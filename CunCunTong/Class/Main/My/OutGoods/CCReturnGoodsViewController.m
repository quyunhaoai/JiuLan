//
//  CCReturnGoodsViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCReturnGoodsViewController.h"
#import "CCReturnGoodsFooterView.h"
#import "CCBackOrderModel.h"
#import "CCTimeSelectModel.h"
#import "CCOutTimeSelectDateViewController.h"
#import "CCMyOrderViewController.h"
@interface CCReturnGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) CCReturnGoodsFooterView *footerView;
@property (strong, nonatomic) CCBackOrderModel *Model;
@property (nonatomic,copy) NSString *name;  // name
@property (nonatomic,assign) CGFloat count;
@property (nonatomic,copy) NSString *remark;
@property (strong, nonatomic) NSMutableArray *photoArray;
@property (strong, nonatomic) UITextField *fieldView;
@property (nonatomic,copy) NSString *types;  //
@property (nonatomic,copy) NSString *product_date;  //
@property (nonatomic,strong) CCTimeSelectModel *timemodel;
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
    [self initData];
    self.remark = @"";
    self.types = @"1";
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path =  [NSString stringWithFormat:@"/app0/backgetdate/%@/",self.skuID];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.Model = [CCBackOrderModel modelWithJSON:data];
            [weakSelf.tableView reloadData];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

#pragma mark  - Get
- (CCReturnGoodsFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[CCReturnGoodsFooterView alloc] init];
        [_footerView.sendBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
        _footerView.blackBlock = ^(NSMutableArray * _Nonnull photoArray) {
            self.photoArray = photoArray;
            if (self.count && [self.types isNotBlank] && [self.product_date isNotBlank] && self.photoArray.count) {
                [self.footerView.sendBtn setBackgroundColor:kMainColor];
                [self.footerView.sendBtn setUserInteractionEnabled:YES];
            } else {
                [self.footerView.sendBtn setBackgroundColor:kGrayCustomColor];
                [self.footerView.sendBtn setUserInteractionEnabled:NO];
            }
        };
    }
    return _footerView;
}

- (void)sendAction:(UIButton *)button {
    CCReturnGoodsFooterView *footView =(CCReturnGoodsFooterView *)button.superview;
    XYWeakSelf;
    NSDictionary *params = @{@"center_sku_id":self.skuID,
                             @"count":@(self.count),
                             @"types":self.types,
                             @"product_date":self.product_date,
                             @"image_set":footView.photoArray,
                             @"remark":self.remark,
    };
    NSString *path = @"/app0/backorderlist/";
    [[STHttpResquest sharedManager] requestWithPUTMethod:POST
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBManager showBriefAlert:@"提交成功"];
                CCMyOrderViewController *vc = [CCMyOrderViewController new];
                vc.selectIndex = 4;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            });
        }else {
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {

    }];
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
            make.size.mas_equalTo(CGSizeMake(257, 14));
            make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
        }];
        titleLab.text = [NSString stringWithFormat:@"%@",[(NSArray *)self.titleArray[indexPath.section-1] objectAtIndex:indexPath.row]];
        if (indexPath.section == 2 && indexPath.row == 0) {
            NSString *string = [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(self.timemodel.play_price*self.count)];
            //
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"退货金额："];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:15.0f] range:NSMakeRange(0, 5)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 5)];
            //189-00
            NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:string];
            [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.395f] range:NSMakeRange(0, string.length)];
            [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:253.0f/255.0f green:103.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, string.length)];
            [attributedString appendAttributedString:attributedString1];
            titleLab.attributedText = attributedString;
        } else if (indexPath.row == 2 && indexPath.section == 1){
            NSString *string = [NSString stringWithFormat:@"(最多可退%@%@)",self.timemodel.max_count,self.Model.play_unit];
            //
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"请选择退货数量"];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:15.0f] range:NSMakeRange(0, 5)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 5)];
            //189-00
            NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:string];
            [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:15.395f] range:NSMakeRange(0, string.length)];
            [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:253.0f/255.0f green:103.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, string.length)];
            if ([self.timemodel.max_count isNotBlank]) {
                [attributedString appendAttributedString:attributedString1];
            }
            titleLab.attributedText = attributedString;
        }
    }
    if (indexPath.section == 1 &&( indexPath.row ==0 || indexPath.row == 1)) {
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
        if (indexPath.row == 0) {
            subtitleLab.text = [self.timemodel.product_date isNotBlank] ? self.timemodel.product_date : @"请选择";
        } else {
            if ([self.types isNotBlank]) {
                subtitleLab.text = [self.types isEqualToString:@"1"] ? @"临期退货" : @"非临期退货";
            }
        }
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(Window_W - 110, 10, 100, 30)];
        numberButton.shakeAnimation = YES;
        numberButton.editing = NO;
        numberButton.increaseImage = [UIImage imageNamed:@"加号 1"];
        numberButton.decreaseImage = [UIImage imageNamed:@"减号"];
        XYWeakSelf;
        numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
            NSLog(@"%f",number);
            if (number >[weakSelf.timemodel.max_count integerValue]) {
                [MBManager showBriefAlert:@"超出最大退货量"];
            } else {
                weakSelf.count = number;
                [weakSelf.tableView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
            }
            if (self.count && [self.types isNotBlank] && [self.product_date isNotBlank] && self.photoArray.count) {
                [self.footerView.sendBtn setBackgroundColor:kMainColor];
                [self.footerView.sendBtn setUserInteractionEnabled:YES];
            } else {
                [self.footerView.sendBtn setBackgroundColor:kGrayCustomColor];
                [self.footerView.sendBtn setUserInteractionEnabled:NO];
            }
        };
        [cell.contentView addSubview:numberButton];
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        UITextField *titleTextField = [UITextField new];
        titleTextField.font = FONT_16;
        titleTextField.textAlignment = NSTextAlignmentLeft;
        titleTextField.textColor = COLOR_999999;
        titleTextField.userInteractionEnabled = YES;
        [cell.contentView addSubview:titleTextField];
        titleTextField.frame = CGRectMake(105, 10, Window_W - 115, 30);
        titleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        titleTextField.tag = 100+indexPath.row;
        [cell.contentView addSubview:titleTextField];
        [titleTextField addTarget:self action:@selector(textChangeField:) forControlEvents:UIControlEventEditingDidEnd];
        self.fieldView = titleTextField;
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIImageView *iconIamgeView4 = ({
            UIImageView *view = [UIImageView new];
            view.userInteractionEnabled = YES;
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.layer.masksToBounds = YES ;
            view ;
        });
        [cell.contentView addSubview:iconIamgeView4];
        [iconIamgeView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
            make.left.mas_equalTo(cell.contentView).mas_offset(15);
            make.height.width.mas_equalTo(76);
        }];
        [iconIamgeView4 setImageWithURL:[NSURL URLWithString:[[CCTools sharedInstance]IsChinese:self.Model.image]] placeholder:IMAGE_NAME(@"")];
        UILabel *taRendaiFusumTextLab2 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(14);
            view.numberOfLines = 2;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
        [cell.contentView addSubview:taRendaiFusumTextLab2];
        [taRendaiFusumTextLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconIamgeView4.mas_right).mas_offset(10);
            make.width.mas_equalTo(Window_W-76-15-20);
//            make.size.mas_equalTo(CGSizeMake(Window_W-76-15-20, 14));
            make.top.mas_equalTo(10);
        }];
        taRendaiFusumTextLab2.text = self.Model.goods_name;
        UILabel *taRendaiFusumTextLab3 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(14);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
        [cell.contentView addSubview:taRendaiFusumTextLab3];
        [taRendaiFusumTextLab3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconIamgeView4.mas_right).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(Window_W-76-15-20, 14));
            make.top.mas_equalTo(taRendaiFusumTextLab2.mas_bottom).mas_offset(8);
        }];
        if (self.Model.specoption_set.count) {
            NSMutableString *string = [[NSMutableString alloc] init];
            if (self.Model.specoption_set.count == 1) {
                [string appendString:self.Model.specoption_set[0]];
            } else {
                [string appendString:self.Model.specoption_set[0]];
                for (NSString *item in self.Model.specoption_set) {
                    if ([item isEqual:string]) {
                        continue;
                    }
                    [string appendFormat:@",%@",item];
                }
            }
            taRendaiFusumTextLab3.text = string;
        }
        UILabel *taRendaiFusumTextLab1 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(12);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
        [cell.contentView addSubview:taRendaiFusumTextLab1];
        [taRendaiFusumTextLab1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconIamgeView4.mas_right).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.bottom.mas_equalTo(iconIamgeView4.mas_bottom).mas_offset(-4);
        }];
        taRendaiFusumTextLab1.text = [NSString stringWithFormat:@"共%ld件",self.total_count];
    }
    return cell;
}
- (void)textChangeField:(UITextField *)field {
    self.remark = field.text;
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
    if (indexPath.row == 1 && indexPath.section == 1) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UILabel *label = [cell viewWithTag:100];
        XYWeakSelf;
        LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@"" cancelButtonTitle:@"取消" clicked:^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
                NSLog(@"%ld",buttonIndex);
                switch (buttonIndex) {
                    case 1:
                        label.text = @"非临期退货";
                        weakSelf.types =@"0";
                        break;
                    case 2:
                        label.text = @"临期退货";
                        weakSelf.types = @"1";
                        break;
                    case 3:
                        label.text = @"";
                        break;
                    default:
                        break;
                }
            if (self.count && [self.types isNotBlank] && [self.product_date isNotBlank] && self.photoArray.count) {
                [self.footerView.sendBtn setBackgroundColor:kMainColor];
                [self.footerView.sendBtn setUserInteractionEnabled:YES];
            } else {
                [self.footerView.sendBtn setBackgroundColor:kGrayCustomColor];
                [self.footerView.sendBtn setUserInteractionEnabled:NO];
            }
            } otherButtonTitles:@"非临期退货", @"临期退货", nil];
            actionSheet.destructiveButtonColor = kMainColor;
            [actionSheet show];
    } else  if (indexPath.row == 0 && indexPath.section == 1) {
        if ([self.types isNotBlank]) {
          XYWeakSelf;
          UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
          UILabel *label = [cell viewWithTag:100];
          CCOutTimeSelectDateViewController *vc = [[CCOutTimeSelectDateViewController alloc] init];
          vc.types = self.types;
          vc.sku_id =STRING_FROM_INTAGER(self.Model.id);
          vc.clickCatedity = ^(NSString * _Nonnull name, CCTimeSelectModel * _Nonnull timeModel) {
              label.text = name;
              weakSelf.product_date = timeModel.product_date;
              weakSelf.timemodel = timeModel;
//              [weakSelf.tableView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
              [weakSelf.tableView reloadData];
              if (self.count && [self.types isNotBlank] && [self.product_date isNotBlank] && self.photoArray.count) {
                  [self.footerView.sendBtn setBackgroundColor:kMainColor];
                  [self.footerView.sendBtn setUserInteractionEnabled:YES];
              } else {
                  [self.footerView.sendBtn setBackgroundColor:kGrayCustomColor];
                  [self.footerView.sendBtn setUserInteractionEnabled:NO];
              }
          };
          [self.navigationController pushViewController:vc animated:NO];
       } else {
            [MBManager showBriefAlert:@"请选择退货类型"];
        }
    }
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@[@"请选择商品生产日期",@"请选择退货类型",@"请选择退货数量"],@[@"",@"退款说明："]];
    }
    return _titleArray;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (NSMutableArray *)photoArray {
    if (!_photoArray) {
        _photoArray = [[NSMutableArray alloc] init];
    }
    return _photoArray;
}
@end
