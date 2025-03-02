
//
//  CCSelectPinPaViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//
//
//#import "CCSelectPinPaViewController.h"
//
//@interface CCSelectPinPaViewController ()<UITableViewDelegate,UITableViewDataSource>
//
//@end
//
//@implementation CCSelectPinPaViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    [self customNavBarWithTitle:@"请选择品牌"];
//    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
//    }];
//    self.tableView.rowHeight = 41;
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    [self initData];
//}
//
//- (void)initData {
//    self.dataSoureArray = @[@"",@""].mutableCopy;
//}
//#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataSoureArray.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    static NSString *CellIdentifier = @"CellIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if(cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.backgroundColor = [UIColor whiteColor];
//        cell.textLabel.textColor = COLOR_333333;
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"全部品牌"];
//
//
//    return cell;
//}
//
//#pragma mark - Table view delegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 41;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0.0001f;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0.0001f;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return [UIView new];
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    return [UIView new];
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.textLabel.textColor = kMainColor;
//    if (self.clickCatedity) {
//        self.clickCatedity(cell.textLabel.text);
//    }
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//
//@end

//
//  CCSelectPinPaViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSelectPinPaViewController.h"

@interface CCSelectPinPaViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CCSelectPinPaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"请选择品牌"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    self.tableView.rowHeight = 41;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self initData];
}

- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = @"/app0/keybrand/";
    [[STHttpResquest sharedManager] requestWithMethod:GET WithPath:path WithParams:params WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            NSArray *data = dic[@"data"];
            weakSelf.dataSoureArray = data.mutableCopy;
            [weakSelf.dataSoureArray insertObject:@{@"name":@"全部品牌",@"id":@"999999"}
                                          atIndex:0];
            [weakSelf.tableView reloadData];
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
    NSDictionary *dict = self.dataSoureArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",dict[@"name"]];
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
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = kMainColor;
    NSDictionary *dict = self.dataSoureArray[indexPath.row];
    if (self.clickCatedity) {
        self.clickCatedity(cell.textLabel.text,[dict[@"id"] integerValue]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
