//
//  ZStudentMineOrderBuyListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderBuyListVC.h"
#import "ZCellConfig.h"

#import "ZSpaceEmptyCell.h"
#import "ZStudentMineOrderListCell.h"
#import "ZStudentMineOrderDetailtVC.h"


@interface ZStudentMineOrderBuyListVC ()

@end
@implementation ZStudentMineOrderBuyListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableViewGaryBack];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < 15; i++) {
        ZStudentOrderListModel *model = [[ZStudentOrderListModel alloc] init];
        model.state = @"待支付";
        model.club = @"散打俱乐部";
        model.name = @"评判器的地方三房";
        model.price = @"140.00";
        model.tiTime = @"45";
        model.teacher = @"看到老师";
        model.fail = @"";
        model.image = @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcazaxshi9j30jg0tbwho.jpg";
        
        switch (i%9) {
            case 0:
                model.type = ZStudentOrderTypeForPay;
                break;
            case 1:
                model.type = ZStudentOrderTypeHadPay;
                break;
            case 2:
                model.type = ZStudentOrderTypeHadEva;
                break;
            case 3:
                model.type = ZStudentOrderTypeOutTime;
                break;
            case 4:
                model.type = ZStudentOrderTypeCancel;
                break;
            case 5:
                model.type = ZStudentOrderTypeOrderForReceived;
                break;
            case 6:
                model.type = ZStudentOrderTypeOrderComplete;
                break;
            case 7:
                model.type = ZStudentOrderTypeOrderRefuse;
                break;
            case 8:
                model.type = ZStudentOrderTypeOrderForPay;
                break;
                
                  
            default:
                break;
        }
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderListCell className] title:[ZStudentMineOrderListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineOrderListCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:orderCellConfig];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"订单"];
}

- (void)setupMainView {
    [super setupMainView];
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentMineOrderListCell"]){
        ZStudentMineOrderListCell *enteryCell = (ZStudentMineOrderListCell *)cell;
        enteryCell.handleBlock = ^(NSInteger index, ZStudentOrderListModel *model) {
            ZStudentMineOrderDetailtVC *evc = [[ZStudentMineOrderDetailtVC alloc] init];
            [self.navigationController pushViewController:evc animated:YES];
        };
    }
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if ([cellConfig.title isEqualToString:@"ZStudentMineOrderListCell"]){
        ZStudentMineOrderDetailtVC *evc = [[ZStudentMineOrderDetailtVC alloc] init];
        evc.model = cellConfig.dataModel;
        [self.navigationController pushViewController:evc animated:YES];
    }
}

@end


