//
//  ZStudentMineOrderDetailtVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderDetailtVC.h"
#import "ZCellConfig.h"

#import "ZSpaceEmptyCell.h"
#import "ZStudentMineOrderDetailInfoCell.h"
#import "ZStudentMineOrderDetailSubCell.h"
#import "ZStudentMineOrderDetailtVC.h"
#import "ZStudentMineOrderDetailHandleBottomView.h"

#import "ZStudentOrderPayVC.h"

@interface ZStudentMineOrderDetailtVC ()
@property (nonatomic,strong) ZStudentMineOrderDetailHandleBottomView *handleView;

@end
@implementation ZStudentMineOrderDetailtVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
    
    
    ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderDetailInfoCell className] title:[ZStudentMineOrderDetailInfoCell className] showInfoMethod:nil heightOfCell:[ZStudentMineOrderDetailInfoCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:orderCellConfig];
    
    ZCellConfig *subCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderDetailSubCell className] title:[ZStudentMineOrderDetailSubCell className] showInfoMethod:nil heightOfCell:[ZStudentMineOrderDetailSubCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:subCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"订单详情"];
}

- (void)setupMainView {
    [super setupMainView];
    [self.view addSubview:self.handleView];
    [self.handleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(kTabBarHeight);
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.handleView.mas_top);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}

#pragma mark lazy loading...
- (ZStudentMineOrderDetailHandleBottomView *)handleView {
    if (!_handleView) {
        __weak typeof(self) weakSelf = self;
        _handleView  = [[ZStudentMineOrderDetailHandleBottomView alloc] init];
        _handleView.handleBlock = ^(ZLessonOrderHandleType type) {
            if (type == ZLessonOrderHandleTypePay) {
                ZStudentOrderPayVC *pvc = [[ZStudentOrderPayVC alloc] init];
                [weakSelf.navigationController pushViewController:pvc animated:YES];
            }
        };
        
    }
    return _handleView;
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if ([cellConfig.title isEqualToString:@"ZStudentMineOrderListCell"]){
           ZStudentMineOrderDetailtVC *evc = [[ZStudentMineOrderDetailtVC alloc] init];
           [self.navigationController pushViewController:evc animated:YES];
       }
}

@end


