//
//  CCCommodDetaildViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/17.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCCommodDetaildViewController.h"
#import "SDCycleScrollView.h"
#import "AJ_TopBar.h"
#import "CCGoodsDetail.h"
#import "CCGoodsDetailTableViewCell.h"
#import "CCGoodsHeadView.h"
#import "BottomAlertContentView.h"
#import "BottomAlert2Contentview.h"
#import "CCShopBottomView.h"
#import "CCShopCarView.h"
#import "CCServiceMassageView.h"
#import "CCBottomShareAlertContentView.h"
#import "CCSharePicView.h"
#import "CCSureOrderViewController.h"
#import "CCGoodsDetailHeadTableViewCell.h"
#import "CCYouHuiQuanViewController.h"

#import "CCGoodsDetailInfoModel.h"
@interface CCCommodDetaildViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CGRect HeaderFrame;
}
@property (strong, nonatomic) UIScrollView *scrollView;

//@property (strong, nonatomic) NSMutableArray         *dataSoureArray;
@property (nonatomic,strong) UITableView             *tableView;
@property (nonatomic, strong) AJ_TopBar              *topBar;//  顶部筛选组件
@property (strong, nonatomic) SDCycleScrollView      *cycleScrollView;

@property (strong, nonatomic) CCShopBottomView       *bottomView;
@property (assign, nonatomic) BOOL                   isOpen;
@property (strong, nonatomic) CCServiceMassageView   *massageView;
@property (strong, nonatomic) CCGoodsHeadView        *headView;
@property (strong, nonatomic) NSArray                *titleArray;

@property (nonatomic,strong) UICollectionView    *collectionView;
// 监测范围的临界点,>0代表向上滑动多少距离,<0则是向下滑动多少距离
@property (nonatomic, assign)CGFloat threshold;
// 记录scrollView.contentInset.top
@property (nonatomic, assign)CGFloat marginTop;
@property (nonatomic,strong) CCGoodsDetailInfoModel *goodsDetailModel;
@property (strong, nonatomic) UILabel *salesLab;

@end

@implementation CCCommodDetaildViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    HeaderFrame = [self.tableView rectForHeaderInSection:2];
    self.marginTop = self.view.size.height-NAVIGATION_BAR_HEIGHT-48-20;
    NSLog(@"--%f",HeaderFrame.origin.y);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat newoffsetY = offsetY + self.marginTop;
    NSLog(@"newoffsetY:%f,offsetY%f",newoffsetY,offsetY);

    if (newoffsetY >= HeaderFrame.origin.y) {
        NSLog(@"-----============----------商品详情");
        [self.topBar setCurrentPage:1];
    }else if (newoffsetY < HeaderFrame.origin.y){
        NSLog(@"信息");
        [self.topBar setCurrentPage:0];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initData];
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = @"/app0/goodsdetail/10/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.goodsDetailModel = [CCGoodsDetailInfoModel modelWithJSON:data];
            weakSelf.salesLab.text = [NSString stringWithFormat:@"销量：%ld",(long)weakSelf.goodsDetailModel.sales];
            weakSelf.cycleScrollView.imageURLStringsGroup = weakSelf.goodsDetailModel.goodsimage_set;
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
- (void)setupUI {
    UIButton *rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [btn setImage:IMAGE_NAME(@"分享按钮") forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES ;
        [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
        btn ;
    });
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [self customNavBarWithtitle:@"" andLeftView:@"" andRightView:@[rightBtn]];
    self.navTitleView.titleLabel.hidden = YES;
    self.navTitleView.splitView.backgroundColor = self.navTitleView.backgroundColor;
    [self.navTitleView addSubview:self.topBar];
    [self.topBar setCurrentPage:0];
    [self.tableView setTableHeaderView:self.cycleScrollView];
    //258 203
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }

    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
    self.tableView.backgroundColor = COLOR_f5f5f5;
    self.tableView.estimatedRowHeight = 97;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.tableView registerNib:CCGoodsDetailTableViewCell.loadNib
         forCellReuseIdentifier:@"CCGoodsDetail"];
    [self.tableView registerClass:CCGoodsDetailHeadTableViewCell.class
           forCellReuseIdentifier:@"CCGoodsDetailHeadTableViewCell"];
    self.bottomView.frame = CGRectMake(0, 0, Window_W, 60);
    [self.tableView setTableFooterView:self.bottomView];
    self.isOpen = NO;
    XYWeakSelf;
    _bottomView.clickCallBack = ^(NSInteger tag) {
        if (tag ==2) {
            if (!weakSelf.bottomView.isOpen) {
                CCShopCarView *customContentView = [[CCShopCarView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 554)];
                weakSelf.bottomView.contentView = customContentView;
                weakSelf.bottomView.hiddenWhenTapBG = YES;
                [weakSelf.bottomView show];
                weakSelf.bottomView.isOpen = YES;
            } else {
                [weakSelf.bottomView hide];
                weakSelf.bottomView.isOpen = NO;
            }
        } else if(tag == 1){
            if (!weakSelf.isOpen) {
                weakSelf.isOpen = YES;
                [UIView animateWithDuration:0.25 animations:^{
                    weakSelf.massageView.alpha = 1.0;
                    weakSelf.massageView.hidden = NO;
                } completion:^(BOOL finished) {
                }];
            } else {
                weakSelf.isOpen = NO;
                [UIView animateWithDuration:0.25 animations:^{
                    weakSelf.massageView.alpha = 0;
                    weakSelf.massageView.hidden = YES;
                } completion:^(BOOL finished) {
                }];
            }
        } else {
            CCSureOrderViewController *vc = [CCSureOrderViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    [self.view addSubview:self.massageView];
    [self.massageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(13);
        make.bottom.mas_equalTo(self.view).mas_offset(-(56+HOME_INDICATOR_HEIGHT));
        make.width.mas_equalTo(152);
        make.height.mas_equalTo(78);
    }];
    UILabel *style = [[UILabel alloc] initWithFrame:CGRectMake(Window_W-90, 228, 79, 18)];
    style.layer.cornerRadius = 3;
    style.layer.backgroundColor = [[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.3f] CGColor];
    style.font = FONT_12;
    style.textColor = kWhiteColor;
    style.textAlignment = NSTextAlignmentCenter;
    self.salesLab = style;
    [_cycleScrollView addSubview:style];
}

#pragma mark  - Get
- (CCServiceMassageView *)massageView {
    if (!_massageView) {
        _massageView = [[CCServiceMassageView alloc] init];
        _massageView.hidden = YES;
    }
    return _massageView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.accessibilityIdentifier = @"table_view1";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}

- (CCShopBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CCShopBottomView alloc] initWithFrame:CGRectMake(0, Window_H-66, Window_W, 66) inView:self.view];
    }
    return _bottomView;
}

