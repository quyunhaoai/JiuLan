//
//  BottomAlert2Contentview.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BottomAlert2Contentview.h"
#import "CCSureOrderViewController.h"
//@implementation BottomAlert2Contentview

#import "CCShaiXuanAlertView.h"
#import "CCTextCustomTableViewCell.h"
#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface BottomAlert2Contentview ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) UIImageView *goodsImageView;
@property (strong, nonatomic) UILabel *pricelab;
@property (strong, nonatomic) UILabel *kucunLab;
@property (strong, nonatomic) UILabel *selectLab;
@property (nonatomic,copy) NSString *center_sku_id;
@property (nonatomic,copy) NSString *count;
@property (nonatomic,strong) NSMutableString *selectGuGe;
@property (strong, nonatomic) NSMutableArray *selectArray;
@property (nonatomic,strong) UIButton *sureBtn;
@property (nonatomic,strong) UIButton *sureBtn1;
@property (strong, nonatomic) Sku_setItem *myItem;
@property (strong, nonatomic) UILabel *activeLabLab; //



@end

@implementation BottomAlert2Contentview

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 92;
        
        [self addSubview:_tableView];
    }
    return _tableView;
}
- (instancetype)initWithFrame:(CGRect)frame withShowSure:(BOOL)showSure {
    if (self = [super initWithFrame:frame]) {
        self.showSure = showSure;
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
        self.selectGuGe = [[NSMutableString alloc]init];
        self.tableView.frame = CGRectMake(0, 128, CGRectGetWidth(frame), CGRectGetHeight(frame) - 128-66);
        [self.tableView registerNib:CCTextCustomTableViewCell.loadNib forCellReuseIdentifier:@"cell1234"];
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (_showSure) {
            [rightBtn setBackgroundColor:krgb(255,157,52)];
            rightBtn.layer.masksToBounds = YES;
            rightBtn.layer.cornerRadius = 23;
            [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        } else {
            [rightBtn setBackgroundImage:IMAGE_NAME(@"加入购物车背景大") forState:UIControlStateNormal];
            [rightBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        }
        rightBtn.tag = 12;
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        self.sureBtn = rightBtn;
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(self.showSure?Window_W-30:(Window_W-30)/2);
            make.height.mas_equalTo(46);
            make.top.mas_equalTo(self.mas_bottom).mas_offset(-56);
        }];
        UIButton *sureBtn = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setTitle:@"立即购买" forState:UIControlStateNormal];
            [view.titleLabel setTextColor:kWhiteColor];
            [view.titleLabel setFont:FONT_14];
            [view setBackgroundImage:IMAGE_NAME(@"立即购买背景大") forState:UIControlStateNormal];
            [view setUserInteractionEnabled:YES];
            view.tag = 13;
             [view addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
        if(_showSure)sureBtn.hidden = YES;
        self.sureBtn1 = sureBtn;
        [self addSubview:sureBtn];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(rightBtn.mas_right);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(46);
            make.top.mas_equalTo(self.mas_bottom).mas_offset(-56);
        }];
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 70)];
        self.tableView.tableFooterView = footerView;
        UILabel *pricelab = ({
            UILabel *view = [UILabel new];
            view.textColor = COLOR_333333;
            view.font = FONT_13;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 1;
            view.text = @"购买数量";
            view ;
        });
        [footerView addSubview:pricelab];
        [pricelab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(footerView).mas_offset(20);
            make.left.mas_equalTo(footerView).mas_offset(10);
            make.width.mas_equalTo(Window_W/2);
            make.height.mas_equalTo(17);
        }];
        PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(Window_W - 110, 20, 100, 30)];
        numberButton.shakeAnimation = YES;
        numberButton.increaseImage = [UIImage imageNamed:@"加号 1"];
        numberButton.decreaseImage = [UIImage imageNamed:@"减号"];
        numberButton.currentNumber = 1;
        numberButton.minValue = 1;
        XYWeakSelf;
        numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
            NSLog(@"%d",(int)number);
            if (weakSelf.isChexiao) {
                if (number > weakSelf.cccModel.stock) {
                    [ppBtn setCurrentNumber:weakSelf.cccModel.stock];
                    weakSelf.count = [NSString stringWithFormat:@"%d",(int)weakSelf.model.stock];
                } else {
                    weakSelf.count = [NSString stringWithFormat:@"%d",(int)number];
                }
            } else {
                if (number > weakSelf.model.stock) {
                    [ppBtn setCurrentNumber:weakSelf.model.stock];
                    weakSelf.count = [NSString stringWithFormat:@"%d",(int)weakSelf.model.stock];
                } else {
                    weakSelf.count = [NSString stringWithFormat:@"%d",(int)number];
                }
            }
            [self setPricellll:number];
        };
        self.numberButton = numberButton;
        [footerView addSubview:numberButton];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        [self setUI];
        self.selectGuGe = [[NSMutableString alloc]init];
        self.tableView.frame = CGRectMake(0, 128, CGRectGetWidth(frame), CGRectGetHeight(frame) - 128-66);
        [self.tableView registerNib:CCTextCustomTableViewCell.loadNib forCellReuseIdentifier:@"cell1234"];
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (_showSure) {
            [rightBtn setBackgroundColor:krgb(255,157,52)];
            rightBtn.layer.masksToBounds = YES;
            rightBtn.layer.cornerRadius = 23;
            [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        } else {
            [rightBtn setBackgroundImage:IMAGE_NAME(@"加入购物车背景大") forState:UIControlStateNormal];
            [rightBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        }
        rightBtn.tag = 12;
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        self.sureBtn = rightBtn;
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(self.showSure?Window_W-30:(Window_W-30)/2);
            make.height.mas_equalTo(46);
            make.top.mas_equalTo(self.mas_bottom).mas_offset(-56);
        }];
        UIButton *sureBtn = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setTitle:@"立即购买" forState:UIControlStateNormal];
            [view.titleLabel setTextColor:kWhiteColor];
            [view.titleLabel setFont:FONT_14];
            [view setBackgroundImage:IMAGE_NAME(@"立即购买背景大") forState:UIControlStateNormal];
            [view setUserInteractionEnabled:YES];
            view.tag = 13;
             [view addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
        if(_showSure)sureBtn.hidden = YES;
        [self addSubview:sureBtn];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(rightBtn.mas_right);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(46);
            make.top.mas_equalTo(self.mas_bottom).mas_offset(-56);
        }];
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 70)];
        self.tableView.tableFooterView = footerView;
        UILabel *pricelab = ({
            UILabel *view = [UILabel new];
            view.textColor = COLOR_333333;
            view.font = FONT_13;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 1;
            view.text = @"购买数量";
            view ;
        });
        [footerView addSubview:pricelab];
        [pricelab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(footerView).mas_offset(20);
            make.left.mas_equalTo(footerView).mas_offset(10);
            make.width.mas_equalTo(Window_W/2);
            make.height.mas_equalTo(17);
        }];
        PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(Window_W - 110, 20, 100, 30)];
        numberButton.shakeAnimation = YES;
        numberButton.currentNumber = 1;
        numberButton.minValue = 1;
        numberButton.increaseImage = [UIImage imageNamed:@"加号 1"];
        numberButton.decreaseImage = [UIImage imageNamed:@"减号"];
        XYWeakSelf;
        numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
            NSLog(@"%d",(int)number);
            if (weakSelf.isChexiao) {
                if (number > weakSelf.cccModel.stock) {
                    [ppBtn setCurrentNumber:weakSelf.cccModel.stock];
                    weakSelf.count = [NSString stringWithFormat:@"%d",(int)weakSelf.model.stock];
                } else {
                    weakSelf.count = [NSString stringWithFormat:@"%d",(int)number];
                }
            } else {
                if (number > weakSelf.model.stock) {
                    [ppBtn setCurrentNumber:weakSelf.model.stock];
                    weakSelf.count = [NSString stringWithFormat:@"%d",(int)weakSelf.model.stock];
                } else {
                    weakSelf.count = [NSString stringWithFormat:@"%d",(int)number];
                }
            }
            [self setPricellll:number];
        };
        
        [footerView addSubview:numberButton];
        self.numberButton = numberButton;
    }
    return self;
}
- (void)setPricellll:(CGFloat )count{
    if (self.isChexiao) {
        return;
    }
    NSString *price = self.myItem.sku_promote == nil ? STRING_FROM_0_FLOAT(self.myItem.play_price):STRING_FROM_0_FLOAT(self.myItem.sku_promote.now_price);
        if (self.myItem.sku_promote != nil) {
            if (self.myItem.sku_promote.types == 1 || self.myItem.sku_promote.types == 0) {
                price = STRING_FROM_0_FLOAT(self.myItem.sku_promote.now_price);
            } else if(self.myItem.sku_promote.types == 2) {
                if (self.myItem.is_grid_play_price) {
                    for (Grid_play_priceItem *model in self.myItem.grid_play_price) {
                        if (count>model.down_limit) {
                            price = STRING_FROM_INTAGER(model.play_price);
                        }
                    }
                }
            }
        } else {
            if (self.myItem.is_grid_play_price) {
                for (Grid_play_priceItem *model in self.myItem.grid_play_price) {
                    if (count>model.down_limit) {
                        price = STRING_FROM_INTAGER(model.play_price);
                    }
                }
            }
        }
        //46-90
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",price]];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];
        //46-90 text-style1
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length)];
        self.pricelab.attributedText = attributedString;
}
- (void)setUI {
   UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 128)];
    [self addSubview:headView];
    UIImageView *goodsImageView = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        view;
    });
    [headView addSubview:goodsImageView];
    [goodsImageView masUpdateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView).mas_offset(10);
        make.top.mas_equalTo(headView).mas_offset(10);
        make.width.mas_equalTo(102);
        make.height.mas_equalTo(107);
    }];
    self.goodsImageView = goodsImageView;
    [goodsImageView setLayerShadow:kWhiteColor offset:CGSizeMake(0, 0) radius:5];
    UILabel *pricelab = ({
        UILabel *view = [UILabel new];
        view.textColor = color_textBg_C7C7D1;
        view.font = FONT_10;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [headView addSubview:pricelab];
    [pricelab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(28);
        make.left.mas_equalTo(goodsImageView.mas_right).mas_offset(10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];
    self.pricelab = pricelab;
    UIImageView *icon = ({
          UIImageView *view = [UIImageView new];
          view.contentMode = UIViewContentModeScaleAspectFill ;
          view.layer.masksToBounds = YES ;
          view.userInteractionEnabled = YES;
          view.image = IMAGE_NAME(@"叉号图标");
          view;
    });
    [headView addSubview:icon];
    [icon mas_updateConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(headView).mas_offset(10);
          make.right.mas_equalTo(headView).mas_offset(-10);
          make.width.mas_equalTo(21);
          make.height.mas_equalTo(21);
    }];
    [icon addTapGestureWithBlock:^(UIView *gestureView) {
          CCShaiXuanAlertView *alertView = (CCShaiXuanAlertView *)self.superview;
          [alertView hide];
    }];
    UILabel *kucunLab = ({
        UILabel *view = [UILabel new];
        view.textColor = color_textBg_C7C7D1;
        view.font = FONT_10;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [headView addSubview:kucunLab];
    [kucunLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pricelab.mas_bottom).mas_offset(16);
        make.left.mas_equalTo(goodsImageView.mas_right).mas_offset(10);
        make.width.mas_equalTo(Window_W*0.3);
        make.height.mas_equalTo(17);
    }];
    self.kucunLab = kucunLab;
    UILabel *selectLab = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_333333;
        view.font = FONT_10;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [self addSubview:selectLab];
    [selectLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kucunLab.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(goodsImageView.mas_right).mas_offset(10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];
    self.selectLab = selectLab;
    UILabel *activeLab  = ({
        UILabel *view = [UILabel new];
        view.textColor = kRedColor;
        view.font = FONT_10;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [self addSubview:activeLab];
    [activeLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(selectLab.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(goodsImageView.mas_right).mas_offset(10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(14);
    }];
    self.activeLabLab = activeLab;
    
    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    line.backgroundColor = COLOR_e5e5e5;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(goodsImageView.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.spec_set.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 92;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView removeAllSubviews];
    UILabel *nameLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(13);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view ;
    });
    [cell.contentView addSubview:nameLab];
    [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.contentView).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(177, 14));
        make.top.mas_equalTo(cell.contentView).mas_offset(10);
    }];
    Spec_setItem *mmm = self.model.spec_set[indexPath.row];
    nameLab.text = mmm.spec_name;
    if (mmm.children.count) {
        NSMutableArray *strArray = [NSMutableArray array];
        for (NSDictionary  *item in mmm.children) {
            ChildrenItem *iiii = [ChildrenItem modelWithJSON:item];
            [strArray addObject:iiii.specoption_name];
        }
        GBTagListView *tagList=[[GBTagListView alloc]initWithFrame:CGRectMake(0, 34, Window_W, 0)];
        tagList.tag = indexPath.row;
        /**允许点击 */
        tagList.canTouch=YES;
        /**可以控制允许点击的标签数 */
        tagList.canTouchNum=5;
        /**控制是否是单选模式 */
        tagList.isSingleSelect=YES;
        tagList.signalTagColor=krgb(245,245,245);
        [tagList setTagWithTagArray:strArray];

        __weak __typeof(self)weakSelf = self;
        [tagList setDidselectItemBlock:^(NSArray *arr,NSInteger tag) {
            if (arr.count) {
                NSString *str = [NSString stringWithFormat:@"\"%@\"",arr[0]];
                if (![weakSelf.selectGuGe containsString:str]) {
                    [weakSelf.selectArray replaceObjectAtIndex:tag withObject:str];
                }
                weakSelf.selectGuGe = [[NSMutableString alloc] init];
                for (NSString *string in weakSelf.selectArray) {
                    if (string.length>0) {
                        [weakSelf.selectGuGe appendString:string];
                    }
                }
                weakSelf.selectLab.text = [NSString stringWithFormat:@"已选择：%@",weakSelf.selectGuGe];
                [weakSelf selectGuge:weakSelf.selectGuGe];
            }
        }];
        [cell.contentView addSubview:tagList];
    }
    return cell;
}

