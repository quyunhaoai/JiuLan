//
//  CCComplaintViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/8.
//  Copyright © 2020 GOOUC. All rights reserved.
// 投诉

#import "CCBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCComplaintViewController : CCBaseViewController
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIView *yuanYinView;
@property (weak, nonatomic) IBOutlet UIView *orderView;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UILabel *yuanYinLab;
@property (weak, nonatomic) IBOutlet UILabel *orderLab;
@property (weak, nonatomic) IBOutlet UILabel *selectOrderLab;
@property (weak, nonatomic) IBOutlet UILabel *placelab;

@end

NS_ASSUME_NONNULL_END
