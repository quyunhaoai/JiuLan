//
//  CCNeedListModelTableViewCell.h
//  CunCunDriverEnd
//
//  Created by GOOUC on 2020/5/23.
//  Copyright © 2020 GOOUC. All rights reserved.
//
#import "PYPhotosView.h"
#import "BaseTableViewCell.h"
#import "CCNeedListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCTemListModelTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;
@property (strong,nonatomic) PYPhotosView *photosView;
@property (nonatomic,strong) CCNeedListModel *needModel;
@property (weak, nonatomic) IBOutlet UILabel *numberlab;


@property (weak, nonatomic) IBOutlet UILabel *imageTitle;
@property (nonatomic,strong) CCNeedListModel *temModel;  // 
+(CGFloat )height;
@end

NS_ASSUME_NONNULL_END
