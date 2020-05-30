//
//  BottomAlert2Contentview.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BottomAlert2Contentview.h"

//@implementation BottomAlert2Contentview

#import "NKAlertView.h"
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
@end

@implementation BottomAlert2Contentview

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        [self setUI];
        
        self.tableView.frame = CGRectMake(0, 128, CGRectGetWidth(frame), CGRectGetHeight(frame) - 128-66);
        [self.tableView registerNib:CCTextCustomTableViewCell.loadNib forCellReuseIdentifier:@"cell1234"];
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.backgroundColor = krgb(255,157,52);
        rightBtn.tag = 12;
        [rightBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.layer.masksToBounds = YES;
        rightBtn.layer.cornerRadius = 23;
        [self addSubview:rightBtn];
        rightBtn.frame = CGRectMake(10, CGRectGetHeight(frame) - 56, CGRectGetWidth(frame)-20, 46);
        
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
        XYWeakSelf;
        numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
            NSLog(@"%f",number);
            weakSelf.count = [NSString stringWithFormat:@"%f",number];
        };
        
        [footerView addSubview:numberButton];
    }
    return self;
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
          NKAlertView *alertView = (NKAlertView *)self.superview;
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

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.spec_set.count;
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
        /**允许点击 */
        tagList.canTouch=YES;
        /**可以控制允许点击的标签数 */
        tagList.canTouchNum=5;
        /**控制是否是单选模式 */
        tagList.isSingleSelect=YES;
        tagList.signalTagColor=krgb(245,245,245);
        [tagList setTagWithTagArray:strArray];
        __weak __typeof(self)weakSelf = self;
        [tagList setDidselectItemBlock:^(NSArray *arr) {
            NSLog(@"选中的标签%@",arr);
            NSString *str = [NSString stringWithFormat:@"\"%@\"",arr[0]];
            weakSelf.selectLab.text = [NSString stringWithFormat:@"已选择：%@",str];
            [weakSelf selectGuge:str];
        }];
        [cell.contentView addSubview:tagList];
    }
    return cell;
}
- (void)selectGuge:(NSString *)str {
    for (Sku_setItem *item in self.model.sku_set) {
        if ([str isEqualToString:item.specoption_str]) {
            self.center_sku_id = STRING_FROM_INTAGER(item.sku_id);
            [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:IMAGE_NAME(@"")];
             NSString *price = _model.promote == nil ? STRING_FROM_INTAGER(_model.play_price):STRING_FROM_INTAGER(_model.promote.old_price);
            //46-90
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",price]];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];
            //46-90 text-style1
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length)];
            self.pricelab.attributedText = attributedString;
            self.kucunLab.text = [NSString stringWithFormat:@"库存%ld件",item.stock];
        }
    }
    
}
- (void)botBtnClick:(UIButton *)btn
{
    NSDictionary *params = @{@"center_sku_id":checkNull(self.center_sku_id),
                             @"count":checkNull(self.count),
    };
    NSString *path = @"/app0/mcarts/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            NKAlertView *alertView = (NKAlertView *)self.superview;
            [alertView hide];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];

}
- (void)setModel:(CCGoodsDetailInfoModel *)model {
    _model = model;
    NSString *url = self.model.goodsimage_set[0];
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:IMAGE_NAME(@"")];
    NSString *price = _model.promote == nil ? STRING_FROM_INTAGER(_model.play_price):STRING_FROM_INTAGER(_model.promote.old_price);
       //46-90
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",price]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];
   //46-90 text-style1
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length)];
    self.pricelab.attributedText = attributedString;
    
    self.kucunLab.text = [NSString stringWithFormat:@"库存%ld件",_model.stock];
    NSMutableString *string = [[NSMutableString alloc] initWithString:@"请选择："];
    for (Spec_setItem *ccc  in self.model.spec_set) {
        [string appendString:ccc.spec_name];
    }
    self.selectLab.text = string;
    [self.tableView reloadData];
}
@end


