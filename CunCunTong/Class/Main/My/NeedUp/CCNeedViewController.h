//
//  CCNeedViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseViewController.h"
#import "KKButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCNeedViewController : CCBaseViewController
@property (weak, nonatomic) IBOutlet KKButton *photosBtn;
@property (weak, nonatomic) IBOutlet UITextField *detailTextF;
@property (weak, nonatomic) IBOutlet UITextField *needNumberTextF;
@property (weak, nonatomic) IBOutlet UITextField *nametextField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end

NS_ASSUME_NONNULL_END
