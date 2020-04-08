//
//  CCDaySalesViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCDaySalesViewController.h"
#import "CCDaySales.h"
#import "CCNewAddBuyGoodsViewController.h"
#import "GHDropMenu.h"
#import "GHDropMenuModel.h"
@interface CCDaySalesViewController ()<GHDropMenuDelegate,GHDropMenuDataSource>
@property (nonatomic , strong)GHDropMenu *dropMenu;
@end

@implementation CCDaySalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initData];
    
}
- (void)initData {
    self.dataSoureArray = @[[CCDaySales new]].mutableCopy;
}
-(void)setupUI {
    self.view.backgroundColor = kWhiteColor;
    UIButton *rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [btn setImage:IMAGE_NAME(@"新建加号图标") forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES ;
        [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
        btn ;
    });
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [self customNavBarWithtitle:@"日销售录入" andLeftView:@"" andRightView:@[rightBtn]];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT + 44);
    }];
    
    [self style1];
    
}
- (void)rightBtAction:(UIButton *)btn {
    CCNewAddBuyGoodsViewController *vc = [CCNewAddBuyGoodsViewController new];
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
    GHDropMenu *dropMenu = [GHDropMenu creatDropMenuWithConfiguration:nil frame:CGRectMake(0, NAVIGATION_BAR_HEIGHT,kGHScreenWidth, 44) dropMenuTitleBlock:^(GHDropMenuModel * _Nonnull dropMenuModel) {
        NSLog(@"--%@--",dropMenuModel.title);
    } dropMenuTagArrayBlock:^(NSArray * _Nonnull tagArray) {
        [weakSelf getStrWith:tagArray];
    }];
    dropMenu.durationTime = 0.5;
    dropMenu.delegate = self;
    dropMenu.dataSource = self;
    dropMenu.titleSeletedImageName = @"上箭头";
    dropMenu.titleNormalImageName = @"下箭头";
    self.dropMenu = dropMenu;
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
//    self.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@",string];
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
