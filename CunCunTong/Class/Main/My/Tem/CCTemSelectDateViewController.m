
//
//  CCTemSelectDateViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCTemSelectDateViewController.h"
#import "CCTimeSelectModel.h"
@interface CCTemSelectDateViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CCTemSelectDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"选择日期"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    self.tableView.rowHeight = 41;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self initData];
    self.baseTableView = self.tableView;
}

- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path = [NSString stringWithFormat:@"/app0/nearactionskulist/%@/",self.sku_id];
    [[STHttpResquest sharedManager] requestWithPUTMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *array = dic[@"data"];
                if (weakSelf.page) {
                    [weakSelf.dataSoureArray addObjectsFromArray:array];
                } else {
                    weakSelf.dataSoureArray = array.mutableCopy;
                    if (weakSelf.dataSoureArray.count) {
                        weakSelf.showTableBlankView = NO;
                    } else {
                        weakSelf.showTableBlankView = YES;
                    }
                }
                [weakSelf.tableView reloadData];
            });
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = COLOR_333333;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CCTimeSelectModel *model =[CCTimeSelectModel modelWithJSON:self.dataSoureArray[indexPath.row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",model.product_date];
    if ([self.selename isEqualToString:cell.textLabel.text]) {
        cell.textLabel.textColor = kMainColor;
    }
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 41;
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
    CCTimeSelectModel *model =[CCTimeSelectModel modelWithJSON:self.dataSoureArray[indexPath.row]];
    if (self.clickCatedity) {
        self.clickCatedity(model.product_date,model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
