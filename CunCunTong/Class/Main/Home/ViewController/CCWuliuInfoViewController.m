
//
//  CCWuliuInfoViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCWuliuInfoViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "OKLogisticsView.h"
#import "OKLogisticModel.h"
#import "CCWuliuInfoModel.h"
#import "CCCustomMapTipView.h"
#import "CCCustomMapTip2View.h"

//#import "MANaviRoute.h"
#import <AMapSearchKit/AMapSearchKit.h>
@interface CCWuliuInfoViewController ()<MAMapViewDelegate,AMapSearchDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic,strong) NSMutableArray * dataArry;
@property (nonatomic,strong) OKLogisticsView * logis;
@property (nonatomic,strong) CCWuliuInfoModel *myModel;

@end

@implementation CCWuliuInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"物流信息"];
//    NSLog(@"%@",[AMapServices ])
    [AMapServices sharedServices].enableHTTPS = YES;
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0,
                                                               NAVIGATION_BAR_HEIGHT,
                                                               Window_W,
                                                               Window_H-NAVIGATION_BAR_HEIGHT)];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    self.dataArry = [NSMutableArray array];
    OKLogisticsView * logis = [[OKLogisticsView alloc]initWithDatas:self.dataArry];
    // 给headView赋值
    logis.frame = CGRectMake(10,  Window_H-296, Window_W-20, 296);
    logis.clipsToBounds = YES;
    [logis setCornerRadius:10 withShadow:YES withOpacity:0.5];
    logis.layer.masksToBounds = YES;
    [self.view addSubview:logis];
    self.logis = logis;
    [self initData];
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path = [NSString stringWithFormat:@"/app0/orderpostinfo/%@/",self.OrderID];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.myModel = [CCWuliuInfoModel modelWithJSON:data];
            for (CrossItem *item in weakSelf.myModel.cross) {
                OKLogisticModel * model = [[OKLogisticModel alloc]init];
                model.dsc = item.info;
                model.date = item.time;
                [weakSelf.dataArry addObject:model];
            }
//            weakSelf.dataArry = (NSMutableArray *)[[weakSelf.dataArry reverseObjectEnumerator] allObjects];
             [weakSelf.logis reloadDataWithDatas:weakSelf.dataArry];
             MAPointAnnotation *a =[weakSelf addFromWeizhi:weakSelf.myModel.from];
             MAPointAnnotation *b =[weakSelf addannotion:weakSelf.myModel.to];
             MAPointAnnotation *c = [weakSelf addannotionccc:weakSelf.myModel.cross.lastObject];
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            [arr addObject:a];
            [arr addObject:b];
            [arr addObject:c];
            [weakSelf.mapView addAnnotations:arr];
            [weakSelf.mapView showAnnotations:arr animated:YES];
            [weakSelf addoverLay];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}
- (MAPointAnnotation*)addFromWeizhi:(From *)weizhi{
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(weizhi.lat, weizhi.lng);
    pointAnnotation.title = weizhi.name;
    return pointAnnotation;
}
- (MAPointAnnotation*)addannotion:(To*)weizhi {
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(weizhi.lat, weizhi.lng);
    pointAnnotation.title = weizhi.name;
    return pointAnnotation;
}
- (MAPointAnnotation*)addannotionccc:(CrossItem*)weizhi {
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(weizhi.lat, weizhi.lng);
    pointAnnotation.title = weizhi.info;
    return pointAnnotation;
}
- (void)addoverLay {
    CLLocationCoordinate2D commonPolylineCoords[2];
    commonPolylineCoords[0].latitude = self.myModel.from.lat;
    commonPolylineCoords[0].longitude = self.myModel.from.lng;
    CrossItem *item = self.myModel.cross.lastObject;
    commonPolylineCoords[1].latitude = item.lat;
    commonPolylineCoords[1].longitude = item.lng;
    
//    commonPolylineCoords[2].latitude = self.myModel.to.lat;
//    commonPolylineCoords[2].longitude = self.myModel.to.lng;
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:2];
    CLLocationCoordinate2D commonPolylineCoords1[2];
    commonPolylineCoords1[0].latitude = item.lat;
    commonPolylineCoords1[0].longitude = item.lng;
    
    commonPolylineCoords1[1].latitude = self.myModel.to.lat;
    commonPolylineCoords1[1].longitude = self.myModel.to.lng;
    MAPolyline *line1 = [MAPolyline polylineWithCoordinates:commonPolylineCoords1 count:2];
    //在地图上添加折线对象
