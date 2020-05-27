
//
//  CCActiveDivHeadView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//
static NSString *cellReuseIdentifier = @"CCActiveDivHeadCollectionViewCell";
#import "CCActiveDivHeadCollectionViewCell.h"
#import "CCActiveDivHeadView.h"

@implementation CCActiveDivHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setupUI {
    
    UIImageView *imageBgView = ({
          UIImageView *view = [UIImageView new];
          view.contentMode = UIViewContentModeScaleAspectFill ;
          view.layer.masksToBounds = YES ;
          view.userInteractionEnabled = YES ;
          [view setImage:IMAGE_NAME(@"矩形2")];
           
          view;
      });
      
      [self addSubview:imageBgView];
      [imageBgView mas_updateConstraints:^(MASConstraintMaker *make) {
          make.left.top.right.mas_equalTo(self);
          make.height.mas_equalTo(221-NAVIGATION_BAR_HEIGHT);
      }];
    UIImageView *imageBgView2 = ({
          UIImageView *view = [UIImageView new];
          view.contentMode = UIViewContentModeScaleAspectFill ;
          view.layer.masksToBounds = YES ;
          view.userInteractionEnabled = YES ;
          [view setImage:IMAGE_NAME(@"矩形3")];
           
          view;
      });
      
      [self addSubview:imageBgView2];
      [imageBgView2 mas_updateConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(self).mas_offset(40);
          make.left.mas_equalTo(self).mas_offset(10);
          make.right.mas_equalTo(self).mas_offset(-10);
          make.height.mas_equalTo(223);
      }];
    [imageBgView2 addSubview:self.collectView];
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageBgView2).mas_offset(16);
        make.right.mas_equalTo(imageBgView2).mas_offset(-16);
        make.height.mas_equalTo(147);
        make.top.mas_equalTo(imageBgView2).mas_offset(44);
    }];
    UIImageView *imageBgView3 = ({
          UIImageView *view = [UIImageView new];
          view.contentMode = UIViewContentModeScaleAspectFill ;
          view.layer.masksToBounds = YES ;
          view.userInteractionEnabled = YES ;
          [view setImage:IMAGE_NAME(@"矩形4")];
           
          view;
      });
      [imageBgView2 addSubview:imageBgView3];
      [imageBgView3 mas_updateConstraints:^(MASConstraintMaker *make) {
          make.bottom.mas_equalTo(imageBgView2);
          make.left.mas_equalTo(self).mas_offset(10);
          make.right.mas_equalTo(self).mas_offset(-10);
          make.height.mas_equalTo(50);
      }];
      UIButton *goBtn = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [view setTitle:@"立即秒杀" forState:UIControlStateNormal];
        [view setBackgroundImage:IMAGE_NAME(@"按钮") forState:UIControlStateNormal];
        [view.titleLabel setFont:FONT_15];
        view.tag = 3;
        [view addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        view ;
      });
    [imageBgView3 addSubview:goBtn];
    [goBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(imageBgView3).mas_offset(-5);
        make.centerX.mas_equalTo(self).mas_offset(0);
        make.height.mas_equalTo(31);
        make.width.mas_equalTo(105);
    }];
    
    UILabel *nameLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(15);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"秒杀专区";
        view ;
    });
    [imageBgView2 addSubview:nameLab];
    [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(77, 14));
        make.top.mas_equalTo(imageBgView2).mas_offset(15);
    }];
    UILabel *addressLab = ({
        UILabel *view = [UILabel new];
        view.textColor =krgb(255,70,26);
        view.font = STFont(13);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentRight;
        view.numberOfLines = 2;
        view.text = @"距离秒杀开始";
        view ;
    });
    [self addSubview:addressLab];
    [addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-22);
        make.size.mas_equalTo(CGSizeMake(147, 14));
        make.top.mas_equalTo(imageBgView2).mas_offset(15);
    }];
    

    
    
}
- (void)moreBtnClicked:(UIButton *)button {
    
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray =[NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@""]];
    }
    return _dataArray;
}


#pragma mark -- @property

- (UICollectionView *)collectView{
    if(!_collectView){
        _collectView = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            UICollectionView *view = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
            view.delegate= self;
            view.dataSource= self;
            view.backgroundColor = kClearColor;
            view.showsHorizontalScrollIndicator = NO;
            view.showsVerticalScrollIndicator = NO;
            view.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            [view registerNib:[UINib nibWithNibName:CCActiveDivHeadCollectionViewCell.className bundle:[NSBundle mainBundle] ] forCellWithReuseIdentifier:cellReuseIdentifier];
            view;
        });
    }
    return _collectView;
}

#pragma mark -- UICollectionViewDelegate,UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CCActiveDivHeadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((Window_W-20-50)/3, 147);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

//设置水平间距 (同一行的cell的左右间距）
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//垂直间距 (同一列cell上下间距)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
@end
