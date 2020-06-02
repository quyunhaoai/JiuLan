//
//  CCShopCarTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//
@protocol KKCCShopCarTableViewCellDelegate <NSObject>//通用，
@optional
- (void)clickPPNumberWithItem:(id _Nullable )item isAdd:(BOOL)isAdd indexPaht:(NSIndexPath *)path ppnumberButton:(PPNumberButton *)numberButton;
@end
#import <UIKit/UIKit.h>
#import "CCShopCarListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCShopCarTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) CCShopCarListModel * Model;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *gugeLab;

@property (weak, nonatomic) IBOutlet UILabel *kucunLab;

@property (weak, nonatomic) IBOutlet UILabel *pricelab;
@property (strong, nonatomic) PPNumberButton *ppButton;
@property (weak, nonatomic)  id<KKCCShopCarTableViewCellDelegate>delegate;
@property (nonatomic,strong) NSIndexPath *path;

@end

NS_ASSUME_NONNULL_END
