//
//  ZMineSwitchRoleVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/29.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineSwitchRoleVC.h"
#import "ZStudentMineSettingSwitchUserCell.h"

#import "ZStudentMineSwitchAccountLoginVC.h"
#import "ZLoginViewModel.h"

@interface ZMineSwitchRoleVC ()
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIImageView *backImageView;

@end

@implementation ZMineSwitchRoleVC

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self refreshData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
    
}

#pragma mark - set data

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"切换身份";
        model.cellTitle = @"title";
        model.leftFont = [UIFont boldSystemFontOfSize:CGFloatIn750(52)];
        model.leftMargin = CGFloatIn750(50);
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(126);
        
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:titleCellConfig];
    }
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZUserRolesListModel *user = self.dataSources[i];
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.cellTitle = @"user";
        if ([user.type isEqualToString:[ZUserHelper sharedHelper].user.type]) {
            model.isSelected = YES;
        }else{
            model.isSelected = NO;
        }
        model.data = self.dataSources[i];
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingSwitchUserCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineSettingSwitchUserCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    if (self.cellConfigArr.count < 2) {
        [self.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(40))];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"换个新账号登录";
        model.rightImage = isDarkModel() ? @"rightBlackArrowDarkN" : @"rightBlackArrowN";
        model.cellTitle = @"switch";
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = YES;
    
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    [self.navigationItem setTitle:@"切换身份"];
}


#pragma mark - lazy loading...
- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(88))];
        __weak typeof(self) weakSelf  = self;
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [backBtn bk_addEventHandler:^(id sender) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CGFloatIn750(98));
            make.top.bottom.left.equalTo(self.navView);
        }];
        
        [backBtn addSubview:self.backImageView];
        [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(backBtn);
        }];
    }
    
    return _navView;
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [[UIImage imageNamed:@"navleftBack"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _backImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorWhite]);
    }
    return _backImageView;
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if ([cellConfig.title isEqualToString:@"user"]){
         ZBaseSingleCellModel *cellModel = (ZBaseSingleCellModel *)cellConfig.dataModel;
//         if (!cellModel.isSelected) {
//             [ZUserHelper sharedHelper].user.type = [NSString stringWithFormat:@"%d",arc4random()%3];
//             [self.navigationController popToRootViewControllerAnimated:YES];
//             ZUser *user = cellModel.data;
//             [[ZUserHelper sharedHelper] switchUser:user];
//             [self initCellConfigArr];
//             [self.iTableView reloadData];
             
             ZStudentMineSwitchAccountLoginVC *lvc = [[ZStudentMineSwitchAccountLoginVC alloc] init];
             lvc.model = cellModel.data;
             [self.navigationController pushViewController:lvc animated:YES];
//         }
         
     }
}


#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    _backImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorBlackBGDark]);
    // darkmodel change
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


#pragma mark - refresha
- (void)refreshData {
    __weak typeof(self) weakSelf = self;
    [ZLoginViewModel getUserRolesWithBlock:^(BOOL isSuccess, ZUserRolesListNetModel *data) {
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}
@end
