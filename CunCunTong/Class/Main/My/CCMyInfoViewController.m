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
@interface CCMyInfoViewController ()<UITableViewDelegate,UITableViewDataSource,STPhotoKitDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@end

@implementation CCMyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"个人信息"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    self.footerView.frame = CGRectMake(0, 0, Window_W, 300);
    self.tableView.tableFooterView = self.footerView;
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
    }
    return _tableView;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
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
        iconImageView.image = IMAGE_NAME(@"个人信息头像");
        iconImageView.layer.masksToBounds = YES;
        iconImageView.layer.cornerRadius = 5;
        iconImageView.tag = 1024;
        [cell.contentView addSubview:iconImageView];
    } else if (indexPath.row == 1 && indexPath.section == 0){
        for (UIView *view in cell.contentView.subviews) {
            if (view.tag == 100+indexPath.row) {
                [view removeFromSuperview];
            }
        }
        UITextField *titleTextField = [UITextField new];
        titleTextField.font = FONT_16;
        titleTextField.textAlignment = NSTextAlignmentLeft;
        titleTextField.textColor = COLOR_999999;
        [titleTextField setValue:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        titleTextField.userInteractionEnabled = YES;
        [cell.contentView addSubview:titleTextField];
        titleTextField.frame = CGRectMake(Window_W-94-15, 10, 94, 30);
//        titleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//        titleTextField.delegate = self;
        titleTextField.tag = 100+indexPath.row;
        NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:@"请输入昵称"];
        [textColor addAttribute:NSForegroundColorAttributeName
                          value:COLOR_999999
                          range:[@"请输入昵称" rangeOfString:@"请输入昵称"]];
        titleTextField.attributedPlaceholder = textColor;
    } else if (indexPath.row == 2 && indexPath.section == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(94), 10, Window_W-kWidth(94)-27, 30)];
        label.textColor = COLOR_999999;
        label.font = FONT_16;
        label.text = @"更换微信";
        label.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:label];
        label.tag = 110+indexPath.row;
    }else if (indexPath.row == 3 && indexPath.section == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(94), 10, Window_W-kWidth(94)-27, 30)];
        label.textColor = COLOR_999999;
        label.font = FONT_16;
        label.text = @"更换手机号";
        label.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:label];
        label.tag = 110+indexPath.row;
    }
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0 && indexPath.section == 0) {
        return 74;
    }
    return 51;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 46.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = UIColorHex(0xf7f7f7);
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = FONT_16;
    label.frame = CGRectMake(10, 10, 200, 26);
    if (section == 1) {
        label.text = @"资质上传";
    } else {
        label.text = @"基本信息";
    }

    [view addSubview:label];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3 && indexPath.section == 0) {
        CCBangDingMobileViewController *vc = [CCBangDingMobileViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2 && indexPath.section == 0) {//更换微信

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
    }
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"头像",@"昵称",@"微信已绑定",@"手机号已绑定"];
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

- (void)back {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
