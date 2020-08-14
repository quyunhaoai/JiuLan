////
////  CCSelectCatediyViewController.m
////  CunCunTong
////
////  Created by GOOUC on 2020/4/10.
////  Copyright © 2020 GOOUC. All rights reserved.


#import "CCSelectCatediyViewController.h"
#import "YKMultiLevelTableView.h"
#import "YKNodeModel.h"
#import "CCCateBaseMode.h"
@interface CCSelectCatediyViewController ()
@property (nonatomic,strong)  YKMultiLevelTableView *mutableTable;
@property (strong, nonatomic) NSMutableArray *mutableArray;

@end

@implementation CCSelectCatediyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavBarWithTitle:@"请选择商品类别"];
    self.mutableArray = [NSMutableArray array];
    [self setupUI];
    [self initData];
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = @"/app0/keycategory/";
    NSMutableArray *array = [NSMutableArray array];
    [[STHttpResquest sharedManager] requestWithMethod:GET WithPath:path WithParams:params WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            NSArray *data = dic[@"data"];
            for (NSDictionary *dicc in data) {
                YKNodeModel *node = [YKNodeModel nodeWithParentID:checkNull(STRING_FROM_INTAGER([checkNullReplaceZero(dicc[@"parent"]) integerValue]))
                                                             name:dicc[@"name"] childrenID:checkNull(STRING_FROM_INTAGER([dicc[@"id"] integerValue])) level:[checkNullReplaceZero(dicc[@"level"]) integerValue] isExpand:YES];
                [array addObject:node];
            }
            YKNodeModel *node = [YKNodeModel nodeWithParentID:@"0"
                                                         name:@"全部类别"
                                                   childrenID:@"999999" level:3 isExpand:YES];
            [array insertObject:node atIndex:0];
            weakSelf.mutableTable.nodes = array.mutableCopy;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        
    }];
}

- (void)setupUI {
    CGRect rect = self.view.frame;
    CGRect frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, CGRectGetWidth(rect), CGRectGetHeight(rect)-NAVIGATION_BAR_HEIGHT);
    YKMultiLevelTableView *mutableTable = [[YKMultiLevelTableView alloc] initWithFrame:frame
                                                                                     nodes:@[]
                                                                                    rootNodeID:@"0"
                                                                          needPreservation:YES
                                                                               selectBlock:^(YKNodeModel *node) {
                                                                                   NSLog(@"--select node name=%@", node.name);
        if (self.clickCatedity) {
            if (node.level == 1) {
                self.clickCatedity(node.name, node.childrenID, @"", @"");
            }else if (node.level == 2){
                self.clickCatedity(node.name, @"", node.childrenID, @"");
            } else {
                self.clickCatedity(node.name, @"", @"", node.childrenID);
            }
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:mutableTable];
    self.mutableTable = mutableTable;
    mutableTable.name = self.selectName;
}

@end
