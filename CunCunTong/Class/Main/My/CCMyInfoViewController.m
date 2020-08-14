//
//  CCMyInfoViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCMyInfoViewController.h"
#import "CCBangDingMobileViewController.h"
#import "BRAddressPickerView.h"
#import "CCMyinfoModel.h"
#import <CoreLocation/CoreLocation.h>
#import "CCAboutListViewController.h"
@interface CCMyInfoViewController ()<UITableViewDelegate,UITableViewDataSource,STPhotoKitDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) CCMyinfoModel *myInfoModel;
@property (copy, nonatomic) NSString *latsss;//weidu
@property (copy, nonatomic) NSString *longsss;//jingdu
@property (nonatomic,strong) CLLocationManager *locationManager;         //定位
@property (nonatomic,strong) CLGeocoder *geoCoder;                       //地理位置信息
@property (nonatomic,copy) NSString *address;  //
@end

@implementation CCMyInfoViewController
- (void)initLocationInfo {
    // 初始化定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    // 设置代理
    _locationManager.delegate = self;
    // 设置定位精确度到米
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置过滤器为无
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    // 取得定位权限，有两个方法，取决于你的定位使用情况
    // 一个是requestAlwaysAuthorization，一个是requestWhenInUseAuthorization
    // 这句话ios8以上版本使用。
    [_locationManager requestAlwaysAuthorization];
    // 开始定位
    [_locationManager startUpdatingLocation];
    //地理信息
    _geoCoder = [[CLGeocoder alloc] init];
}
//MARK: - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"%lu",(unsigned long)locations.count);
    CLLocation * location = locations.lastObject;
    // 纬度
    CLLocationDegrees latitude = location.coordinate.latitude;
    // 经度
    CLLocationDegrees longitude = location.coordinate.longitude;
    self.longsss = [NSString stringWithFormat:@"%lf",longitude];
    self.latsss = [NSString stringWithFormat:@"%lf",latitude];
    NSLog(@"%@",[NSString stringWithFormat:@"%lf", location.coordinate.longitude]);
    //    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f", location.coordinate.longitude, location.coordinate.latitude,location.altitude,location.course,location.speed);
    
    [_geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSLog(@"%@",placemark.name);
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            // 位置名
            NSLog(@"name,%@",placemark.name);
            // 街道
            NSLog(@"thoroughfare,%@",placemark.thoroughfare);
            // 子街道
            NSLog(@"subThoroughfare,%@",placemark.subThoroughfare);
            // 市
            NSLog(@"locality,%@",placemark.locality);
            // 区
            NSLog(@"subLocality,%@",placemark.subLocality);
            // 国家
            NSLog(@"country,%@",placemark.country);
            
        }else if (error == nil && [placemarks count] == 0) {
            NSLog(@"No results were returned.");
        } else if (error != nil){
            NSLog(@"An error occurred = %@", error);
        }
    }];
    [self.locationManager stopUpdatingLocation];//不用的时候关闭更新位置服务，不关闭的话这个 delegate 隔一定的时间间隔就会有回调
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"个人信息"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    [self initData];
}

- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path = @"/app0/personinfo/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.myInfoModel = [CCMyinfoModel modelWithJSON:data];
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
- (CCMyInfoFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[CCMyInfoFooterView alloc] init];
    }
    return _footerView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.accessibilityIdentifier = @"table_view";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        adjustsScrollViewInsets_NO(self.tableView, self);
        _tableView.backgroundColor = UIColorHex(0xf7f7f7);	
    }
    return _tableView;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 0;;
    }
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView removeAllSubviews];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.titleArray[indexPath.row]];
    UIImageView *rightIcon = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view.image = [UIImage imageNamed:@"右箭头灰"];
        view.userInteractionEnabled = YES;
        view.tag = 100+indexPath.row;
        view ;
    });
    [cell.contentView addSubview:rightIcon];
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(cell.contentView).mas_offset(-10);
        make.centerY.mas_equalTo(cell.contentView);
        make.width.mas_equalTo(kWidth(7));
        make.height.mas_equalTo(kWidth(12));
    }];
    if (indexPath.row == 0 && indexPath.section == 0) {
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.frame = CGRectMake(Window_W-54-27, 10, 54, 54);
        [iconImageView setImageWithURL:[NSURL URLWithString:self.myInfoModel.head_photo] placeholder:IMAGE_NAME(@"村村仓logo无底色")];
        iconImageView.layer.masksToBounds = YES;
        iconImageView.layer.cornerRadius = 5;
        iconImageView.tag = 1024;
        [cell.contentView addSubview:iconImageView];
    } else if (indexPath.row == 1 && indexPath.section == 0){
        cell.detailTextLabel.text = self.myInfoModel.name;
        rightIcon.hidden = YES;
    }else if (indexPath.row == 2 && indexPath.section == 0) {
        NSString *mobile = [kUserDefaults objectForKey:@"mobile"];
        if (mobile.length > 0) {
            cell.detailTextLabel.text = mobile;
        } else {
            cell.detailTextLabel.text = @"手机号已绑定";
        }
        rightIcon.hidden = YES;
    } else if(indexPath.row == 3 && indexPath.section == 0){
        rightIcon.hidden = YES;
        if ([self.myInfoModel.lat isNotBlank]) {
            cell.detailTextLabel.text = self.myInfoModel.address;
        } else {
            [self initLocationInfo];
            UIButton *sureBtn = ({
                UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
                [view setTitle:@"点击获取" forState:UIControlStateNormal];
                [view.titleLabel setTextColor:kWhiteColor];
                [view.titleLabel setFont:FONT_14];
                [view setBackgroundColor:krgb(255,157,52)];
                view.layer.masksToBounds = YES;
                view.layer.cornerRadius = YES;
                [view setUserInteractionEnabled:YES];
                 [view addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                view ;
            });
            [cell.contentView addSubview:sureBtn];
            [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(76);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(31);
                make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
            }];
        }
    }
    return cell;
}

