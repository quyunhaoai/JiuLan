//
//  UISegmentedControl+CCStyle_OC.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/18.
//  Copyright © 2020 GOOUC. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISegmentedControl (CCStyle_OC)

/// UISegmentedControl 将iOS13风格转化成iOS12之前的风格样式
- (void)ensureiOS12Style;
@end

NS_ASSUME_NONNULL_END
