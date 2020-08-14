//
//  CCPushViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/8/5.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JpushManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCPushViewController : NSObject
- (void)receiveNotificationWithUserInfo:(NSInteger )targetTypeID AndTarget:(NSInteger )point andData:(NSInteger )massageId;
@end

NS_ASSUME_NONNULL_END
