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
@end

@implementation CCNeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"需求上报"];
    [self.photosBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleTop imageTitleSpace:10];
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
    publishPhotosView.photoMargin = 8;
    publishPhotosView.delegate = self;
    publishPhotosView.addImageButtonImage = IMAGE_NAME(@"照片");
    [self.view addSubview:publishPhotosView];
    self.publishPhotosView = publishPhotosView;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
