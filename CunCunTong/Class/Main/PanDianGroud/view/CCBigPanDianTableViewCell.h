//
//  CCBigPanDianTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/29.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCAddPanDianModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCBigPanDianTableViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
{

}
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) Child_setItem *item;
@property (strong, nonatomic) UILabel *titleLab; //
@property (strong, nonatomic) UILabel *gugeLab; //
@property (strong, nonatomic) UILabel *stokeLab; //
@property (strong, nonatomic) UILabel *untiLab; //
@property (strong, nonatomic) UILabel *pandianLab; //
@property (weak, nonatomic) id<KKCommonDelegate> deleaget; // 
@property (assign, nonatomic) BOOL isDatil; // 





@end

NS_ASSUME_NONNULL_END
