//
//  AJ_TopBar.m
//  YiRenShi新版
//
//  Created by wuweijian on 15/11/30.
//  Copyright © 2015年 wuweijian. All rights reserved.
//

#import "AJ_TopBar.h"

@interface AJ_TopBar () {
    BOOL    _isEnable;//    是否可点击
}

@property (nonatomic, strong) UIView          *markView;
@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;

@property (nonatomic,strong)  UIButton        *currentButton;

@end

@implementation AJ_TopBar

//获取buttons的宽度
- (NSMutableArray *)getButtonsWidthWithTitles:(NSArray *)titles {
    _isEnable = YES;
    NSMutableArray *widths = [@[] mutableCopy];
    for (NSString *title in titles) {
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:FONT_18}];
        NSNumber *width = [NSNumber numberWithFloat:size.width + 15];
        [widths addObject:width];
    }
    return widths;
}

- (void)setTitles:(NSMutableArray *)titles{
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator   = NO;
    _titles = titles;
    self.widths  = [self getButtonsWidthWithTitles:self.titles];
    self.buttons = [ NSMutableArray array];
    CGFloat padding = kWidth(24);
    CGFloat originX = 0;
    [self.buttons removeAllObjects];
    for (UIButton *button in self.subviews) {
        [button removeFromSuperview];
    }
    for (NSInteger i = 0; i < titles.count; i++) {
        if ([_titles[i] isKindOfClass:[NSNull class]]) {
            continue;
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tintColor = [UIColor clearColor];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        [button setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
        [button setTitleColor:self.buttonTitleSelectedColor forState:UIControlStateSelected];
        [button.titleLabel setFont:[UIFont fontWithName:@"AdobeHeitiStd-Regular" size:15]];
        CGRect frame;
        if (self.buttonWidth) {
              frame = CGRectMake(originX,0,self.buttonWidth,self.height);
        }
        else{
              frame = CGRectMake(originX, 0, [self.widths[i] floatValue], self.height );
        }
        button.frame = frame;
        originX = CGRectGetMaxX(frame) + padding;
        if (i == self.currentPage) {
            button.selected = YES;
        }
        [self addSubview:button];
        [self.buttons addObject:button];
    }
    self.contentSize = CGSizeMake(CGRectGetMaxX([self.buttons.lastObject frame]),self.frame.size.height);
    UIButton *firstButton = self.buttons[_currentPage];
//    firstButton.titleLabel.font = FONT_18;
//    firstButton.titleLabel.textColor = self.buttonTitleSelectedColor;
    self.currentButton = firstButton;
    self.markView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(firstButton.frame)+4, 30, 2)];
    self.markView.centerX = firstButton.centerX;
    _markView.backgroundColor = self.markcolor;
    [self addSubview:_markView];
}

- (void)buttonClick:(id)sender {
    if (_isEnable == YES) {
        _isEnable = NO;
        UIButton *button = (UIButton *)sender;
        for (id btn in self.subviews) {
            if ([btn isKindOfClass:[UIButton class]]) {
                UIButton *bun = (UIButton *)btn;
                if ([bun.titleLabel.text isEqualToString:button.titleLabel.text]) {
                    _currentButton = button;
                    button.selected = YES;
//                    [button setTintColor:[UIColor clearColor]];
//                    [button setTitleColor:self.buttonTitleSelectedColor forState:UIControlStateSelected];
//                    [button.titleLabel setFont:FONT_18];
                    self.currentPage = [self.buttons indexOfObject:button];
//                    if (self.dramaIdArray && self.dramaIdArray.count > 0) {
                        NSInteger dramaId = [self.dramaIdArray[self.currentPage] integerValue];
                        if (_blockHandler) {
                            _blockHandler(dramaId);
                        }
//                    } else {
//                        if (_blockHandler) {
//                            _blockHandler(self.currentPage);
//                        }
//                    }
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self->_isEnable = YES;
                    });
                } else {
                    bun.selected = NO;
//                    bun.titleLabel.font = FONT_16;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self->_isEnable = YES;
                    });
                }
            }
        }
    }
}
- (void)setCurrentPage:(NSInteger)currentPage {
    if (_currentPage >= _buttons.count) {
        _currentPage = 0;
    }
    UIButton *lastButton = [_buttons objectAtIndex:_currentPage];
    [lastButton.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:15]];//PingFangSC-Regular
    lastButton.selected  = NO;
    _currentPage = currentPage;
    UIButton *button = [_buttons objectAtIndex:_currentPage];
    button.selected = YES;
    [button.titleLabel setFont:[UIFont fontWithName:@"AdobeHeitiStd-Regular" size:15]];
    button.titleLabel.textColor = self.buttonTitleSelectedColor;
    CGRect frame = button.frame;
    frame.origin.x -= 5;
    frame.size.width += 10;
    [self scrollRectToVisible:frame animated:NO];
    CGFloat width = (self.frame.size.width)/2;
    CGFloat offsetX = 0;
    if (CGRectGetMaxX(frame) <= width) {
        offsetX = 0;
    }
    else if (CGRectGetMidX(frame) + width >= self.contentSize.width) {
        offsetX = self.contentSize.width - CGRectGetWidth(self.frame);
    }
    else if (offsetX < 0) {
        offsetX = 0;
    } else {
        offsetX = CGRectGetMidX(frame)-CGRectGetWidth(self.frame)/2;
    }
    if (offsetX < 0) {
        offsetX = 0;
    }
    [self setContentOffset:CGPointMake(offsetX, 0) animated:NO];
    
    self.markView.frame = CGRectMake(button.frame.origin.x, self.height - 6, 30, 2);
    self.markView.centerX = button.centerX;

//    [UIView animateWithDuration:0.0f animations:^{
//        self.markView.frame = CGRectMake(button.frame.origin.x, self.height - 4, 30, 2);
//        self.markView.centerX = button.centerX;
//    }];
}
@end
