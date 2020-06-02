//
//  CCSureOrderHeadView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/2.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"
#import "KKButton.h"
#import "CCCustomLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCSureOrderHeadView : CCBaseView
@property (strong, nonatomic) UILabel *nameLab;
@property (strong, nonatomic) CCCustomLabel *addressLab;
@property (strong, nonatomic) UILabel *numberLab;  


@property (nonatomic,strong)  KKButton *modifyBtn;
@end

NS_ASSUME_NONNULL_END
