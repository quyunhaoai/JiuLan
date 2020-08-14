//
//  CCNeedListModelTableViewCell.m
//  CunCunDriverEnd
//
//  Created by GOOUC on 2020/5/23.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCTemListModelTableViewCell.h"

@implementation CCTemListModelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    PYPhotosView *photosView = [PYPhotosView photosViewWithThumbnailUrls:@[] originalUrls:@[] photosMaxCol:4];
    photosView.photosState = PYPhotosViewStateDidCompose;
    photosView.photoMargin = 8;
    photosView.photoWidth = (Window_W-64) /4;
    photosView.photoHeight = (Window_W-64) /4;
    photosView.x = 10;
    photosView.y = 130;
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
    self.numberlab.text = [NSString stringWithFormat:@"需求数量：%ld%@",(long)_needModel.amount,_needModel.unit];
    self.imageTitle.text = @"商品图片：";
    self.dataLab.text = [NSString stringWithFormat:@"提交日期：%@",_needModel.create_time];
    if (_needModel.status == 0) {
        self.stateLab.text = @"待回复";
    } else {
        self.stateLab.text = @"已回复";
    }
}
- (void)setTemModel:(CCNeedListModel *)temModel {
    _temModel = temModel;
    
    self.titleLab.text = [NSString stringWithFormat:@"申请商品：%@",_temModel.goods_name];
    self.photosView.thumbnailUrls = _temModel.image_set;
    self.numberlab.text = [NSString stringWithFormat:@"申请数量：%ld%@",(long)_temModel.count,_temModel.play_unit];
    self.imageTitle.text =[NSString stringWithFormat:@"商品生产日期：%@",_temModel.product_date];
    self.dataLab.text = [NSString stringWithFormat:@"申请日期：%@",_temModel.create_time];
    if (_temModel.status == 0) {//                "status": 0,  # 状态，0：审核中，1：已拒绝，2：待退款，3：待确认收款，4：已完成
        self.stateLab.text = @"审核中";
    } else if(_temModel.status == 1){
        self.stateLab.text = @"审核拒绝";
        } else if(_temModel.status ==2 ){
              self.stateLab.text = @"待退款";
              } else if(_temModel.status ==3 ){
                    self.stateLab.text = @"待确认收款";
                 } else if(_temModel.status ==4){
                          self.stateLab.text = @"已完成";
                      }
    self.stateLab.text = _temModel.status_str;
}
@end

