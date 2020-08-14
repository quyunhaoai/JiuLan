//
//  CCProductZZTableViewCell.h
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCProductZZModel.h"
#import "CCBusinessZZModel.h"
#import "PYPhotosView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCProductZZTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *nameLab;
@property (strong, nonatomic) UILabel *subLab;
@property (strong, nonatomic) UIButton *deleteBtn;
@property (strong, nonatomic) UIButton *changeBtn; //  


@property (strong, nonatomic) CCProductZZModel *model;
@property (strong, nonatomic) CCBusinessZZModel *businessModel;
@property (strong, nonatomic) PYPhotosView *photosView ;
@property (weak, nonatomic) id<KKCommonDelegate>delegate;




@end

NS_ASSUME_NONNULL_END
