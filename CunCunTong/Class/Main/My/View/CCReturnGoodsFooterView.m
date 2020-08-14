//
//  CCReturnGoodsFooterView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCReturnGoodsFooterView.h"

#import "PYPhotoBrowser.h"
#import "TZImagePickerController.h"
@interface CCReturnGoodsFooterView ()<PYPhotosViewDelegate,TZImagePickerControllerDelegate>
@property (nonatomic, weak) PYPhotosView *publishPhotosView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@end
@implementation CCReturnGoodsFooterView


- (void)setupUI {
    self.backgroundColor = kWhiteColor;
    UILabel *taRendaiFusumTextLab2 = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(15);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.numberOfLines =0;
        view ;
    });
    [self addSubview:taRendaiFusumTextLab2];
    [taRendaiFusumTextLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(Window_W-20, 44));
        make.top.mas_equalTo(self).mas_offset(10);
    }];
    //0-00
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"请在此上传凭证\n(必须包含一张带生产日期的照片，最多8张）"];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f
                                                                                        green:51.0f/255.0f
                                                                                         blue:51.0f/255.0f
                                                                                        alpha:1.0f] range:NSMakeRange(0, 7)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153.0f/255.0f
                                                                                        green:153.0f/255.0f
                                                                                         blue:153.0f/255.0f
                                                                                        alpha:1.0f] range:NSMakeRange(7, 22)];
    taRendaiFusumTextLab2.attributedText = attributedString;
    
    // 1. 常见一个发布图片时的photosView
    PYPhotosView *publishPhotosView = [PYPhotosView photosView];
    publishPhotosView.photosMaxCol = 4;
    publishPhotosView.x = 12;
    publishPhotosView.y = 65;
    publishPhotosView.width = Window_W -24;
    publishPhotosView.photoWidth = ((Window_W - 24) - 24)/4;
    publishPhotosView.photoHeight = ((Window_W - 24) - 24)/4;
    publishPhotosView.photoMargin = 8;
    publishPhotosView.delegate = self;
    publishPhotosView.addImageButtonImage = IMAGE_NAME(@"照片");
    [self addSubview:publishPhotosView];
    self.publishPhotosView = publishPhotosView;
    [self addSubview:self.sendBtn];
    [self.sendBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.right.bottom.mas_equalTo(self).mas_offset(-10);
        make.height.mas_equalTo(46);
    }];
    
}
#pragma mark  -  PYdelegate
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
            //上传图片
            NSString *name=[NSString stringWithFormat:@"%.0f_Image_",DATE_NOW_SINCE1970];
        
            [CCTools uploadTokenMultiple:weakSelf.imageArray namespaceString:name percentLabel:[UILabel new] cancleButton:[UIButton new] finishBlock:^(NSMutableArray * _Nonnull qualificationFileListArray) {
                NSLog(@"得到签名照的图片URL %@%@",qualificationFileListArray,[qualificationFileListArray lastObject]);
                weakSelf.photoArray = qualificationFileListArray.mutableCopy;
                if (weakSelf.blackBlock) {
                    weakSelf.blackBlock(weakSelf.photoArray);
                }
            }];
        });
    }];
    [self.viewController presentViewController:imagePickerVc animated:YES completion:nil];
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
            view.backgroundColor = kMainColor;
            [view setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [view setTitle:@"提交" forState:UIControlStateNormal];
            [view.titleLabel setFont:FONT_18];
            [view setBackgroundColor:kGrayCustomColor];
            [view setUserInteractionEnabled:NO];
            view.tag = 3;
            [view addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
    }
    return _sendBtn;
}
- (void)BtnClicked:(UIButton *)button {
    
}

@end
