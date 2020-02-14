//
//  ZStudentMineSettingVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingVC.h"
#import "ZCellConfig.h"
#import "ZStudentDetailModel.h"

#import "ZSpaceEmptyCell.h"
#import "ZStudentMineSignListCell.h"
#import "ZStudentLessonOrderCompleteCell.h"
#import "ZStudentMineSettingBottomCell.h"

#import "ZStudentMineSignDetailVC.h"
#import "ZStudentMineSettingMineVC.h"
#import "ZStudentMineSettingCommonVC.h"
#import "ZStudentMineSettingSafeVC.h"
#import "ZStudentMineSettingAboutUsVC.h"
#import "ZStudentMineSwitchAccountVC.h"
#import "ZUserHelper.h"


@interface ZStudentMineSettingVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end
@implementation ZStudentMineSettingVC

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
    
    NSArray <NSArray *>*titleArr = @[@[@"个人信息", @"mineLessonRight",@"us"], @[@"账号与安全", @"mineLessonRight",@"safe"],@[@"通用", @"mineLessonRight",@"common"],@[@"关于小莫", @"mineLessonRight",@"about"]];
    
    for (int i = 0; i < titleArr.count; i++) {
        ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
        model.leftTitle = titleArr[i][0];
        model.rightImage = titleArr[i][1];
        model.leftFont = [UIFont systemFontOfSize:CGFloatIn750(28)];
        model.cellTitle = titleArr[i][2];
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
 
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG])];
    [self.cellConfigArr addObject:topCellConfig];
    
    ZCellConfig *switchCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"switch" showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentMineSettingBottomCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"切换账号"];
    [self.cellConfigArr addObject:switchCellConfig];
    
    [self.cellConfigArr addObject:topCellConfig];
    
    ZCellConfig *loginOutCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"logout" showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentMineSettingBottomCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"退出登录"];
    [self.cellConfigArr addObject:loginOutCellConfig];
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"设置"];
}

- (void)setupMainView {
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
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
        _iTableView.backgroundColor = KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG]);
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
    if ([cellConfig.title isEqualToString:@"ZStudentMineSignListCell"]){
        ZStudentMineSignListCell *enteryCell = (ZStudentMineSignListCell *)cell;
        enteryCell.handleBlock = ^(NSInteger type) {
            ZStudentMineSignDetailVC *dvc = [[ZStudentMineSignDetailVC alloc] init];
            
            [self.navigationController pushViewController:dvc animated:YES];
        };
        
    }
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
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
     if ([cellConfig.title isEqualToString:@"us"]){
         ZStudentMineSettingMineVC *dvc = [[ZStudentMineSettingMineVC alloc] init];
         [self.navigationController pushViewController:dvc animated:YES];
     }else if ([cellConfig.title isEqualToString:@"common"]) {
         ZStudentMineSettingCommonVC *cvc = [[ZStudentMineSettingCommonVC alloc] init];
         [self.navigationController pushViewController:cvc animated:YES];
     }else if ([cellConfig.title isEqualToString:@"safe"]) {
         ZStudentMineSettingSafeVC *svc = [[ZStudentMineSettingSafeVC alloc] init];
         [self.navigationController pushViewController:svc animated:YES];
     }else if( [cellConfig.title isEqualToString:@"about"]){
         ZStudentMineSettingAboutUsVC *avc = [[ZStudentMineSettingAboutUsVC alloc] init];
         [self.navigationController pushViewController:avc animated:YES];
     }else if ([cellConfig.title isEqualToString:@"logout"]){
         [[ZUserHelper sharedHelper] loginOutUser:[ZUserHelper sharedHelper].user];
     }else if ([cellConfig.title isEqualToString:@"switch"]){
         ZStudentMineSwitchAccountVC *accountvc = [[ZStudentMineSwitchAccountVC alloc] init];
         [self.navigationController pushViewController:accountvc animated:YES];
     }
    
    
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





