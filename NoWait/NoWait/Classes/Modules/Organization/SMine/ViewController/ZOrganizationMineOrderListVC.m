//
//  ZOrganizationMineOrderListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationMineOrderListVC.h"

#import "ZStudentMineOrderListCell.h"
#import "ZOrganizationMineOrderDetailVC.h"


@interface ZOrganizationMineOrderListVC ()

@end
@implementation ZOrganizationMineOrderListVC

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
        
        model.club = @"散打俱乐部";
        model.name = @"评判器的地方三房";
        model.price = @"140.00";
        model.tiTime = @"45";
        model.teacher = @"看到老师";
        model.fail = @"";
        model.image = @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcazaxshi9j30jg0tbwho.jpg";
        
        switch (i%11) {
            case 0:
                model.type = ZOrganizationOrderTypeForPay;
                model.state = @"待支付";
                break;
            case 1:
                model.type = ZOrganizationOrderTypeHadPay;
                model.state = @"已支付";
                break;
            case 2:
                model.type = ZOrganizationOrderTypeHadEva;
                model.state = @"已评价";
                break;
            case 3:
                model.type = ZOrganizationOrderTypeOutTime;
                model.state = @"超时";
                break;
            case 4:
                model.type = ZOrganizationOrderTypeCancel;
                model.state = @"已取消";
                break;
            case 5:
                model.type = ZOrganizationOrderTypeOrderForReceived;
                model.state = @"预约待接收";
                break;
            case 6:
                model.type = ZOrganizationOrderTypeOrderComplete;
                model.state = @"预约已完成";
                break;
            case 7:
                model.type = ZOrganizationOrderTypeOrderRefuse;
                model.state = @"一月已拒绝";
                break;
            case 8:
                model.type = ZOrganizationOrderTypeOrderForPay;
                model.state = @"预约待付款";
                break;
            case 9:
                model.type = ZOrganizationOrderTypeForRefuse;
                model.state = @"待退款";
                break;
            case 10:
                model.type = ZOrganizationOrderTypeForRefuseComplete;
                model.state = @"退款已完成";
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
            ZOrganizationMineOrderDetailVC *evc = [[ZOrganizationMineOrderDetailVC alloc] init];
            [self.navigationController pushViewController:evc animated:YES];
        };
    }
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if ([cellConfig.title isEqualToString:@"ZStudentMineOrderListCell"]){
        ZOrganizationMineOrderDetailVC *evc = [[ZOrganizationMineOrderDetailVC alloc] init];
        evc.model = cellConfig.dataModel;
        [self.navigationController pushViewController:evc animated:YES];
    }
}

@end
