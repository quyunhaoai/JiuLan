//
//  CCNeedViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCNeedViewController.h"
#import "PYPhotoBrowser.h"
#import "TZImagePickerController.h"
@interface CCNeedViewController ()<PYPhotosViewDelegate,TZImagePickerControllerDelegate>
@property (nonatomic, weak) PYPhotosView *publishPhotosView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *smountTextfield;
@property (weak, nonatomic) IBOutlet UITextField *infoTextField;
@property (strong, nonatomic) NSMutableArray *photosArray;
@property (nonatomic,copy) NSString *goodsname;  //
@property (nonatomic,copy) NSString *goodsCount;  //
@property (nonatomic,copy) NSString *goodsDetail;  //
@end

@implementation CCNeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"需求上报"];
    [self.photosBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleTop
                                    imageTitleSpace:10];
    [self setupUI];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)setupUI {
    
    // 1. 常见一个发布图片时的photosView
    PYPhotosView *publishPhotosView = [PYPhotosView photosView];
    publishPhotosView.photosMaxCol = 4;
    publishPhotosView.x = 12;
    publishPhotosView.y = self.photosBtn.y;
    publishPhotosView.width = Window_W -24;
    publishPhotosView.photoWidth = ((Window_W - 24) - 24)/4;
    publishPhotosView.photoHeight = ((Window_W - 24) - 24)/4;
    publishPhotosView.photoMargin = 3;
    publishPhotosView.delegate = self;
    publishPhotosView.addImageButtonImage = IMAGE_NAME(@"照片");
    [self.view addSubview:publishPhotosView];
    self.publishPhotosView = publishPhotosView;
    if (self.photosArray.count && [self.goodsDetail isNotBlank] && [self.goodsCount isNotBlank] && [self.goodsname isNotBlank]) {
        self.sendBtn.userInteractionEnabled = YES;
        [self.sendBtn setBackgroundColor:kMainColor];
    } else {
        self.sendBtn.userInteractionEnabled = NO;
        [self.sendBtn setBackgroundColor:kGrayCustomColor];
    }
}
- (IBAction)textChanged:(UITextField *)sender {
    if (sender.tag == 1) {
        self.goodsname = sender.text;
        if (self.photosArray.count && [self.goodsDetail isNotBlank] && [self.goodsCount isNotBlank] && [self.goodsname isNotBlank]) {
            self.sendBtn.userInteractionEnabled = YES;
            [self.sendBtn setBackgroundColor:kMainColor];
        } else {
            self.sendBtn.userInteractionEnabled = NO;
            [self.sendBtn setBackgroundColor:kGrayCustomColor];
        }
    } else if(sender.tag ==2 ){
        self.goodsCount = sender.text;
        if (self.photosArray.count && [self.goodsDetail isNotBlank] && [self.goodsCount isNotBlank] && [self.goodsname isNotBlank]) {
            self.sendBtn.userInteractionEnabled = YES;
            [self.sendBtn setBackgroundColor:kMainColor];
        } else {
            self.sendBtn.userInteractionEnabled = NO;
            [self.sendBtn setBackgroundColor:kGrayCustomColor];
        }
    } else if(sender.tag == 3){
        self.goodsDetail = sender.text;
        if (self.photosArray.count && [self.goodsDetail isNotBlank] && [self.goodsCount isNotBlank] && [self.goodsname isNotBlank]) {
            self.sendBtn.userInteractionEnabled = YES;
            [self.sendBtn setBackgroundColor:kMainColor];
        } else {
            self.sendBtn.userInteractionEnabled = NO;
            [self.sendBtn setBackgroundColor:kGrayCustomColor];
        }
    }
}

- (IBAction)sendMethod:(UIButton *)sender {
    XYWeakSelf;
    NSDictionary *params = @{@"name":checkNull(self.nameTextField.text),
                             @"amount":checkNull(self.smountTextfield.text),
                             @"info":checkNull(self.infoTextField.text),
                             @"photo_set":self.photosArray,
    };
    NSString *path = @"/app0/need/";
    [[STHttpResquest sharedManager] requestWithPUTMethod:POST
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            dispatch_async(dispatch_get_main_queue(), ^{
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
#pragma mark  -  PYdelegate
- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:(8-self.imageArray.count) delegate:self];
    imagePickerVc.maxImagesCount = 3;
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
            NSString *name = [NSString stringWithFormat:@"%@imageccc",[NSString currentTime]];
            [CCTools uploadTokenMultiple:weakSelf.imageArray
                         namespaceString:name percentLabel:[UILabel new]
                            cancleButton:[UIButton new]
                             finishBlock:^(NSMutableArray * _Nonnull qualificationFileListArray) {
                weakSelf.photosArray = qualificationFileListArray.mutableCopy;
                if (weakSelf.photosArray.count && [self.goodsDetail isNotBlank] && [self.goodsCount isNotBlank] && [self.goodsname isNotBlank]) {
                    weakSelf.sendBtn.userInteractionEnabled = YES;
                    [weakSelf.sendBtn setBackgroundColor:kMainColor];
                } else {
                    weakSelf.sendBtn.userInteractionEnabled = NO;
                    [weakSelf.sendBtn setBackgroundColor:kGrayCustomColor];
                }
            }];
        });
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
- (NSMutableArray *)photosArray {
    if (!_photosArray) {
        _photosArray = [[NSMutableArray alloc] init];
    }
    return _photosArray;
}




@end
