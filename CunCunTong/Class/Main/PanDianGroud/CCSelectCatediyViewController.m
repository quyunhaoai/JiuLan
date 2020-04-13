//
//  CCSelectCatediyViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSelectCatediyViewController.h"
#import "YKMultiLevelTableView.h"
#import "YKNodeModel.h"
@interface CCSelectCatediyViewController ()

@end

@implementation CCSelectCatediyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"请选择商品类别"];
    
    CGRect rect = self.view.frame;
    CGRect frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, CGRectGetWidth(rect), CGRectGetHeight(rect)-NAVIGATION_BAR_HEIGHT);
    YKMultiLevelTableView *mutableTable = [[YKMultiLevelTableView alloc] initWithFrame:frame
                                                                                     nodes:[self returnData]
                                                                                    rootNodeID:@""
                                                                          needPreservation:YES
                                                                               selectBlock:^(YKNodeModel *node) {
                                                                                   NSLog(@"--select node name=%@", node.name);
        if (self.clickCatedity) {
            self.clickCatedity(node.name);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:mutableTable];

}

- (NSArray*)returnData{
    NSArray *list = @[@{@"parentID":@"", @"name":@"全部类别 ", @"ID":@"1"},
                      @{@"parentID":@"1", @"name":@"食品", @"ID":@"10"},
                      @{@"parentID":@"1", @"name":@"洗护", @"ID":@"11"},
                      @{@"parentID":@"10", @"name":@"零食", @"ID":@"100"},
                      @{@"parentID":@"100", @"name":@"坚果", @"ID":@"101"},
                      @{@"parentID":@"100", @"name":@"豆干", @"ID":@"102"},
                      @{@"parentID":@"11", @"name":@"家用清洁", @"ID":@"110"},
                      @{@"parentID":@"110", @"name":@"拖把", @"ID":@"111"}];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in list) {
        YKNodeModel *node  = [YKNodeModel nodeWithParentID:dic[@"parentID"]
                                                      name:dic[@"name"]
                                                childrenID:dic[@"ID"]
                                                  isExpand:NO];
        [array addObject:node];
    }
    
    return [array copy];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
