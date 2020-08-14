//
//  CCNewAddBuyGoodsViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/8.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseViewController.h"
#import "KKButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCNewAddBuyGoodsViewController : CCBaseViewController
@property (nonatomic,copy) NSString *paindianID;  
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *sumlab;
@property (weak, nonatomic) IBOutlet UIButton *zanCunBtn;

@end

NS_ASSUME_NONNULL_END
