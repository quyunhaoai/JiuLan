//
//  CCNewAddPanDianViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCNewAddPanDianViewController.h"
#import "KKButton.h"
#import "CCSelectGoodsViewController.h"
#import "BRDatePickerView.h"
#import "CCSelectCatediyViewController.h"
#import "BRStringPickerView.h"
#import "CCAddPanDianModel.h"
#import "CCBigPanDianTableViewCell.h"
#import <IQKeyboardManager.h>
@interface CCNewAddPanDianViewController ()<UITableViewDelegate,UITableViewDataSource,KKCommonDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (nonatomic,copy) NSString *createStr;
@property (nonatomic,strong) CCAddPanDianModel *model;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *types;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *selelctCatedity;  //
@property (strong, nonatomic) NSMutableDictionary *myDic;  //
@end

@implementation CCNewAddPanDianViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [IQKeyboardManager sharedManager].enable = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
         [IQKeyboardManager sharedManager].enable = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.createStr = @"";
    self.remark = @"";
    self.types = @"0";
    [self customNavBarWithTitle:@"新增盘点单"];
    self.tableView.backgroundColor = UIColorHex(0xf7f7f7);
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-44);
    }];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, -10);
    if ([self.paindianID intValue]) {
        self.status = @"0";
        [self initData];
    } else {
        self.status = @"1";
    }
    [self.tableView registerClass:CCBigPanDianTableViewCell.class
           forCellReuseIdentifier:@"CCBigPanDianTableViewCell"];
    [kNotificationCenter addObserver:self selector:@selector(initData) name:@"initData" object:nil];
    [kNotificationCenter addObserver:self selector:@selector(initData2:) name:@"initData2" object:nil];
    
}

- (void)initData2:(NSNotification *)noti {

}

