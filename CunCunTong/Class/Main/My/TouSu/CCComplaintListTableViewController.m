//
//  CCComplaintListTableViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/8.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCComplaintListTableViewController.h"
#import "CCComplaintViewController.h"
#import "CCConPlainListMOdel.h"
#import "LWQ_CheXiaoRuKuCell.h"
#import "CCTousuDetailViewController.h"
#import "CCHeadInfoTableViewCell.h"

@interface CCComplaintListTableViewController ()

@end

@implementation CCComplaintListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorHex(0xf7f7f7);
    UIButton *rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:IMAGE_NAME(@"新建加号图标") forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES ;
        [btn addTarget:self action:@selector(rightBtAction:)
      forControlEvents:UIControlEventTouchUpInside];
        btn ;
    });
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [self customNavBarWithtitle:@"投诉" andLeftView:@"" andRightView:@[rightBtn]];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.right.mas_equalTo(-10);
    }];
    self.baseTableView = self.tableView;
    [self initData];
    [self.tableView registerNib:LWQ_CheXiaoRuKuCell.loadNib
         forCellReuseIdentifier:@"LWQ_CheXiaoRuKuCell"];
    [kNotificationCenter addObserver:self selector:@selector(initData1) name:@"initData1" object:nil];
    [self addTableViewRefresh];
}
- (void)initData1{
    [self.tableView.mj_header beginRefreshing];
}
- (void)rightBtAction:(UIButton *)button {
    CCComplaintViewController *vc = [CCComplaintViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)initData {
    XYWeakSelf;
    NSString *path = @"/app0/conplain/";
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
            weakSelf.page ++;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSoureArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CCConPlainListMOdel *model = [CCConPlainListMOdel modelWithJSON:self.dataSoureArray[section]];
    return  model.child_order_set.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCConPlainListMOdel *model = [CCConPlainListMOdel modelWithJSON:self.dataSoureArray[indexPath.section]];
    if (indexPath.row == 0) {
        CCHeadInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCHeadInfoTableViewCell"];
        cell.titleLab.text = [NSString stringWithFormat:@"订单号：%@",model.order_num];
        switch (model.status) {
            case 0:
                cell.stateLab.text = @"审核中";
                break;
            case 1:
                 cell.stateLab.text = @"审核通过";
                break;
            default:
                break;
        }
        return cell;
    } else if(indexPath.row ==  model.child_order_set.count+1) {
        static NSString *CellIdentifier = @"CellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell.contentView removeAllSubviews];
         UIView *view = [[UIView alloc] init];
         view.backgroundColor = kWhiteColor;
        view.frame = cell.contentView.frame;
        [cell.contentView addSubview:view];
        UIView *line = [UIView new];
        line.backgroundColor = COLOR_f5f5f5;
        [view addSubview:line];
        line.frame = CGRectMake(0, 0, Window_W, 1);
         UILabel *titleLab = ({
             UILabel *view = [UILabel new];
             view.textColor =COLOR_333333;
             view.font = STFont(13);
             view.lineBreakMode = NSLineBreakByTruncatingTail;
             view.backgroundColor = [UIColor clearColor];
             view.textAlignment = NSTextAlignmentLeft;
             view ;
         });
         [view addSubview:titleLab];
         [titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
             make.left.mas_equalTo(view).mas_offset(10);
             make.size.mas_equalTo(CGSizeMake(217, 14));
             make.top.mas_equalTo(view).mas_offset(10);
         }];
         titleLab.text = [NSString stringWithFormat:@"投诉原因：%@",model.reason];
         UILabel *subtitleLab = ({
             UILabel *view = [UILabel new];
             view.textColor =COLOR_333333;
             view.font = STFont(13);
             view.lineBreakMode = NSLineBreakByTruncatingTail;
             view.backgroundColor = [UIColor clearColor];
             view.textAlignment = NSTextAlignmentLeft;
             view ;
         });
         [view addSubview:subtitleLab];
         [subtitleLab mas_updateConstraints:^(MASConstraintMaker *make) {
             make.left.mas_equalTo(view).mas_offset(10);
             make.size.mas_equalTo(CGSizeMake(217, 14));
             make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(10);
         }];
        subtitleLab.text = [NSString stringWithFormat:@"投诉时间：%@",model.create_time];
        if (model.status == 1) {
            UILabel *titleLab1 = ({
                UILabel *view = [UILabel new];
                view.textColor =COLOR_333333;
                view.font = STFont(13);
                view.lineBreakMode = NSLineBreakByTruncatingTail;
                view.backgroundColor = [UIColor clearColor];
                view.textAlignment = NSTextAlignmentLeft;
                view ;
            });
            [view addSubview:titleLab1];
            [titleLab1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).mas_offset(10);
                make.size.mas_equalTo(CGSizeMake(217, 14));
                make.top.mas_equalTo(subtitleLab.mas_bottom).mas_offset(10);
            }];
            titleLab1.text = [NSString stringWithFormat:@"审核意见：%@",model.return_msg];
            UILabel *subtitleLab1 = ({
                UILabel *view = [UILabel new];
                view.textColor =COLOR_333333;
                view.font = STFont(13);
                view.lineBreakMode = NSLineBreakByTruncatingTail;
                view.backgroundColor = [UIColor clearColor];
                view.textAlignment = NSTextAlignmentLeft;
                view ;
            });
            [view addSubview:subtitleLab1];
            [subtitleLab1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).mas_offset(10);
                make.size.mas_equalTo(CGSizeMake(217, 14));
                make.top.mas_equalTo(titleLab1.mas_bottom).mas_offset(10);
            }];
            subtitleLab1.text = [NSString stringWithFormat:@"审核时间：%@",model.check_time];
        }
        return cell;
    }
    LWQ_CheXiaoRuKuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWQ_CheXiaoRuKuCell"];
    cell.item = model.child_order_set[indexPath.row-1];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCConPlainListMOdel *model = [CCConPlainListMOdel modelWithJSON:self.dataSoureArray[indexPath.section]];
    if (indexPath.row == model.child_order_set.count+1) {
        if (model.status == 1) {
            return 105;
        }
        return 53.0001f;
    }
    if (indexPath.row == 0) {
        return 44;
    }
    return 95;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kClearColor;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
     UIView *view = [[UIView alloc] init];
    return view;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {
            // 圆角弧度半径
            CGFloat cornerRadius = 10.f;
            // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
            cell.backgroundColor = UIColor.clearColor;
            // 创建一个shapeLayer
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
            // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
            CGMutablePathRef pathRef = CGPathCreateMutable();
            // 获取cell的size
            CGRect bounds = CGRectInset(cell.bounds, 0, 0);
            // CGRectGetMinY：返回对象顶点坐标
            // CGRectGetMaxY：返回对象底点坐标
            // CGRectGetMinX：返回对象左边缘坐标
            // CGRectGetMaxX：返回对象右边缘坐标
            // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行
            BOOL addLine = NO;
            // CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            if (indexPath.row == 0) {
                // 初始起点为cell的左下角坐标
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                // 起始坐标为左下角，设为p1，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
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
                addLine = YES;
            }
            // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
            layer.path = pathRef;
            backgroundLayer.path = pathRef;
            // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
            CFRelease(pathRef);
            // 按照shape layer的path填充颜色，类似于渲染render
            // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            layer.fillColor = [UIColor whiteColor].CGColor;
            // 添加分隔线图层
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height-lineHeight, bounds.size.width, lineHeight);
                // 分隔线颜色取自于原来tableview的分隔线颜色
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            // view大小与cell一致
            UIView *roundView = [[UIView alloc] initWithFrame:bounds];
            // 添加自定义圆角后的图层到roundView中
            [roundView.layer insertSublayer:layer atIndex:0];
            roundView.backgroundColor = UIColor.clearColor;
            //cell的背景view
            //cell.selectedBackgroundView = roundView;
            cell.backgroundView = roundView;
            //以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
            UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
            backgroundLayer.fillColor = tableView.separatorColor.CGColor;
            [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
            selectedBackgroundView.backgroundColor = UIColor.clearColor;
            cell.selectedBackgroundView = selectedBackgroundView;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CCTousuDetailViewController *vc = [CCTousuDetailViewController new];
    vc.tagerID = @"";
    CCConPlainListMOdel *model = [CCConPlainListMOdel modelWithJSON:self.dataSoureArray[indexPath.section]];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
        UITableView *tableview = (UITableView *)scrollView;
        CGFloat sectionHeaderHeight = 34;
        CGFloat sectionFooterHeight = 85;
        CGFloat offsetY = tableview.contentOffset.y;
        if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
        {
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
        }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
        {
            tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
        }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)
        {
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
        }
    }
}
@end
