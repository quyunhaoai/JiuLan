
//
//  CCNewPanDianInputTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/29.
//  Copyright © 2020 GOOUC. All rights reserved.
//
#import "BRStringPickerView.h"
#import "CCNewPanDianInputTableViewCell.h"
#import "LMJDropdownMenu.h"
#import "CCTimeSelectViewController.h"
@implementation CCNewPanDianInputTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.timeBtn.layer.masksToBounds = YES;
    self.timeBtn.layer.cornerRadius = 8;
    [self.timeBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRightLeft
                                  imageTitleSpace:5];
    [self.timeBtn setBackgroundColor:[UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f]];
     menu1 = [[LMJDropdownMenu alloc] init];
     [menu1 setFrame:CGRectMake(10, 4, 110, 16)];
     menu1.dataSource = self;
     menu1.delegate   = self;
     
//     menu1.layer.borderColor  = [UIColor whiteColor].CGColor;
//     menu1.layer.borderWidth  = 1;
    menu1.layer.cornerRadius = 8;
     
//     menu1.title           = @"Please Select";
     menu1.titleBgColor    = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
     menu1.titleFont       = [UIFont boldSystemFontOfSize:12];
     menu1.titleColor      = COLOR_333333;
     menu1.titleAlignment  = NSTextAlignmentLeft;
     menu1.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
     
     menu1.rotateIcon      = [UIImage imageNamed:@"downImage_icon"];
     menu1.rotateIconSize  = CGSizeMake(7, 7);
     
     menu1.optionBgColor       = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:0.5];
     menu1.optionFont          = [UIFont systemFontOfSize:12];
     menu1.optionTextColor     = [UIColor clearColor];
     menu1.optionTextAlignment = NSTextAlignmentLeft;
     menu1.optionNumberOfLines = 0;
     menu1.optionLineColor     = [UIColor clearColor];
     menu1.optionIconSize      = CGSizeMake(0, 0);
     
//     [self.contentView addSubview:menu1];
//    [menu1 mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.timeBtn);
//    }];
//    [self loadDate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)timeSelect:(KKButton *)sender {
    CCTimeSelectViewController *vc = [CCTimeSelectViewController new];
    vc.selename = sender.titleLabel.text;
    vc.sku_id = STRING_FROM_INTAGER(sender.tag);
    vc.clickCatedity = ^(NSString * _Nonnull name, NSInteger ID) {
        [sender setTitle:name forState:UIControlStateNormal];
    };
    [self.viewController.navigationController pushViewController:vc
                                                        animated:YES];
}
//- (void)loadDate{
//    XYWeakSelf;
//    NSDictionary *params = @{@"center_sku_id":@(self.item.id),
//                             @"limit":@"20",
//                             @"offset":@"0",
//
//    };
//    NSString *path = @"/app0/reckondatelist/";
//    [[STHttpResquest sharedManager] requestWithMethod:GET
//                                             WithPath:path
//                                           WithParams:params
//                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
//        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
//        NSString *msg = [[dic objectForKey:@"errmsg"] description];
//        if(status == 0){
//            NSDictionary *data = dic[@"data"];
//            NSArray *arr = data[@"results"];
//            weakSelf.dataArray = arr.mutableCopy;
//            [self->menu1 reloadOptionsData];
//        }else {
//            if (msg.length>0) {
//                [MBManager showBriefAlert:msg];
//            }
//        }
//    } WithFailurBlock:^(NSError * _Nonnull error) {
//    }];
//}
//#pragma mark - LMJDropdownMenu DataSource
//- (NSUInteger)numberOfOptionsInDropdownMenu:(LMJDropdownMenu *)menu{
//    return self.dataArray.count;
//}
//- (CGFloat)dropdownMenu:(LMJDropdownMenu *)menu heightForOptionAtIndex:(NSUInteger)index{
//    return 15;
//}
//- (NSString *)dropdownMenu:(LMJDropdownMenu *)menu titleForOptionAtIndex:(NSUInteger)index{
//    return self.dataArray[index];
//}
//- (UIImage *)dropdownMenu:(LMJDropdownMenu *)menu iconForOptionAtIndex:(NSUInteger)index{
//    return nil;
//}
//#pragma mark - LMJDropdownMenu Delegate
//- (void)dropdownMenu:(LMJDropdownMenu *)menu didSelectOptionAtIndex:(NSUInteger)index optionTitle:(NSString *)title{
//    if (menu == menu1) {
//        NSLog(@"你选择了(you selected)：menu1，index: %ld - title: %@", index, title);
//    }
//}
//
//- (void)dropdownMenuWillShow:(LMJDropdownMenu *)menu{
//    NSLog(@"--将要显示(will appear)--menu1");
//
//}
//- (void)dropdownMenuDidShow:(LMJDropdownMenu *)menu{
//    if (menu == menu1) {
//        NSLog(@"--已经显示(did appear)--menu1");
//    }
//}
//
//- (void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu{
//    if (menu == menu1) {
//        NSLog(@"--将要隐藏(will disappear)--menu1");
//    }
//}
//- (void)dropdownMenuDidHidden:(LMJDropdownMenu *)menu{
//    if (menu == menu1) {
//        NSLog(@"--已经隐藏(did disappear)--menu1");
//    }
//}

- (IBAction)delegateBtn:(UIButton *)sender {
    
    
}

- (void)setItem:(Batch_setItemBBB *)item {
    _item = item;
    self.delegate.hidden = !_item.can_del;
    if ([_item.product_date isNotBlank]) {
        [self.timeBtn setTitle:_item.product_date forState:UIControlStateNormal];
        [self.timeBtn setImage:IMAGE_NAME(@"") forState:UIControlStateNormal];
        [self.timeBtn setUserInteractionEnabled:NO];
        [self.timeBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleDefault imageTitleSpace:5];
    } else {
        self.timeBtn.userInteractionEnabled = YES;
    }

    if (_item.sys_stock_set.count ) {
        if (_item.sys_stock_set.count == 2) {
            self.stokLab.text = [NSString stringWithFormat:@"库存数量：%@%@%@%@",_item.sys_stock_set[0],self.unitArray[0],_item.sys_stock_set[1],self.unitArray[1]];
        } else {
            self.stokLab.text = [NSString stringWithFormat:@"库存数量：%@%@",_item.sys_stock_set[0],self.unitArray[0]];
        }
    } else {
        self.stokLab.text = [NSString stringWithFormat:@"库存数量：0箱"];
    }
    if (_item.stock_set.count) {
        if (_item.stock_set.count == 2) {
            self.textField2.text = [NSString stringWithFormat:@"%@",_item.stock_set[0]];
            self.textField3.text = [NSString stringWithFormat:@"%@",_item.stock_set[1]];
            self.unit2.text = [NSString stringWithFormat:@"%@",self.unitArray[0]];
            self.unit3.text = [NSString stringWithFormat:@"%@",self.unitArray[1]];
            self.unit3.hidden = NO;
            self.textField3.hidden = NO;
        } else if(_item.stock_set.count == 1){
            self.textField2.text = [NSString stringWithFormat:@"%@",_item.stock_set[0]];
            self.unit2.text = [NSString stringWithFormat:@"%@",self.unitArray[0]];
            self.unit3.hidden = YES;
            self.textField3.hidden = YES;
        }
    } else {
        self.textField2.text = [NSString stringWithFormat:@"0"];
        self.unit3.hidden = YES;
        self.textField3.hidden = YES;
    }
}

@end
