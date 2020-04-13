//
//  CCPanDianViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCPanDianViewController.h"
#import "CCSelectTimeView.h"
#import "UISegmentedControl+CCStyle_OC.h"
#import "GHDropMenu.h"
#import "GHDropMenuModel.h"
#import "CCDaySales.h"
#import "CCNewAddPanDianViewController.h"
#import "CCPanDianDetailViewController.h"
@interface CCPanDianViewController ()<GHDropMenuDelegate,GHDropMenuDataSource>

@end

@implementation CCPanDianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [rightBtn setImage:IMAGE_NAME(@"新建加号图标") forState:UIControlStateNormal];
    [rightBtn setImage:IMAGE_NAME(@"新建加号图标") forState:UIControlStateHighlighted];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitlePadding:15];
    [rightBtn sizeToFit];
    [self customNavBarWithtitle:@"盘点" andLeftView:@"" andRightView:@[rightBtn]];
    [(UIButton *)self.navTitleView.leftBtns[0] setHidden:YES];
    [self addSegmentedView];
    [self.tableView masUpdateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(96+NAVIGATION_BAR_HEIGHT);
    }];
    
}

- (void)rightBtn:(UIButton *)btn {
    CCNewAddPanDianViewController *vc = [CCNewAddPanDianViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addSegmentedView {
    //创建segmentControl 分段控件
    UISegmentedControl *segC = [[UISegmentedControl alloc]initWithFrame:CGRectZero];
    //添加小按钮
    [segC insertSegmentWithTitle:@"周盘" atIndex:0 animated:NO];
    [segC insertSegmentWithTitle:@"月盘" atIndex:1 animated:NO];
    //设置样式
    [segC setTintColor:krgb(36,149,143)];
    segC.layer.masksToBounds = YES;
    segC.layer.cornerRadius = 16;
    segC.layer.borderWidth = 1.0;
    segC.layer.borderColor = kMainColor.CGColor;
    //添加事件
    [segC addTarget:self action:@selector(segCChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segC];
    [segC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).mas_offset(0);
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT + 10);
        make.width.mas_equalTo(182);
        make.height.mas_equalTo(32);
    }];
    segC.selectedSegmentIndex = 0;
    [segC ensureiOS12Style];
    [self style1];
    [self initData];
}

- (void)initData {
    self.dataSoureArray = @[[CCDaySales new]].mutableCopy;
}

-(void)segCChanged:(UISegmentedControl *)seg{
    NSInteger i = seg.selectedSegmentIndex;
    NSLog(@"切换了状态 %lu",i);
}
- (void)tableViewDidSelect:(NSIndexPath *)indexPath {
    CCPanDianDetailViewController *vc = [CCPanDianDetailViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 样式1
- (void)style1 {
      /** 配置筛选菜单模型 */
    GHDropMenuModel *configuration = [[GHDropMenuModel alloc]init];
      /** 配置筛选菜单是否记录用户选中 默认NO */
    configuration.recordSeleted = NO;
      /** 设置数据源 */
    configuration.titles = [configuration creaDropMenuData];
    weakself(self);
    GHDropMenu *dropMenu = [GHDropMenu creatDropMenuWithConfiguration:nil frame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+42+10,kGHScreenWidth, 44) dropMenuTitleBlock:^(GHDropMenuModel * _Nonnull dropMenuModel) {
        NSLog(@"--%@--",dropMenuModel.title);
    } dropMenuTagArrayBlock:^(NSArray * _Nonnull tagArray) {
        [weakSelf getStrWith:tagArray];
    }];
    dropMenu.durationTime = 0.5;
    dropMenu.delegate = self;
    dropMenu.dataSource = self;
    dropMenu.titleSeletedImageName = @"上箭头";
    dropMenu.titleNormalImageName = @"下箭头";
    dropMenu.titleNormalColor = COLOR_333333;
    [self.view addSubview:dropMenu];
}


#pragma mark - 代理回调
- (void)dropMenu:(GHDropMenu *)dropMenu dropMenuTitleModel:(GHDropMenuModel *)dropMenuTitleModel {
}
- (void)dropMenu:(GHDropMenu *)dropMenu tagArray:(NSArray *)tagArray {
    [self getStrWith:tagArray];
}

- (void)getStrWith: (NSArray *)tagArray {
    NSMutableString *string = [NSMutableString string];
    if (tagArray.count) {
        for (GHDropMenuModel *dropMenuTagModel in tagArray) {
            if (dropMenuTagModel.tagSeleted) {
                if (dropMenuTagModel.tagName.length) {
                    [string appendFormat:@"%@",dropMenuTagModel.tagName];
                }
            }
            if (dropMenuTagModel.maxPrice.length) {
                [string appendFormat:@"最大价格%@",dropMenuTagModel.maxPrice];
            }
            if (dropMenuTagModel.minPrice.length) {
                [string appendFormat:@"最小价格%@",dropMenuTagModel.minPrice];
            }
        }
    }
    NSLog(@"%@",string);
}

- (NSArray *)columnTitlesInMeun:(GHDropMenu *)menu {
    return @[@"全部状态",@"条件筛选"];
}
- (NSArray *)menu:(GHDropMenu *)menu numberOfColumns:(NSInteger)columns {
    if (columns == 0) {
        return @[@"价格从高到低",@"价格从低到高",@"距离从远到近",@"销量从低到高",@"信用从高到低"];
    } else if (columns == 1){
        return @[@"0 - 10 元",@"10-20 元",@"20-50 元",@"50-100 元",@"100 - 1000元",@"1000 - 10000 元",@"10000-100000 元",@"100000-500000 元",@"500000-1000000 元",@"1000000以上"];
    } else if (columns== 2){
        return @[@"psp",@"psv",@"nswitch",@"gba",@"gbc",@"gbp",@"ndsl",@"3ds"];
    } else {
        return @[@"上午",@"下午",@"早上",@"晚上",@"清晨",@"黄昏"];
    }
}

@end
