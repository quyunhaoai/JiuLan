//
//  CCNeedDetailViewController.m
//  CunCunDriverEnd
//
//  Created by GOOUC on 2020/7/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCNeedDetailViewController.h"
#import "CCNeedListModel.h"
#import "PYPhotosView.h"

@interface CCNeedDetailViewController ()
@property (nonatomic,strong) CCNeedListModel *model; //
@end

@implementation CCNeedDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavBarWithTitle:@"需求上报详情"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self initData];
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path =[NSString stringWithFormat:@"/app0/need/%@/",self.needID];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        NSDictionary *data = dic[@"data"];
        if(status == 0){
            weakSelf.model = [CCNeedListModel modelWithJSON:data];
            [weakSelf.tableView reloadData];
        } else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        if (self.model.status == 0) {
            return 2;
        } else {
            return 4;
        }
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.font = FONT_14;
    }
    [cell.contentView removeAllSubviews];
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            cell.textLabel.text = @"审核状态";//0：待审核，2：已拒绝，15：添加中，3：完成
            if (self.model.status == 0) {
                 cell.detailTextLabel.text = @"审核中";
            } else if(self.model.status == 2) {
                 cell.detailTextLabel.text = @"审核拒绝";
                } else if(self.model.status == 15) {
                     cell.detailTextLabel.text = @"添加中";
                    } else if(self.model.status == 3) {
                         cell.detailTextLabel.text = @"已完成";
                    }
        }else if (indexPath.row == 0){
            cell.textLabel.text = @"申请时间";
            cell.detailTextLabel.text = self.model.create_time;
        } else if(indexPath.row == 2){
            cell.textLabel.text = @"审核时间";
            cell.detailTextLabel.text = self.model.check_time;
            } else if(indexPath.row == 3){
                cell.textLabel.text = @"审核意见";
                cell.detailTextLabel.text = self.model.reason;
                }
        
    } else if(indexPath.section == 0){
        if (indexPath.row == 3) {
            UILabel *nameLab = ({
                UILabel *view = [UILabel new];
                view.textColor =COLOR_333333;
                view.font = STFont(15);
                view.lineBreakMode = NSLineBreakByTruncatingTail;
                view.backgroundColor = [UIColor clearColor];
                view.textAlignment = NSTextAlignmentLeft;
                view.text = @"商品图片：";
                view ;
            });
            [cell.contentView addSubview:nameLab];
            [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.contentView).mas_offset(25);
                make.size.mas_equalTo(CGSizeMake(77, 14));
                make.top.mas_equalTo(cell.contentView).mas_offset(15);
            }];
            // 1. 常见一个发布图片时的photosView
            PYPhotosView *publishPhotosView = [PYPhotosView photosView];
            publishPhotosView.photosState = 1;
            publishPhotosView.addImageButtonImage = IMAGE_NAME(@"");
            publishPhotosView.autoSetPhotoState = NO;
            publishPhotosView.x = 35;
            publishPhotosView.y = 44;
            publishPhotosView.width = Window_W -24;
            publishPhotosView.photoWidth = ((Window_W - 24) - 24 - 25)/4;
            publishPhotosView.photoHeight = ((Window_W - 24) - 24 - 25)/4;
            publishPhotosView.photoMargin = 8;
            [cell.contentView addSubview:publishPhotosView];
            publishPhotosView.thumbnailUrls = self.model.image_set.mutableCopy;
        } else if (indexPath.row == 1){
            cell.textLabel.text = @"需求数量：";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld%@",self.model.amount,self.model.unit];
        } else if (indexPath.row == 0){
            cell.textLabel.text = @"需求商品名称：";
            cell.detailTextLabel.text = self.model.name;
        } else {
            cell.textLabel.text = @"详细说明：";
            cell.detailTextLabel.text = self.model.info;
        }
    }
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 3) {
        if (self.model.image_set.count) {
            return ((Window_W - 24) - 24)/4+60;
        }
        return 44;
    } else if (indexPath.section == 0){
        return 44;
    }
    return 44;
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
