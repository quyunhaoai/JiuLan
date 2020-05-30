//
//  CCSureOrderViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSureOrderViewController.h"
#import "CCSureOrderBottomView.h"
#import "CCSureOrder.h"
#import "NKAlertView.h"
#import "BottomAlert3ContentView.h"
#import "CCCententAlertErWeiMaView.h"
#import "CCAddBlankCarViewController.h"
@interface CCSureOrderViewController ()
{
    
}
@property (strong, nonatomic) CCSureOrderBottomView *bottomView;

@property (assign, nonatomic) BOOL isOpen;

@property (assign, nonatomic) NSInteger selectPayType;
@property (assign, nonatomic) BOOL isSlect;
@property (strong, nonatomic) UIView *temView;


@end

@implementation CCSureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavBarWithTitle:@"确认订单"];
    self.hhhView.frame = CGRectMake(0, 0, Window_W, 85);
    self.tableView.tableHeaderView = self.hhhView;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    self.bottomView.frame = CGRectMake(0, 0, Window_W, 51);
    self.tableView.tableFooterView = self.bottomView;
    self.tableView.backgroundColor = UIColorHex(0xf7f7f7);
    
    [self initData];
    [self setupUI];
}
- (void)setupUI {
//    NKAlertView *alert = [[NKAlertView alloc] init];
//    BottomAlert3ContentView *bottomCententView = [[BottomAlert3ContentView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 197)];;
//    XYWeakSelf;
//    bottomCententView.btnClick = ^{
//        CCAddBlankCarViewController *vc = [CCAddBlankCarViewController new];
//        [weakSelf.navigationController pushViewController:vc animated:YES];
//    };
//    alert.contentView = bottomCententView;
//    alert.type = NKAlertViewTypeBottom;
//    alert.hiddenWhenTapBG = YES;
//
//    [alert show];
}
- (void)initData {
    self.dataSoureArray = @[[CCSureOrder new],[CCSureOrder new]].mutableCopy;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    }
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView model:self.dataSoureArray[indexPath.row] indexPath:indexPath];
        return cell;
    } else if(indexPath.section == 1) {
       static NSString *CellIdentifier = @"CellIdentifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView removeAllSubviews];
        [self cellAddSubViews:cell.contentView];
        
        return cell;
    }else{
        static NSString *CellIdentifier = @"CellIdentifier2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.textColor = COLOR_333333;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"商品数量"];
            cell.detailTextLabel.text = @"3";
        } else {
            cell.textLabel.text = [NSString stringWithFormat:@"商品金额"];
            cell.detailTextLabel.text = @"¥234.00";
        }

        return cell;
    }

}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (self.isOpen) {
            return 318;
        } else {
            return 132;
        }
    } else if (indexPath.section == 2){
        return 40;
    }
    NSString *modelName = NSStringFromClass([self.dataSoureArray[indexPath.row] class]);
    Class CellClass = NSClassFromString([modelName stringByAppendingString:@"TableViewCell"]);
    if ([modelName isEqualToString:@"TextModel"]) {
        CellClass = NSClassFromString(@"TextModelCell");
    }
    return [CellClass height];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}


 
#pragma mark  -  get
-(CCSureOrderHeadView *)hhhView {
    if (!_hhhView) {
        _hhhView = [[CCSureOrderHeadView alloc] init];
        _hhhView.backgroundColor = kWhiteColor;
        _hhhView.nameLab.text = @"收货人：王强";;
        _hhhView.addressLab.text = @"收货地址：河南省 郑州市 二七区 长江路街道长江路与连云路交叉口正商城2号楼 ";
        _hhhView.numberLab.text = @"13145217111";
    }
    return _hhhView;
}

- (CCSureOrderBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CCSureOrderBottomView alloc] init];
        //
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"合计："];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f] range:NSMakeRange(0, 3)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];
        //234-00
        NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:@"¥234.00"];
        [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:20.0f] range:NSMakeRange(0, 7)];
        [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:254.0f/255.0f green:98.0f/255.0f blue:44.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 7)];
        [attributedString appendAttributedString:attributedString1];
        _bottomView.sumLab.attributedText = attributedString;
    }
    return _bottomView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NKAlertView *alert = [[NKAlertView alloc] init];
    alert.contentView = [[CCCententAlertErWeiMaView alloc] initWithFrame:CGRectMake(0, 0, 300, 336)];
    alert.type = NKAlertViewTypeDef;
    alert.hiddenWhenTapBG = YES;
    
    [alert show];
}

