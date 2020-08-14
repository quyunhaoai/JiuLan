//
//  CCMyinfoModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/6/25.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCMyinfoModel : BaseModel
@property (nonatomic , copy) NSString              * head_photo;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) BOOL              wx_band;
@property (nonatomic , assign) BOOL              mobile_band;
@property (nonatomic , copy) NSString             *lat;
@property (nonatomic , copy) NSString              *lng;
@property (nonatomic,copy) NSString *address;  // <#name#>
@end

NS_ASSUME_NONNULL_END
/*
 {
   "head_photo": "",
   "name": "赵老板",
   "wx_band": false,
   "mobile_band": true,
   "lat": 34.723636075322,
   "lng": 113.728651895264
 }
 **/
