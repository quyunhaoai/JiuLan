//
//  CCPayChongzhiViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCPayChongzhiViewController.h"
#import "CCMchargeModel.h"
@interface CCPayChongzhiViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (strong, nonatomic) NSArray *dataArray;
@property (assign, nonatomic) NSInteger pay_type;    //
@property (weak, nonatomic) IBOutlet UIButton *goPayButton;
@end

@implementation CCPayChongzhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavBarWithTitle:@"充值"];
    
    self.view.backgroundColor = kWhiteColor;
    
    [[CCTools sharedInstance] addborderToView:self.select1 width:1.0 color:kMainColor];
    [[CCTools sharedInstance] addborderToView:self.select2 width:1.0 color:kMainColor];
    [[CCTools sharedInstance] addborderToView:self.select3 width:1.0 color:kMainColor];
    [[CCTools sharedInstance] addborderToView:self.weixinPay width:1.0 color:COLOR_cccccc];
    [[CCTools sharedInstance] addborderToView:self.zhifubaoPay width:1.0 color:COLOR_cccccc];
    [[CCTools sharedInstance] addborderToView:self.yinlianPay width:1.0 color:COLOR_cccccc];
    [self initData];
    XYWeakSelf;
    [self.select1 addTapGestureWithBlock:^(UIView *gestureView) {
              [weakSelf tapview:gestureView];
    }];
    [self.select3 addTapGestureWithBlock:^(UIView *gestureView) {
              [weakSelf tapview:gestureView];
    }];
    [self.select2 addTapGestureWithBlock:^(UIView *gestureView) {
              [weakSelf tapview:gestureView];
    }];
    [self.weixinPay addTapGestureWithBlock:^(UIView *gestureView) {
              [weakSelf tapPayView:gestureView];
    }];
    [self.zhifubaoPay addTapGestureWithBlock:^(UIView *gestureView) {
              [weakSelf tapPayView:gestureView];
    }];
    [self.yinlianPay addTapGestureWithBlock:^(UIView *gestureView) {
              [weakSelf tapPayView:gestureView];
    }];
    self.priceTextField.delegate = self;
    self.goPayButton.layer.masksToBounds = YES;
    self.goPayButton.layer.cornerRadius = 5;
    [self.priceTextField addTarget:self action:@selector(textfiledChange:) forControlEvents:UIControlEventValueChanged];
    
}
#pragma mark  -  delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.goPayButton.userInteractionEnabled = YES;
    [self.goPayButton setBackgroundColor:kMainColor];
}
- (void)textFieldDidChangeSelection:(UITextField *)textField{
    self.goPayButton.userInteractionEnabled = YES;
    [self.goPayButton setBackgroundColor:kMainColor];
}

- (void)textfiledChange:(UITextField *)textField {
    self.goPayButton.userInteractionEnabled = YES;
    [self.goPayButton setBackgroundColor:kMainColor];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}
