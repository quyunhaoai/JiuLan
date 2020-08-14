//
//  CCAboutListViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCAboutListViewController.h"
#import "CCAboutHeadView.h"
#import "CCAboutViewController.h"
#import "CCUpdateTipModel.h"
@interface CCAboutListViewController ()
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) CCUpdateTipModel *model; //
@property (nonatomic,copy) NSString *upDataStr;  //
@end

@implementation CCAboutListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.upDataStr = @"当前已是最新版本";
    [self customNavBarWithTitle:@"关于村村仓"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    CCAboutHeadView *head = [[CCAboutHeadView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 210)];
    self.tableView.tableHeaderView = head;
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
    [self initData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.array[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 1) {
        cell.detailTextLabel.text = self.upDataStr;
    }
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 53;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        CCAboutViewController *vc = [[CCAboutViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        if ([self.upDataStr isEqualToString:@"更新版本"]) {
            NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@",AppID];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        }
    }
}
- (NSArray *)array {
    if (!_array) {
        _array = @[@"功能介绍",
                   @"版本更新",
                   @"软件许可及服务协议",
                   @"隐私保护协议",
        ];
    }
    return _array;
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path = @"/app/iosset/?point=0";
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    // 网络请求获取最新版本
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.model = [CCUpdateTipModel modelWithJSON:data];
            //把版本号转换成数值
            NSArray * array1 = [currentVersion componentsSeparatedByString:@"."];
            NSInteger currentVersionInt = 0;
            if (array1.count == 3)//默认版本号1.0.0类型
            {
                currentVersionInt = [array1[0] integerValue]*100 + [array1[1] integerValue]*10 + [array1[2] integerValue];
            }
            NSArray * array2 = [weakSelf.model.versionStr componentsSeparatedByString:@"."];
            NSInteger lineVersionInt = 0;
            if (array2.count == 3)
            {
                lineVersionInt = [array2[0] integerValue]*100 + [array2[1] integerValue]*10 + [array2[2] integerValue];
            }
            if (lineVersionInt > currentVersionInt)//线上版本大于本地版本
            {
                self.upDataStr = @"更新版本";
                [self.tableView reloadData];
            } else {
                
            }
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}
- (void)showUpdateTip {
    NSString *AppID = @"";
    SPAlertController *alert = [SPAlertController alertControllerWithTitle:[NSString stringWithFormat:@"发现新版本%@",self.model.versionStr] message:self.model.updateContent preferredStyle:SPAlertControllerStyleAlert];

    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"去更新" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
         //跳转到App Store
        NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@",AppID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }];
    SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"取消" style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController: alert animated:YES completion:^{}];
}
@end
