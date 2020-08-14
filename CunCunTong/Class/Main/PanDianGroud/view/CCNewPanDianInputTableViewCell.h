//
//  CCNewPanDianInputTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/29.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKButton.h"
#import "CCAddPanDianModel.h"
#import "LMJDropdownMenu.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCNewPanDianInputTableViewCell : UITableViewCell<LMJDropdownMenuDelegate,LMJDropdownMenuDataSource>
{
        LMJDropdownMenu * menu1;
}

@property (weak, nonatomic) IBOutlet KKButton *timeBtn;
@property (weak, nonatomic) IBOutlet UILabel *unit1;
@property (weak, nonatomic) IBOutlet UILabel *unit2;
@property (weak, nonatomic) IBOutlet UILabel *unit3;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextField *textField3;
@property (strong, nonatomic) NSMutableArray *dataArray;  //  
@property (weak, nonatomic) IBOutlet UILabel *stokLab;
@property (strong, nonatomic) NSArray *unitArray;   // 
@property (strong, nonatomic) Batch_setItemBBB *item;
@property (weak, nonatomic) IBOutlet UILabel *pandianLab;

@property (weak, nonatomic) IBOutlet UIButton *delegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidth;

@end

NS_ASSUME_NONNULL_END