- (void)cellAddSubViews:(UIView *)contentView {
     UILabel *titlelab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_333333;
         view.font = STFont(12);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.text = @"支付方式";
         view ;
     });
     [contentView addSubview:titlelab];
     [titlelab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(contentView).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(117, 14));
         make.top.mas_equalTo(contentView).mas_offset(10);
     }];
     
     UIView *zhanHuView = [[UIView alloc] init];
     zhanHuView.userInteractionEnabled = YES;
     [contentView addSubview:zhanHuView];
     [zhanHuView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(titlelab.mas_bottom).mas_offset(15);
         make.left.mas_equalTo(contentView).mas_offset(10);
         make.right.mas_equalTo(contentView).mas_offset(-10);
         make.height.mas_equalTo(32);
     }];
     [[CCTools sharedInstance] addborderToView:zhanHuView width:1.0 color:kMainColor];
     UIImageView *iconIamgeView = ({
         UIImageView *view = [UIImageView new];
         view.userInteractionEnabled = YES;
         view.contentMode = UIViewContentModeScaleAspectFill;
         view.image = [UIImage imageNamed:@"选中圆点图标 1"];
         view.layer.masksToBounds = YES ;
         view.tag = 1;
         view ;
     });
     [zhanHuView addSubview:iconIamgeView];
     [iconIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.mas_equalTo(zhanHuView).mas_offset(0);
         make.left.mas_equalTo(contentView).mas_offset(15);
         make.height.width.mas_equalTo(13);
     }];
     UILabel *zhuanghutitlelab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_333333;
         view.font = STFont(12);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.text = @"账户余额";
         view ;
     });
     [zhanHuView addSubview:zhuanghutitlelab];
    self.temView = zhanHuView;
    XYWeakSelf;
    [zhanHuView addTapGestureWithBlock:^(UIView *gestureView) {
        weakSelf.isSlect = !weakSelf.isSlect;
        if (weakSelf.isSlect) {
            weakSelf.selectPayType = 1;
        }
        [weakSelf setSelectState:gestureView isSelect:weakSelf.isSlect];
    }];
     [zhuanghutitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(iconIamgeView.mas_right).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(117, 14));
         make.centerY.mas_equalTo(zhanHuView).mas_offset(0);
     }];
     UILabel *yuEtitlelab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_333333;
         view.font = STFont(12);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.text = @"可用余额：";
         view ;
     });
     [contentView addSubview:yuEtitlelab];
     [yuEtitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(contentView).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(70, 14));
         make.top.mas_equalTo(zhanHuView.mas_bottom).mas_offset(10);
     }];
     UIButton *chongzhiBtn = ({
         UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
         [view setTitleColor:kMainColor forState:UIControlStateNormal];
         [view setTitle:@"充值" forState:UIControlStateNormal];
         [view.titleLabel setFont:FONT_15];
         view.tag = 3;
         [view addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
         view ;
     });
     [contentView addSubview:chongzhiBtn];
     [chongzhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(yuEtitlelab.mas_right).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(50, 25));
         make.centerY.mas_equalTo(yuEtitlelab).mas_offset(0);
     }];
     KKButton *rightBtn = [KKButton buttonWithType:UIButtonTypeCustom];
     rightBtn.tag = 11;
     [rightBtn setTitle:@"其他" forState:UIControlStateNormal];
     if (self.isOpen) {
        [rightBtn setImage:IMAGE_NAME(@"上箭头") forState:UIControlStateNormal];
     } else {
        [rightBtn setImage:IMAGE_NAME(@"下箭头") forState:UIControlStateNormal];
     }
     [rightBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
     rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
     [rightBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
     [contentView addSubview:rightBtn];
     [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(yuEtitlelab.mas_bottom).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(50, 25));
         make.centerX.mas_equalTo(contentView).mas_offset(0);
     }];
     [rightBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    if (!self.isOpen) {
        return;
    }
     UIView *weixinView = [[UIView alloc] init];
     [contentView addSubview:weixinView];
     [weixinView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(rightBtn.mas_bottom).mas_offset(10);
         make.left.mas_equalTo(contentView).mas_offset(10);
         make.right.mas_equalTo(contentView).mas_offset(-10);
         make.height.mas_equalTo(32);
     }];
     [[CCTools sharedInstance] addborderToView:weixinView width:1.0 color:COLOR_e5e5e5];
     UIImageView *iconIamgeView1 = ({
         UIImageView *view = [UIImageView new];
         view.userInteractionEnabled = YES;
         view.contentMode = UIViewContentModeScaleAspectFill;
         view.image = [UIImage imageNamed:@"未选中圆点图标"];
         view.layer.masksToBounds = YES ;
          view.tag = 1;
         view ;
     });
     [weixinView addSubview:iconIamgeView1];
     [iconIamgeView1 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.mas_equalTo(weixinView).mas_offset(0);
         make.left.mas_equalTo(contentView).mas_offset(15);
         make.height.width.mas_equalTo(13);
     }];
     UILabel *weixintitlelab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_333333;
         view.font = STFont(12);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.text = @"微信支付";
         view ;
     });
     [weixinView addSubview:weixintitlelab];
     [weixintitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(iconIamgeView1.mas_right).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(117, 14));
         make.centerY.mas_equalTo(weixinView).mas_offset(0);
     }];
    UIImageView *iconIamge1 = ({
        UIImageView *view = [UIImageView new];
        view.userInteractionEnabled = YES;
        view.contentMode = UIViewContentModeScaleToFill;
        view.image = [UIImage imageNamed:@"微信图标 1"];
        view.layer.masksToBounds = YES ;
         view.tag = 1;
        view ;
    });
    [weixinView addSubview:iconIamge1];
    [iconIamge1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weixinView).mas_offset(0);
        make.right.mas_equalTo(contentView).mas_offset(-21);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(25);
    }];
     [weixinView addTapGestureWithBlock:^(UIView *gestureView) {
         weakSelf.isSlect = !weakSelf.isSlect;
         if (weakSelf.isSlect) {
             weakSelf.selectPayType = 2;
         }
         [weakSelf setSelectState:gestureView isSelect:weakSelf.isSlect];
     }];
     UIView *zhifubaoView = [[UIView alloc] init];
     [contentView addSubview:zhifubaoView];
     [zhifubaoView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(weixinView.mas_bottom).mas_offset(15);
         make.left.mas_equalTo(contentView).mas_offset(10);
         make.right.mas_equalTo(contentView).mas_offset(-10);
         make.height.mas_equalTo(32);
     }];
     [[CCTools sharedInstance] addborderToView:zhifubaoView width:1.0 color:COLOR_e5e5e5];
     UIImageView *iconIamgeView2 = ({
         UIImageView *view = [UIImageView new];
         view.userInteractionEnabled = YES;
         view.contentMode = UIViewContentModeScaleAspectFill;
         view.image = [UIImage imageNamed:@"未选中圆点图标"];
         view.layer.masksToBounds = YES ;
          view.tag = 1;
         view ;
     });
     [zhifubaoView addSubview:iconIamgeView2];
     [iconIamgeView2 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.mas_equalTo(zhifubaoView).mas_offset(0);
         make.left.mas_equalTo(contentView).mas_offset(15);
         make.height.width.mas_equalTo(13);
     }];
     UILabel *zhifubaotitlelab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_333333;
         view.font = STFont(12);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.text = @"支付宝支付";
         view ;
     });
     [zhifubaoView addSubview:zhifubaotitlelab];
     [zhifubaotitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(iconIamgeView2.mas_right).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(117, 14));
         make.centerY.mas_equalTo(zhifubaoView).mas_offset(0);
     }];
    UIImageView *iconIamge2 = ({
        UIImageView *view = [UIImageView new];
        view.userInteractionEnabled = YES;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.image = [UIImage imageNamed:@"支付宝图标"];
        view.layer.masksToBounds = YES ;
         view.tag = 1;
        view ;
    });
    [zhifubaoView addSubview:iconIamge2];
    [iconIamge2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(zhifubaoView).mas_offset(0);
        make.right.mas_equalTo(contentView).mas_offset(-21);
        make.height.width.mas_equalTo(18);
    }];
     [zhifubaoView addTapGestureWithBlock:^(UIView *gestureView) {
         weakSelf.isSlect = !weakSelf.isSlect;
         if (weakSelf.isSlect) {
             weakSelf.selectPayType = 3;
         }
         [weakSelf setSelectState:gestureView isSelect:weakSelf.isSlect];
     }];
     UIView *yinlianzhifuView = [[UIView alloc] init];
     [contentView addSubview:yinlianzhifuView];
     [yinlianzhifuView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(zhifubaoView.mas_bottom).mas_offset(10);
         make.left.mas_equalTo(contentView).mas_offset(10);
         make.right.mas_equalTo(contentView).mas_offset(-10);
         make.height.mas_equalTo(32);
     }];
     [[CCTools sharedInstance] addborderToView:yinlianzhifuView width:1.0 color:COLOR_e5e5e5];
     UIImageView *iconIamgeView3 = ({
         UIImageView *view = [UIImageView new];
         view.userInteractionEnabled = YES;
         view.contentMode = UIViewContentModeScaleAspectFill;
         view.image = [UIImage imageNamed:@"未选中圆点图标"];
         view.layer.masksToBounds = YES ;
          view.tag = 1;
         view ;
     });
     [yinlianzhifuView addSubview:iconIamgeView3];
     [iconIamgeView3 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.mas_equalTo(yinlianzhifuView).mas_offset(0);
         make.left.mas_equalTo(contentView).mas_offset(15);
         make.height.width.mas_equalTo(13);
     }];
     UILabel *yinliantitlelab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_333333;
         view.font = STFont(12);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.text = @"银联支付";
         view ;
     });
     [yinlianzhifuView addSubview:yinliantitlelab];
     [yinliantitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(iconIamgeView3.mas_right).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(117, 14));
         make.centerY.mas_equalTo(yinlianzhifuView).mas_offset(0);
     }];
    [yinlianzhifuView addTapGestureWithBlock:^(UIView *gestureView) {
        weakSelf.isSlect = !weakSelf.isSlect;
        if (weakSelf.isSlect) {
            weakSelf.selectPayType = 4;
        }
        [weakSelf setSelectState:gestureView isSelect:weakSelf.isSlect];
    }];
     UIView *tarendaifuView = [[UIView alloc] init];
     [contentView addSubview:tarendaifuView];
     [tarendaifuView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(yinlianzhifuView.mas_bottom).mas_offset(10);
         make.left.mas_equalTo(contentView).mas_offset(10);
         make.right.mas_equalTo(contentView).mas_offset(-10);
         make.height.mas_equalTo(32);
     }];
     [[CCTools sharedInstance] addborderToView:tarendaifuView width:1.0 color:COLOR_e5e5e5];
     UIImageView *iconIamgeView4 = ({
         UIImageView *view = [UIImageView new];
         view.userInteractionEnabled = YES;
         view.contentMode = UIViewContentModeScaleAspectFill;
         view.image = [UIImage imageNamed:@"未选中圆点图标"];
         view.layer.masksToBounds = YES ;
         view.tag = 1;
         view ;
     });
     [tarendaifuView addSubview:iconIamgeView4];
     [iconIamgeView4 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.mas_equalTo(tarendaifuView).mas_offset(0);
         make.left.mas_equalTo(contentView).mas_offset(15);
         make.height.width.mas_equalTo(13);
     }];
     UILabel *taRendaiFutitlelab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_333333;
         view.font = STFont(12);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.text = @"他人代付";
         view ;
     });
     [tarendaifuView addSubview:taRendaiFutitlelab];
     [taRendaiFutitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(iconIamgeView4.mas_right).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(117, 14));
         make.centerY.mas_equalTo(tarendaifuView).mas_offset(0);
     }];
    [tarendaifuView addTapGestureWithBlock:^(UIView *gestureView) {
        weakSelf.isSlect = !weakSelf.isSlect;
        if (weakSelf.isSlect) {
            weakSelf.selectPayType = 5;
        }
        [weakSelf setSelectState:gestureView isSelect:weakSelf.isSlect];
    }];
}

- (void)BtnClick:(UIButton *)button {
    if (button.tag == 3) {
        //充值
    } else {
        //其他
        self.isOpen = !self.isOpen;
        [self.tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
    }
}
- (void)setSelectState:(UIView *)view isSelect:(BOOL) isSelect {
    UIImageView *imageView = [view viewWithTag:1];
    if ([self.temView isEqual:view]) {
        if (isSelect) {
            imageView.image = [UIImage imageNamed:@"选中圆点图标 1"];
            [[CCTools sharedInstance] addborderToView:view width:1.0 color:kMainColor];
        } else {
            imageView.image = [UIImage imageNamed:@"未选中圆点图标"];
            [[CCTools sharedInstance] addborderToView:view width:1.0 color:COLOR_e5e5e5];
        }
    } else {
        UIImageView *imageV = [self.temView viewWithTag:1];
        imageV.image = [UIImage imageNamed:@"未选中圆点图标"];
        [[CCTools sharedInstance] addborderToView:self.temView width:1.0 color:COLOR_e5e5e5];
        
        imageView.image = [UIImage imageNamed:@"选中圆点图标 1"];
        [[CCTools sharedInstance] addborderToView:view width:1.0 color:kMainColor];

        self.temView = view;
    }
}
@end