- (void)selectGuge:(NSString *)str {
    for (Sku_setItem *item in self.model.sku_set) {
        NSString *sstring = [item.specoption_str stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([str isEqualToString:sstring]) {
            self.myItem = item;
            self.center_sku_id = STRING_FROM_INTAGER(item.sku_id);
            [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:IMAGE_NAME(@"")];
            NSString *price = item.sku_promote == nil ? STRING_FROM_0_FLOAT(item.play_price):STRING_FROM_0_FLOAT(item.sku_promote.now_price);
            if (item.sku_promote != nil) {
                if (item.sku_promote.types == 1 || item.sku_promote.types == 0) {
                    price = STRING_FROM_0_FLOAT(item.sku_promote.now_price);
                    NSString *string = [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(item.sku_promote.old_price)];
                    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:string];
                    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, string.length)];
                    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f] range:NSMakeRange(0, string.length)];
                    [attributedString2 addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid)} range:NSMakeRange(0, string.length)];
                   //46-90
                   NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",price]];
                   [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
                   [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];
                   //46-90 text-style1
                   [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length)];
                   [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length)];
                    [attributedString appendAttributedString:attributedString2];
                   self.pricelab.attributedText = attributedString;
                    if (item.sku_promote.limit_stock||item.sku_promote.limit) {
                        self.activeLabLab.text =item.sku_promote.limit == 0 ? [NSString stringWithFormat:@"限购%ld%@",item.sku_promote.limit_stock,item.unit] : [NSString stringWithFormat:@"限购%ld%@",item.sku_promote.limit,item.unit];
                    } else  {
                        self.activeLabLab.text = @"";
                    }
                } else if(item.sku_promote.types == 2) {
                    if (item.sku_promote.limit_stock||item.sku_promote.limit) {
                        NSString *manjian = [NSString stringWithFormat:@"每满%ld%@送%ld%@",item.sku_promote.full,item.unit,item.sku_promote.give,item.unit];
                        NSString *xiangou = item.sku_promote.limit == 0 ? [NSString stringWithFormat:@"限购%ld%@",item.sku_promote.limit_stock,item.unit] : [NSString stringWithFormat:@"限购%ld%@",item.sku_promote.limit,item.unit];
                        self.activeLabLab.text = [NSString stringWithFormat:@"%@,%@",manjian,xiangou];
                    } else  {
                        self.activeLabLab.text = @"";
                    }
                }
            } else {
                //46-90
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",price]];
                [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];
                //46-90 text-style1
                [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length)];
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length)];
        
                self.pricelab.attributedText = attributedString;
                self.activeLabLab.text = @"";
            }

            self.kucunLab.text = [NSString stringWithFormat:@"库存%ld%@",item.stock,item.unit];
            if (item.stock == 0) {
                [self.sureBtn setTitle:@"上报需求" forState:0];
                [self.sureBtn setBackgroundColor:krgb(255,157,52)];
                self.sureBtn.layer.masksToBounds = YES;
                self.sureBtn.layer.cornerRadius = 23;
                [self.sureBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(15);
                    make.width.mas_equalTo(Window_W-30);
                    make.height.mas_equalTo(46);
                    make.top.mas_equalTo(self.mas_bottom).mas_offset(-56);
                }];
                self.sureBtn1.hidden = YES;
            } else {
                if (self.showSure) {
                    [self.sureBtn setTitle:@"确定" forState:0];
                    [self.sureBtn setBackgroundColor:krgb(255,157,52)];
                    self.sureBtn.layer.masksToBounds = YES;
                    self.sureBtn.layer.cornerRadius = 23;
                } else {
                    self.sureBtn1.hidden = NO;
                    [self.sureBtn setTitle:@"加入购物车" forState:0];
                    [self.sureBtn setBackgroundImage:IMAGE_NAME(@"加入购物车背景大") forState:UIControlStateNormal];
                    self.sureBtn.layer.masksToBounds = YES;
                    self.sureBtn.layer.cornerRadius = 0;
                    [self.sureBtn setBackgroundColor:kClearColor];
                }
                [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(15);
                    make.width.mas_equalTo(self.showSure?Window_W-30:(Window_W-30)/2);
                    make.height.mas_equalTo(46);
                    make.top.mas_equalTo(self.mas_bottom).mas_offset(-56);
                }];
            }
        }
    }
}

