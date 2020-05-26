//
//  ZStudentMessageSendListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMessageSendListVC.h"
#import "ZOriganizationStudentViewModel.h"

@interface ZStudentMessageSendListVC ()
@property (nonatomic,strong) ZMessageInfoModel *infoModel;

@end

@implementation ZStudentMessageSendListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
    [self refreshHeadData];
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"收件人列表"];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    if (ValidArray(self.infoModel.account )) {
        [self.infoModel.account enumerateObjectsUsingBlock:^(ZMessageAccountModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = obj.nick_name;
            model.isHiddenLine = YES;
            model.cellHeight = CGFloatIn750(96);
            model.leftFont = [UIFont fontContent];
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }];
    }
}


- (void)refreshHeadData {
    __weak typeof(self) weakSelf = self;
    self.loading = YES;
    [ZOriganizationStudentViewModel getSendMessageInfo:@{@"id":SafeStr(self.model.message_id)} completeBlock:^(BOOL isSuccess, ZMessageInfoModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            weakSelf.infoModel = data;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];

            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }
    }];
}
@end
