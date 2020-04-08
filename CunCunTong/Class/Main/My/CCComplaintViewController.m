//
//  CCComplaintViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/8.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCComplaintViewController.h"
#import "PYPhotoBrowser.h"
#import "TZImagePickerController.h"
@interface CCComplaintViewController ()<PYPhotosViewDelegate,TZImagePickerControllerDelegate>
@property (nonatomic, weak) PYPhotosView *publishPhotosView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation CCComplaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"投诉"];
    self.view.backgroundColor = UIColorHex(0xf7f7f7);
    
    [self setupUI];
    XYWeakSelf;
    self.yuanYinView.userInteractionEnabled = YES;
    [self.yuanYinView addTapGestureWithBlock:^(UIView *gestureView) {
        LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@"" cancelButtonTitle:@"取消" clicked:^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
            NSLog(@"%ld",buttonIndex);
            switch (buttonIndex) {
                case 1:
                    weakSelf.yuanYinLab.text = @"假货";
                    break;
                case 2:
                    weakSelf.yuanYinLab.text = @"服务态度";
                    break;
                default:
                    break;
            }
        } otherButtonTitles:@"假货", @"服务态度", nil];
        actionSheet.destructiveButtonColor = kMainColor;
        [actionSheet show];
    }];
    self.orderView.userInteractionEnabled = YES;
    [self.orderView addTapGestureWithBlock:^(UIView *gestureView) {
        
    }];
}

- (void)setupUI {
    
    // 1. 常见一个发布图片时的photosView
    PYPhotosView *publishPhotosView = [PYPhotosView photosView];
    publishPhotosView.photosMaxCol = 4;
    publishPhotosView.x = 12;
    publishPhotosView.y = 10 + 21 + 10;
    publishPhotosView.width = Window_W -24;
    publishPhotosView.photoWidth = ((Window_W - 24) - 24)/4;
    publishPhotosView.photoHeight = ((Window_W - 24) - 24)/4;
    publishPhotosView.photoMargin = 8;
    publishPhotosView.delegate = self;
    publishPhotosView.addImageButtonImage = IMAGE_NAME(@"照片");
    [self.downView addSubview:publishPhotosView];
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



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
