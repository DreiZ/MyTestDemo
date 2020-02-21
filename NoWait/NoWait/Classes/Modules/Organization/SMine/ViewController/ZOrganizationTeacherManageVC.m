//
//  ZOrganizationTeacherManageVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeacherManageVC.h"
#import "ZOrganizationTeacherSearchVC.h"

#import "ZOriganizationTeachListCell.h"
#import "ZOriganizationTeachSwitchView.h"
#import "ZOriganizationTeachSearchTopHintView.h"

#import "ZAlertDataModel.h"
#import "ZAlertDataPickerView.h"

@interface ZOrganizationTeacherManageVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIButton *navRightBtn;
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) ZOriganizationTeachSwitchView *switchView;
@property (nonatomic,strong) ZOriganizationTeachSearchTopHintView *searchView;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZOrganizationTeacherManageVC

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
    
    for (int i = 0; i < 12; i++) {
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTeachListCell className] title:[ZOriganizationTeachListCell className] showInfoMethod:nil heightOfCell:[ZOriganizationTeachListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [self.cellConfigArr addObject:progressCellConfig];
    } 
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"教师管理"];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn]];
}

- (void)setupMainView {
    
    [self.view addSubview:self.switchView];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(126));
    }];
    
    [self.view addSubview:self.iTableView];
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.switchView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(126));
    }];
   
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
        make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(20));
        make.top.equalTo(self.searchView.mas_bottom).offset(-CGFloatIn750(20));
    }];
}

#pragma mark lazy loading...
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        [_navLeftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontSmall]];
    }
    return _navLeftBtn;
}

- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        _navRightBtn.layer.masksToBounds = YES;
        _navRightBtn.layer.cornerRadius = 3;
        _navRightBtn.backgroundColor = [UIColor  colorMain];
        [_navRightBtn setTitle:@"添加" forState:UIControlStateNormal];
        [_navRightBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_navRightBtn.titleLabel setFont:[UIFont fontSmall]];
    }
    return _navRightBtn;
}

- (ZOriganizationTeachSwitchView *)switchView {
    if (!_switchView) {
        _switchView = [[ZOriganizationTeachSwitchView alloc] init];
        _switchView.handleBlock = ^(NSInteger index) {
            NSMutableArray *mainItems = @[].mutableCopy;
            NSMutableArray *items = @[].mutableCopy;
            NSArray *temp = @[@"徐州",@"南京"];
            for (int i = 0; i < temp.count; i++) {
                ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
                model.name = temp[i];
                
                NSMutableArray *subItems = @[].mutableCopy;
                
                NSArray *temp = @[@"篮球俱乐部",@"排球俱乐部",@"摄氏度",@"足球"];
                for (int i = 0; i < temp.count; i++) {
                    ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
                    model.name = temp[i];
                    [subItems addObject:model];
                }
                model.ItemArr = subItems;
                [items addObject:model];
            }
            
            [mainItems addObjectsFromArray:items];
            [ZAlertDataPickerView setAlertName:@"校区选择" items:mainItems handlerBlock:^(NSInteger index) {
                
            }];
        };
    }
    return _switchView;
}

- (ZOriganizationTeachSearchTopHintView *)searchView {
    if (!_searchView) {
        __weak typeof(self) weakSelf = self;
        _searchView = [[ZOriganizationTeachSearchTopHintView alloc] init];
        _searchView.handleBlock = ^(NSInteger index) {
            ZOrganizationTeacherSearchVC *svc = [[ZOrganizationTeacherSearchVC alloc] init];
            [weakSelf.navigationController pushViewController:svc animated:YES];
        };
    }
    return _searchView;
}


-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.showsHorizontalScrollIndicator = NO;
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
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_iTableView, CGFloatIn750(18));
        UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(20))];
        topLineView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(20))];
        bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iTableView.tableHeaderView = topLineView;
        _iTableView.tableFooterView = bottomLineView;
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
    if ([cellConfig.title isEqualToString:@"ZSpaceEmptyCell"]){
//        ZSpaceEmptyCell *enteryCell = (ZSpaceEmptyCell *)cell;
        
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



