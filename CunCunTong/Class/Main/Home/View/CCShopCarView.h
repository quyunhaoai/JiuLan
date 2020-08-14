//
//  CCShopCarView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCShopCarView : CCBaseView
@property (strong, nonatomic) NSMutableDictionary * DataDic;
@property (assign, nonatomic) BOOL isChexiao;
@property (strong, nonatomic) KKNoDataView *noDataView;
@end

NS_ASSUME_NONNULL_END
