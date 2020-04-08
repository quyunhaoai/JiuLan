//
//  CCLonginTextInputVIew.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"
#import "CCCustomTextFiled.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCLonginTextInputVIew : CCBaseView

@property (strong,nonatomic)CCCustomTextFiled *moblieTextField;
@property (strong,nonatomic)CCCustomTextFiled *keyTextField;

@property (nonatomic,strong) UIButton *sendVarkeyBtn;
@property (nonatomic,strong) UIButton *longinBtn;
@property (nonatomic,strong) UIButton *passworldChuageBtn;

@end

NS_ASSUME_NONNULL_END
