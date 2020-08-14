//
//  CCPersonHeaderView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"
#import "ImageTitleButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCPersonHeaderView : CCBaseView
@property (strong,nonatomic)UIImageView *bgImageView;
@property (strong, nonatomic) UIImageView *headerImage;
@property (strong, nonatomic) UILabel *nameStrLab;
@property (strong, nonatomic) UIButton *moreButtonView;
@property (strong, nonatomic) NSArray *toaArray;
@property (strong, nonatomic) ImageTitleButton *oneImage;
@property (strong, nonatomic) ImageTitleButton *towImage;
@property (strong, nonatomic) ImageTitleButton *threeImage;
@property (strong, nonatomic) UIView *oneImageview;
@property (strong, nonatomic) UIView *towImagevvv;
@property (strong, nonatomic) UIView *threeImagevvv;


/*
 *  click block
 */
@property (copy, nonatomic) void(^click)(NSInteger tag);

@end

NS_ASSUME_NONNULL_END
