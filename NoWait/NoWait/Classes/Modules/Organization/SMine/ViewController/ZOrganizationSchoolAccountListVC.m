//
//  ZOrganizationSchoolAccountListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSchoolAccountListVC.h"
#import "ZOrganizationAccountSchoolNOListCell.h"
#import "ZOriganizationAccountFilteView.h"
#import "ZAlertBeginAndEndTimeView.h"

@interface ZOrganizationSchoolAccountListVC ()
@property (nonatomic,strong) ZOriganizationAccountFilteView *topView;

@end

@implementation ZOrganizationSchoolAccountListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationAccountSchoolNOListCell className] title:[ZOrganizationAccountSchoolNOListCell className] showInfoMethod:nil heightOfCell:[ZOrganizationAccountSchoolNOListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"账户信息"];
}

- (void)setupMainView {
    [super setupMainView];
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(106));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.right.bottom.equalTo(self.view);
         make.top.equalTo(self.topView.mas_bottom).offset(CGFloatIn750(0));
    }];
}

#pragma mark - lazy loading...
- (ZOriganizationAccountFilteView *)topView {
    if (!_topView) {
//        __weak typeof(self) weakSelf = self;
        _topView = [[ZOriganizationAccountFilteView alloc] init];
        _topView.handleBlock = ^(NSInteger index) {
            [ZAlertBeginAndEndTimeView setAlertName:@"选择开始日期" subName:@"选择结束时间"  pickerMode:PGDatePickerModeDate handlerBlock:^(NSDateComponents *begin, NSDateComponents *end) {
                NSLog(@"-begin-%@-end-%@",[NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:begin] timeIntervalSince1970]],[NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:end] timeIntervalSince1970]]);
//                weakSelf.viewModel.addModel.limit_start = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:begin] timeIntervalSince1970]];
//                weakSelf.viewModel.addModel.limit_end = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:end] timeIntervalSince1970]];
//
//                [weakSelf initCellConfigArr];
//                [weakSelf.iTableView reloadData];
            }];
        };
        if (self.type == 2) {
            _topView.isHandle = NO;
        }
    }
    return _topView;
}

@end
