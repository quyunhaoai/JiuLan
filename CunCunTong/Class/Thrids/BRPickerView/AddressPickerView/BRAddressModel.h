//
//  BRAddressModel.h
//  BRPickerViewDemo
//
//  Created by 任波 on 2017/8/11.
//  Copyright © 2017年 91renb. All rights reserved.
//
//  最新代码下载地址：https://github.com/91renb/BRPickerView

#import <Foundation/Foundation.h>

/// 省
@interface BRProvinceModel : NSObject
/** 省对应的code或id */
//@property (nonatomic, copy) NSString *code;
///** 省的名称 */
//@property (nonatomic, copy) NSString *name;
///** 省的索引 */
//@property (nonatomic, assign) NSInteger index;
///** 城市数组 */



@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, copy) NSString *provinceID;
@property (nonatomic, copy) NSString *provinceName;


@end

/// 市
@interface BRCityModel : NSObject
/** 市对应的code或id */
//@property (nonatomic, copy) NSString *code;
///** 市的名称 */
//@property (nonatomic, copy) NSString *name;
///** 市的索引 */
//@property (nonatomic, assign) NSInteger index;
///** 地区数组 */
//@property (nonatomic, strong) NSArray *arealist;


@property (nonatomic, copy) NSString *cityID;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, strong) NSArray *regions;

@end

/// 区
@interface BRAreaModel : NSObject
///** 区对应的code或id */
//@property (nonatomic, copy) NSString *code;
///** 区的名称 */
//@property (nonatomic, copy) NSString *name;
///** 区的索引 */
//@property (nonatomic, assign) NSInteger index;



@property (nonatomic, copy) NSString *regionID;
@property (nonatomic, copy) NSString *regionName;


@end
