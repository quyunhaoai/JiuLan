//
//  CCSmallShopViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/8.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSmallShopViewController.h"
#import "HXCharts.h"
#import "CCInGoodsListViewController.h"
@interface CCSmallShopViewController ()<UITableViewDelegate,UITableViewDataSource,SegmentTapViewDelegate>
@property (nonatomic, strong) SegmentTapView *segment;
@property (strong, nonatomic) CCSmallShopHeadView *headView;
@end

@implementation CCSmallShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"小店"];
    [(UIButton *)self.navTitleView.leftBtns[0] setHidden:YES];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    self.headView.frame = CGRectMake(0, 0, Window_W, 230);
    self.tableView.tableHeaderView = self.headView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    XYWeakSelf;
    self.headView.clcikView = ^(NSInteger tag) {
        CCInGoodsListViewController *vc = [CCInGoodsListViewController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    if (indexPath.section == 0) {
        [self initSegmentInView:cell.contentView];
        UIImageView *areaIcon = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;
            [view setImage:IMAGE_NAME(@"奖杯图标")];
             
            view;
        });
        [cell.contentView addSubview:areaIcon];
        [areaIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(13, 13));
            make.top.mas_equalTo(cell.contentView).mas_offset(60);
        }];
        UILabel *nameLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(15);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"销量前7商品";
            view ;
        });
        [cell.contentView addSubview:nameLab];
        [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(areaIcon.mas_right).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(177, 14));
            make.top.mas_equalTo(cell.contentView).mas_offset(60);
        }];
        NSArray *color1 = @[[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f],[UIColor colorWithRed:117.0f/255.0f green:221.0f/255.0f blue:215.0f/255.0f alpha:1.0f]];
        [self initChartsInview:cell.contentView barChartX:78 andColors:color1];
        UIView *line = [UIView new];
        line.backgroundColor = UIColorHex(0xf7f7f7);
        [cell.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(Window_W-40, 1));
            make.top.mas_equalTo(cell.contentView).mas_offset(305);
        }];
        UIImageView *areaIcon1 = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;
            [view setImage:IMAGE_NAME(@"奖杯图标")];
             
            view;
        });
        [cell.contentView addSubview:areaIcon1];
        [areaIcon1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(13, 13));
            make.top.mas_equalTo(cell.contentView).mas_offset(325);
        }];
        UILabel *nameLab1 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(15);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"销量后7商品";
            view ;
        });
        [cell.contentView addSubview:nameLab1];
        [nameLab1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(areaIcon.mas_right).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(177, 14));
            make.top.mas_equalTo(cell.contentView).mas_offset(325);
        }];
        NSArray *color2 = @[[UIColor colorWithRed:255.0f/255.0f green:157.0f/255.0f blue:52.0f/255.0f alpha:1.0f],[UIColor colorWithRed:255.0f/255.0f green:214.0f/255.0f blue:171.0f/255.0f alpha:1.0f]];
        [self initChartsInview:cell.contentView barChartX:351 andColors:color2];
        
    }else if (indexPath.section == 1 || indexPath.section == 2) {
        UILabel *nameLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(15);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"利润分析";
            view ;
            
        });
        [cell.contentView addSubview:nameLab];
        [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(77, 14));
            make.top.mas_equalTo(cell.contentView).mas_offset(15);
        }];
        if (indexPath.section == 2) {
            nameLab.text = @"毛利率分析";
            [self initChatsZheLineTuInView:cell.contentView];
        } else {
            NSArray *color1 = @[[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f],[UIColor colorWithRed:117.0f/255.0f green:221.0f/255.0f blue:215.0f/255.0f alpha:1.0f]];
            [self initChartsInview:cell.contentView barChartX:78 andColors:color1];
        }
    }
    return cell;
}
- (void)initChatsZheLineTuInView:(UIView *)view {
    CGFloat lineChartWidth = self.view.frame.size.width * 0.86+10;
    CGFloat lineChartHeight = 149;
    
    CGFloat lineChartX = 21;
    CGFloat lineChartY = 50;
    
    HXLineChart *line = [[HXLineChart alloc] initWithFrame:CGRectMake(lineChartX, lineChartY, lineChartWidth, lineChartHeight)];
    
    [line setTitleArray:@[@"一",@"二",@"三",@"四",@"五",@"六"]];
    
    [line setValue:@[@13,@30,@52,@73,@91,@34] withYLineCount:5];
    
    line.lineColor = [UIColor colorWithRed:255.0f/255.0f green:206.0f/255.0f blue:153.0f/255.0f alpha:1.0f];

    line.markTextColor = COLOR_333333;
    line.markTextFont = FONT_15;
    line.fillColor = kClearColor;
    
    line.backgroundLineColor = UIColorHex(0xf7f7f7);
    
    [view addSubview:line];
}
/*//Base style for 矩形 1149
UIView *style = [[UIView alloc] initWithFrame:CGRectMake(90, 678, 11, 162)];
style.alpha = 1;

//Gradient 0 fill for 矩形 1149
CAGradientLayer *gradientLayer0 = [[CAGradientLayer alloc] init];
gradientLayer0.frame = style.bounds;
gradientLayer0.colors = @[
    (id)[UIColor colorWithRed:255.0f/255.0f green:157.0f/255.0f blue:52.0f/255.0f alpha:1.0f].CGColor,
    (id)[UIColor colorWithRed:255.0f/255.0f green:187.0f/255.0f blue:113.0f/255.0f alpha:1.0f].CGColor,
    (id)[UIColor colorWithRed:255.0f/255.0f green:214.0f/255.0f blue:171.0f/255.0f alpha:1.0f].CGColor];
gradientLayer0.locations = @[@0, @1, @1];
[gradientLayer0 setStartPoint:CGPointMake(1, 1)];
[gradientLayer0 setEndPoint:CGPointMake(1, 0)];
[style.layer addSublayer:gradientLayer0];**/
- (void)initChartsInview:(UIView *)view barChartX:(CGFloat )X andColors:(NSArray *)colorArr{
    CGFloat barChartWidth = self.view.frame.size.width * 0.86;
    CGFloat barChartHeight = 207;
    
    CGFloat barChartX = 31;
    CGFloat barChartY = X;
    
    ///渐变色
    NSArray *color1 = colorArr;
    NSArray *color2 = color1;
    NSArray *color3 = color1;
    NSArray *color4 = color1;
    NSArray *color5 = color1;
    NSArray *color6 = color1;
    
    
    HXBarChart *bar = [[HXBarChart alloc] initWithFrame:CGRectMake(barChartX, barChartY, barChartWidth, barChartHeight) withMarkLabelCount:6 withOrientationType:OrientationVertical];
    [view addSubview:bar];
    bar.titleArray = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
    bar.valueArray = @[@"15",@"27",@"13",@"42",@"34",@"2",@"24",@"41",@"12",@"56",@"69",@"33"];
    bar.colorArray = @[color1,color2,color3,color4,color5,color6,color1,color2,color3,color4,color5,color6];
    bar.locations = @[@0.15,@0.85];
    bar.markTextColor = COLOR_333333;
    bar.markTextFont = [UIFont systemFontOfSize:14];//4b4e52
    bar.xlineColor = UIColorHex(0xEEEEEE);
    ///不需要滑动可不设置
    bar.contentValue = 12 * 45;
    bar.barWidth = 25;
    bar.margin = 20;
    
    [bar drawChart];
}
/*//Base style for 矩形 1149
UIView *style = [[UIView alloc] initWithFrame:CGRectMake(90, 396, 11, 162)];
style.alpha = 1;

//Gradient 0 fill for 矩形 1149
CAGradientLayer *gradientLayer0 = [[CAGradientLayer alloc] init];
gradientLayer0.frame = style.bounds;
gradientLayer0.colors = @[
    (id)[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f].CGColor,
    (id)[UIColor colorWithRed:78.0f/255.0f green:186.0f/255.0f blue:180.0f/255.0f alpha:1.0f].CGColor,
    (id)[UIColor colorWithRed:117.0f/255.0f green:221.0f/255.0f blue:215.0f/255.0f alpha:1.0f].CGColor];
gradientLayer0.locations = @[@0, @1, @1];
[gradientLayer0 setStartPoint:CGPointMake(1, 1)];
[gradientLayer0 setEndPoint:CGPointMake(1, 0)];
[style.layer addSublayer:gradientLayer0];**/
-(void)initSegmentInView:(UIView *)view {
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(10, 10, Window_W-20, 40) withDataArray:@[@"本周",@"本月",@"本季",@"本年"] withFont:15];
    self.segment.backgroundColor = kWhiteColor;
    self.segment.delegate = self;
    self.segment.textSelectedColor = kMainColor;
    self.segment.textNomalColor = COLOR_333333;
    self.segment.lineColor = kMainColor;
    [view addSubview:self.segment];

}
- (void)selectedIndex:(NSInteger)index {
    NSLog(@"%ld",(long )index);
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 227;
    } else if (indexPath.section == 1){
        return 356;
    }
    return 584;
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
    CGRect bounds = CGRectInset(cell.bounds, 10, 5);
    
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



- (CCSmallShopHeadView *)headView {
    if (!_headView) {
        _headView = [[CCSmallShopHeadView alloc] init];
    }
    return _headView;
}





@end