- (void)commentBtnClick:(UIButton *)button {

    XYWeakSelf;
    NSDictionary *params = @{
                             @"lat":self.latsss,
                             @"lng":self.longsss,
    };
    NSString *path = @"/app0/changelnglat/";
    [[STHttpResquest sharedManager] requestWithPUTMethod:POST
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            [weakSelf initData];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0 && indexPath.section == 0) {
        return 74;
    }
    return 51;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
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
    if (indexPath.row == 2 && indexPath.section == 0) {
//        CCBangDingMobileViewController *vc = [CCBangDingMobileViewController new];
//        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 0 ){
        XYWeakSelf;
        LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@"" cancelButtonTitle:@"取消" clicked:^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
            NSLog(@"%ld",buttonIndex);
            switch (buttonIndex) {
                case 0:
                    
                    break;
                case 1:
                     [weakSelf presentImageView:1];
                    break;
                case 2:
                     [weakSelf presentImageView:2];
                    break;
                case 3:
                     [weakSelf saveImageMethod];
                    break;
                    
                default:
                    break;
            }
        } otherButtonTitles:@"拍照", @"从手机相册选择", @"保存图片", nil];
        [actionSheet show];
    } else if (indexPath.row == 4) {
        CCAboutListViewController *vc = [[CCAboutListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"头像",@"昵称",@"手机号绑定",@"店铺地址",@"关于村村仓"];
    }
    return _titleArray;
}

-(void)saveImageMethod{
 
    UIImage* image = IMAGE_NAME(@"");
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
//        [MBManager showBriefAlert:@"保存成功"];
    }];

}

- (void)presentImageView:(NSInteger )buttonIndex {
    if (buttonIndex == 1) {
        UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];

        if ([controller isAvailableCamera] && [controller isSupportTakingPhotos]) {
            [controller setDelegate:self];
            [self presentViewController:controller animated:YES completion:nil];
        }else {
            NSLog(@"%s %@", __FUNCTION__, @"相机权限受限");
        }
    } else if(buttonIndex == 2){
        UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [controller setDelegate:self];
        if ([controller isAvailablePhotoLibrary]) {
            [self presentViewController:controller animated:YES completion:nil];
        }
    }
}

#pragma mark - 1.STPhotoKitDelegate的委托

- (void)photoKitController:(STPhotoKitController *)photoKitController resultImage:(UIImage *)resultImage
{
    NSLog(@"image:%@",resultImage);
    NSString *name = [NSString stringWithFormat:@"%@imageCCC",[NSString currentTime]];
    XYWeakSelf;
    [CCTools upImage:resultImage name:name finishBlock:^(NSMutableArray * _Nonnull qualificationFileListArray) {
        [weakSelf changeHeadImage:qualificationFileListArray];
    }];
}

- (void)changeHeadImage:(NSMutableArray *)arr {
    XYWeakSelf;
    NSDictionary *params = @{@"image":arr[0],
    };
    NSString *path = @"/app0/changeheadphoto/";
    [[STHttpResquest sharedManager] requestWithPUTMethod:POST
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [kUserDefaults setObject:arr[0] forKey:headPhots];
                [kNotificationCenter postNotificationName:@"personCenter" object:nil];
            });
            [weakSelf initData];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}
#pragma mark - 2.UIImagePickerController的委托

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *imageOriginal = [info objectForKey:UIImagePickerControllerOriginalImage];
        STPhotoKitController *photoVC = [STPhotoKitController new];
        [photoVC setDelegate:self];
        [photoVC setImageOriginal:imageOriginal];

        [photoVC setSizeClip:CGSizeMake(300,
                                        300)];

        [self presentViewController:photoVC animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//- (void)back {
//    [self dismissViewControllerAnimated:YES completion:^{
//
//    }];
//}


@end
