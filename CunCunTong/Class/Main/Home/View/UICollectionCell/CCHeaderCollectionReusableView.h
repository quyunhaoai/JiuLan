//
//  CCHeaderCollectionReusableView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCHeaderCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet KKButton *moreBtn;

@end

NS_ASSUME_NONNULL_END
#ifdef __IPHONE_11_0
@interface LQLayer : CALayer

@end
#endif
