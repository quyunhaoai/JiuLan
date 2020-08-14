//
//  CCHomeHeaderView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

typedef void(^buttonClick)(NSInteger i);
#import "CCBaseView.h"
#import "SDCycleScrollView.h"
#import "CCLunboTuModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCHomeHeaderView : CCBaseView
@property (strong, nonatomic) NSArray *buttosArray;
@property (copy, nonatomic) buttonClick buttonAction;


@property (strong, nonatomic) SDCycleScrollView *bgImage;

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSArray *photosArray;   
@end

NS_ASSUME_NONNULL_END
 
