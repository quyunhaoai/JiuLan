
//
//  CCActiveDivViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCActiveDivViewController.h"
#import "CCActiveDivHeadView.h"
#import "CCEverDayTeTableViewCell.h"
#import "CCEverDayTe.h"
#import "BottomAlert2Contentview.h"
#import "CCGoodsDetail.h"
#import "CCOrderSearchViewController.h"
#import "CCCommodDetaildViewController.h"
#import "SegmentTapView.h"
#import "CCYouHuiQuan.h"
#import "CCYouHuiQuanTableViewCell.h"
#import "XYMallClassifyViewcController.h"
@interface CCActiveDivViewController ()<UITableViewDelegate,UITableViewDataSource,KKCommonDelegate,SegmentTapViewDelegate>
@property (strong, nonatomic) CCActiveDivHeadView *headView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) SegmentTapView *segment; //
@property (strong, nonatomic) NSArray *titleArray;
@property (assign, nonatomic) NSInteger listType;    //
@end

@implementation CCActiveDivViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [rightBtn setImage:IMAGE_NAME(@"搜索图标白") forState:UIControlStateNormal];
    [rightBtn setImage:IMAGE_NAME(@"搜索图标白") forState:UIControlStateHighlighted];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitlePadding:15];
    [rightBtn sizeToFit];
    [self customNavBarWithtitle:@"活动专区" andLeftView:@"" andRightView:@[rightBtn]];
    self.navTitleView.backgroundColor = [UIColor colorWithPatternImage:IMAGE_NAME(@"矩形1")];
    [self.tableView registerNib:CCEverDayTeTableViewCell.loadNib
         forCellReuseIdentifier:@"CCEverDayTe"];
    self.baseTableView = self.tableView;
    self.tableView.delegate=self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColorHex(0xf7f7f7);
    [self setupUI];
    self.listType = 0;
    [self initData];
    [self addTableViewRefresh];
    [kNotificationCenter addObserver:self selector:@selector(initData) name:@"refreshYouHuiQuan" object:nil];
}

- (void)initData {
    if (self.listType == 0) {
        [self initData2];
    } else if(self.listType == 2){
        [self getCuXiaoData];
    } else {
        [self initData1];
    }
}

- (void)setupUI {
    [self initSegment];
}

-(void)initSegment{
    self.titleArray = @[@"优惠券专区",@"抢购专区",@"促销专区"];
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0,
                                                                    NAVIGATION_BAR_HEIGHT +0,
                                                                    Window_W,
                                                                    44)
                                           withDataArray:self.titleArray
                                                withFont:15 wihtLineWidth:30];
    self.segment.backgroundColor = [UIColor colorWithPatternImage:IMAGE_NAME(@"矩形1")];
    self.segment.delegate = self;
    self.segment.textSelectedColor = kWhiteColor;
    self.segment.textNomalColor = kWhiteColor;
    self.segment.lineColor = kWhiteColor;
    self.segment.lineHeight = 2;
    [self.view addSubview:self.segment];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT+ 44);
    }];
}
- (void)selectedIndex:(NSInteger)index {
    self.listType = index;
    self.page = 0;
    [self.dataSoureArray removeAllObjects];
    [self.dataArray removeAllObjects];
    if (index == 0) {
        [self initData2];
    } else if(index == 2){
        [self getCuXiaoData];
    } else {
        [self initData1];
    }
}
- (void)initData1 {
    XYWeakSelf;
    [self.dataSoureArray removeAllObjects];
    NSString *path = @"/app0/centergoodspromotelist/";
    NSDictionary *params = @{@"limit":@(10),
                             @"offset":@(self.page*10),
    };
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            NSString *next = data[@"next"];
            NSArray *array = data[@"results"];
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
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            if ([next isKindOfClass:[NSNull class]] || next == nil) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [weakSelf.tableView.mj_footer resetNoMoreData];
            }
            [weakSelf.tableView reloadData];
            weakSelf.page++;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}
- (void)getCuXiaoData {
    NSString *path = @"/app0/centergoodsreducelist/";
    XYWeakSelf;
    NSDictionary *params = @{@"limit":@(10),
                             @"offset":@(self.page*10),
    };
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            NSString *next = data[@"next"];
            NSArray *array = data[@"results"];
            if (weakSelf.page) {
                [weakSelf.dataArray addObjectsFromArray:array];
            } else {
                weakSelf.dataArray = array.mutableCopy;
                if (weakSelf.dataArray.count) {
                    weakSelf.showTableBlankView = NO;
                } else {
                    weakSelf.showTableBlankView = YES;
                }
            }
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            if ([next isKindOfClass:[NSNull class]] || next == nil) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [weakSelf.tableView.mj_footer resetNoMoreData];
            }
            [weakSelf.tableView reloadData];
            weakSelf.page++;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}
