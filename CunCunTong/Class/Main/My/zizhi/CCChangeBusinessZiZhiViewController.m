//
//  CCChangeBusinessZiZhiViewController.m
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCChangeBusinessZiZhiViewController.h"
#import "PYPhotosView.h"
#import "TZImagePickerController.h"
@interface CCChangeBusinessZiZhiViewController ()<PYPhotosViewDelegate,TZImagePickerControllerDelegate>
@property (nonatomic,strong) UIButton *sendBtn;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (nonatomic,strong) PYPhotosView *publishPhotosView;
@property (nonatomic,copy) NSString *prodroutId;
@property (strong, nonatomic) NSMutableArray *relsutArray;
@property (nonatomic,copy) NSString *prodroutName;

@end

@implementation CCChangeBusinessZiZhiViewController
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
    if (self.navTitleString.length >0) {
        [self customNavBarWithTitle:self.navTitleString];
    } else {
        [self customNavBarWithTitle:@"新增营业资质"];
    }
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
        view.text = @"请填写资质名称：";
        view ;

    });
    [self.view addSubview:nameLab];
    [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(125, 14));
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT+15);
    }];
    UIView *line = [[UIView alloc] init];
    [self.view addSubview:line];
    line.backgroundColor = UIColorHex(0xf7f7f7);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(nameLab.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(10);
    }];
    UITextField *titleTextField = [UITextField new];
    titleTextField.font = FONT_14;
    titleTextField.textAlignment = NSTextAlignmentRight;
    titleTextField.textColor = COLOR_999999;
    titleTextField.userInteractionEnabled = YES;
    [self.view addSubview:titleTextField];
    [titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab.mas_right);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.centerY.mas_equalTo(nameLab);
    }];
    titleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    titleTextField.delegate = self;
    [titleTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    titleTextField.tag = 100;
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:@"资质名称"];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:COLOR_999999
                      range:[@"资质名称" rangeOfString:@"资质名称"]];
    titleTextField.attributedPlaceholder = textColor;
    
    UILabel *addressLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(13);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.numberOfLines = 1;
        view.text = @"请添加资质图片：";
        view ;
    });
    [self.view addSubview:addressLab];
    [addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(247, 14));
        make.top.mas_equalTo(nameLab.mas_bottom).mas_offset(35);
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
        titleTextField.text = self.myModel.name;
        self.prodroutName = self.myModel.name;
        NSMutableArray *arr = [NSMutableArray array];
        for (Supplierqualifyphoto_setItem *model in self.myModel.marketqualifyphoto_set) {
            [arr addObject:model.image];
        }
        self.publishPhotosView.thumbnailUrls = arr;
        self.publishPhotosView.photosState = PYPhotosViewStateWillCompose;
        [self.publishPhotosView reloadDataWithImages:arr];
        self.relsutArray = arr.mutableCopy;
    }
    if (_prodroutId.length >0 && self.relsutArray.count) {
        [self.sendBtn setBackgroundColor:kMainColor];
        [self.sendBtn setUserInteractionEnabled: YES];
    } else {
        [self.sendBtn setBackgroundColor:kGrayCustomColor];
        [self.sendBtn setUserInteractionEnabled: NO];
    }
}
- (void)textFieldChange:(UITextField *)field {
    self.prodroutName = field.text;
    if (_prodroutName.length >0 && self.relsutArray.count) {
        [self.sendBtn setBackgroundColor:kMainColor];
        [self.sendBtn setUserInteractionEnabled: YES];
    } else {
        [self.sendBtn setBackgroundColor:kGrayCustomColor];
        [self.sendBtn setUserInteractionEnabled: NO];
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
        if (_prodroutId.length >0 && self.relsutArray.count) {
            [self.sendBtn setBackgroundColor:kMainColor];
            [self.sendBtn setUserInteractionEnabled: YES];
        } else {
            [self.sendBtn setBackgroundColor:kGrayCustomColor];
            [self.sendBtn setUserInteractionEnabled: NO];
        }
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
            if (_prodroutName.length >0 && self.relsutArray.count) {
                [self.sendBtn setBackgroundColor:kMainColor];
                [self.sendBtn setUserInteractionEnabled: YES];
            } else {
                [self.sendBtn setBackgroundColor:kGrayCustomColor];
                [self.sendBtn setUserInteractionEnabled: NO];
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
- (void)BtnClicked:(UIButton *)button {
    if (self.myModel) {
        XYWeakSelf;
        NSDictionary *params = @{@"photo_set":self.relsutArray,
                                 @"name":self.prodroutName
        };
        NSString *path = [NSString stringWithFormat:@"/app0/qualify/%@/",self.prodroutId];
        [[STHttpResquest sharedManager] requestWithPUTMethod:PUT
                                                    WithPath:path
                                                  WithParams:params
                                            WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBManager showBriefAlert:@"提交成功"];
                [kNotificationCenter postNotificationName:@"initData" object:nil];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        } WithFailurBlock:^(NSError * _Nonnull error) {
            
        }];
    } else {
        XYWeakSelf;
        NSDictionary *params = @{@"name":checkNull(self.prodroutName),
                                 @"photo_set":self.relsutArray,
        };
        NSString *path = @"/app1/qualify/";
        [[STHttpResquest sharedManager] requestWithPUTMethod:POST
                                                    WithPath:path
                                                  WithParams:params
                                            WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBManager showBriefAlert:@"提交成功"];
                [kNotificationCenter postNotificationName:@"initData" object:nil];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        } WithFailurBlock:^(NSError * _Nonnull error) {
            
        }];
    }
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
