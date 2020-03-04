//
//  ZOrganizationTimeSelectVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTimeSelectVC.h"
#import "ZOrganizationTimeRightCell.h"
#import "ZOrganizationTimeLeftCell.h"


@interface ZOrganizationTimeSelectVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iRightTableView;
@property (nonatomic,strong) UIButton *navRightBtn;

@property (nonatomic,strong) NSMutableArray *cellRightConfigArr;
@end

@implementation ZOrganizationTimeSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    self.iTableView.delegate = self;
    self.iRightTableView.delegate = self;
    
    [self.iTableView reloadData];
    [self.iRightTableView reloadData];
}

- (void)setDataSource {
    [super setDataSource];
    _cellRightConfigArr = @[].mutableCopy;
    
    NSArray *leftTitleArr = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天"];
    for (int i = 0; i < leftTitleArr.count; i++) {
        ZBaseMenuModel *model = [[ZBaseMenuModel alloc] init];
        model.name = leftTitleArr[i];
        model.uid = [NSString stringWithFormat:@"%d",i];
        ZBaseMenuModel *tempModel = [self getModelWith:leftTitleArr[i]];
        if (tempModel && tempModel.units) {
            model.units = tempModel.units;
        }else{
            model.units = @[].mutableCopy;
        }
        
        if (i == 0) {
            model.isSelected = YES;
        }
        [self.dataSources addObject:model];
    }
}

- (ZBaseMenuModel *)getModelWith:(NSString *)time {
    if (self.timeArr) {
        for (int i = 0; i < self.timeArr.count; i++) {
            ZBaseMenuModel *model = self.timeArr[i];
            if ([model.name isEqualToString:time]) {
                return model;
            }
        }
    }
    return nil;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZBaseMenuModel *model = self.dataSources[i];
        
        ZCellConfig *channelCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTimeLeftCell className] title:[ZOrganizationTimeLeftCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationTimeLeftCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:channelCellConfig];
    }
    [self initCellRightConfigArr];
}

- (void)initCellRightConfigArr {
    [_cellRightConfigArr removeAllObjects];
    for (int i = 0; i < self.dataSources.count; i++) {
        ZBaseMenuModel *model = self.dataSources[i];
        if (model.isSelected) {
            NSMutableArray *time = @[].mutableCopy;
            for (int j = 0; j < model.units.count; j++) {
                ZBaseUnitModel *subModel = model.units[j];
                [time addObject:subModel];
            }
            
            for (int k = 0; k < time.count; k++) {
                ZCellConfig *channelCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTimeRightCell className] title:[ZOrganizationTimeRightCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationTimeRightCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:time[k]];
                [self.cellRightConfigArr addObject:channelCellConfig];
            }
        }
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"选择时间"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn];

    [self.navigationItem setRightBarButtonItem:item];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.width.mas_equalTo(CGFloatIn750(204));
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
    
    [self.view addSubview:self.iRightTableView];
    [self.iRightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.iTableView.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}

#pragma mark lazy loading...
-(UITableView *)iRightTableView {
    if (!_iRightTableView) {
        _iRightTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _iRightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iRightTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if ([_iRightTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iRightTableView.estimatedRowHeight = 0;
            _iRightTableView.estimatedSectionHeaderHeight = 0;
            _iRightTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iRightTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        _iRightTableView.delegate = self;
        _iRightTableView.dataSource = self;
        _iRightTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iRightTableView.tableFooterView = [self addTime];
    }
    return _iRightTableView;
}


- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        __weak typeof(self) weakSelf = self;
        _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        [_navRightBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_navRightBtn setTitleColor:[UIColor colorMain] forState:UIControlStateNormal];
        [_navRightBtn.titleLabel setFont:[UIFont fontContent]];
        [_navRightBtn bk_whenTapped:^{
            if (weakSelf.timeBlock) {
                weakSelf.timeBlock(weakSelf.dataSources);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _navRightBtn;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.iTableView) {
        return self.cellConfigArr.count;
    }
    return _cellRightConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.iTableView) {
        ZCellConfig *cellConfig = [self.cellConfigArr objectAtIndex:indexPath.row];
            ZBaseCell *cell;
            cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
            if ([cellConfig.title isEqualToString:@"ZSpaceEmptyCell"]){
        //        ZSpaceEmptyCell *enteryCell = (ZSpaceEmptyCell *)cell;
                
            }
            return cell;
    }else{
        ZCellConfig *cellConfig = [_cellRightConfigArr objectAtIndex:indexPath.row];
            ZBaseCell *cell;
            cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
            if ([cellConfig.title isEqualToString:@"ZOrganizationTimeRightCell"]){
//                ZOrganizationTimeRightCell *enteryCell = (ZOrganizationTimeRightCell *)cell;
                
            }
            return cell;
    }
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.iTableView) {
        ZCellConfig *cellConfig = self.cellConfigArr[indexPath.row];
        CGFloat cellHeight =  cellConfig.heightOfCell;
        return cellHeight;
    }else{
        ZCellConfig *cellConfig = _cellRightConfigArr[indexPath.row];
        CGFloat cellHeight =  cellConfig.heightOfCell;
        return cellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [self.cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"ZOrganizationTimeLeftCell"]) {
        for (int i = 0; i < self.dataSources.count; i++) {
            ZBaseUnitModel *model = self.dataSources[i];
            if (i == indexPath.row) {
                model.isSelected = YES;
            }else{
                model.isSelected = NO;
            }
        }
        
        [self initCellConfigArr];
        [self.iTableView reloadData];
        [self.iRightTableView reloadData];
    }
    
}

#pragma mark - 删除列表
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.iRightTableView) {
        return YES;
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        for (int i = 0; i < self.dataSources.count; i++) {
        ZBaseMenuModel *model = self.dataSources[i];
            if (model.isSelected) {
                if (indexPath.row < model.units.count) {
                    [model.units removeObjectAtIndex:indexPath.row];
                    
                    [self initCellRightConfigArr];
                    [self.iRightTableView reloadData];
                }
            }
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

#pragma mark - set addBtn
- (UIView *)addTime {
    UIView *addView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, [ZOrganizationTimeLeftCell z_getCellHeight:nil])];
    addView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    addLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    addLabel.text = @"添加时间段 >";
    addLabel.textAlignment = NSTextAlignmentCenter;
    [addLabel setFont:[UIFont fontContent]];
    
    [addView addSubview:addLabel];
    [addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addView.mas_centerY);
        make.centerX.equalTo(addView.mas_centerX);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [addView addSubview:addBtn];
    [addBtn bk_whenTapped:^{
        [[ZDatePickerManager sharedManager] showDatePickerWithTitle:@"课程开始时间" type:PGDatePickerModeTime handle:^(NSDateComponents * date) {
            for (int i = 0; i < self.dataSources.count; i++) {
                ZBaseMenuModel *model = self.dataSources[i];
                if (model.isSelected) {
                    
                    ZBaseUnitModel *smodel = [[ZBaseUnitModel alloc] init];
                    smodel.name = [NSString stringWithFormat:@"%ld",(long)date.hour];
                    smodel.subName = [NSString stringWithFormat:@"%ld:",(long)date.minute];
                    [model.units addObject:smodel];
                    [weakSelf initCellConfigArr];
                    [weakSelf.iRightTableView reloadData];
                    
                }
            }
        }];
        
        
        
    }];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(addView);
    }];
    
    return addView;
}
@end
