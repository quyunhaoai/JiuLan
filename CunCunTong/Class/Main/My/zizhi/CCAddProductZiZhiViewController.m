//
//  CCAddProductZiZhiViewController.m
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCAddProductZiZhiViewController.h"
#import "PYPhotosView.h"
#import "TZImagePickerController.h"
#import "CCSelectPinPaViewController.h"
@interface CCAddProductZiZhiViewController ()<PYPhotosViewDelegate,TZImagePickerControllerDelegate>
@property (nonatomic,strong) UIButton *sendBtn;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (nonatomic,strong) PYPhotosView *publishPhotosView;
@property (nonatomic,copy) NSString *prodroutId;
@property (strong, nonatomic) NSMutableArray *relsutArray;


@end

@implementation CCAddProductZiZhiViewController
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
    [self customNavBarWithTitle:@"产品资质"];
    [self setupUI];
}

- (void)setupUI {
    UILabel *nameLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(15);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"请填写商品名称：";
        view ;
    });
    [self.view addSubview:nameLab];
    [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(125, 14));
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT+30);
    }];
    UILabel *mobleNumberLab = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_999999;
        view.font = STFont(14);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentRight;
        view.text = @"商品名称";
        view.userInteractionEnabled = YES;
        view ;
    });
    [self.view addSubview:mobleNumberLab];
    [mobleNumberLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(117, 14));
        make.centerY.mas_equalTo(nameLab).mas_offset(0);
    }];
    XYWeakSelf;
    [mobleNumberLab addTapGestureWithBlock:^(UIView *gestureView) {
        UILabel *lable = (UILabel *)gestureView;
        CCSelectPinPaViewController *vc = [CCSelectPinPaViewController new];
        vc.clickCatedity = ^(NSString * _Nonnull name, NSInteger prodroutId) {
            lable.text = name;
            weakSelf.prodroutId = STRING_FROM_INTAGER(prodroutId);
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    UILabel *addressLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(13);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.numberOfLines = 1;
        view.text = @"请添加商品资质图片：";
        view ;
    });
    [self.view addSubview:addressLab];
    [addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(247, 14));
        make.top.mas_equalTo(nameLab.mas_bottom).mas_offset(25);
    }];
    
    [self.view addSubview:self.sendBtn];
    [self.sendBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.right.bottom.mas_equalTo(self.view).mas_offset(-10);
        make.height.mas_equalTo(46);
    }];
    // 1. 常见一个发布图片时的photosView
    PYPhotosView *publishPhotosView = [PYPhotosView photosView];
    publishPhotosView.photosMaxCol = 4;
    publishPhotosView.x = 12;
    publishPhotosView.y =NAVIGATION_BAR_HEIGHT+ 30 + 25 + 14 +25;
    publishPhotosView.width = Window_W -24;
    publishPhotosView.photoWidth = ((Window_W - 24) - 24)/4;
    publishPhotosView.photoHeight = ((Window_W - 24) - 24)/4;
    publishPhotosView.photoMargin = 8;
    publishPhotosView.delegate = self;
    publishPhotosView.addImageButtonImage = IMAGE_NAME(@"照片");
    [self.view addSubview:publishPhotosView];
    self.publishPhotosView = publishPhotosView;
    if (self.myModel) {
        self.prodroutId = STRING_FROM_INTAGER(self.myModel.ccid);
        mobleNumberLab.text = self.myModel.center_goods_name;
        NSMutableArray *arr = [NSMutableArray array];
        for (Centergoodsqualifyphoto_setItem *model in self.myModel.centergoodsqualifyphoto_set) {
            if (arr.count >2) {
                break;
            }
            [arr addObject:model.image];
        }
        self.publishPhotosView.thumbnailUrls = arr;
        self.publishPhotosView.photosState = PYPhotosViewStateWillCompose;
        [self.publishPhotosView reloadDataWithImages:arr];
        self.relsutArray = arr.mutableCopy;
    }
    
}
#pragma mark  -  PYdelegate
/**
 * 删除图片按钮触发时调用此方法
 * imageIndex : 删除的图片在之前图片数组的位置
 */
- (void)photosView:(PYPhotosView *)photosView didDeleteImageIndex:(NSInteger)imageIndex {
    if (self.myModel) {
        [self.relsutArray removeObjectAtIndex:imageIndex];
    } else {
        [self.imageArray removeObjectAtIndex:imageIndex];
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
            if (self.myModel) {
                [weakSelf.imageArray addObjectsFromArray:self.relsutArray];
            }
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
            view.backgroundColor = kMainColor;
            [view setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [view setTitle:@"提交" forState:UIControlStateNormal];
            [view.titleLabel setFont:FONT_18];
            view.tag = 3;
            [view addTarget:self action:@selector(BtnClicked:)
           forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
    }
    return _sendBtn;
}
- (void)BtnClicked:(UIButton *)button {
    if (self.myModel) {
        NSDictionary *params = @{@"photo_set":self.relsutArray,
        };
        NSString *path = [NSString stringWithFormat:@"/app0/qualify/%@/",self.prodroutId];
        [[STHttpResquest sharedManager] requestWithPUTMethod:PUT
                                                    WithPath:path
                                                  WithParams:params
                                            WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            
        } WithFailurBlock:^(NSError * _Nonnull error) {
            
        }];
    } else {
        NSDictionary *params = @{@"name":checkNull(self.prodroutId),
                                 @"photo_set":self.relsutArray,
        };
        NSString *path = @"/app0/qualify/";
        [[STHttpResquest sharedManager] requestWithPUTMethod:POST
                                                    WithPath:path
                                                  WithParams:params
                                            WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            
        } WithFailurBlock:^(NSError * _Nonnull error) {
            
        }];
    }
}

@end
