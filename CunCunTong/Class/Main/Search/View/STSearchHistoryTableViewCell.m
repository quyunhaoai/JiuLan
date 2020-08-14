//
//  STSearchHistoryTableViewCell.m
//  StudyOC
//
//  Created by 光引科技 on 2019/10/21.
//  Copyright © 2019 光引科技. All rights reserved.
//

#import "STSearchHistoryTableViewCell.h"
#import "AKSearchHotDataTypeView.h"
#import "GBTagListView.h"
@implementation STSearchHistoryTableViewCell
+ (instancetype)initializationCellWithTableView:(UITableView *)tableView {
    static NSString *ID  = @"STSearchHistoryTableViewCell";
    id cell  = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initCell {
    GBTagListView *tagList=[[GBTagListView alloc]initWithFrame:CGRectMake(0, 0, Window_W, 200)];
    /**允许点击 */
    tagList.canTouch=YES;
    /**可以控制允许点击的标签数 */
    tagList.canTouchNum=5;
    /**控制是否是单选模式 */
    tagList.isSingleSelect=YES;
    tagList.signalTagColor=krgb(245,245,245);
    __weak __typeof(self)weakSelf = self;
    [tagList setDidselectItemBlock:^(NSArray *arr,NSInteger tag) {
        NSLog(@"选中的标签%@",arr);
        if (weakSelf.searchHotCellLabelClickButton) {
            weakSelf.searchHotCellLabelClickButton(arr);
        }
    }];
    [self.contentView addSubview:tagList];
    self.taglistView = tagList;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setHistoryArray:(NSMutableArray *)historyArray {
    _historyArray = historyArray;
    [self.taglistView setTagWithTagArray:_historyArray];
}

@end