- (void)rightBtAction:(UIButton *)btn {//分享
    NKAlertView *alertView = [[NKAlertView alloc] init];
     CCBottomShareAlertContentView *customContentView = [[CCBottomShareAlertContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 133+49+5)];
    CCSharePicView *customImageView = [[CCSharePicView alloc] initWithFrame:CGRectMake(0, 0, Window_W-106, 370)];
    
    alertView.type = NKAlertViewTypeBottom;
    alertView.contentView = customContentView;
    alertView.middleView = customImageView;
    alertView.hiddenWhenTapBG = YES;
    [alertView show];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if(section == 1){
        return 2;
    } else {
        return 20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0 && indexPath.row == 0) {
         cell = [tableView dequeueReusableCellWithIdentifier:@"CCGoodsDetailHeadTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CCGoodsDetailHeadTableViewCell *ccc = (CCGoodsDetailHeadTableViewCell *)cell;
        ccc.goodsTitleLab.text = self.goodsDetailModel.goods_name;
        ccc.kuCunLab.text =[NSString stringWithFormat:@"库存量：%ld件",(long)self.goodsDetailModel.stock];
        ccc.priceLab2.text =[NSString stringWithFormat:@"建议零售价：¥%ld",(long)self.goodsDetailModel.retail_price];
        NSString *pricestr = self.goodsDetailModel.promote == nil ? STRING_FROM_INTAGER(self.goodsDetailModel.play_price):STRING_FROM_INTAGER(self.goodsDetailModel.promote.now_price);
        NSString *price = [NSString stringWithFormat:@"￥%@",pricestr];
        NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:@"¥" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:krgb(255,69,4)}];
        NSMutableAttributedString *nameString2 = [[NSMutableAttributedString alloc] initWithString:STRING_FROM_INTAGER(self.goodsDetailModel.promote.old_price) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21],NSForegroundColorAttributeName:krgb(255,69,4)}];
        NSAttributedString *countString = [[NSAttributedString alloc] initWithString:@" 原价：" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:COLOR_999999}];
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:price attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:COLOR_999999,NSStrikethroughColorAttributeName:COLOR_999999,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid)}];
        [nameString appendAttributedString:nameString2];
        [nameString appendAttributedString:countString];
        [nameString appendAttributedString:attrStr];
        ccc.priceLab.attributedText = nameString;
    } else if (indexPath.section == 2){
        static NSString *CellIdentifier = @"CellIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@%ld",[self class],indexPath.row];
        return cell;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CCGoodsDetail"];
        CCGoodsDetailTableViewCell *cellll = (CCGoodsDetailTableViewCell *)cell;
        if (indexPath.section == 0) {
            NSArray *arr = (NSArray *)self.titleArray[indexPath.section];
            [(CCGoodsDetailTableViewCell *)cell titleLab].text = arr[indexPath.row-1];
            if (indexPath.row == 1 || indexPath.row == 2) {
                cellll.jiantouimageView.hidden = YES;
                if (indexPath.row == 1) {
                    cellll.subLab.text = [NSString stringWithFormat:@"%@%@%@",self.goodsDetailModel.address.place1,self.goodsDetailModel.address.place2,self.goodsDetailModel.address.place3];
                } else if (indexPath.row == 2){
                    cellll.subLab.text = @"包邮";
                }
            }
        } else if(indexPath.section == 1) {
            NSArray *arr = (NSArray *)self.titleArray[indexPath.section];
            [(CCGoodsDetailTableViewCell *)cell titleLab].text = arr[indexPath.row];
            if (indexPath.row == 0) {
                cellll.subLab.text = @"选择颜色、数量、尺码";
            } else {
                cellll.subLab.text = @"生产日期、品牌...";
            }
        } else {
            
        }
    }
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 97;
    }
    return [CCGoodsDetailTableViewCell height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 48.0f;
    }
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *head =[UIView new];;
    [head removeAllSubviews];
    if (section == 2) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Window_W, 48)];
        label.textColor = COLOR_999999;
        label.font = FONT_16;
        label.text = @"------ 商品详情 ------";//更换手机号
        label.textAlignment = NSTextAlignmentCenter;
        [head addSubview:label];
    }
    return head;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *vvv = [UIView new];
    vvv.backgroundColor = UIColorHex(0xf7f7f7);
    return vvv;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            NKAlertView *alertView = [[NKAlertView alloc] init];
            BottomAlertContentView *customContentView = [[BottomAlertContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 426)];
            customContentView.model = self.goodsDetailModel;
            alertView.type = NKAlertViewTypeBottom;
            alertView.contentView = customContentView;
            alertView.hiddenWhenTapBG = YES;
            [alertView show];
        }else {
            NKAlertView *alertView = [[NKAlertView alloc] init];
            BottomAlert2Contentview *customContentView = [[BottomAlert2Contentview alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 554)];
            customContentView.model = self.goodsDetailModel;
            alertView.type = NKAlertViewTypeBottom;
            alertView.contentView = customContentView;
            alertView.hiddenWhenTapBG = YES;
            [alertView show];
        }
    } else {
        if (indexPath.row == 3) {
            CCYouHuiQuanViewController *vc = [CCYouHuiQuanViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark  -  SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld",(long)index);
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}
#pragma mark - getters and setters
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray =@[@[@"送至",@"运费",@"活动"],@[@"选择",@"参数"]];
    }
    return _titleArray;
}
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Window_W, 258) delegate:self placeholderImage:IMAGE_NAME(@"")];
        _cycleScrollView.currentPageDotColor = kMainColor;
        _cycleScrollView.pageDotColor = kWhiteColor;

    }
    return _cycleScrollView;
}
- (AJ_TopBar *)topBar {
    if (!_topBar) {

        _topBar = [[AJ_TopBar alloc] init];
           
        _topBar.center = CGPointMake(Window_W/2,
                                         STATUS_BAR_HEIGHT+(NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)/2);
          
        _topBar.bounds = CGRectMake(0,
                                        0,
                                        kWidth(39)*2+kWidth(24),
                                        NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT);
        
        _topBar.backgroundColor =  kClearColor;
        _topBar.buttonTitleColor = kWhiteColor;
        _topBar.markcolor = kWhiteColor;
        _topBar.buttonWidth = kWidth(39);
        _topBar.scrollEnabled = NO;
        _topBar.buttonTitleSelectedColor = kWhiteColor;
        _topBar.titles = [NSMutableArray arrayWithArray:@[@"商品",@"详情"]];
        XYWeakSelf;
        _topBar.blockHandler = ^(NSInteger currentPage) {
            if (currentPage == 1) {
                [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            } else {
                [weakSelf.tableView scrollToTopAnimated:NO];
            }
        };
    }
    return _topBar;
}




@end
