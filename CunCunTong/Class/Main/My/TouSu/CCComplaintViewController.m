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
#import "CCOrderSelectViewController.h"
@interface CCComplaintViewController ()<PYPhotosViewDelegate,TZImagePickerControllerDelegate,UITextViewDelegate>
@property (nonatomic, weak) PYPhotosView *publishPhotosView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (strong, nonatomic) NSArray *dataArray;
@property (nonatomic,copy) NSString *name_id;
@property (nonatomic,copy) NSString *info;
@property (strong, nonatomic) NSMutableArray *m_child_order_setArray;
@property (strong, nonatomic) NSMutableArray *photsArray;
@property (weak, nonatomic) IBOutlet UITextView *infoTextview;
@property (nonatomic,copy) NSString *infoString;  //

@end

@implementation CCComplaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"投诉"];
    self.infoString = @"";
    self.view.backgroundColor = UIColorHex(0xf7f7f7);
    [self.sendBtn setUserInteractionEnabled:NO];
    [self.sendBtn setBackgroundColor:kGrayCustomColor];
    [self setupUI];
    XYWeakSelf;
    self.yuanYinView.userInteractionEnabled = YES;
    [self.yuanYinView addTapGestureWithBlock:^(UIView *gestureView) {
        LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@"" cancelButtonTitle:@"取消" clicked:^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
            NSLog(@"%ld",buttonIndex);
            switch (buttonIndex) {
                case 1:{
                    weakSelf.yuanYinLab.text = self.dataArray[0][@"name"];
                    weakSelf.name_id =[NSString stringWithFormat:@"%d",[self.dataArray[0][@"id"] intValue]];
                    if ([self.name_id isNotBlank] && self.photsArray.count && self.m_child_order_setArray.count) {
                        [self.sendBtn setUserInteractionEnabled:YES];
                        [self.sendBtn setBackgroundColor:kMainColor];
                    } else {
                        [self.sendBtn setUserInteractionEnabled:NO];
                        [self.sendBtn setBackgroundColor:kGrayCustomColor];
                    }
                }
                    break;
                case 2:{
                    weakSelf.yuanYinLab.text = self.dataArray[1][@"name"];
                    weakSelf.name_id =[NSString stringWithFormat:@"%d",[self.dataArray[1][@"id"] intValue]];
                    if ([self.name_id isNotBlank] && self.photsArray.count && self.m_child_order_setArray.count) {
                        [self.sendBtn setUserInteractionEnabled:YES];
                        [self.sendBtn setBackgroundColor:kMainColor];
                    } else {
                        [self.sendBtn setUserInteractionEnabled:NO];
                        [self.sendBtn setBackgroundColor:kGrayCustomColor];
                    }
                }

                    break;
                default:
                    break;
            }
        } otherButtonTitles:self.dataArray[0][@"name"], self.dataArray[1][@"name"], nil];
        actionSheet.destructiveButtonColor = kMainColor;
        [actionSheet show];
    }];
    self.orderView.userInteractionEnabled = YES;
    [self.orderView addTapGestureWithBlock:^(UIView *gestureView) {
        CCOrderSelectViewController *vc = [CCOrderSelectViewController new];
        vc.blackAction = ^(NSMutableArray * _Nonnull arr) {
            weakSelf.m_child_order_setArray = arr.mutableCopy;
            weakSelf.selectOrderLab.text =[NSString stringWithFormat:@"%d",[arr[0] intValue]];
            if ([self.name_id isNotBlank] && self.photsArray.count && self.m_child_order_setArray.count) {
                [self.sendBtn setUserInteractionEnabled:YES];
                [self.sendBtn setBackgroundColor:kMainColor];
            } else {
                [self.sendBtn setUserInteractionEnabled:NO];
                [self.sendBtn setBackgroundColor:kGrayCustomColor];
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self initData];
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path = @"/app0/keydneedname/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSArray *data = dic[@"data"];
            weakSelf.dataArray = data.copy;
            if (weakSelf.dataArray.count) {
                
            } else {
                
            }
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
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
    self.detailTextView.delegate = self;
}
#pragma mark  -  TextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.placelab.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
//    textView.text = @"";
//    self.placelab.hidden = NO;
}

- (void)textViewDidChange:(UITextView *)textView{
    self.infoString = textView.text;
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
            NSString *name = [NSString stringWithFormat:@"%@conplain_image",[NSString currentTime]];
            [CCTools uploadTokenMultiple:weakSelf.imageArray namespaceString:name finishBlock:^(NSMutableArray * _Nonnull qualificationFileListArray) {
                weakSelf.photsArray = qualificationFileListArray.mutableCopy;
                if ([self.name_id isNotBlank] && self.photsArray.count && self.m_child_order_setArray.count) {
                    [self.sendBtn setUserInteractionEnabled:YES];
                    [self.sendBtn setBackgroundColor:kMainColor];
                } else {
                    [self.sendBtn setUserInteractionEnabled:NO];
                    [self.sendBtn setBackgroundColor:kGrayCustomColor];
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


- (IBAction)sendContent:(UIButton *)sender {
    XYWeakSelf;
    NSDictionary *params = @{@"name_id":self.name_id,
                             @"info":self.infoString,
                             @"m_child_order_set":self.m_child_order_setArray,
                             @"photo_set":self.photsArray,
    };
    NSString *path = @"/app0/conplain/";
    [[STHttpResquest sharedManager] requestWithPUTMethod:POST
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [kNotificationCenter postNotificationName:@"initData1" object:nil];
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