- (void)initData2 {
    XYWeakSelf;
    [self.dataSoureArray removeAllObjects];
    NSDictionary *params = @{};
    NSString *path = @"/app0/coupon/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSArray *data = dic[@"data"];
            if (data.count) {
                for (NSDictionary *dict in data) {
                    CCYouHuiQuan *model = [CCYouHuiQuan modelWithJSON:dict];
                    [weakSelf.dataSoureArray addObject:model];
                }
                weakSelf.showTableBlankView = NO;
            } else {
                weakSelf.showTableBlankView = YES;
            }
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView reloadData];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}
- (void)rightBtn:(UIButton *)button {
    CCOrderSearchViewController *vc = [CCOrderSearchViewController new];
    vc.searchStr = @"请输入商品名称";
    [self.navigationController pushViewController:vc animated:YES];
}
- (CCActiveDivHeadView *)headView {
    if (!_headView) {
        _headView = [[CCActiveDivHeadView alloc] init];
    }
    return _headView;
}
#pragma mark  -  kkcommonDelegate
- (void)jumpBtnClicked:(id)item {
    XYMallClassifyViewcController *vc = [XYMallClassifyViewcController new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.listType == 2) {
        return self.dataArray.count;
    } else if(self.listType == 0){
        return self.dataSoureArray.count;
    } else {
        return self.dataSoureArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listType == 0) {
        CCYouHuiQuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCYouHuiQuan"];
        cell.isActive = YES;
        cell.modelccc = self.dataSoureArray[indexPath.row];
        [cell setDelegate:self];
        return cell;
    } else {
        CCEverDayTeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCEverDayTe"];
        cell.backgroundColor = kWhiteColor;
        if (self.listType ==2) {
              cell.model = [CCGoodsDetail modelWithJSON:self.dataArray[indexPath.row]];
        } else {
              cell.model = [CCGoodsDetail modelWithJSON:self.dataSoureArray[indexPath.row]];
        }
        cell.delegate = self;
        return cell;
    }
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listType == 1 || self.listType == 2) {
        return 130;
    }
    return 137;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self tableViewDidSelect:indexPath];
    CCGoodsDetail *model;
    if (self.listType==2) {
        model = [CCGoodsDetail modelWithJSON:self.dataSoureArray[indexPath.row]];
        CCCommodDetaildViewController *vc = [CCCommodDetaildViewController new];
        vc.goodsID = STRING_FROM_INTAGER(model.ccid);
        [self.navigationController pushViewController:vc animated:YES];
    } else if(self.listType==1){
        model = [CCGoodsDetail modelWithJSON:self.dataArray[indexPath.row]];
        CCCommodDetaildViewController *vc = [CCCommodDetaildViewController new];
        vc.goodsID = STRING_FROM_INTAGER(model.ccid);
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 圆角弧度半径
    CGFloat cornerRadius = 6.f;
    // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
    cell.backgroundColor = UIColor.clearColor;
    
    // 创建一个shapeLayer
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
    // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
    CGMutablePathRef pathRef = CGPathCreateMutable();
    // 获取cell的size
    // 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
    CGRect bounds = CGRectInset(cell.bounds, 10, 0);
    
    // CGRectGetMinY：返回对象顶点坐标
    // CGRectGetMaxY：返回对象底点坐标
    // CGRectGetMinX：返回对象左边缘坐标
    // CGRectGetMaxX：返回对象右边缘坐标
    // CGRectGetMidX: 返回对象中心点的X坐标
    // CGRectGetMidY: 返回对象中心点的Y坐标
    
    // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行
    
    // CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
    if (indexPath.row == 0) {
        // 初始起点为cell的左下角坐标
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
        // 起始坐标为左下角，设为p，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
        
    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        // 初始起点为cell的左上角坐标
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        // 添加一条直线，终点坐标为右下角坐标点并放到路径中去
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
    } else {
        // 添加cell的rectangle信息到path中（不包括圆角）
        CGPathAddRect(pathRef, nil, bounds);
    }
    // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
    layer.path = pathRef;
    backgroundLayer.path = pathRef;
    // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
    CFRelease(pathRef);
    // 按照shape layer的path填充颜色，类似于渲染render
    // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    
    // view大小与cell一致
    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
    // 添加自定义圆角后的图层到roundView中
    [roundView.layer insertSublayer:layer atIndex:0];
    roundView.backgroundColor = UIColor.clearColor;
    // cell的背景view
    cell.backgroundView = roundView;
    
    // 以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
    // 如果你 cell 已经取消选中状态的话,那以下方法是不需要的.
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
    backgroundLayer.fillColor = [UIColor cyanColor].CGColor;
    [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
    selectedBackgroundView.backgroundColor = UIColor.clearColor;
    cell.selectedBackgroundView = selectedBackgroundView;
    
}

- (void)clickButtonWithType:(KKBarButtonType)type item:(id)item {
    CCGoodsDetail *model = (CCGoodsDetail *)item;
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = [NSString stringWithFormat:@"/app0/goodsdetail/%ld/",model.ccid];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            CCGoodsDetailInfoModel *goodsDetailModel = [CCGoodsDetailInfoModel modelWithJSON:data];
            NKAlertView *alertView = [[NKAlertView alloc] init];
            BottomAlert2Contentview *customContentView = [[BottomAlert2Contentview alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 554)];
            customContentView.model = goodsDetailModel;
            alertView.type = NKAlertViewTypeBottom;
            alertView.contentView = customContentView;
            alertView.hiddenWhenTapBG = YES;
            [alertView show];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)dealloc {
    [kNotificationCenter removeObserver:self name:@"refreshYouHuiQuan" object:nil];
}
@end
