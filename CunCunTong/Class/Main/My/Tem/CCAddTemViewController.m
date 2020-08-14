//
//  CCAddTemViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/29.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCAddTemViewController.h"
#import "CCTemGoodsModel.h"
#import "CCTimeSelectModel.h"
#import "PYPhotosView.h"
#import "TZImagePickerController.h"
#import "CCTemGoodsSelectViewController.h"
#import "CCTemSelectDateViewController.h"
@interface CCAddTemViewController ()<PYPhotosViewDelegate,TZImagePickerControllerDelegate>
@property (nonatomic,strong) UIButton *sendBtn;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (nonatomic,strong) PYPhotosView *publishPhotosView;
@property (nonatomic,copy) NSString *prodroutId;
@property (strong, nonatomic) NSMutableArray *relsutArray;
@property (nonatomic,copy) NSString *prodroutName;
@property (assign, nonatomic) NSInteger count;    //
@property (strong, nonatomic) CCTemGoodsModel *selectGoodsModel;

@property (strong, nonatomic) CCTimeSelectModel *selectTimeModel;
@property (nonatomic,copy) NSString *dateStr;  //
@end

@implementation CCAddTemViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"临期优惠申请"];
    [self setupUI];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    self.count = 1;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.font = FONT_14;
    }
    [cell.contentView removeAllSubviews];
    if (indexPath.section == 1) {
        if (self.selectTimeModel.diff_price) {
            NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:@"差额："];
            [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:15.0f] range:NSMakeRange(0, 3)];
            [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];
            //189-00
            NSString *price = [NSString stringWithFormat:@"￥%ld",self.selectTimeModel.diff_price];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.395f] range:NSMakeRange(0, price.length)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:253.0f/255.0f green:103.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, price.length)];
            [attributedString2 appendAttributedString:attributedString];
            cell.textLabel.attributedText = attributedString2;
        } else {
            cell.textLabel.text = @"差额：";
        }
    } else if(indexPath.section == 2){
            UILabel *nameLab = ({
                UILabel *view = [UILabel new];
                view.textColor =COLOR_333333;
                view.font = STFont(15);
                view.lineBreakMode = NSLineBreakByTruncatingTail;
                view.backgroundColor = [UIColor clearColor];
                view.textAlignment = NSTextAlignmentLeft;
                view.numberOfLines = 0;
                view.text = @"请在此上传凭证\n(必须包含一张带生产日期的照片，最多8张)";
                view ;
            });
            [cell.contentView addSubview:nameLab];
            [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.contentView).mas_offset(15);
                make.size.mas_equalTo(CGSizeMake(Window_W-20, 44));
                make.top.mas_equalTo(cell.contentView).mas_offset(10);
            }];

            // 1. 常见一个发布图片时的photosView
            PYPhotosView *publishPhotosView = [PYPhotosView photosView];
            publishPhotosView.photosMaxCol = 4;
            publishPhotosView.x = 12;
            publishPhotosView.y = 55;
            publishPhotosView.width = Window_W -24;
            publishPhotosView.photoWidth = ((Window_W - 24) - 24)/4;
            publishPhotosView.photoHeight = ((Window_W - 24) - 24)/4;
            publishPhotosView.photoMargin = 8;
            publishPhotosView.delegate = self;
            publishPhotosView.addImageButtonImage = IMAGE_NAME(@"照片");
            [cell.contentView addSubview:publishPhotosView];
            self.publishPhotosView = publishPhotosView;
            self.publishPhotosView.photosState = PYPhotosViewStateWillCompose;
    }else if(indexPath.section == 0){
        if (indexPath.row == 1){
            cell.textLabel.text = @"请选择申请数量";
            PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(Window_W - 130, 7, 85, 30)];
            numberButton.shakeAnimation = YES;
            numberButton.increaseImage = [UIImage imageNamed:@"加号 1"];
            numberButton.decreaseImage = [UIImage imageNamed:@"减号"];
            numberButton.currentNumber = 1;
            numberButton.minValue = 1;
            XYWeakSelf;
            numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
                NSLog(@"%d",(int)number);
                weakSelf.count = number;
            };
            [cell.contentView addSubview:numberButton];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"箱"];
        } else if (indexPath.row == 0){
            cell.textLabel.text = @"请选择申请商品：";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = [self.selectGoodsModel.goods_name isNotBlank] ? self.selectGoodsModel.goods_name : @"请选择";
        } else if(indexPath.row == 2){
            cell.textLabel.text = @"请选择商品生产日期";
            cell.detailTextLabel.text = [self.selectTimeModel.product_date isNotBlank] ? self.selectTimeModel.product_date :@"请选择";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if(indexPath.row == 3){
            cell.textLabel.text = @"商品临期活动价：";
            if (self.selectTimeModel.action_price) {
                cell.textLabel.text =[NSString stringWithFormat:@"商品临期活动价：￥%ld",self.selectTimeModel.action_price];
            }
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return Window_H-44*5-30-NAVIGATION_BAR_HEIGHT;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0001f;
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
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    XYWeakSelf;
    if (indexPath.row == 0) {
        CCTemGoodsSelectViewController *vc = [CCTemGoodsSelectViewController new];
        vc.selectName = cell.detailTextLabel.text;
        vc.clickSelectGoods = ^(CCTemGoodsModel * _Nonnull model) {
            cell.detailTextLabel.text = model.goods_name;
            weakSelf.selectGoodsModel = model;
            if ([weakSelf.dateStr isNotBlank] && weakSelf.selectGoodsModel.id && weakSelf.relsutArray.count) {
                [weakSelf.sendBtn setBackgroundColor:kMainColor];
                [weakSelf.sendBtn setUserInteractionEnabled:YES];
            } else {
                [weakSelf.sendBtn setBackgroundColor:kGrayCustomColor];
                [weakSelf.sendBtn setUserInteractionEnabled:NO];
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else if(indexPath.row == 2){
        CCTemSelectDateViewController *vc = [CCTemSelectDateViewController new];
        vc.sku_id = STRING_FROM_INTAGER(self.selectGoodsModel.id);
        vc.selename = cell.detailTextLabel.text;
        vc.clickCatedity = ^(NSString * _Nonnull name, CCTimeSelectModel * _Nonnull timeModel) {
            cell.detailTextLabel.text = name;
            weakSelf.dateStr = name;
            weakSelf.selectTimeModel = timeModel;
            [weakSelf.relsutArray removeAllObjects];
            [weakSelf.imageArray removeAllObjects];
            [weakSelf.tableView reloadData];
            if ([weakSelf.dateStr isNotBlank] && weakSelf.selectGoodsModel.id && weakSelf.relsutArray.count) {
                [weakSelf.sendBtn setBackgroundColor:kMainColor];
                [weakSelf.sendBtn setUserInteractionEnabled:YES];
            } else {
                [weakSelf.sendBtn setBackgroundColor:kGrayCustomColor];
                [weakSelf.sendBtn setUserInteractionEnabled:NO];
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)setupUI {
    [self.view addSubview:self.sendBtn];
    [self.sendBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.right.bottom.mas_equalTo(self.view).mas_offset(-10);
        make.height.mas_equalTo(46);
    }];
}
- (void)textFieldChange:(UITextField *)field {
    self.prodroutName = field.text;
}
#pragma mark  -  PYdelegate
/**
 * 删除图片按钮触发时调用此方法
 * imageIndex : 删除的图片在之前图片数组的位置
 */
- (void)photosView:(PYPhotosView *)photosView didDeleteImageIndex:(NSInteger)imageIndex {
    if ([self.dateStr isNotBlank] && self.selectGoodsModel.id && self.relsutArray.count) {
        [self.sendBtn setBackgroundColor:kMainColor];
        [self.sendBtn setUserInteractionEnabled:YES];
    } else {
        [self.sendBtn setBackgroundColor:kGrayCustomColor];
        [self.sendBtn setUserInteractionEnabled:NO];
    }
}
- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:(8-self.imageArray.count) delegate:self];
    imagePickerVc.maxImagesCount = 8;
    imagePickerVc.allowPickingOriginalPhoto = NO; //不允许选择原图
    imagePickerVc.allowPickingVideo = YES; //不能选择视频
    imagePickerVc.showSelectBtn = YES; //允许显示选择按钮
    imagePickerVc.allowPickingGif = NO; //不允许选择Gif图
    XYWeakSelf;
    //MARK: 选择照片
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.imageArray addObjectsFromArray:photos];
            [photosView reloadDataWithImages:weakSelf.imageArray];
        });
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObjectsFromArray:photos];
        NSString *name = [NSString stringWithFormat:@"image%@.png",[NSString currentTime]];
        [CCTools uploadTokenMultiple:arr
                     namespaceString:name
                        percentLabel:nil cancleButton:nil
                         finishBlock:^(NSMutableArray * _Nonnull qualificationFileListArray) {
            NSLog(@"---%@",qualificationFileListArray);
            [weakSelf.relsutArray addObjectsFromArray:qualificationFileListArray];
            if ([weakSelf.dateStr isNotBlank] && weakSelf.selectGoodsModel.id && weakSelf.relsutArray.count) {
                [weakSelf.sendBtn setBackgroundColor:kMainColor];
                [weakSelf.sendBtn setUserInteractionEnabled:YES];
            } else {
                [weakSelf.sendBtn setBackgroundColor:kGrayCustomColor];
                [weakSelf.sendBtn setUserInteractionEnabled:NO];
            }
        }];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (NSMutableArray *)relsutArray {
    if (!_relsutArray) {
        _relsutArray = [[NSMutableArray alloc] init];
    }
    return _relsutArray;
}
- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 5;
            view.backgroundColor = kGrayCustomColor;
            [view setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [view setTitle:@"提交" forState:UIControlStateNormal];
            [view.titleLabel setFont:FONT_18];
            view.tag = 3;
            [view addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            view.userInteractionEnabled = NO;
            view ;
        });
    }
    return _sendBtn;
}
- (void)BtnClicked:(UIButton *)button {
    XYWeakSelf;
    NSDictionary *params = @{@"image_set":self.relsutArray,
                             @"center_sku_id":@(self.selectGoodsModel.id),
                             @"product_date":self.dateStr,
                             @"count":@(self.count),
    };
    NSString *path = @"/app0/nearaction/";
    [[STHttpResquest sharedManager] requestWithPUTMethod:POST
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [kNotificationCenter postNotificationName:@"initData" object:nil];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
