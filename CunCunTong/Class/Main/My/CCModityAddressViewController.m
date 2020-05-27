//
//  CCModityAddressViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCModityAddressViewController.h"
#import "BRAddressPickerView.h"
@interface CCModityAddressViewController ()
@property (weak, nonatomic) IBOutlet UILabel *selectAddressLabel;

@end

@implementation CCModityAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavBarWithTitle:@"修改地址"];
    XYWeakSelf;
    [self.selectAddressLabel addTapGestureWithBlock:^(UIView *gestureView) {
        NSMutableArray *area = [NSMutableArray array];
        NSString *filePath_bundle = [[NSBundle mainBundle] pathForResource:@"Area.plist" ofType:nil];
        NSData *data_bundle = [NSData dataWithContentsOfFile:filePath_bundle];
        if (data_bundle.length > 0) {
            /******取plist数据*******/
            area = [NSMutableArray arrayWithPlistData:data_bundle];
            if (area.count <= 0) {
                /******取json数据*******/
                area= [NSJSONSerialization JSONObjectWithData:data_bundle options:NSJSONReadingAllowFragments error:nil];
            }
        }
        NSMutableArray *arr = [NSMutableArray array];
        [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:area defaultSelected:arr isAutoSelect:NO themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
            weakSelf.selectAddressLabel.text = [NSString stringWithFormat:@"  %@/%@/%@",province.provinceName,city.cityName,area.regionName];
        } cancelBlock:^{
        }];
    }];
    
}
- (IBAction)sendContent:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickViewWithAddress:moblieNumber:name:)]) {
        [self.delegate clickViewWithAddress:[NSString stringWithFormat:@"%@%@",self.selectAddressLabel.text,self.detailAddressTextF.text] moblieNumber:self.moblieTextf.text name:self.nameTextF.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
