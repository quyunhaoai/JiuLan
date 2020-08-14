

//
//  CCSelectGoodsViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSelectGoodsViewController.h"
#import "CCGoodsSelectModel.h"
#import "CCSearchView.h"
#import "CCGoodsSelectModelTableViewCell.h"
@interface CCSelectGoodsViewController ()<UITextFieldDelegate,KKCommonDelegate>

@property (weak, nonatomic) IBOutlet UILabel *sumLab;
@property (nonatomic,copy) NSString *search;
@property (strong, nonatomic)  CCSearchView *searchView;
@property (strong, nonatomic) NSMutableArray *selectArray;


@end

@implementation CCSelectGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:self.titleStr];
    self.search=@"";
    self.view.backgroundColor = UIColorHex(0xf7f7f7);
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT + 44);
        make.bottom.mas_equalTo(self.view).mas_offset(-44);
    }];
    self.baseTableView = self.tableView;
    [self setupUI];
    [self initData];
}
- (void)setupUI {
    CCSearchView *searchView = [CCSearchView new];
    [self.view addSubview:searchView];
    [searchView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.left.right.mas_equalTo(self.view).mas_offset(0);
        make.height.mas_equalTo(44);
    }];
    [searchView.searchTextField addTarget:self action:@selector(textfiledChange:) forControlEvents:UIControlEventValueChanged];
    searchView.searchTextField.delegate = self;
    self.searchView = searchView;
}
#pragma mark  -  textfiledDelegate
- (void)textfiledChange:(UITextField *)textField {
    self.search = textField.text;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}
- (NSString *)SubStringfrom:(UITextField *)textField andLength:(NSUInteger )length {
    return textField.text;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.search = textField.text;
    textField.text = @"";
    self.page = 0;
    [self.dataSoureArray removeAllObjects];
    [self initData];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

- (IBAction)selectOver:(id)sender {
    XYWeakSelf;
    NSDictionary *params = @{@"category_id":self.catedity,
                             @"center_sku_id_list":self.selectArray,
    };
    NSString *path = @"";
    if (self.isSales) {
        path =[self.paindianID intValue] ? [NSString stringWithFormat:@"/app0/salescentersku/%@/",self.paindianID] : @"/app0/salescentersku/";
    } else {
        path =[self.paindianID intValue] ? [NSString stringWithFormat:@"/app0/reckoncentersku/%@/",self.paindianID] : @"/app0/reckoncentersku/";
    }
    [[STHttpResquest sharedManager] requestWithPUTMethod:[self.paindianID intValue] ? PUT :POST
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [kNotificationCenter postNotificationName:@"initData" object:nil];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];

}

- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{@"category_id":self.catedity,
                             @"limit":@(10),
                             @"offset":@(self.page*10),
                             @"search":self.search,
    };
    NSString *path = @"/app0/reckoncentersku/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            NSString *next = data[@"next"];
            NSArray *array = data[@"results"];
            if (weakSelf.page) {
                [weakSelf.dataSoureArray addObjectsFromArray:array];
            } else {
                weakSelf.dataSoureArray = array.mutableCopy;
                if (weakSelf.dataSoureArray.count) {
                    weakSelf.showTableBlankView = NO;
                } else {
                    weakSelf.showTableBlankView = YES;
                }
            }
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            if ([next isKindOfClass:[NSNull class]] || next == nil) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [weakSelf.tableView.mj_footer resetNoMoreData];
            }
            [weakSelf.tableView reloadData];
            weakSelf.page++;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}
#pragma mark  -  kkcommonDelegate
- (void)clickButtonWithType:(KKBarButtonType)type item:(id)item {
    CCGoodsSelectModel *model = (CCGoodsSelectModel *)item;
    if (type == 0) {
        if ([self.selectArray containsObject:[NSNumber numberWithInteger:model.id]]) {
            [self.selectArray removeObject:[NSNumber numberWithInteger:model.id]];
        }
    } else {
        if (![self.selectArray containsObject:[NSNumber numberWithInteger:model.id]]) {
            [self.selectArray addObject:[NSNumber numberWithInteger:model.id]];
        }
    }

    self.sumLab.text = [NSString stringWithFormat:@"已选择（%ld）",self.selectArray.count];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView model:[CCGoodsSelectModel modelWithJSON:self.dataSoureArray[indexPath.row]] indexPath:indexPath];
    [(CCGoodsSelectModelTableViewCell *)cell setDelegate:self];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 133;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self tableViewDidSelect:indexPath];
}
#pragma mark  -  get
- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [[NSMutableArray alloc] init];
    }
    return _selectArray;
}
@end
