//
//  CCBottomShareAlertContentView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBottomShareAlertContentView.h"
#import "ImageTitleButton.h"
#import "KKThirdTools.h"
#import "CCShareOutView.h"
@implementation CCBottomShareAlertContentView


- (void)setupUI {

    self.backgroundColor = krgb(241,241,241);
    NSArray *arr = @[@"微信",@"朋友圈",@"QQ"];
    NSArray *aaa = @[@"微信logo",@"朋友圈logo",@"QQlogo"];
    NSMutableArray *tolAry = [NSMutableArray new];
    for (int i = 0; i <arr.count; i ++) {
        ImageTitleButton *button = [[ImageTitleButton alloc] initWithStyle:EImageTopTitleBottom maggin:UIEdgeInsetsMake(30, 0, 0, 0) padding:CGSizeMake(0, 50)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:FONT_12];
        [button setTitleColor:krgb(51, 51, 51) forState:UIControlStateNormal];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button setImage:IMAGE_NAME(aaa[i]) forState:UIControlStateNormal];
        [button setTag:i];
        [button addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [tolAry addObject:button];
    }
    [tolAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:30 tailSpacing:166];
    [tolAry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@66).mas_offset(15);
        make.height.equalTo(@54);
    }];

    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    line.frame = CGRectMake(0, self.height-54, Window_W, 5);
    line.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.backgroundColor = krgb(255,157,52);
    rightBtn.tag = 12;
    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rightBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.backgroundColor = kWhiteColor;
    [self addSubview:rightBtn];
    rightBtn.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 49, CGRectGetWidth(self.frame), 49);
}

- (void)botBtnClick:(UIButton *)button {
    if (button.tag == 0 || button.tag == 1) {//微信
        NKAlertView *alertView = [[NKAlertView alloc] init];
       NSString *url = self.model.goodsimage_set[0];
       url = [[CCTools sharedInstance] IsChinese:url];
       [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:url]
                                                             options:SDWebImageDownloaderUseNSURLCache
                                                            progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {

        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            //这边就能拿到图片了
            [CCTools srh_saveImage:image completionHandle:^(NSError * _Nonnull aaa, NSString * _Nonnull bbb) {
                if (bbb.length > 0) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        CCShareOutView *customContentView = [[CCShareOutView alloc] initWithFrame:CGRectMake(0, 0, Window_W-40,kHeight(554))];
                        customContentView.goodsImage.image = image;
                        if (button.tag == 1) {
                           [customContentView.bottomBtn setTitle:@"去微信朋友圈分享" forState:UIControlStateNormal];
                        } else {
                           [customContentView.bottomBtn setTitle:@"去微信分享给好友" forState:UIControlStateNormal];
                        }
                        alertView.type = NKAlertViewTypeDef;
                        alertView.contentView = customContentView;
                        alertView.hiddenWhenTapBG = YES;
                        [alertView show];
                    });
                }
            }];
        }];
    } else if (button.tag == 2){//QQ
        NKAlertView *alertView = [[NKAlertView alloc] init];
        NSString *url = self.model.goodsimage_set[0];
        url = [[CCTools sharedInstance] IsChinese:url];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:url]
                                                              options:SDWebImageDownloaderUseNSURLCache
                                                             progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {

         } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
             //这边就能拿到图片了
             [CCTools srh_saveImage:image completionHandle:^(NSError * _Nonnull aaa, NSString * _Nonnull bbb) {
                 if (bbb.length > 0) {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         CCShareOutView *customContentView = [[CCShareOutView alloc] initWithFrame:CGRectMake(0, 0, Window_W-40, kHeight(554))];
                         customContentView.goodsImage.image = image;
                         [customContentView.bottomBtn setTitle:@"去QQ分享" forState:UIControlStateNormal];
                         alertView.type = NKAlertViewTypeDef;
                         alertView.contentView = customContentView;
                         alertView.hiddenWhenTapBG = YES;
                         [alertView show];
                     });
                 }
             }];
         }];
    } else {
         NKAlertView *alertView = (NKAlertView *)self.superview;
         [alertView hide];
    }
    
}

/*
- (void)ccc {
    KKShareObject *obj = [[KKShareObject alloc] init];
    obj.shareType = KKShareContentTypeImage;
//    obj.shareContent = @"test";
//    obj.title = @"title";
//    obj.desc = @"desc";
//    obj.linkUrl = @"http://www.baidu.com";
    NSString *url = self.model.goodsimage_set[0];
    url = [[CCTools sharedInstance] IsChinese:url];
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:url]
                                                          options:SDWebImageDownloaderUseNSURLCache
                                                         progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {

     } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
         //这边就能拿到图片了
         obj.shareImage = image;
         obj.thumbImage = image;
         if (button.tag == 0 || button.tag == 1) {//微信
             NKAlertView *alertView = [[NKAlertView alloc] init];
             CCShareOutView *customContentView = [[CCShareOutView alloc] initWithFrame:CGRectMake(0, 0, Window_W-40,kHeight(554))];
             customContentView.goodsImage.image = image;
             if (button.tag == 1) {
                [customContentView.bottomBtn setTitle:@"去微信朋友圈分享" forState:UIControlStateNormal];
             } else {
                [customContentView.bottomBtn setTitle:@"去微信分享给好友" forState:UIControlStateNormal];
             }
             alertView.type = NKAlertViewTypeDef;
             alertView.contentView = customContentView;
             alertView.hiddenWhenTapBG = YES;
             [alertView show];
         } else if (button.tag == 2){//QQ
             NKAlertView *alertView = [[NKAlertView alloc] init];
             CCShareOutView *customContentView = [[CCShareOutView alloc] initWithFrame:CGRectMake(0, 0, Window_W-40, kHeight(554))];
             customContentView.goodsImage.image = image;
             [customContentView.bottomBtn setTitle:@"去QQ分享" forState:UIControlStateNormal];
             alertView.type = NKAlertViewTypeDef;
             alertView.contentView = customContentView;
             alertView.hiddenWhenTapBG = YES;
             [alertView show];
         } else {
              NKAlertView *alertView = (NKAlertView *)self.superview;
              [alertView hide];
         }
//         if (button.tag == 0) {
//             [KKThirdTools shareToWXWithObject:obj scene:0 complete:^(KKErrorCode resultCode, NSString *resultString) {
//
//             }];
//         } else if (button.tag == 1){
//             [KKThirdTools shareToWXWithObject:obj scene:1 complete:^(KKErrorCode resultCode, NSString *resultString) {
//
//             }];
//         } else {
//             [KKThirdTools shareToQQWithObject:obj scene:KKQQSceneTypeFriend complete:^(KKErrorCode resultCode, NSString *resultString) {
//
//             }];
//         }
//         NKAlertView *alertView = (NKAlertView *)self.superview;
//         [alertView hide];
    }];

}
*/
@end
