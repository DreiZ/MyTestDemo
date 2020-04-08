//
//  ZOriganizationReportVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/31.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationReportVC.h"
#import "ZMultiseriateContentLeftLineCell.h"
#import "ZStudentLabelCell.h"
#import "ZAlertView.h"
#import "ZStudentMainViewModel.h"
#import "ZStudentMainModel.h"

@interface ZOriganizationReportVC ()

@end

@implementation ZOriganizationReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshHeadData:@{}];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    
    [self.navigationItem setTitle:@"投诉"];
}

- (void)setDataSource {
    [super setDataSource];
    
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.rightTitle = self.sTitle;
        model.isHiddenLine = YES;
        model.leftTitle = @"投诉";
        model.cellWidth = KScreenWidth - CGFloatIn750(60);
        model.singleCellHeight = CGFloatIn750(78);
        model.cellHeight = CGFloatIn750(80);
        model.lineSpace = CGFloatIn750(2);
        model.rightFont = [UIFont boldFontContent];
        model.leftFont = [UIFont fontContent];
        model.rightColor = [UIColor colorTextBlack];
        model.rightDarkColor =  [UIColor colorTextBlackDark];
        model.leftColor = [UIColor colorTextGray];
        model.leftDarkColor =  [UIColor colorTextGrayDark];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr  addObject:menuCellConfig];
    }
    
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.leftTitle = @"选择你想要投诉的类型";
        model.isHiddenLine = YES;
        model.cellWidth = KScreenWidth - CGFloatIn750(60);
        model.singleCellHeight = CGFloatIn750(78);
        model.cellHeight = CGFloatIn750(80);
        model.lineSpace = CGFloatIn750(2);
        model.leftFont = [UIFont fontContent];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr  addObject:menuCellConfig];
    }
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLabelCell className] title:@"label" showInfoMethod:@selector(setTitleArr:) heightOfCell:[ZStudentLabelCell z_getCellHeight:self.dataSources] cellType:ZCellTypeClass dataModel:self.dataSources];
    
    [self.cellConfigArr  addObject:menuCellConfig];
    
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"label"]) {
        ZStudentLabelCell *lcell = (ZStudentLabelCell *)cell;
        lcell.handleBlock = ^(ZComplaintModel *model) {
            [ZAlertView setAlertWithTitle:@"提示" subTitle:[NSString stringWithFormat:@"确定举报 %@ %@",self.sTitle,model.type] leftBtnTitle:@"取消" rightBtnTitle:@"确定" handlerBlock:^(NSInteger index) {
                NSMutableDictionary *param = @{}.mutableCopy;
                if (self.stores_id) {
                    [param setObject:self.stores_id forKey:@"stores_id"];
                    [param setObject:@"2" forKey:@"object"];
                }
                if (self.course_id) {
                    [param setObject:self.course_id forKey:@"course_id"];
                    [param setObject:@"1" forKey:@"object"];
                }
                [param setObject:model.complaintId forKey:@"type"];
                [ZStudentMainViewModel addComplaint:param completeBlock:^(BOOL isSuccess, id data) {
                    weakSelf.loading = NO;
                    if (isSuccess && data) {
//                        [TLUIUtility showAlertWithTitle:data];
                        [TLUIUtility showSuccessHint:data];
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }else{
                        [TLUIUtility showErrorHint:data];
                    }
                }];
            }];
        };
    }
}


- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZStudentMainViewModel getComplaintType:param completeBlock:^(BOOL isSuccess, ZComplaintNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }else{
            [weakSelf.iTableView reloadData];
        }
    }];
}

@end