- (NSString *)SubStringfrom:(UITextField *)textField andLength:(NSUInteger )length {
    return textField.text;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

- (void)tapPayView:(UIView *)view {

    if (view.tag == 10000) {
        [[CCTools sharedInstance] addborderToView:self.weixinPay width:1.0 color:kMainColor];
        [[CCTools sharedInstance] addborderToView:self.yinlianPay width:1.0 color:COLOR_cccccc];
        [[CCTools sharedInstance] addborderToView:self.zhifubaoPay width:1.0 color:COLOR_cccccc];
        UIImageView *icon = (UIImageView *)[view viewWithTag:1000];
        UIImageView *icon2 = (UIImageView *)[self.yinlianPay viewWithTag:1000];
        UIImageView *icon3 = (UIImageView *)[self.zhifubaoPay viewWithTag:1000];
        [icon2 setImage:IMAGE_NAME(@"未选中图标")];
        [icon3 setImage:IMAGE_NAME(@"未选中图标")];
        [icon setImage:IMAGE_NAME(@"选中圆点图标 1")];
        self.pay_type = 1;
    } else if (view.tag == 10001){
        [[CCTools sharedInstance] addborderToView:self.weixinPay width:1.0 color:COLOR_cccccc];
        [[CCTools sharedInstance] addborderToView:self.yinlianPay width:1.0 color:COLOR_cccccc];
        [[CCTools sharedInstance] addborderToView:self.zhifubaoPay width:1.0 color:kMainColor];
        self.pay_type = 2;
        UIImageView *icon = (UIImageView *)[view viewWithTag:1000];
        UIImageView *icon2 = (UIImageView *)[self.yinlianPay viewWithTag:1000];
        UIImageView *icon3 = (UIImageView *)[self.weixinPay viewWithTag:1000];
        [icon2 setImage:IMAGE_NAME(@"未选中图标")];
        [icon3 setImage:IMAGE_NAME(@"未选中图标")];
        [icon setImage:IMAGE_NAME(@"选中圆点图标 1")];
    } else {
        [[CCTools sharedInstance] addborderToView:self.weixinPay width:1.0 color:COLOR_cccccc];
        [[CCTools sharedInstance] addborderToView:self.yinlianPay width:1.0 color:kMainColor];
        [[CCTools sharedInstance] addborderToView:self.zhifubaoPay width:1.0 color:COLOR_cccccc];
        self.pay_type = 3;
        UIImageView *icon = (UIImageView *)[view viewWithTag:1000];
        UIImageView *icon2 = (UIImageView *)[self.zhifubaoPay viewWithTag:1000];
        UIImageView *icon3 = (UIImageView *)[self.weixinPay viewWithTag:1000];
        [icon2 setImage:IMAGE_NAME(@"未选中图标")];
        [icon3 setImage:IMAGE_NAME(@"未选中图标")];
        [icon setImage:IMAGE_NAME(@"选中圆点图标 1")];
    }
}
- (void)tapview:(UIView *)view {
    CCMchargeModel *model = [CCMchargeModel modelWithJSON:self.dataArray[view.tag-100]];
    self.priceTextField.text = STRING_FROM_INTAGER(model.full);
    self.goPayButton.userInteractionEnabled = YES;
    [self.goPayButton setBackgroundColor:kMainColor];
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path = @"/app0/mcharge/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            NSArray *data = dic[@"data"];
            weakSelf.dataArray = data.copy;
            if (data.count <3) {
                self.select1.hidden = YES;
                self.select2.hidden = YES;
                self.select3.hidden = YES;
            } else {
                self.select1.hidden = NO;
                self.select2.hidden = NO;
                self.select3.hidden = NO;
                for (int i = 0;i<3;i++) {
                    CCMchargeModel *model = [CCMchargeModel modelWithJSON:data[i]];
                    if (i == 0) {
                        UILabel *one = (UILabel *)[self.select1 viewWithTag:1];
                        UILabel *tow =  (UILabel *)[self.select1 viewWithTag:2];
                        one.text = [NSString stringWithFormat:@"%ld元",model.full];
                        tow.text = [NSString stringWithFormat:@"到账%ld元",model.real];
                    } else if (i == 1){
                        UILabel *one =  (UILabel *)[self.select2 viewWithTag:1];
                        UILabel *tow =  (UILabel *)[self.select2 viewWithTag:2];
                        one.text = [NSString stringWithFormat:@"%ld元",model.full];
                        tow.text = [NSString stringWithFormat:@"到账%ld元",model.real];
                    } else {
                        UILabel *one =  (UILabel *)[self.select3 viewWithTag:1];
                        UILabel *tow =  (UILabel *)[self.select3 viewWithTag:2];
                        one.text = [NSString stringWithFormat:@"%ld元",model.full];
                        tow.text = [NSString stringWithFormat:@"到账%ld元",model.real];
                    }
                }
            }
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}

- (IBAction)goPay:(UIButton *)sender {
    XYWeakSelf;
    NSDictionary *params = @{@"types":[NSString stringWithFormat:@"%ld",(long)self.pay_type],
                             @"price":self.priceTextField.text,
    };
    NSString *path = @"/app2/aisendline/";
    [[STHttpResquest sharedManager] requestWithPUTMethod:POST
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
    
}


@end
