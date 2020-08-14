//
//  CCTemListViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/29.
//  Copyright © 2020 GOOUC. All rights reserved.
//


#import "CCTemListViewController.h"
#import "CCNeedListModel.h"
#import "CCTemDetailViewController.h"
#import "CCAddTemViewController.h"
#import "CCTemListModelTableViewCell.h"
@interface CCTemListViewController ()

@end

@implementation CCTemListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *rightBtn = ({
         UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
         [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
         [btn setImage:IMAGE_NAME(@"新建加号图标") forState:UIControlStateNormal];
         btn.layer.masksToBounds = YES ;
         btn.tag = 1;
         [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
         btn ;
     });
     rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [self customNavBarWithtitle:@"临期优惠申请" andLeftView:@"" andRightView:@[rightBtn]];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    [self initData];
    [self addTableViewRefresh];
    self.baseTableView = self.tableView;
    [self.tableView registerNib:CCTemListModelTableViewCell.loadNib forCellReuseIdentifier:@"CCTemListModelTableViewCell"];
}
- (void)initData {
    NSString *path = @"/app0/nearaction/";
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
        weakSelf.showErrorView = YES;
    }];
}
- (void)rightBtAction:(id)sender {
    CCAddTemViewController *vc = [CCAddTemViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCTemListModelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCTemListModelTableViewCell"];
    cell.temModel = [CCNeedListModel modelWithJSON:self.dataSoureArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCNeedListModel *model =[CCNeedListModel modelWithJSON:self.dataSoureArray[indexPath.row]];
    if (model.image_set.count >4) {
        return (Window_W-64) /4 + 20+ 268;
    }
    return 268;
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
    CCTemDetailViewController *vc = [CCTemDetailViewController new];
    CCNeedListModel *model = [CCNeedListModel modelWithJSON:self.dataSoureArray[indexPath.row]];
    vc.needID = STRING_FROM_INTAGER(model.id);
    [self.navigationController pushViewController:vc animated:YES];
    
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(tintColor)]) {
//        if (tableView == self.tableView) {
//            // 圆角弧度半径
//            CGFloat cornerRadius = 10.f;
//            // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
//            cell.backgroundColor = UIColor.clearColor;
//
//            // 创建一个shapeLayer
//            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
//            CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
//            // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
//            CGMutablePathRef pathRef = CGPathCreateMutable();
//            // 获取cell的size
//            CGRect bounds = CGRectInset(cell.bounds, 0, 0);
//
//            // CGRectGetMinY：返回对象顶点坐标
//            // CGRectGetMaxY：返回对象底点坐标
//            // CGRectGetMinX：返回对象左边缘坐标
//            // CGRectGetMaxX：返回对象右边缘坐标
//
//            // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行
//            BOOL addLine = NO;
//            // CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
//            if (indexPath.row == 0) {
//                // 初始起点为cell的左下角坐标
//                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
//                // 起始坐标为左下角，设为p1，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
//                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
//                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
//                // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
//                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
//                addLine = YES;
//            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
//                // 初始起点为cell的左上角坐标
//                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
//                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
//                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
//                // 添加一条直线，终点坐标为右下角坐标点并放到路径中去
//                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
//            } else {
//                // 添加cell的rectangle信息到path中（不包括圆角）
//                CGPathAddRect(pathRef, nil, bounds);
//                addLine = YES;
//            }
//            // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
//            layer.path = pathRef;
//            backgroundLayer.path = pathRef;
//            // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
//            CFRelease(pathRef);
//            // 按照shape layer的path填充颜色，类似于渲染render
//            // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
//            layer.fillColor = [UIColor whiteColor].CGColor;
//            // 添加分隔线图层
//            if (addLine == YES) {
//                CALayer *lineLayer = [[CALayer alloc] init];
//                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
//                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height-lineHeight, bounds.size.width, lineHeight);
//                // 分隔线颜色取自于原来tableview的分隔线颜色
//                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
//                [layer addSublayer:lineLayer];
//            }
//
//            // view大小与cell一致
//            UIView *roundView = [[UIView alloc] initWithFrame:bounds];
//            // 添加自定义圆角后的图层到roundView中
//            [roundView.layer insertSublayer:layer atIndex:0];
//            roundView.backgroundColor = UIColor.clearColor;
//            //cell的背景view
//            //cell.selectedBackgroundView = roundView;
//            cell.backgroundView = roundView;
//
//            //以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
//            UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
//            backgroundLayer.fillColor = tableView.separatorColor.CGColor;
//            [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
//            selectedBackgroundView.backgroundColor = UIColor.clearColor;
//            cell.selectedBackgroundView = selectedBackgroundView;
//        }
//    }
//
//}

@end
