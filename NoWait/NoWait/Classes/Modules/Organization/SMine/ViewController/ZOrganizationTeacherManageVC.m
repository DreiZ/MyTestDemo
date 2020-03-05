//
//  ZOrganizationTeacherManageVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeacherManageVC.h"
#import "ZOrganizationTeacherSearchVC.h"
#import "ZOrganizationTeacherAddVC.h"

#import "ZOriganizationTeachListCell.h"
#import "ZOriganizationTeachSwitchView.h"
#import "ZOriganizationTeachSearchTopHintView.h"

#import "ZAlertDataModel.h"
#import "ZAlertDataPickerView.h"

#import "ZOrganizationTeacherDetailVC.h"

@interface ZOrganizationTeacherManageVC ()
@property (nonatomic,strong) UIButton *navRightBtn;
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIButton *bottomBtn;

@property (nonatomic,strong) ZOriganizationTeachSwitchView *switchView;
@property (nonatomic,strong) ZOriganizationTeachSearchTopHintView *searchView;

@end

@implementation ZOrganizationTeacherManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
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
    [super setupMainView];
    
    [self.view addSubview:self.switchView];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(126));
    }];
    
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.switchView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(126));
    }];
   
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(88));
        make.bottom.equalTo(self.view).offset(-safeAreaBottom());
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
        make.bottom.equalTo(self.bottomBtn.mas_top).offset(-CGFloatIn750(0));
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
        __weak typeof(self) weakSelf = self;
        _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        _navRightBtn.layer.masksToBounds = YES;
        _navRightBtn.layer.cornerRadius = 3;
        _navRightBtn.backgroundColor = [UIColor  colorMain];
        [_navRightBtn setTitle:@"添加" forState:UIControlStateNormal];
        [_navRightBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_navRightBtn.titleLabel setFont:[UIFont fontSmall]];
        [_navRightBtn bk_whenTapped:^{
            ZOrganizationTeacherAddVC *avc = [[ZOrganizationTeacherAddVC alloc] init];
            [weakSelf.navigationController pushViewController:avc animated:YES];
        }];
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
            [ZAlertDataPickerView setAlertName:@"校区选择" items:mainItems handlerBlock:^(NSInteger index, NSInteger subIndex) {
                
            }];
        };
    }
    return _switchView;
}


- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
//        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:[UIColor colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            
        }];
    }
    return _bottomBtn;
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


#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig  {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZOriganizationTeachListCell"]){
        ZOriganizationTeachListCell *enteryCell = (ZOriganizationTeachListCell *)cell;
        enteryCell.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                ZOrganizationTeacherDetailVC *dvc = [[ZOrganizationTeacherDetailVC alloc] init];
                [weakSelf.navigationController pushViewController:dvc animated:YES];
            }
        };
    }
}
@end
