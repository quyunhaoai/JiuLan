//
//  CCMyInfoFooterView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"

#import <Photos/Photos.h>
#import "STPhotoKitController.h"
#import "UIImagePickerController+ST.h"
#import "STConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCMyInfoFooterView : CCBaseView<UIImagePickerControllerDelegate,UINavigationControllerDelegate,STPhotoKitDelegate>
@property (nonatomic,strong) UIButton *sendBtn;  
@end

NS_ASSUME_NONNULL_END
