//
//  CCReturnGoodsDetailViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCReturnGoodsDetailViewController.h"
#import "CCReturnGoodsDetailHeadView.h"
#import "PYPhotosView.h"
@interface CCReturnGoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) CCReturnGoodsDetailHeadView *headView;


@end

@implementation CCReturnGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self customNavBarWithBlackTitle:@"退货详情"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.headView.frame = CGRectMake(0, 0, Window_W, 110);
    self.tableView.tableHeaderView = self.headView;
    self.tableView.backgroundColor = kWhiteColor;
}

- (CCReturnGoodsDetailHeadView *)headView {
    if (!_headView) {
        _headView = [[CCReturnGoodsDetailHeadView alloc] init];
    }
    return _headView;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
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
    if (indexPath.section == 1 && indexPath.row == 0) {
        NSMutableArray *toaArry = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < 5; i++) {
            UILabel *TextLab = ({
                UILabel *view = [UILabel new];
                view.textColor = COLOR_666666;
                view.font = FONT_14;
                view.lineBreakMode = NSLineBreakByTruncatingTail;
                view.backgroundColor = [UIColor clearColor];
                view.textAlignment = NSTextAlignmentLeft;
                view.layer.masksToBounds = YES;
                view.layer.cornerRadius = 1;
                view.text = @"退货原因：发错货";
                view ;
            });
            [cell.contentView addSubview:TextLab];
            [toaArry addObject:TextLab];
            [TextLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(cell.contentView).mas_offset(7+20*i);
                make.left.mas_equalTo(cell.contentView).mas_offset(10);
                make.width.mas_equalTo(Window_W/2);
                make.height.mas_equalTo(17);
            }];
        }
        UIView *line = [UIView new];
        line.backgroundColor =  [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.08f];;
        [cell.contentView addSubview:line];
        [line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(Window_W-20, 1));
            make.top.mas_equalTo(87+17+10);
        }];
        UILabel *titleLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(16);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"凭证：";
            view ;
        });
        [cell.contentView addSubview:titleLab];
        [titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.top.mas_equalTo(line.mas_bottom).mas_offset(10);
        }];

        // 2. 创建一个photosView
        PYPhotosView *photosView = [PYPhotosView photosViewWithThumbnailUrls:@[@"http://ww3.sinaimg.cn/large/006ka0Iygw1f6bqm7zukpj30g60kzdi2.jpg",@"http://ww3.sinaimg.cn/large/006ka0Iygw1f6bqm7zukpj30g60kzdi2.jpg"] originalUrls:@[]];
        // 3. 添加photosView
        [cell.contentView addSubview:photosView];
        [photosView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(10);
            make.right.mas_equalTo(cell.contentView).mas_offset(-10);
            make.bottom.mas_equalTo(cell.contentView).mas_offset(-10);
            make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(10);
        }];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        UILabel *titleLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(16);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"退款信息";
            view ;
        });
        [cell.contentView addSubview:titleLab];
        [titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.top.mas_equalTo(cell.contentView.mas_top).mas_offset(10);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor =  [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.08f];;
        [cell.contentView addSubview:line];
        [line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(Window_W-20, 1));
            make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(10);
        }];
        UIImageView *iconIamgeView4 = ({
            UIImageView *view = [UIImageView new];
            view.userInteractionEnabled = YES;
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.image = [UIImage imageNamed:@"首页课程图片"];
            view.layer.masksToBounds = YES ;
            view ;
        });
        [cell.contentView addSubview:iconIamgeView4];
        [iconIamgeView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(cell.contentView).mas_offset(-7);
            make.left.mas_equalTo(cell.contentView).mas_offset(15);
            make.height.width.mas_equalTo(76);
        }];
        UILabel *taRendaiFusumTextLab2 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(14);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"七色堇面包0蔗糖";
            view ;
        });
        [cell.contentView addSubview:taRendaiFusumTextLab2];
        [taRendaiFusumTextLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconIamgeView4.mas_right).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.top.mas_equalTo(iconIamgeView4.mas_top);
        }];
        UILabel *taRendaiFusumTextLab3 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(14);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"芒果味";
            view ;
        });
        [cell.contentView addSubview:taRendaiFusumTextLab3];
        [taRendaiFusumTextLab3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconIamgeView4.mas_right).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.top.mas_equalTo(taRendaiFusumTextLab2.mas_bottom).mas_offset(8);
        }];
        UILabel *taRendaiFusumTextLab1 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(16);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentRight;
            view.text = @"¥189.00";
            view ;
        });
        [cell.contentView addSubview:taRendaiFusumTextLab1];
        [taRendaiFusumTextLab1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.contentView).mas_offset(-10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.centerY.mas_equalTo(taRendaiFusumTextLab2);
        }];
        UILabel *taRendaiFusumTextLab4 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_999999	;
            view.font = STFont(13);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentRight;
            view.text = @"×20";
            view ;
        });
        [cell.contentView addSubview:taRendaiFusumTextLab4];
        [taRendaiFusumTextLab4 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.contentView).mas_offset(-10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.top.mas_equalTo(taRendaiFusumTextLab1.mas_bottom).mas_offset(5);
        }];
    }
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        return 338;
    }
    return 135;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
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

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
