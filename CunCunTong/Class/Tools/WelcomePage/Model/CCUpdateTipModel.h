//
//  CCUpdateTipModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCUpdateTipModel : BaseModel
@property (nonatomic , copy) NSString              * appSign;
@property (nonatomic , assign) NSInteger              versionCode;
@property (nonatomic , copy) NSString              * versionStr;
@property (nonatomic , copy) NSString              * updateContent;
@property (nonatomic , assign) BOOL              forceSign;
@property (nonatomic , copy) NSString              * uploadUrl;
@end

NS_ASSUME_NONNULL_END
