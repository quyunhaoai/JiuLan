//
//  LWQ_CheXiaoRuKuCell.h
//  CunCunDriverEnd
//
//  Created by aa on 2020/6/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCConPlainListMOdel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LWQ_CheXiaoRuKuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *totPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *ciaoJiLabel;
@property (weak, nonatomic) IBOutlet UILabel *totNumberLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (strong,nonatomic) Child_order_setItem *item;
@end

NS_ASSUME_NONNULL_END
