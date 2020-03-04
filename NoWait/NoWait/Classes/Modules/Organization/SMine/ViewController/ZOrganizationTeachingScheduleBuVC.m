//
//  ZOrganizationTeachingScheduleBuVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeachingScheduleBuVC.h"
#import "ZOrganizationTeachingScheduleBuCell.h"

#import "ZOrganizationLessonDetailVC.h"
#import "ZOrganizationTrachingScheduleNewClassVC.h"

@interface ZOrganizationTeachingScheduleBuVC ()
@property (nonatomic,strong) UIButton *bottomBtn;

@end

@implementation ZOrganizationTeachingScheduleBuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTeachingScheduleBuCell className] title:[ZOrganizationTeachingScheduleBuCell className] showInfoMethod:nil heightOfCell:[ZOrganizationTeachingScheduleBuCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
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
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.bottomBtn.mas_top).offset(-CGFloatIn750(0));
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
