//
//  CCHeadInfoTableViewCell.h
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/12.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBackOrderListModel.h"
#import "CCMyOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCHeadInfoTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UILabel *stateLab;
@property (strong, nonatomic) UILabel *addressLab;  
@property (strong, nonatomic) CCBackOrderListModel *backModel;
@property (strong, nonatomic) CCMyOrderModel *model;


@end

NS_ASSUME_NONNULL_END
