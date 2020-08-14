//
//  CCActivityView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/2.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"
#import "CCActiveModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCActivityView : CCBaseView
@property (strong, nonatomic) UIImageView *activiteImage;  
@property (strong, nonatomic) CCActiveModel *Model;
@end

NS_ASSUME_NONNULL_END
