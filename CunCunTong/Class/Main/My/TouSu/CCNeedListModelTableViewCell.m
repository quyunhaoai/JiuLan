//
//  CCNeedListModelTableViewCell.m
//  CunCunDriverEnd
//
//  Created by GOOUC on 2020/5/23.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCNeedListModelTableViewCell.h"

@implementation CCNeedListModelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    PYPhotosView *photosView = [PYPhotosView photosViewWithThumbnailUrls:@[] originalUrls:@[] photosMaxCol:4];
    photosView.photosState = PYPhotosViewStateDidCompose;
    photosView.photoMargin = 8;
    photosView.photoWidth = (Window_W-64) /4;
    photosView.photoHeight = (Window_W-64) /4;
    photosView.x = 10;
    photosView.y = 100;
    photosView.thumbnailUrls = @[@"",@""].mutableCopy;
    // 3. 添加photosView
    [self.bgView addSubview:photosView];
    self.photosView = photosView;
    self.stateLab.textColor = krgb(255,0,0);
    [[CCTools sharedInstance] addShadowToView:self.bgView withColor:KKColor(0, 0, 0, 0.18)];
    self.bgView.layer.cornerRadius = 10;
    self.bgView.layer.masksToBounds = YES;
}
- (void)setModel:(BaseModel *)model {
    CCNeedListModel *mmm = (CCNeedListModel *)model;
    self.titleLab.text = [NSString stringWithFormat:@"需求类型：%@",mmm.name];
    self.photosView.thumbnailUrls = mmm.photo_set;
    self.dataLab.text = [NSString stringWithFormat:@"申请日期：%@",mmm.create_time];
    if (mmm.status == 0) {
        self.stateLab.text = @"审核中";
    } else {
        self.stateLab.text = @"审核通过";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(CGFloat)height {
    return 198;
}

- (void)setNeedModel:(CCNeedListModel *)needModel {
    _needModel = needModel;
    self.titleLab.text = [NSString stringWithFormat:@"需求商品：%@",_needModel.name];
    self.photosView.thumbnailUrls = _needModel.image_set;
    self.photosView.x = 10;
    self.photosView.y = 100;
    self.photosView.size = [self.photosView sizeWithPhotoCount:_needModel.image_set.count photosState:1];
    self.numberlab.text = [NSString stringWithFormat:@"需求数量：%ld%@",(long)_needModel.amount,_needModel.unit];
    self.imageTitle.text = @"商品图片：";
    self.dataLab.text = [NSString stringWithFormat:@"提交日期：%@",_needModel.create_time];
    if (_needModel.status == 0) {
        self.stateLab.text = @"审核中";
    } else if(_needModel.status == 2) {
        self.stateLab.text = @"审核拒绝";
    } else if(_needModel.status == 1 || _needModel.status == 5) {
        self.stateLab.text = @"添加中";
    } else if(_needModel.status == 3) {
            self.stateLab.text = @"已完成";
    }//0：待审核，2：已拒绝，15：添加中，3：完成）
}
- (void)setTemModel:(CCNeedListModel *)temModel {
    _temModel = temModel;
    
    self.titleLab.text = [NSString stringWithFormat:@"需求商品：%@",_temModel.name];
    self.photosView.thumbnailUrls = _temModel.image_set;
    self.numberlab.text = [NSString stringWithFormat:@"需求数量：%ld%@",(long)_temModel.amount,_temModel.unit];
    self.imageTitle.text = @"商品图片：";
    self.dataLab.text = [NSString stringWithFormat:@"提交日期：%@",_temModel.create_time];
    if (_temModel.status == 0) {
        self.stateLab.text = @"待回复";
    } else {
        self.stateLab.text = @"已回复";
    }
}
@end

