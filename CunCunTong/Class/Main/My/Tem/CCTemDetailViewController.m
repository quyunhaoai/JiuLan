

//
//  CCTemDetailViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/29.
//  Copyright © 2020 GOOUC. All rights reserved.
//


#import "CCTemDetailViewController.h"
#import "CCNeedListModel.h"
#import "PYPhotosView.h"
#import "CCTemDetailMdoel.h"
@interface CCTemDetailViewController ()
@property (nonatomic,strong) CCTemDetailMdoel *model; //
@end

@implementation CCTemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavBarWithTitle:@"临期优惠申请详情"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self initData];
    [kNotificationCenter addObserver:self selector:@selector(initData) name:@"initData" object:nil];
}
- (void)dealloc {
    [kNotificationCenter removeObserver:self name:@"initData" object:nil];
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path =[NSString stringWithFormat:@"/app0/nearaction/%@/",self.needID];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        NSDictionary *data = dic[@"data"];
        if(status == 0){
            weakSelf.model = [CCTemDetailMdoel modelWithJSON:data];
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 3) {
        return 4;
    }
    return 1;
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
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:@"差额："];
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:15.0f] range:NSMakeRange(0, 3)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];
        //189-00
        NSString *price = [NSString stringWithFormat:@"￥%ld",self.model.total_diff_price];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.395f] range:NSMakeRange(0, price.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:253.0f/255.0f green:103.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, price.length)];
        [attributedString2 appendAttributedString:attributedString];
        cell.textLabel.attributedText = attributedString2;
    } else if(indexPath.section == 2){
            UILabel *nameLab = ({
                UILabel *view = [UILabel new];
                view.textColor =COLOR_333333;
                view.font = STFont(15);
                view.lineBreakMode = NSLineBreakByTruncatingTail;
                view.backgroundColor = [UIColor clearColor];
                view.textAlignment = NSTextAlignmentLeft;
                view.numberOfLines = 0;
                view.text = @"凭证";
                view ;
            });
            [cell.contentView addSubview:nameLab];
            [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.contentView).mas_offset(15);
                make.size.mas_equalTo(CGSizeMake(Window_W-20, 14));
                make.top.mas_equalTo(cell.contentView).mas_offset(10);
            }];

            // 1. 常见一个发布图片时的photosView
            PYPhotosView *publishPhotosView = [PYPhotosView photosView];
//            publishPhotosView.photosMaxCol = 4;
            publishPhotosView.x = 15;
            publishPhotosView.y = 35;
            publishPhotosView.width = Window_W -24;
            publishPhotosView.photoWidth = ((Window_W - 24) - 24)/4;
            publishPhotosView.photoHeight = ((Window_W - 24) - 24)/4;
//            publishPhotosView.photoMargin = 8;
//            publishPhotosView.delegate = self;
//            publishPhotosView.addImageButtonImage = IMAGE_NAME(@"照片");
        publishPhotosView.thumbnailUrls = self.model.image_set;
            [cell.contentView addSubview:publishPhotosView];

    }else if(indexPath.section == 0){
        if (indexPath.row == 1){
            cell.textLabel.text = @"申请数量";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld%@",self.model.count,self.model.play_unit];
        } else if (indexPath.row == 0){
            cell.textLabel.text = @"申请商品：";
            cell.detailTextLabel.text = self.model.goods_name;
        } else if(indexPath.row == 2){
            cell.textLabel.text = @"商品生产日期";
            cell.detailTextLabel.text = self.model.product_date;
        } else if(indexPath.row == 3){
            cell.textLabel.text = @"商品临期活动价：";
            if (self.model.action_price) {
                cell.textLabel.text =[NSString stringWithFormat:@"商品临期活动价：￥%ld",self.model.action_price];
            }
        }
    } else {
        if (indexPath.row == 1){
            cell.textLabel.text = @"审核状态";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.model.status_str];
        } else if (indexPath.row == 0){
            cell.textLabel.text = @"申请日期";
            cell.detailTextLabel.text = self.model.create_time;
        } else if(indexPath.row == 2){
            cell.textLabel.text = @"审核日期";
            cell.detailTextLabel.text = self.model.check_time;
        } else if(indexPath.row == 3){
            cell.textLabel.text = @"审核意见";
            cell.detailTextLabel.text =[NSString stringWithFormat:@"%@",self.model.reason];
        }
    }
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return ((Window_W - 24) - 24)/4+60;
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
