//
//  ZStudentMineChangePasswordVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineChangePasswordVC.h"
#import "ZCellConfig.h"
#import "ZStudentDetailModel.h"

#import "ZSpaceEmptyCell.h"
#import "ZTextFieldCell.h"

@interface ZStudentMineChangePasswordVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end
@implementation ZStudentMineChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setDataSource];
    [self initCellConfigArr];
    [self setupMainView];
}

- (void)setDataSource {
    _dataSources = @[].mutableCopy;
    _cellConfigArr = @[].mutableCopy;
    
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
    
    NSArray <NSArray *>*titleArr = @[@[@"旧密码", @"请填写密码"],@[@"新密码", @"请输入密码"],@[@"确认新密码", @"确认新密码"]];
    
    for (int i = 0; i < titleArr.count; i++) {
        ZBaseTextFieldCellModel *model = [[ZBaseTextFieldCellModel alloc] init];
        model.leftTitle = titleArr[i][0];
        model.placeholder = titleArr[i][1];
//        model.subTitle = @"(必选)";
        model.leftContentWidth = CGFloatIn750(226);
        model.isHiddenInputLine = YES;
        model.textAlignment = NSTextAlignmentLeft;
        if (i == titleArr.count - 1) {
            model.isHiddenLine = YES;
        }
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"修改密码"];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = KMainColor;
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [sureBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:sureBtn]];
}

- (void)setupMainView {
    self.view.backgroundColor = KBackColor;
    
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(20));
        make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(20));
        make.height.mas_equalTo(kCellNormalHeight * 3);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
    self.iTableView.layer.masksToBounds = YES;
    self.iTableView.layer.cornerRadius = CGFloatIn750(18);
    
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    hintLabel.textColor = KFont9Color;
    hintLabel.text = @"密码长度8-16位字符，而且包含数字和字母";
    hintLabel.textAlignment = NSTextAlignmentLeft;
    [hintLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.view addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iTableView.mas_left).offset(CGFloatIn750(28));
        make.top.equalTo(self.iTableView.mas_bottom).offset(CGFloatIn750(20));
    }];
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.backgroundColor = KWhiteColor;
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
    }
    return _iTableView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
 
}

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
@end