- (void)botBtnClick:(UIButton *)btn
{
    if (btn.tag == 13){
        if (![self.center_sku_id isNotBlank]) {
            Sku_setItem *item = self.model.sku_set[0];
            self.center_sku_id =STRING_FROM_INTAGER(item.sku_id);
        }
        self.count =STRING_FROM_0_FLOAT(self.numberButton.currentNumber);
        CCSureOrderViewController *vc = [[CCSureOrderViewController alloc] initWithTypes:@"1"
                                                                             withmcarts:@[]
                                                                      withCenter_sku_id:self.center_sku_id
                                                                              withCount:self.count];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }else if ([btn.titleLabel.text isEqualToString:@"上报需求"]) {
         if (self.model.spec_set.count) {
             if (![self.center_sku_id isNotBlank]) {
                 [MBManager showBriefAlert:@"请选择商品属性！"];
                 return;
             }
         } else {
             Sku_setItem *item = self.model.sku_set[0];
             self.center_sku_id =STRING_FROM_INTAGER(item.sku_id);
         }
        self.count =STRING_FROM_0_FLOAT(self.numberButton.currentNumber);
        NSDictionary *params = @{@"amount":self.count,
                                 @"center_sku_id":self.center_sku_id,
        };
        NSString *path = @"/app0/skustockneed/";
        [[STHttpResquest sharedManager] requestWithPUTMethod:POST
                                                    WithPath:path
                                                  WithParams:params
                                            WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            NSInteger status = [[dic objectForKey:@"errno"] integerValue];
            NSString *msg = [[dic objectForKey:@"errmsg"] description];
            if(status == 0){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBManager showBriefAlert:@"已上报"];
                    CCShaiXuanAlertView *alertView = (CCShaiXuanAlertView *)self.superview;
                    [alertView hide];
                });
            }else {
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
            }
        } WithFailurBlock:^(NSError * _Nonnull error) {
        }];

    } else {
        XYWeakSelf;
        if (self.isChexiao) {
             self.center_sku_id = STRING_FROM_INTAGER(_cccModel.ccid);
             self.count =STRING_FROM_0_FLOAT(self.numberButton.currentNumber);
         } else {
             if (self.model.spec_set.count) {
                 if (![self.center_sku_id isNotBlank]) {
                     [MBManager showBriefAlert:@"请选择商品属性！"];
                     return;
                 }
             } else {
                 Sku_setItem *item = self.model.sku_set[0];
                 self.center_sku_id =STRING_FROM_INTAGER(item.sku_id);
             }
         }
        self.count =STRING_FROM_0_FLOAT(self.numberButton.currentNumber);
        if(self.isSureOrder){
            CCSureOrderViewController *vc = [[CCSureOrderViewController alloc] initWithTypes:@"1"
                                                                                 withmcarts:@[]
                                                                          withCenter_sku_id:self.center_sku_id
                                                                                  withCount:self.count];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }else {
            NSDictionary *params = @{@"center_sku_id":checkNull(self.center_sku_id),
                                     @"count":checkNull(self.count),
            };
            NSString *path = self.isChexiao ? @"/app0/caraddcarts/" : @"/app0/mcarts/";
            [[STHttpResquest sharedManager] requestWithMethod:POST
                                                     WithPath:path
                                                   WithParams:params
                                             WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
                NSInteger status = [[dic objectForKey:@"errno"] integerValue];
                NSString *msg = [[dic objectForKey:@"errmsg"] description];
                if(status == 0){
                    if (weakSelf.blackSelect) {
                        weakSelf.blackSelect([NSString stringWithFormat:@"已选择：%@",weakSelf.selectGuGe]);
                    }
                    CCShaiXuanAlertView *alertView = (CCShaiXuanAlertView *)self.superview;
                    [alertView hide];
                    [kNotificationCenter postNotificationName:@"requestShopCarData1" object:nil];
                    [kNotificationCenter postNotificationName:@"refreshShopCarInfo" object:nil];
                }else {
                    if (msg.length>0) {
                        [MBManager showBriefAlert:msg];
                    }
                }
            } WithFailurBlock:^(NSError * _Nonnull error) {
            }];
        }
    }
}

