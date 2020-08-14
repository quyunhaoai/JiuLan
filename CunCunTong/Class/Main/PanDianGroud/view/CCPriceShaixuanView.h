//
//  CCPriceShaixuanView.h
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCPriceShaixuanView : CCBaseView
/*
 *  c block
 */
@property (copy, nonatomic) void(^productNameAndCodeBlack)(NSString *name,NSString *code,NSString *endTime,NSString *catetiyID);

@end

NS_ASSUME_NONNULL_END
