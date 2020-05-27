//
//  CCHomeHeaderView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

typedef void(^buttonClick)(NSInteger i);
#import "CCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCHomeHeaderView : CCBaseView
@property (strong, nonatomic) NSArray *buttosArray;
@property (copy, nonatomic) buttonClick buttonAction;  
@end

NS_ASSUME_NONNULL_END
