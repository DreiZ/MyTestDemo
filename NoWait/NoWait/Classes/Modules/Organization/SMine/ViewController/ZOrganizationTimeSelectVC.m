//
//  ZOrganizationTimeSelectVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTimeSelectVC.h"
#import "ZOrganizationTimeRightCell.h"
#import "ZOrganizationTimeLeftCell.h"


@interface ZOrganizationTimeSelectVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UITableView *iRightTableView;
@property (nonatomic,strong) UIButton *navRightBtn;



@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@property (nonatomic,strong) NSMutableArray *cellRightConfigArr;
@end

@implementation ZOrganizationTimeSelectVC

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
    _cellRightConfigArr = @[].mutableCopy;
    
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
    
    NSArray *leftTitleArr = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天"];
    for (int i = 0; i < leftTitleArr.count; i++) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.data = leftTitleArr[i];
        if (i == 0) {
            model.isSelected = YES;
        }
        ZCellConfig *channelCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTimeLeftCell className] title:[ZOrganizationTimeLeftCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationTimeLeftCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:channelCellConfig];
    }
    [self initCellRightConfigArr];
}

- (void)initCellRightConfigArr {
    [_cellRightConfigArr removeAllObjects];
    NSArray *leftTitleArr = @[@"14：50~20：50 >",@"添加时间段 >"];
    for (int i = 0; i < leftTitleArr.count; i++) {
        ZCellConfig *channelCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTimeRightCell className] title:[ZOrganizationTimeRightCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZOrganizationTimeRightCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:leftTitleArr[i]];
        [self.cellRightConfigArr addObject:channelCellConfig];
    }
    
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"选择时间"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn];

    [self.navigationItem setRightBarButtonItem:item];
}

- (void)setupMainView {
    
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.width.mas_equalTo(CGFloatIn750(204));
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
    
    [self.view addSubview:self.iRightTableView];
    [_iRightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.iTableView.mas_right);
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
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
    return _iTableView;
}

-(UITableView *)iRightTableView {
    if (!_iRightTableView) {
        _iRightTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _iRightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iRightTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if ([_iRightTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iRightTableView.estimatedRowHeight = 0;
            _iRightTableView.estimatedSectionHeaderHeight = 0;
            _iRightTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iRightTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        _iRightTableView.delegate = self;
        _iRightTableView.dataSource = self;
        _iRightTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _iRightTableView;
}


- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
//        __weak typeof(self) weakSelf = self;
        _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        [_navRightBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_navRightBtn setTitleColor:[UIColor colorMain] forState:UIControlStateNormal];
        [_navRightBtn.titleLabel setFont:[UIFont fontContent]];
        [_navRightBtn bk_whenTapped:^{
            
        }];
    }
    return _navRightBtn;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.iTableView) {
        return _cellConfigArr.count;
    }
    return _cellRightConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.iTableView) {
        ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
            ZBaseCell *cell;
            cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
            if ([cellConfig.title isEqualToString:@"ZSpaceEmptyCell"]){
        //        ZSpaceEmptyCell *enteryCell = (ZSpaceEmptyCell *)cell;
                
            }
            return cell;
    }else{
        ZCellConfig *cellConfig = [_cellRightConfigArr objectAtIndex:indexPath.row];
            ZBaseCell *cell;
            cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
            if ([cellConfig.title isEqualToString:@"ZSpaceEmptyCell"]){
        //        ZSpaceEmptyCell *enteryCell = (ZSpaceEmptyCell *)cell;
                
            }
            return cell;
    }
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.iTableView) {
        ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
        CGFloat cellHeight =  cellConfig.heightOfCell;
        return cellHeight;
    }else{
        ZCellConfig *cellConfig = _cellRightConfigArr[indexPath.row];
        CGFloat cellHeight =  cellConfig.heightOfCell;
        return cellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"address"]) {
        
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



