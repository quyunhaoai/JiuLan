//
//  CCKucunDetailFooterView.h
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"
#import "JJStockView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCKucunDetailFooterView : CCBaseView<SegmentTapViewDelegate,StockViewDataSource,StockViewDelegate>
@property (nonatomic, strong) SegmentTapView *segment;
@property (strong, nonatomic) UILabel *dateLab;  
@property (strong, nonatomic) UILabel *dateLab2;

@property(nonatomic,readwrite,strong)JJStockView* stockView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSDictionary *sumDict;
@property (nonatomic,strong)NSArray *titleArr;
@property (assign, nonatomic) BOOL isJinHuo; 
@end

NS_ASSUME_NONNULL_END
