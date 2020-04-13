
//
//  CCWuliuInfoViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCWuliuInfoViewController.h"
#import <MAMapKit/MAMapKit.h>
@interface CCWuliuInfoViewController ()<MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@end

@implementation CCWuliuInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"物流信息"];
    
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, Window_W, Window_H-NAVIGATION_BAR_HEIGHT)];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
