//
//  STSearchHistoryTableViewCell.h
//  StudyOC
//
//  Created by 光引科技 on 2019/10/21.
//  Copyright © 2019 光引科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKSearchHotDataTypeView.h"
#import "GBTagListView.h"
NS_ASSUME_NONNULL_BEGIN

@interface STSearchHistoryTableViewCell : UITableViewCell
@property (strong, nonatomic) NSMutableArray *historyArray;  //  数组
@property (strong, nonatomic) GBTagListView *taglistView; 


@property (strong, nonatomic) AKSearchHotDataTypeView *searchHotDataTypeView; // hot 视图

+ (instancetype)initializationCellWithTableView:(UITableView *)tableView;

/*
 *  AKSearchHotCell label click block
 */
@property (copy, nonatomic) void(^searchHotCellLabelClickButton)(NSArray *arr);
@end

NS_ASSUME_NONNULL_END
