
//
//  CCKucunDetailViewController.m
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/12.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCKucunDetailViewController.h"
#import "BaseTableViewCell.h"
#import "CCMyGoodsList.h"
#import "CCMyGoodsListTableViewCell.h"

#import "CCKuCunListTableViewCell.h"
#import "CCKucunInfoTableViewCell.h"

#import "CCKucunDetailFooterView.h"
#import "CCMyGoodsList.h"
#import "BRDatePickerView.h"
#import "CCGongHuoListModel.h"
@interface CCKucunDetailViewController ()<UITableViewDelegate,UITableViewDataSource,SegmentTapViewDelegate>
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) CCKucunDetailFooterView *footView;
@property (nonatomic,strong)  CCMyGoodsList *model;
@property (nonatomic,copy) NSString *begin_time;
@property (nonatomic,copy) NSString *end_time;
@property (strong, nonatomic) NSDictionary * myDic;
@property (assign, nonatomic) NSInteger selectIndex;
@end

@implementation CCKucunDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavBarWithTitle:@"库存详情"];
    self.selectIndex = 0;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    [self.tableView registerNib:CCKuCunListTableViewCell.loadNib
         forCellReuseIdentifier:@"CCKuCunListTableViewCell"];
    [self.tableView registerNib:CCKucunInfoTableViewCell.loadNib
         forCellReuseIdentifier:@"CCKucunInfoTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.footView = [[CCKucunDetailFooterView alloc] initWithFrame:CGRectMake(0, 0, Window_W, Window_H-NAVIGATION_BAR_HEIGHT-44*2-123-30)];

    self.tableView.tableFooterView = self.footView;
    [self initData];
    self.begin_time = @"";
    self.end_time = @"";
    self.footView.dateLab.text =@"开始日期";
    self.footView.dateLab2.text = @"结束日期";
    self.footView.isJinHuo = YES;
    XYWeakSelf;
    [self.footView.dateLab addTapGestureWithBlock:^(UIView *gestureView) {
        [weakSelf timeSelect:gestureView];
    }];
    [self.footView.dateLab2 addTapGestureWithBlock:^(UIView *gestureView) {
        [weakSelf timeSelect:gestureView];
    }];
    self.footView.segment.delegate = self;
    self.footView.stockView.jjStockTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestSupcountListData)];
    self.tableView.scrollEnabled = NO;
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{@"types":@"2"
    };
    NSString *path = [NSString stringWithFormat:@"/app0/skulist/%@/",self.goodsID];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.model = [CCMyGoodsList modelWithJSON:data];
            [weakSelf.tableView reloadData];
            [weakSelf requestSupcountListData];
            weakSelf.myDic = data;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}
- (void)requestSupcountListData {
    XYWeakSelf;
    NSDictionary *params = @{@"limit":@"10",
                             @"offset":@(10*self.page),
                             @"begin_time":self.begin_time,
                             @"end_time":self.end_time,
                             @"center_sku_id":self.goodsID,
    };
    NSString *path =self.selectIndex ? @"/app0/salesanalysislist/": @"/app0/inanalysislist/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            NSDictionary *ddd = dic[@"data"];
            NSArray *data = ddd[@"results"];
            NSString *next = ddd[@"next"];
            for (NSDictionary *dict in data) {
                CCGongHuoListModel *model = [CCGongHuoListModel modelWithJSON:dict];
                [weakSelf.dataSoureArray addObject:model];
            }
            weakSelf.footView.dataArray = weakSelf.dataSoureArray.copy;
            [weakSelf.footView.stockView.jjStockTableView.mj_footer endRefreshing];
            if ([next isKindOfClass:[NSNull class]] || next == nil) {
                [weakSelf.footView.stockView.jjStockTableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [weakSelf.footView.stockView.jjStockTableView.mj_footer resetNoMoreData];
            }
            [weakSelf.tableView reloadData];
            [weakSelf requestSumdata];
            weakSelf.page++;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}
- (void)requestSumdata {
    XYWeakSelf;
    NSDictionary *params = @{
        @"center_sku_id":self.goodsID,
        @"begin_time":self.begin_time,
        @"end_time":self.end_time,
    };
    NSString *path =self.selectIndex ? @"/app0/salesanalysiscount/" : @"/app0/inanalysiscount/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.footView.sumDict = data;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}
- (void)timeSelect:(UIView *)button {

    NSString *str = [NSString getCurrentTime:@"YYYY-MM-dd"];
    XYWeakSelf;
    [BRDatePickerView showDatePickerWithTitle:@"请选择"
                                     dateType:BRDatePickerModeYMD
                              defaultSelValue:str resultBlock:^(NSString *selectValue) {
        if (button.tag == 11) {
            weakSelf.footView.dateLab.text = selectValue;
            weakSelf.begin_time = selectValue;
        } else {
            weakSelf.footView.dateLab2.text = selectValue;
            weakSelf.end_time = selectValue;
        }
        weakSelf.page = 0;
        [weakSelf.dataSoureArray removeAllObjects];
        [weakSelf requestSupcountListData];
    }];
    
}
- (void)selectedIndex:(NSInteger)index {
    NSLog(@"%ld",(long )index);
    self.selectIndex = index;
    if (index) {
        self.footView.titleArr = @[@"零售价",@"销量",@"销售金额",@"利润"];
        self.footView.isJinHuo = NO;
    } else {
        self.footView.titleArr = @[@"进货价",@"进货数",@"进货金额"];
        self.footView.isJinHuo = YES;
    }
    self.page = 0;
    [self.dataSoureArray removeAllObjects];
    [self requestSupcountListData];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CCKuCunListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCKuCunListTableViewCell"];
    if (self.model) {
        cell.warnModel = self.model;
    }
    NSArray *arr = self.myDic[@"specoption_set"];
    if (arr.count) {
           //500-ml
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"规格：%@",arr[0]]];
           [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
           [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];

           //500-ml text-style1
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(3, [NSString stringWithFormat:@"%@",arr[0]].length)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(3, [NSString stringWithFormat:@"%@",arr[0]].length)];
           cell.gugeLab.attributedText = attributedString2;
    }
    return cell;
    } else {
        CCKucunInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCKucunInfoTableViewCell"];
        if (indexPath.row == 0) {
            cell.titlelab.text = [NSString stringWithFormat:@"当前库存"];
            cell.detailLab.text = [NSString stringWithFormat:@"%ld%@",self.model.count,self.model.play_unit];
        } else {
            cell.titlelab.text = [NSString stringWithFormat:@"库存金额"];
            cell.detailLab.text = [NSString stringWithFormat:@"%ld元",self.model.count_price];
        }
        return cell;
    }
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 44;
    }
    return 123;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self tableViewDidSelect:indexPath];
}

//去除section黏性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
       CGFloat sectionHeaderHeight = 33;
       if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
          scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
       } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
          scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
       }
    }
}

@end
