//
//  SH_MallSubclassificationViewControllerCell.m
//  XiYuanPlus
//
//  Created by xy on 2018/4/10.
//  Copyright © 2018年 Hoping. All rights reserved.
//

#import "SH_MallSubclassificationViewControllerCell.h"

@interface SH_MallSubclassificationViewControllerCell ()
@property (nonatomic, strong) UIImageView  *headImage;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *priceLbel;

#pragma mark - property

@end

@implementation SH_MallSubclassificationViewControllerCell


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID  = @"SH_MallSubclassificationViewControllerCell";
    id cell  = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initCell];
    }
    return self;
}

- (void)initCell {
    
    self.headImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 100, 100)];
    [self.contentView addSubview:self.headImage];
    self.headImage.clipsToBounds = YES;
    self.headImage.contentMode = UIViewContentModeScaleAspectFill;
    self.headImage.image = ImageNamed(@"tempyule_HD");
    
    self.contentView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.priceLbel];
    [self.contentView addSubview:self.lineview];

}

#pragma mark - getters and setters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(self.headImage.frame)+10, 12, Window_W-122-12, 40)];
        _titleLabel.textColor = COLOR_333333;
        _titleLabel.font = FONT_14;
        _titleLabel.text = @"--";
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)priceLbel {
    if (!_priceLbel) {
        _priceLbel = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.titleLabel.frame), 77, Window_W-122-12, 21)];
        _priceLbel.textColor = COLOR_F42415;
        _priceLbel.font = FONT_15;
        _priceLbel.text = @"--";
    }
    return _priceLbel;
}

- (UIView *)lineview {
    if (!_lineview) {
        _lineview = [[UIView alloc] initWithFrame:CGRectMake(0, 109.5, Window_W, 0.5)];
        [self.contentView addSubview:_lineview];
        _lineview.backgroundColor = COLOR_e5e5e5;
    }
    return _lineview;
}



@end
