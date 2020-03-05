//
//  ZOrganizationClassDetailStudentListAddListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationClassDetailStudentListAddListVC.h"
#import "ZOriganizationStudentListCell.h"

@interface ZOrganizationClassDetailStudentListAddListVC ()
@property (nonatomic,strong) UIButton *bottomBtn;

@end

@implementation ZOrganizationClassDetailStudentListAddListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationStudentListCell className] title:[ZOriganizationStudentListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOriganizationStudentListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:textCellConfig];
  
    [self.cellConfigArr addObject:textCellConfig];
    [self.cellConfigArr addObject:textCellConfig];
    [self.cellConfigArr addObject:textCellConfig];
    [self.cellConfigArr addObject:textCellConfig];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"学员列表"];
}

- (void)setupMainView {
    [super setupMainView];
    
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(140));
        make.left.bottom.right.equalTo(self.view);
    }];
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(bottomView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(20));
        make.height.mas_equalTo(CGFloatIn750(80));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
     make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
     make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
     make.bottom.equalTo(bottomView.mas_top).offset(-CGFloatIn750(0));
     make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(1));
    }];
}

#pragma mark lazy loading...
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            
        }];
    }
    return _bottomBtn;
}

@end