- (void)setCccModel:(CCChexiaoListModel *)cccModel {
    _cccModel = cccModel;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:_cccModel.image] placeholderImage:IMAGE_NAME(@"")];
    NSString *price = STRING_FROM_0_FLOAT(_cccModel.play_price);
         //46-90
      NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",price]];
      [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
      [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];
     //46-90 text-style1
      [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length)];
      [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length)];
      self.pricelab.attributedText = attributedString;
      
      self.kucunLab.text = [NSString stringWithFormat:@"库存%ld件",_cccModel.stock];
      if (_cccModel.stock == 0) {
          [self.sureBtn setTitle:@"上报需求" forState:0];
      } else {
          if (self.showSure) {
              [self.sureBtn setTitle:@"确定" forState:0];
          } else {
              [self.sureBtn setTitle:@"加入购物车" forState:0];
          }
      }
    self.center_sku_id = STRING_FROM_INTAGER(_cccModel.ccid);
    if (_cccModel.specoption_set.count) {
        NSMutableString *string = [[NSMutableString alloc] init];
        if (_cccModel.specoption_set.count == 1) {
            [string appendString:_cccModel.specoption_set[0]];
        } else {
            [string appendString:_cccModel.specoption_set[0]];
            for (NSString *item in _cccModel.specoption_set) {
                if ([item isEqual:string]) {
                    continue;
                }
                [string appendFormat:@",%@",item];
            }
        }
        self.selectLab.text = string;
    }
}
- (void)setModel:(CCGoodsDetailInfoModel *)model {
    _model = model;
    if (model.spec_set.count) {
        NSString *url = self.model.goodsimage_set[0];
        [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:IMAGE_NAME(@"")];
        NSString *price = _model.promote == nil ? STRING_FROM_0_FLOAT(_model.play_price):STRING_FROM_0_FLOAT(_model.promote.now_price);
           //46-90
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",price]];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];
       //46-90 text-style1
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length)];
        self.pricelab.attributedText = attributedString;
        
        self.kucunLab.text = [NSString stringWithFormat:@"库存%ld件",_model.stock];
        if (model.stock == 0) {
            [self.sureBtn setTitle:@"上报需求" forState:0];
        } else {
            if (self.showSure) {
                [self.sureBtn setTitle:@"确定" forState:0];
            } else {
                [self.sureBtn setTitle:@"加入购物车" forState:0];
            }
        }
        NSMutableString *string = [[NSMutableString alloc] initWithString:@"请选择："];
        for (Spec_setItem *ccc  in self.model.spec_set) {
            [string appendString:ccc.spec_name];
        }
        self.selectLab.text = string;
        for (Sku_setItem *item in self.model.sku_set) {
            [self.selectArray addObject:@""];
        }
    } else {
        Sku_setItem *item = self.model.sku_set[0];
        self.myItem = item;
         self.center_sku_id = STRING_FROM_INTAGER(item.sku_id);
         [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:IMAGE_NAME(@"")];
         NSString *price = item.sku_promote == nil ? STRING_FROM_0_FLOAT(item.play_price):STRING_FROM_0_FLOAT(item.sku_promote.now_price);
         //46-90
         NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",price]];
         [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
         [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];
         //46-90 text-style1
         [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length)];
         [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length)];
         self.pricelab.attributedText = attributedString;
         self.kucunLab.text = [NSString stringWithFormat:@"库存%ld件",item.stock];
         if (item.stock == 0) {
             [self.sureBtn setTitle:@"上报需求" forState:0];
         } else {
             if (self.showSure) {
                 [self.sureBtn setTitle:@"确定" forState:0];
             } else {
                 [self.sureBtn setTitle:@"加入购物车" forState:0];
             }
         }
    }
    [self.tableView reloadData];
}

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [[NSMutableArray alloc] init];
    }
    return _selectArray;
}
@end


