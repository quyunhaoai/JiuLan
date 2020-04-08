//
//  CCPersonHeaderView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCPersonHeaderView : CCBaseView
@property (strong,nonatomic)UIImageView *bgImageView;
@property (strong, nonatomic) UIImageView *headerImage;
@property (strong, nonatomic) UILabel *nameStrLab;
@property (strong, nonatomic) UIButton *moreButtonView;
@property (strong, nonatomic) NSArray *toaArray;   
/*
 *  click block
 */
@property (copy, nonatomic) void(^click)(NSInteger tag);

@end

NS_ASSUME_NONNULL_END
