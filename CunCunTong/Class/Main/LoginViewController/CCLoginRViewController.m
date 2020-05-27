//
//  CCLoginRViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCLoginRViewController.h"
#import "CCLonginTextInputVIew.h"
@interface CCLoginRViewController ()<UITextFieldDelegate,KKCommonDelegate>
@property (weak, nonatomic) IBOutlet UIView *MiddeView;
@property (strong,nonatomic) CCLonginTextInputVIew *inTextView;

@property (nonatomic,copy) NSString *mobleNumber;
@property (nonatomic,copy) NSString *codeAndPassworld;

@property (assign, nonatomic) int                                captchaTimeout;
@property (strong, nonatomic) dispatch_source_t                  timer;
@property (nonatomic, copy) NSString                             *verCode;  //
@end

@implementation CCLoginRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupUI];
    [self initData];
}

- (void)initData {
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setupUI {
    self.MiddeView.layer.cornerRadius = 5;
    self.MiddeView.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
    self.MiddeView.alpha = 1;

    [[CCTools sharedInstance] addShadowToView:self.MiddeView withColor: [UIColor colorWithRed:16.0f/255.0f green:117.0f/255.0f blue:113.0f/255.0f alpha:0.2f]];
    [self.MiddeView addSubview:self.inTextView];
    [self.inTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.MiddeView);
    }];
    self.inTextView.delegate = self;
    self.inTextView.moblieTextField.delegate = self;
    self.inTextView.keyTextField.delegate = self;
    [_inTextView.keyTextField addTarget:self
                                        action:@selector(textFieldDidChange:)
                              forControlEvents:UIControlEventEditingChanged];
    [_inTextView.moblieTextField addTarget:self
                                          action:@selector(textFieldDidChange:)
                                forControlEvents:UIControlEventEditingChanged];
    NSLog(@"width:%.f",self.view.frame.size.width);
    
}
- (void)jumpBtnClicked:(id)item {
  UIButton *button = (UIButton *)item;
    if (button.tag == BUTTON_TAG(7)) {//登录
        XYWeakSelf;
        NSDictionary *params = @{};
        NSString *path = @"";
        _mobleNumber = checkNull(_mobleNumber);
        _codeAndPassworld = checkNull(_codeAndPassworld);
        if (self.inTextView.isPassWorldLogin) {
            params = @{@"mobile":_mobleNumber,
                       @"type":@(0),
                       @"password":_codeAndPassworld,
            };
            path = @"/app/loginbypassword/";///app/loginbypassword/
        } else {
            params = @{@"mobile":_mobleNumber,
                       @"type":@(0),
                       @"code":_codeAndPassworld,
            };
            path = @"/app/loginsendsmscode/";
        }
        [[STHttpResquest sharedManager] requestWithMethod:POST
                                                 WithPath:path
                                               WithParams:params
                                         WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            NSInteger status = [[dic objectForKey:@"errno"] integerValue];
            NSString *msg = [[dic objectForKey:@"errmsg"] description];
            if(status == 0){
                NSDictionary *data = dic[@"data"];
                NSString *token = data[@"jwtoken"];
                NSString *centerID = data[@"centerID"];
                NSString *marketID = data[@"marketID"];
                NSString *name = data[@"name"];
                [[NSUserDefaults standardUserDefaults] setObject:centerID forKey:@"centerID"];
                [[NSUserDefaults standardUserDefaults] setObject:marketID forKey:@"marketID"];
                [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
                [kNotificationCenter postNotificationName:@"refreshMyInfo" object:nil];
            }else {
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
            }
        } WithFailurBlock:^(NSError * _Nonnull error) {
            
        }];
    } else {//验证码
        //获取验证码。。。
        [self.view endEditing:YES];
        _mobleNumber = checkNull(_mobleNumber);
        NSDictionary *params = @{@"mobile":_mobleNumber,
                                 @"type":@(0),
        };
        XYWeakSelf;
        [[STHttpResquest sharedManager] requestWithMethod:POST
                                                 WithPath:@"/app/loginsendsmscode/"
                                               WithParams:params
                                         WithSuccessBlock:^(NSDictionary * _Nonnull dic) {

            NSInteger status = [[dic objectForKey:@"errno"] integerValue];
            NSString *msg = [[dic objectForKey:@"errmsg"] description];
            if(status == 0){
                if(weakSelf.captchaTimeout>0) return;
                weakSelf.captchaTimeout = 60;
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
                weakSelf.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
                dispatch_source_set_timer(weakSelf.timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
                    dispatch_source_set_event_handler(weakSelf.timer, ^{
                        if(weakSelf.captchaTimeout <= 0)
                        {
                            dispatch_source_cancel(weakSelf.timer);
                            dispatch_async(dispatch_get_main_queue(), ^{
                                button.enabled = YES;
                                [button setTitle:@"获取验证码" forState:UIControlStateNormal];
                            });
                        }
                        else
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                button.enabled = NO;
                                NSString *strTime = [NSString stringWithFormat:@"%.2d秒后重试",weakSelf.captchaTimeout];
                                [button setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                                weakSelf.captchaTimeout--;
                            });
                        }
                    });
                dispatch_resume(weakSelf.timer);
            }else {
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
            }
        } WithFailurBlock:^(NSError * _Nonnull error) {

        }];
    }
}
#pragma mark  -  textfiledDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}
- (NSString *)SubStringfrom:(UITextField *)textField andLength:(NSUInteger )length {
    NSString *str1 =   [self getSubString:textField.text AndLength:length];
    textField.text = str1;
    return textField.text;
}
/**
 判断输入的是不是数字
 */
- (BOOL)inputShouldNumber:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}
/**
 *  限制字符长度的
 */
-(NSString *)getSubString:(NSString*)string AndLength:(NSInteger)length
{
    if (string.length > length) {
        return [string substringToIndex:length];
    }else {
        return string;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {

}
- (void)textFieldDidEndEditing:(UITextField *)textField {

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == _inTextView.keyTextField) {
        _codeAndPassworld = [self SubStringfrom:textField andLength:18];
    } else if (textField == _inTextView.moblieTextField) {
        _mobleNumber = [self SubStringfrom:textField andLength:11];
        if (_mobleNumber.length>0) {
            [_inTextView.longinBtn setUserInteractionEnabled:YES];
            [_inTextView.longinBtn setBackgroundColor:kMainColor];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}
#pragma get

- (CCLonginTextInputVIew *)inTextView {
    if (!_inTextView) {
        _inTextView = [[CCLonginTextInputVIew alloc] init];
    }
    
    return _inTextView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
