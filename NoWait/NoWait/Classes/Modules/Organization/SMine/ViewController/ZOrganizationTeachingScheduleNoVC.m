//
//  ZOrganizationTeachingScheduleNoVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeachingScheduleNoVC.h"
#import "ZOrganizationTeachingScheduleNoCell.h"

#import "ZOrganizationTrachingScheduleNewClassVC.h"

@interface ZOrganizationTeachingScheduleNoVC ()
@property (nonatomic,strong) UIButton *bottomBtn;

@end

@implementation ZOrganizationTeachingScheduleNoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTeachingScheduleNoCell className] title:[ZOrganizationTeachingScheduleNoCell className] showInfoMethod:nil heightOfCell:[ZOrganizationTeachingScheduleNoCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"课程列表"];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(96));
        make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
        make.bottom.equalTo(self.bottomBtn.mas_top).offset(-CGFloatIn750(0));
        make.top.equalTo(self.view.mas_top).offset(-CGFloatIn750(0));
    }];
}


#pragma mark lazy loading...
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"新建排课" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            ZOrganizationTrachingScheduleNewClassVC *successvc = [[ZOrganizationTrachingScheduleNewClassVC alloc] init];
            [weakSelf.navigationController pushViewController:successvc animated:YES];
        }];
    }
    return _bottomBtn;
}


@end