//    [_mapView addOverlay: commonPolyline];
    [self.mapView addOverlays:@[commonPolyline,line1]];
}
#pragma mark - MAMapViewDelegate
/*!
@brief 根据anntation生成对应的View
@param mapView 地图View
@param annotation 指定的标注
@return 生成的标注View
*/
// */
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation;
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        if ([annotation.title isEqualToString:[(CrossItem *)self.myModel.cross.lastObject info]]) {
//                   annotationView.locationImage.image = IMAGE_NAME(@"物流汽车图标");
            static NSString *customReuseIndetifier = @"customReuseIndetifier2";
            
            CCCustomMapTip2View *annotationView = (CCCustomMapTip2View*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
            
            if (annotationView == nil)
            {
                annotationView = [[CCCustomMapTip2View alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
                // must set to NO, so we can show the custom callout view.
                annotationView.canShowCallout = NO;
                annotationView.draggable = YES;
//                annotationView.centerOffset
//                annotationView.centerOffset = CGPointMake(0, -66);
            }
            return annotationView;
        } else {
            static NSString *customReuseIndetifier = @"customReuseIndetifier";
            
            CCCustomMapTipView *annotationView = (CCCustomMapTipView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
            
            if (annotationView == nil)
            {
                annotationView = [[CCCustomMapTipView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
                // must set to NO, so we can show the custom callout view.
                annotationView.canShowCallout = NO;
                annotationView.draggable = YES;
//                annotationView.centerOffset = CGPointMake(0, -66);
            }
            if ([annotation.title isEqualToString:self.myModel.to.name]) {
                annotationView.nameLabel.text = self.myModel.to.name;
                annotationView.titleLabel.text = @"收";
                annotationView.iconImage.image = IMAGE_NAME(@"灰底");
                annotationView.locationImage.image =IMAGE_NAME(@"地址灰");
            } else if ([annotation.title isEqualToString:self.myModel.from.name]){
                annotationView.nameLabel.text = self.myModel.from.name;
                annotationView.titleLabel.text = @"发";
                annotationView.iconImage.image = IMAGE_NAME(@"红低");
                annotationView.locationImage.image =IMAGE_NAME(@"地址红");
            } else{
                
            }
            return annotationView;
        }
    }
    
    return nil;
}

/*!
 @brief 根据overlay生成对应的Renderer
 @param mapView 地图View
 @param overlay 指定的overlay
 @return 生成的覆盖物Renderer
 */

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        NSLog(@"--------%.f, %.f",overlay.coordinate.latitude,overlay.coordinate.longitude);
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        polylineRenderer.is3DArrowLine = NO;
        polylineRenderer.lineWidth    = 3.f;
        polylineRenderer.strokeColor  = krgb(247,93,0);
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}
#pragma mark - Map Delegate

/*!
 @brief 地图区域即将改变时会调用此接口
 @param mapview 地图View
 @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
}

/*!
 @brief 地图区域改变完成后会调用此接口
 @param mapview 地图View
 @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
}

/**
 *  地图将要发生移动时调用此接口
 *
 *  @param mapView       地图view
 *  @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction {
    
}

/**
 *  地图移动结束后调用此接口
 *
 *  @param mapView       地图view
 *  @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
    
}

/**
 *  地图将要发生缩放时调用此接口
 *
 *  @param mapView       地图view
 *  @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapWillZoomByUser:(BOOL)wasUserAction {
    
}

/**
 *  地图缩放结束后调用此接口
 *
 *  @param mapView       地图view
 *  @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction {
    
}

/**
 *  单击地图底图调用此接口
 *
 *  @param mapView    地图View
 *  @param coordinate 点击位置经纬度
 */
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
}

/**
 *  长按地图底图调用此接口
 *
 *  @param mapView    地图View
 *  @param coordinate 长按位置经纬度
 */
- (void)mapView:(MAMapView *)mapView didLongPressedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
}

/*!
 @brief 当mapView新添加annotation views时调用此接口
 @param mapView 地图View
 @param views 新添加的annotation views
 */
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
}

/*!
 @brief 当选中一个annotation views时调用此接口
 @param mapView 地图View
 @param views 选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
}

/*!
 @brief 当取消选中一个annotation views时调用此接口
 @param mapView 地图View
 @param views 取消选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view {
    
}

/*!
 @brief 标注view的accessory view(必须继承自UIControl)被点击时调用此接口
 @param mapView 地图View
 @param annotationView callout所属的标注view
 @param control 对应的control
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
}

/**
 *  标注view的calloutview整体点击时调用此接口
 *
 *  @param mapView 地图的view
 *  @param view calloutView所属的annotationView
 */
- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view {
    
}

/*!
 @brief 在地图View将要启动定位时调用此接口
 @param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView {
    
}

/*!
 @brief 在地图View停止定位后调用此接口
 @param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView {
    
}

/*!
 @brief 位置或者设备方向更新后调用此接口
 @param mapView 地图View
 @param userLocation 用户定位信息(包括位置与设备方向等数据)
 @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
}

/*!
 @brief 定位失败后调用此接口
 @param mapView 地图View
 @param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    
}

/*!
 @brief 当userTrackingMode改变时调用此接口
 @param mapView 地图View
 @param mode 改变后的mode
 @param animated 动画
 */
- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated {
    
}

/*!
 @brief 拖动annotation view时view的状态变化，ios3.2以后支持
 @param mapView 地图View
 @param view annotation view
 @param newState 新状态
 @param oldState 旧状态
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState {
    
}


/*!
 @brief 当mapView新添加overlay renderer时调用此接口
 @param mapView 地图View
 @param renderers 新添加的overlay renderers
 */
- (void)mapView:(MAMapView *)mapView didAddOverlayRenderers:(NSArray *)renderers {
    
}
@end
