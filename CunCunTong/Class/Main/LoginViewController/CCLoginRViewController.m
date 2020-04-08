//
//  CCLoginRViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCLoginRViewController.h"
#import "CCLonginTextInputVIew.h"
@interface CCLoginRViewController ()
@property (weak, nonatomic) IBOutlet UIView *MiddeView;
@property (strong,nonatomic) CCLonginTextInputVIew *inTextView;
@end

@implementation CCLoginRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupUI];
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
    
    NSLog(@"width:%.f",self.view.frame.size.width);
}

#pragma get

- (CCLonginTextInputVIew *)inTextView {
    if (!_inTextView) {
        _inTextView = [[CCLonginTextInputVIew alloc] init];
    }
    
    return _inTextView;
}





- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
