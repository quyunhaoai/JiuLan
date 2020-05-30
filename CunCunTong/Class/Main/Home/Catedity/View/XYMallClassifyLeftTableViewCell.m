//
//  XYMallClassifyLeftTableViewCell.m
//  XiYuanPlus
//
//  Created by lijie lijie on 2018/4/10.
//  Copyright © 2018年 Hoping. All rights reserved.
//

#import "XYMallClassifyLeftTableViewCell.h"
@interface XYMallClassifyLeftTableViewCell ()
@property (nonatomic, strong) UIView *view;


@end
@implementation XYMallClassifyLeftTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID  = @"XYMallClassifyLeftTableViewCell";
    id cell  = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

// 注意：cell是用initWithStyle初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加所有子控件
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}


- (void)setUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.nameLabel = [UILabel new];
    self.nameLabel.font = FONT_15;
    self.nameLabel.textColor = COLOR_333333;
    [self.contentView addSubview:self.nameLabel];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(kWidth(14));
        make.bottom.mas_equalTo(self.contentView).mas_offset(-kWidth(14));
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
    }];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    
    UIView *view = [UIView new];
    view.backgroundColor = COLOR_e5e5e5;
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.7);
        make.left.right.mas_equalTo(self.contentView);
    }];
    self.view = view;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.contentView.backgroundColor = selected ? COLOR_f5f5f5 : [UIColor whiteColor];
    self.highlighted = selected;
//    self.view.backgroundColor = selected ? COLOR_e5e5e5:[UIColor whiteColor];
    self.nameLabel.textColor = selected ?kMainColor: COLOR_333333 ;
}
@end
