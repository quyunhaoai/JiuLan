//
//  CCFooterInfoTableViewCell.h
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/12.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKButton.h"
#import "CCBackOrderListModel.h"
#import "CCMyOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCFooterInfoTableViewCell : UITableViewCell
@property (nonatomic,strong) UIButton *sureBtn;
@property (strong, nonatomic) KKButton *lookBtn;
@property (strong, nonatomic) UILabel *sumLab; //
@property (strong, nonatomic) UILabel *sumPriceLab; //  
@property (nonatomic,strong) UIButton *sureBtn2;
@property (strong, nonatomic) UIView *line1View; // 
@property (strong, nonatomic) CCBackOrderListModel *backModel;
@property (strong, nonatomic) CCMyOrderModel *model;


@property (weak,nonatomic) id<KKCommonDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
