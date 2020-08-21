//
//  ZMapSchoolListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/8/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMapSchoolListVC.h"
#import <HWPanModal/HWPanModal.h>
#import <Masonry/View+MASAdditions.h>
#import "ZNoDataCell.h"
#import "ZStudentOrganizationNewListCell.h"
#import "ZStudentOrganizationDetailDesVC.h"

@interface ZMapSchoolListVC () < UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cellConfigArr;
@end

@implementation ZMapSchoolListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellConfigArr = @[].mutableCopy;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self initCellConfig];
    [self.tableView reloadData];
}

- (void)setDataSources:(NSArray *)dataSources {
    _dataSources = dataSources;
    [self initCellConfig];
    [self.tableView reloadData];
}

#pragma mark - HWPanModalPresentable

- (PanModalHeight)shortFormHeight {
    return PanModalHeightMake(PanModalHeightTypeContent, 400);
}

- (PanModalHeight)longFormHeight {
    return PanModalHeightMake(PanModalHeightTypeMax, 0);
}

//- (UIScrollView *)panScrollable {
//    return self.tableView;
//}

- (CGFloat)keyboardOffsetFromInputView {
    return 10;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
     ZBaseCell *cell;
//    __weak typeof(self) weakSelf = self;
     cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"ZStudentLessonTeacherCell"]) {
        
    }
     return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationNewListCell"]) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
            ZStoresListModel *model = cellConfig.dataModel;
            routePushVC(ZRoute_main_organizationDetail, @{@"id":model.stores_id}, nil);
        }];
    }
}

#pragma mark - setdata
- (void)initCellConfig {
    [self.cellConfigArr removeAllObjects];
    if (self.dataSources.count > 0) {
        for (int i = 0; i < self.dataSources.count; i++) {
            ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationNewListCell className] title:@"ZStudentOrganizationNewListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationNewListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
            [self.cellConfigArr addObject:orCellCon1fig];
            [self.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
        }
    }else {
        ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZNoDataCell className] title:@"ZNoDataCell" showInfoMethod:@selector(setModel:) heightOfCell:kScreenHeight/2.0 cellType:ZCellTypeClass dataModel:nil];
        [self.cellConfigArr addObject:orCellCon1fig];
    }
}
#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.rowHeight = 50;
        _tableView.scrollEnabled = YES;
        _tableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end

