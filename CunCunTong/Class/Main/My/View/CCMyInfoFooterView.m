//
//  CCMyInfoFooterView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCMyInfoFooterView.h"
#import "ImageTitleButton.h"

@implementation CCMyInfoFooterView


- (void)setupUI {
    self.backgroundColor = UIColorHex(0xf7f7f7);
    
    
    NSArray * arrayTitle = @[@"门店照片",@"营业执照",@"食品流通许可证",@"健康证"];
    NSArray * arrayImage = @[@"门店图标",@"营业执照图标",@"营业执照图标",@"营业执照图标"];
    int SPNum = 2;//水平一行放几个
    CGFloat JGGMinX = kWidth(10);//起始x值
    CGFloat JGGMinY = 2;//起始y值
    CGFloat SPspace = kWidth(10);//水平距离
    CGFloat CXspace = kHeight(15);//垂直距离
    CGFloat widthJGG = (Window_W- JGGMinX * 2 -SPspace * (SPNum-1)) / SPNum ;//九宫格宽
    CGFloat heightJGG = 101;//九宫格高
    for ( int  i = 0; i < arrayTitle.count ; i++) {
        //图片
        ImageTitleButton * buttonBig = [[ImageTitleButton alloc] initWithStyle:EImageTopTitleBottom maggin:UIEdgeInsetsMake(20, 0, 0, 0) padding:CGSizeMake(0, 8)];;
        buttonBig.imageView.contentMode = UIViewContentModeScaleAspectFill;
        buttonBig.clipsToBounds = YES;
        buttonBig.layer.cornerRadius = 10;
        [buttonBig setImage:[UIImage imageNamed:arrayImage[i]] forState:UIControlStateNormal];
        [buttonBig setTitle:arrayTitle[i] forState:UIControlStateNormal];
        [buttonBig setTitleColor:COLOR_333333 forState:UIControlStateNormal];
        buttonBig.titleLabel.font = [UIFont systemFontOfSize:14];
        [buttonBig setBackgroundColor:kWhiteColor];
        [buttonBig addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        buttonBig.tag = 1000+i;
        buttonBig.adjustsImageWhenHighlighted = NO;
        buttonBig.style = EImageTopTitleBottom;
        
        [self addSubview:buttonBig];
        [buttonBig mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(JGGMinX + i % SPNum * (widthJGG + SPspace));
            make.top.mas_equalTo(JGGMinY + i / SPNum * (heightJGG + CXspace));
            make.width.mas_equalTo(widthJGG);
            make.height.mas_equalTo(heightJGG);
            //不能再这里跟新约束，否则会警告,控件错位
        }];
    }

    [self addSubview:self.sendBtn];
    [self.sendBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.right.bottom.mas_equalTo(self).mas_offset(-10);
        make.height.mas_equalTo(46);
    }];
    
}

- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 5;
            view.backgroundColor = kMainColor;
            [view setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [view setTitle:@"提交" forState:UIControlStateNormal];
            [view.titleLabel setFont:FONT_18];
            view.tag = 3;
            [view addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
    }
    return _sendBtn;
}
- (void)BtnClicked:(UIButton *)btn {
    if (btn.tag >=1000) {
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
    } else {
        [self.viewController dismissViewControllerAnimated:YES completion:nil];
    }
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
            [self.viewController presentViewController:controller animated:YES completion:nil];
        }else {
            NSLog(@"%s %@", __FUNCTION__, @"相机权限受限");
        }
    } else if(buttonIndex == 2){
        UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [controller setDelegate:self];
        if ([controller isAvailablePhotoLibrary]) {
            [self.viewController presentViewController:controller animated:YES completion:nil];
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

        [self.viewController presentViewController:photoVC animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}


@end
/*
SPAlertController *alert = [SPAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:SPAlertControllerStyleActionSheet];

SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"Default" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {}];
SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"Destructive" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {}];
SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"Cancel" style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {}];

[alert addAction:action1];
[alert addAction:action2];
[alert addAction:action3];
[self.superview.viewController presentViewController: alert animated:YES completion:^{}];*/
