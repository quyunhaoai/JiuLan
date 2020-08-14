//
//  CCPanDianDetailViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSelectGoodsViewController.h"
#import "CCPanDianDetailViewController.h"
#import "BRDatePickerView.h"
#import "CCSelectCatediyViewController.h"
#import "CCAddPanDianModel.h"
#import "CCBigPanDianTableViewCell.h"
@interface CCPanDianDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) CCAddPanDianModel *model;


@end

@implementation CCPanDianDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customNavBarWithTitle:@"盘点单详情"];
    self.tableView.backgroundColor = UIColorHex(0xf7f7f7);
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(0);
    }];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, -10);
    [self initData];
    [self.tableView registerClass:CCBigPanDianTableViewCell.class
           forCellReuseIdentifier:@"CCBigPanDianTableViewCell"];
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path =[NSString stringWithFormat:@"app0/marketreckon/%@/",self.pandianID];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.model = [CCAddPanDianModel modelWithJSON:data];
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
#pragma mark  - Get

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.accessibilityIdentifier = @"table_view";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}
- (void)goodsSelect:(UIButton*)button {
//    CCSelectGoodsViewController *vc = [CCSelectGoodsViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;;
    } else if (section == 1){
        return self.model.child_set.count+1;
    } else if (section == 2){
        return 2;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView removeAllSubviews];
    if (indexPath.section == 3){
        UILabel *nameLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(13);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = indexPath.row ?  @"制单人" : @"制单日期";
            view ;

        });
        [cell.contentView addSubview:nameLab];
        [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(77, 14));
            make.top.mas_equalTo(cell.contentView).mas_offset(10);
        }];
        UILabel *addressLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_666666;
            view.font = STFont(13);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentRight;
            view.numberOfLines = 1;
            view.text =indexPath.row ? self.model.ccoperator: self.model.update_time;
            view ;
        });
        [cell.contentView addSubview:addressLab];
        [addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.contentView).mas_offset(-21);
            make.size.mas_equalTo(CGSizeMake(287, 14));
            make.top.mas_equalTo(cell.contentView).mas_offset(10);
        }];
        UIView *line = [UIView new];
        line.backgroundColor = UIColorHex(0xf7f7f7);
        [cell.contentView addSubview:line];
        [line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(20);
            make.bottom.mas_equalTo(cell.contentView);
            make.width.mas_equalTo(Window_W-40);
            make.height.mas_equalTo(kWidth(1));
        }];
    }else if (indexPath.section == 2 && indexPath.row == 1) {
        UILabel *nameLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_666666;
            view.font = STFont(15);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = self.model.remark;
            view ;
        });
        [cell.contentView addSubview:nameLab];
        [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(22);
            make.size.mas_equalTo(CGSizeMake(77, 14));
            make.top.mas_equalTo(cell.contentView).mas_offset(10);
        }];
    } else if (indexPath.row == 0 || indexPath.section == 0) {
        UILabel *subtitleLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(13);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.tag = 100;
            view ;
        });
        [cell.contentView addSubview:subtitleLab];
        [subtitleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(23);
            make.size.mas_equalTo(CGSizeMake(237, 14));
            make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
        }];
        if (indexPath.row == 0) {
            UIImageView *rightIcon = ({
                UIImageView *view = [UIImageView new];
                view.contentMode = UIViewContentModeScaleAspectFit;
                view.image = [UIImage imageNamed:@"竖线"];
                view.userInteractionEnabled = YES;
                view.tag = 100+indexPath.row;
                view ;
            });
            [cell.contentView addSubview:rightIcon];
            [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.contentView).mas_offset(10);
                make.centerY.mas_equalTo(cell.contentView);
                make.width.mas_equalTo(kWidth(3));
                make.height.mas_equalTo(kWidth(14));
            }];
            subtitleLab.text = self.titleArray[indexPath.section];
        } else if(indexPath.row == 1){
            subtitleLab.text = @"单据日期";
            
        } else if(indexPath.row == 2){
            subtitleLab.text = @"盘点分类";
        }
        if (indexPath.row == 1 || indexPath.row == 2) {
            UILabel *titleLab = ({
                UILabel *view = [UILabel new];
                view.textColor =COLOR_666666;
                view.font = STFont(13);
                view.lineBreakMode = NSLineBreakByTruncatingTail;
                view.backgroundColor = [UIColor clearColor];
                view.textAlignment = NSTextAlignmentRight;
                view.userInteractionEnabled = YES;
                view.tag = 1000;
                view ;
            });
            [cell.contentView addSubview:titleLab];
            [titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(cell.contentView).mas_offset(-20);
                make.size.mas_equalTo(CGSizeMake(217, 14));
                make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
            }];
            if (indexPath.row == 1) {
                titleLab.text = self.model.create_time;
            } else if(indexPath.row == 2) {
                titleLab.text =self.model.category;
            }
        }
        UIView *line = [UIView new];
        line.backgroundColor = UIColorHex(0xf7f7f7);
        [cell.contentView addSubview:line];
        [line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(20);
            make.bottom.mas_equalTo(cell.contentView);
            make.width.mas_equalTo(Window_W-40);
            make.height.mas_equalTo(kWidth(1));
        }];
    } else if (indexPath.section == 1 && indexPath.row >0){
        Child_setItem *item = self.model.child_set[indexPath.row-1];
        CCBigPanDianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCBigPanDianTableViewCell"];
        cell.isDatil = YES;
        cell.item = item;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0 || indexPath.section == 0) {
        return 35;
    } else if (indexPath.section == 1 && indexPath.row >0){
        Child_setItem *item = self.model.child_set[indexPath.row-1];
        return 74+item.batch_set.count*66+10;
    }
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = UIColorHex(0xf7f7f7);
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = UIColorHex(0xf7f7f7);
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"基础信息",@"盘点商品",@"备注",@""];
    }
    return _titleArray;
}


@end
