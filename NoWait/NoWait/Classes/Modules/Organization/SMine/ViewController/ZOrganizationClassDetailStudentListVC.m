//
//  ZOrganizationClassDetailStudentListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationClassDetailStudentListVC.h"
#import "ZOriganizationClassStudentListCell.h"

#import "ZOriganizationTopTitleView.h"
#import "ZOrganizationClassDetailStudentListAddVC.h"
@interface ZOrganizationClassDetailStudentListVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;

@property (nonatomic,strong) ZOriganizationTopTitleView *topView;

@end

@implementation ZOrganizationClassDetailStudentListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZBaseCellModel *cellModel = [[ZBaseCellModel alloc] init];
    if (self.isOpen) {
        cellModel.data = @"";
    }
    
    ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationClassStudentListCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZOriganizationClassStudentListCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
    [self.cellConfigArr addObject:textCellConfig];
  
    [self.cellConfigArr addObject:textCellConfig];
    [self.cellConfigArr addObject:textCellConfig];
    [self.cellConfigArr addObject:textCellConfig];
    [self.cellConfigArr addObject:textCellConfig];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"学员列表"];
    
    if (self.isOpen) {
        
    }else{
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn]] ;
    }
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(90));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
     make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
     make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
     make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
     make.top.equalTo(self.topView.mas_bottom).offset(-CGFloatIn750(0));
    }];
}

#pragma mark lazy loading...
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(118), CGFloatIn750(50))];
        [_navLeftBtn setTitle:@"加入学员" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontSmall]];
        [_navLeftBtn setBackgroundColor:[UIColor colorMain] forState:UIControlStateNormal];
        ViewRadius(_navLeftBtn, CGFloatIn750(25));
        [_navLeftBtn bk_whenTapped:^{
            ZOrganizationClassDetailStudentListAddVC *avc = [[ZOrganizationClassDetailStudentListAddVC alloc] init];
            [weakSelf.navigationController pushViewController:avc animated:YES];
        }];
    }
    return _navLeftBtn;
}

- (ZOriganizationTopTitleView *)topView {
    if (!_topView) {
        _topView = [[ZOriganizationTopTitleView alloc] init];
        if (self.isOpen) {
            _topView.titleArr = @[@"姓名", @"上课进度", @"签到详情"];
        }else{
            _topView.titleArr = @[@"姓名", @"上课进度", @"签到详情" , @"操作"];
        }
    }
    return _topView;
}

@end
