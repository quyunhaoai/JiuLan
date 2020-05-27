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
@interface CCPanDianDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;

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
        make.bottom.mas_equalTo(self.view).mas_offset(-44);
    }];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, -10);
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
    CCSelectGoodsViewController *vc = [CCSelectGoodsViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;;
    } else if (section == 1){
        return 3;
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
            view.text = @"制单人";
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
            view.text = @"小明";
            view ;
        });
        [cell.contentView addSubview:addressLab];
        [addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.contentView).mas_offset(-21);
            make.size.mas_equalTo(CGSizeMake(247, 14));
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
            view.text = @"无";
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
                make.size.mas_equalTo(CGSizeMake(117, 14));
                make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
            }];
            if (indexPath.row == 1) {
                titleLab.text = [NSString getCurrentTime:@"yyyy-MM-dd"];
                [titleLab addTapGestureWithBlock:^(UIView *gestureView) {
                    NSString *str = [NSString getCurrentTime:@"yyyy-MM-dd"];
                    [BRDatePickerView showDatePickerWithTitle:@"请选择" dateType:BRDatePickerModeYMD defaultSelValue:str resultBlock:^(NSString *selectValue) {
                        titleLab.text = selectValue;
                    }];
                }];
            } else if(indexPath.row == 2) {
                titleLab.text = @"请选择盘点分类";
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
        UILabel *subtitleLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_666666;
            view.font = STFont(13);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.tag = 100;
            view.text = @"商品名称：娃哈哈矿泉水";
            view ;
        });
        [cell.contentView addSubview:subtitleLab];
        [subtitleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(23);
            make.size.mas_equalTo(CGSizeMake(237, 14));
            make.top.mas_equalTo(cell.contentView).mas_offset(10);
        }];
        
        UILabel *subtitleLab2 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_666666;
            view.font = STFont(13);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.tag = 100;
            view.text = @"规格：500ml";
            view ;
        });
        [cell.contentView addSubview:subtitleLab2];
        [subtitleLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(23);
            make.size.mas_equalTo(CGSizeMake(167, 14));
            make.top.mas_equalTo(subtitleLab.mas_bottom).mas_offset(6);
        }];
        UILabel *subtitleLab3 = ({
            UILabel *view = [UILabel new];
            view.textColor = krgb(255,16,16);
            view.font = STFont(13);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.tag = 100;
            view.text = @"库存数量：10";
            view ;
        });
        [cell.contentView addSubview:subtitleLab3];
        [subtitleLab3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(23);
            make.size.mas_equalTo(CGSizeMake(160, 14));
            make.top.mas_equalTo(subtitleLab2.mas_bottom).mas_offset(6);
        }];
        UILabel *subtitleLab4 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_666666;
            view.font = STFont(13);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.tag = 100;
            view.text = @"单位：瓶";
            view ;
        });
        [cell.contentView addSubview:subtitleLab4];
        [subtitleLab4 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(subtitleLab2.mas_right).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(107, 14));
            make.top.mas_equalTo(subtitleLab.mas_bottom).mas_offset(6);
        }];
        UILabel *subtitleLab5 = ({
            UILabel *view = [UILabel new];
            view.textColor =krgb(255,24,24);
            view.font = STFont(13);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.tag = 100;
            view.text = @"盘点数量：10";
            view ;
        });
        [cell.contentView addSubview:subtitleLab5];
        [subtitleLab5 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(subtitleLab4).mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(107, 14));
            make.top.mas_equalTo(subtitleLab4.mas_bottom).mas_offset(6);
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
    }
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0 || indexPath.section == 0) {
        return 35;
    } else if (indexPath.section == 1 && indexPath.row >0){
        return 74;
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
    if (indexPath.section == 0 && indexPath.row == 2) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UILabel *textLab = [cell viewWithTag:1000];
        CCSelectCatediyViewController *vc = [CCSelectCatediyViewController new];
        vc.clickCatedity = ^(NSString * _Nonnull name) {
            NSLog(@"%@",name);
            textLab.text = name;
        };
        [self.navigationController pushViewController:vc animated:YES];
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
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"基础信息",@"盘点商品",@"备注",@""];
    }
    return _titleArray;
}


@end
