//
//  CCModityAddressViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//
@protocol CCMyAddressViewControllerDelegate <NSObject>//通用，
@optional
- (void)clickViewWithAddress:(NSString *_Nullable)address moblieNumber:(NSString *_Nullable)moblie name:(NSString *_Nullable)name;
@end

#import "CCBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCModityAddressViewController : CCBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextF;
@property (weak, nonatomic) IBOutlet UITextField *moblieTextf;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressTextF;
@property (weak, nonatomic) id<CCMyAddressViewControllerDelegate> delegate;    // 代理
@end

NS_ASSUME_NONNULL_END