- (void)dealloc {
    [kNotificationCenter removeObserver:self name:@"initData" object:nil];
    [kNotificationCenter removeObserver:self name:@"initData2" object:nil];
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path =[NSString stringWithFormat:@"app0/marketreckon/%@/",self.paindianID];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.myDic = data.mutableCopy;
            weakSelf.model = [CCAddPanDianModel modelWithJSON:data];
            weakSelf.sumlab.text = [NSString stringWithFormat:@"  共%ld种商品",weakSelf.model.count];
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

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.accessibilityIdentifier = @"table_view";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}
- (void)goodsSelect:(UIButton*)button {
    if ([self.createStr isNotBlank]) {
        CCSelectGoodsViewController *vc = [CCSelectGoodsViewController new];
        vc.catedity = self.createStr;
        vc.titleStr = @"选择盘点商品";
        vc.paindianID = self.paindianID;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [MBManager showBriefAlert:@"请选择盘点分类"];
    }
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;;
    } else if (section == 1){
        return 2+self.model.child_set.count;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self.paindianID intValue]) {
      static NSString *CellIdentifier = @"CellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell.contentView removeAllSubviews];
        if (indexPath.section == 1 && indexPath.row == 1) {
            KKButton *backBtn = [KKButton buttonWithType:UIButtonTypeCustom];
            [backBtn setBackgroundColor:krgb(255,165,0)];
            [backBtn.titleLabel setFont:FONT_13];
            [backBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [backBtn setTitle:@"选择商品" forState:UIControlStateNormal];
            [backBtn setImage:IMAGE_NAME(@"选择商品加号") forState:UIControlStateNormal];
            backBtn.layer.cornerRadius = 3;
            backBtn.layer.masksToBounds = YES;
            [backBtn addTarget:self action:@selector(goodsSelect:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:backBtn];
            [backBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(cell.contentView).mas_offset(0);
                make.centerY.mas_equalTo(cell.contentView);
                make.width.mas_equalTo(82);
                make.height.mas_equalTo(25);
            }];
            [backBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
            UIView *line = [UIView new];
            line.backgroundColor = UIColorHex(0xf7f7f7);
            [cell.contentView addSubview:line];
            [line mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.contentView).mas_offset(20);
                make.bottom.mas_equalTo(cell.contentView);
                make.width.mas_equalTo(Window_W-40);
                make.height.mas_equalTo(kWidth(1));
            }];
        } else if (indexPath.section == 2 && indexPath.row == 1) {
            UITextField *titleTextField = [UITextField new];
            titleTextField.font = FONT_16;
            titleTextField.textAlignment = NSTextAlignmentLeft;
            titleTextField.textColor = COLOR_999999;
            titleTextField.userInteractionEnabled = YES;
            [cell.contentView addSubview:titleTextField];
            titleTextField.frame = CGRectMake(20, 10, Window_W - 40, 30);
            titleTextField.clearButtonMode = 0;
            titleTextField.tag = 100+indexPath.row;
            [titleTextField addTarget:self action:@selector(textFieldsChange:) forControlEvents:UIControlEventEditingChanged];
            [cell.contentView addSubview:titleTextField];
        } else if (indexPath.row == 0 || indexPath.section == 0) {
            UILabel *subtitleLab = ({
                UILabel *view = [UILabel new];
                view.textColor =COLOR_333333;
                view.font = STFont(13);
                view.lineBreakMode = NSLineBreakByTruncatingTail;
                view.backgroundColor = [UIColor clearColor];
                view.textAlignment = NSTextAlignmentLeft;
                view.tag = 100;
                view ;
            });
            [cell.contentView addSubview:subtitleLab];
            [subtitleLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.contentView).mas_offset(23);
                make.size.mas_equalTo(CGSizeMake(237, 14));
                make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
            }];
            if (indexPath.row == 0) {
                UIImageView *rightIcon = ({
                    UIImageView *view = [UIImageView new];
                    view.contentMode = UIViewContentModeScaleAspectFit;
                    view.image = [UIImage imageNamed:@"竖线"];
                    view.userInteractionEnabled = YES;
                    view.tag = 100+indexPath.row;
                    view ;
                });
                [cell.contentView addSubview:rightIcon];
                [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cell.contentView).mas_offset(10);
                    make.centerY.mas_equalTo(cell.contentView);
                    make.width.mas_equalTo(kWidth(3));
                    make.height.mas_equalTo(kWidth(14));
                }];
                subtitleLab.text = self.titleArray[indexPath.section];
            } else if(indexPath.row == 1){
                subtitleLab.text = @"盘点类型";
                UIButton *chongzhiBtn = ({
                      UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
                      [view setImage:IMAGE_NAME(@"未选中圆点图标") forState:UIControlStateNormal];
                      [view setImage:IMAGE_NAME(@"选中圆点图标 1") forState:UIControlStateSelected];
                      view.tag = 3;
                      [view addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                      view ;
                  });
                  [cell.contentView addSubview:chongzhiBtn];
                  [chongzhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                      make.left.mas_equalTo(cell.contentView).mas_offset(101);
                      make.size.mas_equalTo(CGSizeMake(16, 16));
                      make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
                  }];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(101+16+15, 7.5, 67, 20)];
                      label.textColor = COLOR_999999;
                      label.font = FONT_14;
                      label.text = @"周盘";
                      label.textAlignment = NSTextAlignmentLeft;
                      [cell.contentView addSubview:label];
                      label.tag = 110+indexPath.row;
                  UIButton *chongzhiBtn1 = ({
                      UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
                      [view setImage:IMAGE_NAME(@"未选中圆点图标") forState:UIControlStateNormal];
                      [view setImage:IMAGE_NAME(@"选中圆点图标 1") forState:UIControlStateSelected];
                      view.tag = 4;
                      [view addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                      view ;
                  });
                  [cell.contentView addSubview:chongzhiBtn1];
                  [chongzhiBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                      make.left.mas_equalTo(cell.contentView).mas_offset(199);
                      make.size.mas_equalTo(CGSizeMake(16, 16));
                      make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
                  }];
            
                  UILabel *titlelab1 = ({
                      UILabel *view = [UILabel new];
                      view.textColor =COLOR_999999;
                      view.font = STFont(14);
                      view.lineBreakMode = NSLineBreakByTruncatingTail;
                      view.backgroundColor = [UIColor clearColor];
                      view.textAlignment = NSTextAlignmentLeft;
                      view.text = @"月盘";
                      view ;
                  });
                  [cell.contentView addSubview:titlelab1];
                  [titlelab1 mas_updateConstraints:^(MASConstraintMaker *make) {
                      make.left.mas_equalTo(cell.contentView).mas_offset(199+16+13);
                      make.size.mas_equalTo(CGSizeMake(117, 20));
                      make.top.mas_equalTo(cell.contentView).mas_offset(7.5);
                  }];
                if ([self.types isEqualToString:@"1"]) {
                    [chongzhiBtn1 setSelected:YES];
                } else {
                    [chongzhiBtn setSelected:YES];
                }
            } else if(indexPath.row == 2){
                subtitleLab.text = @"单据日期";
                
            } else if(indexPath.row == 3){
                subtitleLab.text = @"盘点分类";
            }
            if (indexPath.row == 3 || indexPath.row == 2) {
                UILabel *titleLab = ({
                    UILabel *view = [UILabel new];
                    view.textColor =COLOR_666666;
                    view.font = STFont(13);
                    view.lineBreakMode = NSLineBreakByTruncatingTail;
                    view.backgroundColor = [UIColor clearColor];
                    view.textAlignment = NSTextAlignmentRight;
                    view.tag = 1000;
                    view ;
                });
                [cell.contentView addSubview:titleLab];
                [titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(cell.contentView).mas_offset(-20);
                    make.size.mas_equalTo(CGSizeMake(117, 14));
                    make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
                }];
                if (indexPath.row == 2) {
                    titleLab.text = [NSString getCurrentTime:@"yyyy-MM-dd"];
                    [titleLab addTapGestureWithBlock:^(UIView *gestureView) {
                        NSString *str = [NSString getCurrentTime:@"yyyy-MM-dd"];
                        [BRDatePickerView showDatePickerWithTitle:@"请选择" dateType:BRDatePickerModeYMD defaultSelValue:str resultBlock:^(NSString *selectValue) {
                            titleLab.text = selectValue;
                        }];
                    }];
                } else if(indexPath.row == 3) {
                    titleLab.text =self.selelctCatedity.length ? self.selelctCatedity : @"请选择盘点分类";
                }
            }
            UIView *line = [UIView new];
            line.backgroundColor = UIColorHex(0xf7f7f7);
            [cell.contentView addSubview:line];
            [line mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.contentView).mas_offset(20);
                make.bottom.mas_equalTo(cell.contentView);
                make.width.mas_equalTo(Window_W-40);
                make.height.mas_equalTo(kWidth(1));
            }];
        } else if (indexPath.section == 1 && indexPath.row >1){
            Child_setItem *item = self.model.child_set[indexPath.row-2];
            CCBigPanDianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCBigPanDianTableViewCell"];
            cell.item = item;
            cell.deleaget = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        return cell;
    } else {
          static NSString *CellIdentifier = @"CellIdentifier";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if(cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                cell.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell.contentView removeAllSubviews];
            cell.contentView.userInteractionEnabled = NO;

            if (indexPath.section == 1 && indexPath.row == 1) {
                KKButton *backBtn = [KKButton buttonWithType:UIButtonTypeCustom];
                [backBtn setBackgroundColor:krgb(255,165,0)];
                [backBtn.titleLabel setFont:FONT_13];
                [backBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
                [backBtn setTitle:@"选择商品" forState:UIControlStateNormal];
                [backBtn setImage:IMAGE_NAME(@"选择商品加号") forState:UIControlStateNormal];
                backBtn.layer.cornerRadius = 3;
                backBtn.layer.masksToBounds = YES;
                backBtn.userInteractionEnabled = YES;
                [backBtn addTarget:self action:@selector(goodsSelect:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:backBtn];
                [backBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(cell.contentView).mas_offset(0);
                    make.centerY.mas_equalTo(cell.contentView);
                    make.width.mas_equalTo(82);
                    make.height.mas_equalTo(25);
                }];
                [backBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
                UIView *line = [UIView new];
                line.backgroundColor = UIColorHex(0xf7f7f7);
                [cell.contentView addSubview:line];
                [line mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cell.contentView).mas_offset(20);
                    make.bottom.mas_equalTo(cell.contentView);
                    make.width.mas_equalTo(Window_W-40);
                    make.height.mas_equalTo(kWidth(1));
                }];
                cell.contentView.userInteractionEnabled = YES;
                self.createStr =STRING_FROM_INTAGER(self.model.category_id);
            } else if (indexPath.section == 2 && indexPath.row == 1) {
                UITextField *titleTextField = [UITextField new];
                titleTextField.font = FONT_14;
                titleTextField.textAlignment = NSTextAlignmentLeft;
                titleTextField.textColor = COLOR_999999;
                titleTextField.userInteractionEnabled = YES;
                [cell.contentView addSubview:titleTextField];
                titleTextField.frame = CGRectMake(20, 10, Window_W - 40, 30);
                titleTextField.clearButtonMode = UITextFieldViewModeNever;
                titleTextField.tag = 100+indexPath.row;
                [titleTextField addTarget:self action:@selector(textFieldsChange:) forControlEvents:UIControlEventEditingChanged];
                [cell.contentView addSubview:titleTextField];
                cell.contentView.userInteractionEnabled = YES;
            } else if (indexPath.row == 0 || indexPath.section == 0) {
                UILabel *subtitleLab = ({
                    UILabel *view = [UILabel new];
                    view.textColor =COLOR_333333;
                    view.font = STFont(13);
                    view.lineBreakMode = NSLineBreakByTruncatingTail;
                    view.backgroundColor = [UIColor clearColor];
                    view.textAlignment = NSTextAlignmentLeft;
                    view.tag = 100;
                    view ;
                });
                [cell.contentView addSubview:subtitleLab];
                [subtitleLab mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cell.contentView).mas_offset(23);
                    make.size.mas_equalTo(CGSizeMake(237, 14));
                    make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
                }];
                if (indexPath.row == 0) {
                    UIImageView *rightIcon = ({
                        UIImageView *view = [UIImageView new];
                        view.contentMode = UIViewContentModeScaleAspectFit;
                        view.image = [UIImage imageNamed:@"竖线"];
                        view.userInteractionEnabled = YES;
                        view.tag = 100+indexPath.row;
                        view ;
                    });
                    [cell.contentView addSubview:rightIcon];
                    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(cell.contentView).mas_offset(10);
                        make.centerY.mas_equalTo(cell.contentView);
                        make.width.mas_equalTo(kWidth(3));
                        make.height.mas_equalTo(kWidth(14));
                    }];
                    subtitleLab.text = self.titleArray[indexPath.section];
                } else if(indexPath.row == 1){
                    subtitleLab.text = @"盘点类型";
                    UIButton *chongzhiBtn = ({
                          UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
                          [view setImage:IMAGE_NAME(@"未选中圆点图标") forState:UIControlStateNormal];
                          [view setImage:IMAGE_NAME(@"选中圆点图标 1") forState:UIControlStateSelected];
                          view.tag = 3;
                          [view addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                          view ;
                      });
                      [cell.contentView addSubview:chongzhiBtn];
                      [chongzhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                          make.left.mas_equalTo(cell.contentView).mas_offset(101);
                          make.size.mas_equalTo(CGSizeMake(16, 16));
                          make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
                      }];
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(101+16+15, 7.5, 67, 20)];
                          label.textColor = COLOR_999999;
                          label.font = FONT_14;
                          label.text = @"周盘";
                          label.textAlignment = NSTextAlignmentLeft;
                          [cell.contentView addSubview:label];
                          label.tag = 110+indexPath.row;
                      UIButton *chongzhiBtn1 = ({
                          UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
                          [view setImage:IMAGE_NAME(@"未选中圆点图标") forState:UIControlStateNormal];
                          [view setImage:IMAGE_NAME(@"选中圆点图标 1") forState:UIControlStateSelected];
                          view.tag = 4;
                          [view addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                          view ;
                      });
                      [cell.contentView addSubview:chongzhiBtn1];
                      [chongzhiBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                          make.left.mas_equalTo(cell.contentView).mas_offset(199);
                          make.size.mas_equalTo(CGSizeMake(16, 16));
                          make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
                      }];
                
                      UILabel *titlelab1 = ({
                          UILabel *view = [UILabel new];
                          view.textColor =COLOR_999999;
                          view.font = STFont(14);
                          view.lineBreakMode = NSLineBreakByTruncatingTail;
                          view.backgroundColor = [UIColor clearColor];
                          view.textAlignment = NSTextAlignmentLeft;
                          view.text = @"月盘";
                          view ;
                      });
                      [cell.contentView addSubview:titlelab1];
                      [titlelab1 mas_updateConstraints:^(MASConstraintMaker *make) {
                          make.left.mas_equalTo(cell.contentView).mas_offset(199+16+13);
                          make.size.mas_equalTo(CGSizeMake(117, 20));
                          make.top.mas_equalTo(cell.contentView).mas_offset(7.5);
                      }];
                    if (self.model.types == 0) {
                        chongzhiBtn.selected = YES;
                        chongzhiBtn1.selected = NO;
                    } else {
                        chongzhiBtn1.selected = YES;
                        chongzhiBtn.selected = NO;
                    }
                    self.types = STRING_FROM_INTAGER(self.model.types);
                } else if(indexPath.row == 2){
                    subtitleLab.text = @"单据日期";
                    
                } else if(indexPath.row == 3){
                    subtitleLab.text = @"盘点分类";
                }
                if (indexPath.row == 3 || indexPath.row == 2) {
                    UILabel *titleLab = ({
                        UILabel *view = [UILabel new];
                        view.textColor =COLOR_666666;
                        view.font = STFont(13);
                        view.lineBreakMode = NSLineBreakByTruncatingTail;
                        view.backgroundColor = [UIColor clearColor];
                        view.textAlignment = NSTextAlignmentRight;
                        view.tag = 1000;
                        view ;
                    });
                    [cell.contentView addSubview:titleLab];
                    [titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(cell.contentView).mas_offset(-20);
                        make.size.mas_equalTo(CGSizeMake(217, 14));
                        make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
                    }];
                    if (indexPath.row == 2) {
                        titleLab.text = self.model.update_time;
                    } else if(indexPath.row == 3) {
                        titleLab.text = self.model.category;
                    }
                }
                UIView *line = [UIView new];
                line.backgroundColor = UIColorHex(0xf7f7f7);
                [cell.contentView addSubview:line];
                [line mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cell.contentView).mas_offset(20);
                    make.bottom.mas_equalTo(cell.contentView);
                    make.width.mas_equalTo(Window_W-40);
                    make.height.mas_equalTo(kWidth(1));
                }];
            } else if (indexPath.section == 1 && indexPath.row >1){
                Child_setItem *item = self.model.child_set[indexPath.row-2];
                CCBigPanDianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCBigPanDianTableViewCell"];
                cell.item = item;
                cell.deleaget = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            return cell;
    }
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0 || indexPath.section == 0) {
        return 35;
    } else if (indexPath.section == 1 && indexPath.row >1){
        Child_setItem *item = self.model.child_set[indexPath.row-2];
        return 74+item.batch_set.count*66+50;
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
    [self.tableView endEditing:YES];
    if (indexPath.section == 0 && indexPath.row == 3 && ![self.paindianID intValue]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UILabel *textLab = [cell viewWithTag:1000];
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
                    textLab.text = selectValue;
                    for (NSDictionary *dic in data) {
                        NSString *str = dic[@"name"];
                        if ([selectValue isEqualToString:str]) {
                            weakSelf.createStr = [NSString stringWithFormat:@"%ld",[dic[@"id"] integerValue]];
                        }
                    }
                    weakSelf.selelctCatedity = selectValue;
                    [weakSelf clearData];
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
- (void)clearData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path =[NSString stringWithFormat:@"/app0/reckoncentersku/%@/",self.paindianID];
    [[STHttpResquest sharedManager] requestWithPUTMethod:DELETE
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            [weakSelf initData];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 圆角弧度半径
    CGFloat cornerRadius = 6.f;
    // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
    cell.backgroundColor = UIColor.clearColor;
    
    // 创建一个shapeLayer
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
    // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
    CGMutablePathRef pathRef = CGPathCreateMutable();
    // 获取cell的size
    // 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
    CGRect bounds = CGRectInset(cell.bounds, 10, 0);
    
    // CGRectGetMinY：返回对象顶点坐标
    // CGRectGetMaxY：返回对象底点坐标
    // CGRectGetMinX：返回对象左边缘坐标
    // CGRectGetMaxX：返回对象右边缘坐标
    // CGRectGetMidX: 返回对象中心点的X坐标
    // CGRectGetMidY: 返回对象中心点的Y坐标
    
    // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行
    
    // CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
    if (indexPath.row == 0) {
        // 初始起点为cell的左下角坐标
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
        // 起始坐标为左下角，设为p，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
        
    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        // 初始起点为cell的左上角坐标
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        // 添加一条直线，终点坐标为右下角坐标点并放到路径中去
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
    } else {
        // 添加cell的rectangle信息到path中（不包括圆角）
        CGPathAddRect(pathRef, nil, bounds);
    }
    // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
    layer.path = pathRef;
    backgroundLayer.path = pathRef;
    // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
    CFRelease(pathRef);
    // 按照shape layer的path填充颜色，类似于渲染render
    // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    
    // view大小与cell一致
    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
    // 添加自定义圆角后的图层到roundView中
    [roundView.layer insertSublayer:layer atIndex:0];
    roundView.backgroundColor = UIColor.clearColor;
    // cell的背景view
    cell.backgroundView = roundView;
    
    // 以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
    // 如果你 cell 已经取消选中状态的话,那以下方法是不需要的.
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
    backgroundLayer.fillColor = [UIColor cyanColor].CGColor;
    [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
    selectedBackgroundView.backgroundColor = UIColor.clearColor;
    cell.selectedBackgroundView = selectedBackgroundView;
    
}
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"基础信息",@"盘点商品",@"备注"];
    }
    return _titleArray;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (IBAction)panDianOver:(id)sender {
    XYWeakSelf;
    NSDictionary *params = @{@"category_id":self.createStr,
                             @"status":@(1),
                             @"types":self.types,
                             @"remark":self.remark,
                             @"child_set":self.model.child_set.modelToJSONObject,
    };
    NSString *path = [self.paindianID integerValue] ?  [NSString stringWithFormat:@"/app0/marketreckon/%@/",self.paindianID] : @"/app0/marketreckon/";
    [[STHttpResquest sharedManager] requestWithPUTMethod:[self.paindianID integerValue] ? PUT : POST
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [kNotificationCenter postNotificationName:@"initData" object:nil];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];

}

- (IBAction)zanCunBtn:(id)sender {
    XYWeakSelf;
    NSDictionary *params = @{@"category_id":self.createStr,
                             @"status":@(0),
                             @"types":self.types,
                             @"remark":self.remark,
                             @"child_set":self.self.model.child_set.modelToJSONObject,
    };
    NSString *path = [self.paindianID integerValue] ?  [NSString stringWithFormat:@"/app0/marketreckon/%@/",self.paindianID] : @"/app0/marketreckon/";
    [[STHttpResquest sharedManager] requestWithPUTMethod:[self.paindianID integerValue] ? PUT : POST
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
             dispatch_async(dispatch_get_main_queue(), ^{
                 [kNotificationCenter postNotificationName:@"initData" object:nil];
                 [weakSelf.navigationController popViewControllerAnimated:YES];
             });
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (void)BtnClicked:(UIButton *)button {
    button.selected = !button.isSelected;
    UIView *cell = (UIView *)button.superview;
    if (button.tag == 13) {//提交
        
    } else if (button.tag == 3) {
        self.types = @"0";
        button.selected = YES;
        UIButton *otherBtn = [cell viewWithTag:4];
        otherBtn.selected = NO;
    } else {
        self.types = @"1";
        button.selected = YES;
        UIButton *otherBtn = [cell viewWithTag:3];
        otherBtn.selected = NO;
    }
}

- (void)textFieldsChange:(UITextField *)textField {
    if (textField.tag == 101) {
        self.remark = textField.text;
    } else {
        UITableViewCell *cell = (UITableViewCell *)textField.superview.superview;
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        Child_setItem *item = self.model.child_set[path.row-2];
        item.count = [textField.text integerValue];
    }
}

#pragma mark  -  kkcommontdelegate
- (void)clickButtonWithView:(id)view item:(id)item {
    UIButton *button = (UIButton *)view;
    CCBigPanDianTableViewCell *cell = (CCBigPanDianTableViewCell *)button.superview.superview.superview.superview;
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    NSMutableArray *arr = [self.myDic[@"child_set"] mutableCopy];
    NSMutableDictionary *dict = [arr[path.row-2] mutableCopy];
    NSMutableArray *arr2 = [dict[@"batch_set"] mutableCopy];
    [arr2 addObject:@{ @"id": @0,
                       @"product_date": @"",
                       @"amount": @0,
                       @"stock_set": @[@0],
                       @"sys_stock_set":@[@0],
                       @"can_del":@1,
    }];
    [dict setObject:arr2 forKey:@"batch_set"];
    [arr replaceObjectAtIndex:path.row-2 withObject:dict];
    [self.myDic setObject:arr forKey:@"child_set"];
    self.model = [CCAddPanDianModel modelWithJSON:self.myDic];
    [self.tableView reloadData];
}

- (void)clickButtonWithType:(KKBarButtonType)type item:(id)item andInView:(UIView *)View {
    NSIndexPath *path2 = (NSIndexPath *)item;
    CCBigPanDianTableViewCell *cell = (CCBigPanDianTableViewCell *)View;
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    NSMutableArray *arr = [self.myDic[@"child_set"] mutableCopy];
    NSMutableDictionary *dict = [arr[path.row-2] mutableCopy];
    NSMutableArray *arr2 = [dict[@"batch_set"] mutableCopy];
    [arr2 removeObjectAtIndex:path2.row];
    [dict setObject:arr2 forKey:@"batch_set"];
    [arr replaceObjectAtIndex:path.row-2 withObject:dict];
    [self.myDic setObject:arr forKey:@"child_set"];
    self.model = [CCAddPanDianModel modelWithJSON:self.myDic];
    [self.tableView reloadData];
}
- (void)clickButtonWithType:(KKBarButtonType)type item:(id)item andInView:(UIView *)View andCommonCell:(NSIndexPath *)index {

    UITextField *field = (UITextField *)item;
    CCBigPanDianTableViewCell *cell = (CCBigPanDianTableViewCell *)View;
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    NSMutableArray *arr = [self.myDic[@"child_set"] mutableCopy];
    NSMutableDictionary *dict = [arr[path.row-2] mutableCopy];
    NSMutableArray *arr2 = [dict[@"batch_set"] mutableCopy];
    NSMutableDictionary *mutablDict = [arr2[index.row] mutableCopy];
    NSInteger count = [field.text integerValue];
    NSMutableArray *stock_set = [mutablDict[@"stock_set"] mutableCopy];
    if (type == 2) {
        [stock_set replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:count]];
    } else {
        [stock_set replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:count]];
    }
    [mutablDict setValue:stock_set forKey:@"stock_set"];
    [arr2 replaceObjectAtIndex:index.row withObject:mutablDict];
    [dict setObject:arr2 forKey:@"batch_set"];
    [arr replaceObjectAtIndex:path.row-2 withObject:dict];
    [self.myDic setObject:arr forKey:@"child_set"];
    self.model = [CCAddPanDianModel modelWithJSON:self.myDic];
    [self.tableView reloadData];
}
@end
