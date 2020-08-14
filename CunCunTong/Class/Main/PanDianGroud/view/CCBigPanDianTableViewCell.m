
//
//  CCBigPanDianTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/29.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBigPanDianTableViewCell.h"
#import "CCNewPanDianInputTableViewCell.h"
@implementation CCBigPanDianTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;;
    
}
- (void)addView {
//Child_setItem *item = self.model.child_set[indexPath.row-2];
     UILabel *subtitleLab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_666666;
         view.font = STFont(13);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.tag = 100;
         view.text =[NSString stringWithFormat:@"商品名称："];
         view ;
     });
     [self.contentView addSubview:subtitleLab];
     [subtitleLab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self.contentView).mas_offset(23);
         make.size.mas_equalTo(CGSizeMake(237, 14));
         make.top.mas_equalTo(self.contentView).mas_offset(10);
     }];
    self.titleLab = subtitleLab;
     UILabel *subtitleLab2 = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_666666;
         view.font = STFont(13);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.tag = 100;

        view.text = [NSString stringWithFormat:@"规格："];

         view ;
     });
     [self.contentView addSubview:subtitleLab2];
     [subtitleLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self.contentView).mas_offset(23);
         make.size.mas_equalTo(CGSizeMake(167, 14));
         make.top.mas_equalTo(subtitleLab.mas_bottom).mas_offset(6);
     }];
    self.gugeLab = subtitleLab2;
     UILabel *subtitleLab3 = ({
         UILabel *view = [UILabel new];
         view.textColor = krgb(255,16,16);
         view.font = STFont(13);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.tag = 100;
         view.text = [NSString stringWithFormat:@"库存数量："];
         view ;
     });
     [self.contentView addSubview:subtitleLab3];
     [subtitleLab3 mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self.contentView).mas_offset(23);
         make.size.mas_equalTo(CGSizeMake(167, 14));
         make.top.mas_equalTo(subtitleLab2.mas_bottom).mas_offset(6);
     }];
    self.stokeLab = subtitleLab3;
     UILabel *subtitleLab4 = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_666666;
         view.font = STFont(13);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.tag = 100;
         view.text = [NSString stringWithFormat:@"单位："];
         view ;
     });
     [self.contentView addSubview:subtitleLab4];
     [subtitleLab4 mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(subtitleLab2.mas_right).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(107, 14));
         make.top.mas_equalTo(subtitleLab.mas_bottom).mas_offset(6);
     }];
    self.untiLab = subtitleLab4;
     UILabel *subtitleLab5 = ({
         UILabel *view = [UILabel new];
         view.textColor =krgb(255,24,24);
         view.font = STFont(13);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.tag = 100;
         view.text = [NSString stringWithFormat:@"盘点数量："];
         view ;
     });
     [self.contentView addSubview:subtitleLab5];
     [subtitleLab5 mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(subtitleLab4).mas_offset(0);
         make.size.mas_equalTo(CGSizeMake(180, 14));
         make.top.mas_equalTo(subtitleLab4.mas_bottom).mas_offset(6);
     }];
    self.pandianLab = subtitleLab5;
    UILabel *subtitleLab6 = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_666666;
        view.font = STFont(13);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = [NSString stringWithFormat:@"批次明细："];
        view ;
    });
    [self.contentView addSubview:subtitleLab6];
    [subtitleLab6 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(23);
        make.size.mas_equalTo(CGSizeMake(107, 14));
        make.top.mas_equalTo(subtitleLab5.mas_bottom).mas_offset(6);
    }];
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(10);
        make.right.mas_equalTo(self.contentView).mas_offset(-10);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
        make.top.mas_equalTo(subtitleLab6.mas_bottom).mas_offset(5);
    }];
    self.tableView.backgroundColor = kWhiteColor;
    [self.tableView registerNib:CCNewPanDianInputTableViewCell.loadNib forCellReuseIdentifier:@"CCNewPanDianInputTableViewCell"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W-20, 34)];
    UIButton *sureBtn = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setTitle:@"+新增批次" forState:UIControlStateNormal];
        [view setTitleColor:kMainColor forState:UIControlStateNormal];
        [view.titleLabel setFont:FONT_12];
        [view setUserInteractionEnabled:YES];
         [view addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        view ;
    });
    [view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
    self.tableView.tableFooterView = view;
    UIView *line = [[UIView alloc] init];
    [self.contentView addSubview:line];
    line.backgroundColor = UIColorHex(0xf7f7f7);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];

}
- (void)setIsDatil:(BOOL)isDatil {
    _isDatil = isDatil;
    if (_isDatil) {
        self.tableView.tableFooterView = nil;
    }
}
- (void)commentBtnClick:(UIButton *)button {
    if (self.deleaget && [self.deleaget respondsToSelector:@selector(clickButtonWithView:item:)]) {
        [self.deleaget clickButtonWithView:button item:self.item];
    }
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 61;
        _tableView.estimatedSectionFooterHeight = 0.001;
        _tableView.estimatedSectionHeaderHeight = 0.001;
        _tableView.rowHeight = 61;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.item.batch_set.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCNewPanDianInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCNewPanDianInputTableViewCell"];
    cell.unitArray = self.item.unit_set;
    Batch_setItemBBB *item =self.item.batch_set[indexPath.row];
    cell.item = item;
    [cell.textField2 addTarget:self action:@selector(textField2Change:) forControlEvents:UIControlEventEditingDidEnd];
    [cell.textField3 addTarget:self action:@selector(textField3Change:) forControlEvents:UIControlEventEditingDidEnd];
    [cell.delegate addTarget:self action:@selector(deleageAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.timeBtn.tag = self.item.center_sku_id;
    if (self.isDatil) {
        cell.timeBtn.userInteractionEnabled = NO;
        [cell.timeBtn setImage:IMAGE_NAME(@"") forState:UIControlStateNormal];
        [cell.timeBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleDefault imageTitleSpace:0];
        cell.unit2.hidden = YES;
        cell.unit3.hidden = YES;
        cell.textField2.hidden = YES;
        cell.textField3.hidden = YES;
        if (item.stock_set.count) {
            if (item.stock_set.count == 2) {
                cell.pandianLab.text = [NSString stringWithFormat:@"盘点数量：%@%@%@%@",item.stock_set[0],self.item.unit_set[0],item.stock_set[1],self.item.unit_set[1]];
            } else if(item.stock_set.count == 1){
                cell.pandianLab.text = [NSString stringWithFormat:@"盘点数量：%@%@",item.stock_set[0],self.item.unit_set[0]];
            }
            cell.labelWidth.constant = 110;
        } else {

        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (void)textField2Change:(UITextField *)field{
//    NSInteger count = [field.text integerValue];
    CCNewPanDianInputTableViewCell *cell = (CCNewPanDianInputTableViewCell *)field.superview.superview;
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    if (self.deleaget && [self.deleaget respondsToSelector:@selector(clickButtonWithType:item:andInView:andCommonCell:)]) {
        [self.deleaget clickButtonWithType:1 item:field andInView:self andCommonCell:path];
    }
}
- (void)textField3Change:(UITextField *)field{
    CCNewPanDianInputTableViewCell *cell = (CCNewPanDianInputTableViewCell *)field.superview.superview;
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    if (self.deleaget && [self.deleaget respondsToSelector:@selector(clickButtonWithType:item:andInView:andCommonCell:)]) {
        [self.deleaget clickButtonWithType:2 item:field andInView:self andCommonCell:path];
    }
}
- (void)deleageAction:(UIButton *)button {
    CCNewPanDianInputTableViewCell *cell = (CCNewPanDianInputTableViewCell *)button.superview.superview;
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    if (self.deleaget && [self.deleaget respondsToSelector:@selector(clickButtonWithType:item:andInView:)]) {
        [self.deleaget clickButtonWithType:0 item:path andInView:self];
    }
}

- (void)botBtnClick:(UIButton *)btn
{

}
- (void)setItem:(Child_setItem *)item {
    _item = item;
    self.titleLab.text = [NSString stringWithFormat:@"商品名称：%@",_item.goods_name];
    if (_item.specoption_set.count) {
        NSMutableString *string = [[NSMutableString alloc] init];
        if (item.specoption_set.count == 1) {
            [string appendString:item.specoption_set[0]];
        } else {
            [string appendString:item.specoption_set[0]];
            for (NSString *item1 in item.specoption_set) {
                if ([item1 isEqual:string]) {
                    continue;
                }
                [string appendFormat:@",%@",item1];
            }
        }
        self.gugeLab.text = [NSString stringWithFormat:@"规格：%@",string];
    }
    if (_item.unit_set.count) {
        self.untiLab.text = [NSString stringWithFormat:@"零售单位：%@",_item.unit_set.lastObject];
    }
    NSInteger totalStoke = 0 ;
    NSInteger totalpanDian = 0;
    NSInteger totalStoke2 = 0 ;
    NSInteger totalpanDian2 = 0;
    for (Batch_setItemBBB *model in item.batch_set) {
        if (model.sys_stock_set.count) {
            totalStoke = totalStoke + [model.sys_stock_set[0] integerValue];
            if (model.sys_stock_set.count == 2) {
                totalStoke2 = totalStoke2 + [model.sys_stock_set[1] integerValue];
            }
        }
        if (model.stock_set.count) {
            totalpanDian = totalpanDian + [model.stock_set[0] integerValue];
            if (model.stock_set.count == 2) {
                totalpanDian2 = totalpanDian2 + [model.stock_set[1] integerValue];
            }
        }
    }
    if (totalStoke2) {
        self.stokeLab.text = [NSString stringWithFormat:@"总库存数量：%ld%@%ld%@",(long)totalStoke,_item.unit_set[0],(long)totalStoke2,_item.unit_set[1]];
    } else {
        self.stokeLab.text = [NSString stringWithFormat:@"总库存数量：%ld%@",(long)totalStoke,_item.unit_set[0]];
    }
    if (totalpanDian2) {
        self.pandianLab.text = [NSString stringWithFormat:@"总盘点数量：%ld%@%ld%@",(long)totalpanDian,_item.unit_set[0],(long)totalpanDian2,_item.unit_set[1]];
    } else {
        self.pandianLab.text = [NSString stringWithFormat:@"总盘点数量：%ld%@",(long)totalpanDian,_item.unit_set[0]];
    }
    [self.tableView reloadData];
}
@end
