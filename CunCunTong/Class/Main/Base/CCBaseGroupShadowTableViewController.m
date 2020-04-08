//
//  CCBaseGroupShadowTableViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//
//static NSString *CellIdentifier3333 = @"CellIdentifier3333";
#import "CCBaseGroupShadowTableViewController.h"
#import "BaseTableViewCell.h"
@interface CCBaseGroupShadowTableViewController ()<GroupShadowTableViewDelegate,GroupShadowTableViewDataSource>

@end

@implementation CCBaseGroupShadowTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[GroupShadowTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    self.tableView.groupShadowDelegate = self;
    self.tableView.groupShadowDataSource = self;
    self.tableView.showSeparator = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }

    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(self.view);
    }];
    [self.tableView registerNib:BaseTableViewCell.loadNib forCellReuseIdentifier:@"TextModel"];

}

#pragma mark delegate datasource
- (NSInteger)numberOfSectionsInGroupShadowTableView:(GroupShadowTableView *)tableView {
    return 1;
}

- (NSInteger)groupShadowTableView:(GroupShadowTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArray.count;
}

- (UITableViewCell *)groupShadowTableView:(GroupShadowTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self.dataSoureArray[indexPath.row] className]];
    return cell;
}

- (CGFloat)groupShadowTableView:(GroupShadowTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *modelName = NSStringFromClass([self.dataSoureArray[indexPath.row] class]);
    Class CellClass = NSClassFromString([modelName stringByAppendingString:@"TableViewCell"]);
    if ([modelName isEqualToString:@"TextModel"]) {
        CellClass = NSClassFromString(@"TextModelCell");
    }
    return [CellClass height];
}

- (void)groupShadowTableView:(GroupShadowTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
- (NSMutableArray *)dataSoureArray {
    if (!_dataSoureArray) {
        _dataSoureArray = [[NSMutableArray alloc] init];
    }
    return _dataSoureArray;
}


@end
