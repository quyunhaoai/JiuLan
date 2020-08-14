//
//  CCTousuDetailViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/27.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCTousuDetailViewController.h"
#import "CCNeedListModel.h"
#import "PYPhotosView.h"

@interface CCTousuDetailViewController ()

@end

@implementation CCTousuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavBarWithTitle:@"投诉详情"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        if (self.model.status == 0) {
            return 2;
        }
        return 4;
    } else if (section == 0){
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView removeAllSubviews];
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"投诉时间";
            cell.detailTextLabel.text = self.model.create_time;
        }else if (indexPath.row == 1) {
            cell.textLabel.text = @"回复状态";
            if (self.model.status == 0) {
                 cell.detailTextLabel.text = @"未回复";
            } else {
                 cell.detailTextLabel.text = @"已回复";
            }
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"回复时间";
            cell.detailTextLabel.text = @"";
        } else {
            cell.textLabel.text = @"回复结果";
            cell.detailTextLabel.text = self.model.return_msg;
        }
    } else if(indexPath.section == 2){
        UILabel *nameLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(15);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"凭证";
            view ;
        });
        [cell.contentView addSubview:nameLab];
        [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(25);
            make.size.mas_equalTo(CGSizeMake(77, 14));
            make.top.mas_equalTo(cell.contentView).mas_offset(10);
        }];
        // 1. 常见一个发布图片时的photosView
        PYPhotosView *publishPhotosView = [PYPhotosView photosView];
        publishPhotosView.photosState = 1;
        publishPhotosView.addImageButtonImage = IMAGE_NAME(@"");
        publishPhotosView.autoSetPhotoState = NO;
        publishPhotosView.x = 25;
        publishPhotosView.y = 10 + 21 + 10;
        publishPhotosView.width = Window_W -24;
        publishPhotosView.photoWidth = ((Window_W - 24) - 24 - 25)/4;
        publishPhotosView.photoHeight = ((Window_W - 24) - 24 - 25)/4;
        publishPhotosView.photoMargin = 8;
        [cell.contentView addSubview:publishPhotosView];
        publishPhotosView.thumbnailUrls = self.model.photo_set.mutableCopy;
    } else if (indexPath.section == 1){
        UILabel *nameLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(15);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
        [cell.contentView addSubview:nameLab];
        [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(25);
            make.size.mas_equalTo(CGSizeMake(Window_W-20, 14));
            make.top.mas_equalTo(cell.contentView).mas_offset(10);
        }];
        nameLab.text = [NSString stringWithFormat:@"具体描述："];
        UILabel *nameLab1 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(15);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
        [cell.contentView addSubview:nameLab1];
        [nameLab1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(25);
            make.size.mas_equalTo(CGSizeMake(Window_W-20,40));
            make.top.mas_equalTo(nameLab.mas_bottom).mas_offset(5);
        }];
        nameLab1.text = [NSString stringWithFormat:@"%@",self.model.info];
    } else if (indexPath.section == 0){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"投诉订单";
            cell.detailTextLabel.text =[NSString stringWithFormat:@"%@",self.model.order_num];
        } else if (indexPath.row == 1){
            cell.textLabel.text = @"投诉原因";
            cell.detailTextLabel.text =[NSString stringWithFormat:@"%@",self.model.reason];
        }
    }
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return ((Window_W - 24) - 24)/4+40;
    } else if (indexPath.section == 1){
        return 100;
    } else if (indexPath.section == 0){
        return 48;
    }
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

@end
