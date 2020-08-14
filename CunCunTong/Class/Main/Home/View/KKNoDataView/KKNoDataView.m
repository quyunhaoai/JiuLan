//
//  KKNoDataView.h
//  KKToydayNews
//
//  Created by finger on 2017/8/6.
//  Copyright © 2017年 finger. All rights reserved.
//

#import "KKNoDataView.h"

@interface KKNoDataView ()
//@property(nonatomic)UIImageView *imageView;
@property(nonatomic)UILabel *tipLabel;
@end

@implementation KKNoDataView

- (instancetype)init{
    self = [super init];
    if(self){
        [self setupUI];
    }
    return self;
}

#pragma mark -- 设置UI

- (void)setupUI{
    [self addSubview:self.imageView];
    [self addSubview:self.tipLabel];
    
    CGFloat imageViewWH = 125;
    
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_centerY).mas_offset(-5);
        make.size.mas_equalTo(CGSizeMake(148, imageViewWH));
    }];
    [self.tipLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_centerY).mas_offset(5);
        make.width.mas_equalTo(self).mas_offset(- 2 * 10).priority(998);
    }];
    
    self.backgroundColor = UIColorHex(0xf7f7f7);
}

#pragma mark -- @property getter

- (UIImageView *)imageView{
    if(!_imageView){
        _imageView = ({
            UIImageView *view = [UIImageView new];
            view.clipsToBounds = YES ;
            view.image = IMAGE_NAME(@"无订单缺省页图标");
            view.contentMode = UIViewContentModeScaleToFill;
            view ;
        });
    }
    return _imageView;
}

- (UILabel *)tipLabel{
    if(!_tipLabel){
        _tipLabel = ({
            UILabel *label = [UILabel new];
            label.textColor = UIColorHex(0x999999);
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14];
            label.backgroundColor = [UIColor clearColor];
            label.numberOfLines = 0 ;
            label.text = @"暂无相关数据哦~";
            label;
        });
    }
    return _tipLabel;
}

#pragma mark -- @property setter

- (void)setTipImage:(UIImage *)tipImage{
    self.imageView.image = tipImage;
}

- (void)setTipText:(NSString *)tipText{
    self.tipLabel.text = tipText;
}

@end
