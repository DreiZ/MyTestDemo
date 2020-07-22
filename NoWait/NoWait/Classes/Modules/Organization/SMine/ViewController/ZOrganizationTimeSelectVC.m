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
#import "ZAlertDateHourPickerView.h"
#import "ZAlertView.h"

@interface ZOrganizationTimeSelectVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iRightTableView;
@property (nonatomic,strong) UIButton *navRightBtn;
@property (nonatomic,strong) UIView *bottomView;

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
        model.name = leftTitleArr[i] ;
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
                if (self.isStartAndEnd) {
                    ZBaseUnitModel *subModel = time[k];
                    ZCellConfig *channelCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTimeRightCell className] title:[ZOrganizationTimeRightCell className] showInfoMethod:@selector(setTime:) heightOfCell:[ZOrganizationTimeRightCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:[NSString stringWithFormat:@"%@~%@",subModel.name,subModel.subName]];
                    [self.cellRightConfigArr addObject:channelCellConfig];
                }else{
                    ZCellConfig *channelCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTimeRightCell className] title:[ZOrganizationTimeRightCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationTimeRightCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:time[k]];
                    [self.cellRightConfigArr addObject:channelCellConfig];
                }
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
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(80));
        make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.width.mas_equalTo(CGFloatIn750(204));
        make.bottom.equalTo(self.bottomView.mas_top);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
    
    [self.view addSubview:self.iRightTableView];
    [self.iRightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.iTableView.mas_right);
        make.bottom.equalTo(self.bottomView.mas_top);
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
        [_navRightBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_navRightBtn.titleLabel setFont:[UIFont fontContent]];
        [_navRightBtn bk_addEventHandler:^(id sender) {
            [weakSelf sortTime];
            if (weakSelf.timeBlock) {
                weakSelf.timeBlock(weakSelf.dataSources);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navRightBtn;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        __weak typeof(self) weakSelf = self;
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor colorMain];
        UIButton *bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [bottomBtn setTitle:@"将每天都设置此时间" forState:UIControlStateNormal];
        [bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [bottomBtn bk_addEventHandler:^(id sender) {
            ZBaseMenuModel *tmodel = nil;
            for (int i = 0; i < weakSelf.dataSources.count; i++) {
                ZBaseMenuModel *model = weakSelf.dataSources[i];
                if (model.isSelected) {
                    tmodel = model;
                    if (model.units.count < 1) {
                        [TLUIUtility showInfoHint:@"该日还没有设置数据"];
                        return;
                    }
                }
            }
            [ZAlertView setAlertWithTitle:@"提示" subTitle:@"确定将每天都设置此时间？" leftBtnTitle:@"取消" rightBtnTitle:@"确定" handlerBlock:^(NSInteger index) {
                if (index == 1) {
                    for (int i = 0; i < weakSelf.dataSources.count; i++) {
                        ZBaseMenuModel *model = weakSelf.dataSources[i];
                        if (model != tmodel) {
                            [model.units removeAllObjects];
                            [tmodel.units enumerateObjectsUsingBlock:^(ZBaseUnitModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                ZBaseUnitModel *ssModel = [[ZBaseUnitModel alloc] init];
                                ssModel.name = obj.name;
                                ssModel.subName = obj.subName;
                                ssModel.data = obj.data;
                                [model.units addObject:ssModel];
                            }];
                        }
                    }
                }
            }];
        } forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:bottomBtn];
        [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bottomView);
        }];
    }
    return _bottomView;
}

- (void)sortTime {
    [self.dataSources enumerateObjectsUsingBlock:^(ZBaseMenuModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.units = [self logArrayFunction:obj.units];
    }];
}

- (NSMutableArray *)logArrayFunction:(NSArray *)tempArr {
    int count  = 0;
    int forcount  = 0;
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:tempArr];
    
    for (int i = 0; i < arr.count; i++) {
        forcount++;
        // 依次定位左边的
        for (int j = (int)arr.count-2; j >= i; j--) {
            count++;
            ZBaseUnitModel *tempModel = arr[j];
            ZBaseUnitModel *tempModel1 = arr[j+1];
            NSInteger startTime = [tempModel.name intValue] *60 + [tempModel.subName intValue];
            NSInteger startTime1 = [tempModel1.name intValue] *60 + [tempModel1.subName intValue];
            
            if (startTime > startTime1) {
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    return arr;
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
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0 && tableView == self.iRightTableView && _cellRightConfigArr && _cellRightConfigArr.count > 0) {
        return CGFloatIn750(60);
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0  && tableView == self.iRightTableView && _cellRightConfigArr && _cellRightConfigArr.count > 0) {
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(60))];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        titleLabel.text = @"左滑删除";
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [titleLabel setFont:[UIFont fontSmall]];
        [sectionView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(sectionView);
        }];
        return sectionView;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [self.cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"ZOrganizationTimeLeftCell"] && self.iTableView == tableView) {
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
        make.right.equalTo(addView.mas_right);
        make.left.equalTo(addView.mas_left);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [addView addSubview:addBtn];
    [addBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.isStartAndEnd) {
            NSString *selectDate = [self getStartAndEndLastSelectDate];
            [ZAlertDateHourPickerView setAlertName:@"选择时间段" now:selectDate handlerBlock:^(NSString *start,NSString *end) {
                ZBaseUnitModel *smodel = [[ZBaseUnitModel alloc] init];
                smodel.name = start;
                smodel.subName = end;
                
                [weakSelf checkStartAndEnd:smodel];
            }];
            
//            [ZAlertDateHourPickerView setAlertName:@"选择时间段" handlerBlock:^(NSString *start,NSString *end) {
//                ZBaseUnitModel *smodel = [[ZBaseUnitModel alloc] init];
//                smodel.name = start;
//                smodel.subName = end;
//
//                [weakSelf checkStartAndEnd:smodel];
//            }];
        }else{
            NSDate *selectDate = [self getLastSelectDate];
            [ZDatePickerManager showDatePickerWithTitle:@"开始时间" type:PGDatePickerModeTime showDate:selectDate handle:^(NSDateComponents * date) {
                [weakSelf checkSeletTime:date];
            }];
//            [ZDatePickerManager showDatePickerWithTitle:@"开始时间" type:PGDatePickerModeTime handle:^(NSDateComponents * date) {
//                [weakSelf checkSeletTime:date];
//            }];
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(addView);
//        make.left.equalTo(addView.mas_centerX);
    }];
    
//    {
//        UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        addLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
//        addLabel.text = @"智能添加";
//        addLabel.textAlignment = NSTextAlignmentCenter;
//        [addLabel setFont:[UIFont fontContent]];
//
//        [addView addSubview:addLabel];
//        [addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(addView.mas_centerY);
//            make.left.equalTo(addView.mas_left);
//            make.right.equalTo(addView.mas_centerX);
//        }];
//
//        __weak typeof(self) weakSelf = self;
//        UIButton *magciBtn = [[UIButton alloc] initWithFrame:CGRectZero];
//        [addView addSubview:magciBtn];
//        [magciBtn bk_addEventHandler:^(id sender) {
//            [weakSelf aiAddTime];
//        } forControlEvents:UIControlEventTouchUpInside];
//        [magciBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.bottom.equalTo(addView);
//            make.right.equalTo(addView.mas_centerX);
//        }];
//    }
    
    return addView;
}

#pragma mark - 智能
- (void)aiAddTime {
    if (self.isStartAndEnd) {
        
    }else{
        for (int i = 0; i < self.dataSources.count; i++) {
            ZBaseMenuModel *model = self.dataSources[i];
            if (model.isSelected) {
                if (ValidArray(model.units)) {
                    ZBaseUnitModel *subModel = model.units.lastObject;
                    
                    if ([subModel.name intValue] >= 23) {
                        [TLUIUtility showInfoHint:@"选择日期已到次日凌晨"];
                    }else{
                        NSInteger off = 1;
                        CGFloat tHour = [self.course_min doubleValue]/60.0f;
                        off = ceil(tHour);
                        
                        if (model.units.count >= 2) {
                            ZBaseUnitModel *zModel = model.units.lastObject;
                            ZBaseUnitModel *tModel = model.units[model.units.count - 2];
                            NSInteger toff = [zModel.name intValue] - [tModel.name intValue];
                            if (toff > off) {
                                off = toff;
                            }
                        }
                        ZBaseUnitModel *nextModel = [[ZBaseUnitModel alloc] init];
                        nextModel.name = [NSString stringWithFormat:@"%ld",[subModel.name intValue]+off];
                        nextModel.subName = [NSString stringWithFormat:@"%d",[subModel.subName intValue]];
                        nextModel.data = [NSString stringWithFormat:@"%@:%@%@~%@",nextModel.name,nextModel.subName.length != 1 ? @"":@"0",nextModel.subName,[self getEndTime:nextModel]];
                        
                        if ([self checkSeletTime:nextModel units:model]) {
                            [model.units addObject:nextModel];
                            [self initCellRightConfigArr];
                            [self.iRightTableView reloadData];
                        }else{
                            [TLUIUtility showInfoHint:@"智能添加冲突，请手动添加"];
                        }
                    }
                }else{
                    if (i == 0) {
                        ZBaseUnitModel *nextModel = [[ZBaseUnitModel alloc] init];
                        nextModel.name = @"9";
                        nextModel.subName = @"0";
                        if (ValidStr(self.course_min)) {
                            nextModel.data = [NSString stringWithFormat:@"%@:%@%@~%@",nextModel.name,nextModel.subName.length != 1 ? @"":@"0",nextModel.subName,[self getEndTime:nextModel]];
                        }
                        
                        if ([self checkSeletTime:nextModel units:model]) {
                            [model.units addObject:nextModel];
                            [self initCellRightConfigArr];
                            [self.iRightTableView reloadData];
                        }
                    }else{
                        ZBaseMenuModel *lastModel = self.dataSources[i - 1];
                        if (ValidArray(lastModel.units)) {
                            [lastModel.units enumerateObjectsUsingBlock:^(ZBaseUnitModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                ZBaseUnitModel *sModel = [[ZBaseUnitModel alloc] init];
                                sModel.name = obj.name;
                                sModel.subName = obj.subName;
                                sModel.data = obj.data;
                                [model.units addObject:sModel];
                            }];
                            [self initCellRightConfigArr];
                            [self.iRightTableView reloadData];
                        }else{
                            ZBaseUnitModel *nextModel = [[ZBaseUnitModel alloc] init];
                            nextModel.name = @"9";
                            nextModel.subName = @"0";
                            if (ValidStr(self.course_min)) {
                                nextModel.data = [NSString stringWithFormat:@"%@:%@%@~%@",nextModel.name,nextModel.subName.length != 1 ? @"":@"0",nextModel.subName,[self getEndTime:nextModel]];
                            }
                            
                            if ([self checkSeletTime:nextModel units:model]) {
                                [model.units addObject:nextModel];
                                [self initCellRightConfigArr];
                                [self.iRightTableView reloadData];
                            }
                        }
                    }
                }
            }
        }
    }
}

#pragma mark - date handle
- (NSString *)getTime:(NSDateComponents *)date {
    if (date.minute < 10) {
        return  [NSString stringWithFormat:@"%ld:0%ld",(long)date.hour,(long)date.minute];
    }else{
        return  [NSString stringWithFormat:@"%ld:%ld",(long)date.hour,(long)date.minute];
    }
}

//最后选择日期
- (NSDate *)getLastSelectDate {
    for (int i = 0; i < self.dataSources.count; i++) {
        ZBaseMenuModel *model = self.dataSources[i];
        if (model.isSelected) {
            if (ValidArray(model.units)) {
                ZBaseUnitModel *subModel = model.units.lastObject;
                
                NSDate *date = [[NSDate alloc] initWithTimeInterval:([subModel.name intValue] * 3600 + [subModel.subName intValue] * 60) sinceDate:[self zeroOfDate]];
                return date;
            }
        }
    }
    
    return nil;
}


//最后选择日期
- (NSString *)getStartAndEndLastSelectDate {
    for (int i = 0; i < self.dataSources.count; i++) {
        ZBaseMenuModel *model = self.dataSources[i];
        if (model.isSelected) {
            if (ValidArray(model.units)) {
                if (self.isStartAndEnd) {
                    ZBaseUnitModel *subModel = model.units.lastObject;
                    return subModel.name;
                }
            }
        }
    }
    return nil;
}


 - (NSDate *)zeroOfDate
 {
     NSCalendar *calendar = [NSCalendar currentCalendar];
     NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:[NSDate new]];
     components.hour = 0;
     components.minute = 0;
     components.second = 0;

    // components.nanosecond = 0 not available in iOS
     NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
     return [NSDate dateWithTimeIntervalSince1970:ts];
}

#pragma mark - getEndTime
- (NSString *)getStartTime:(ZBaseUnitModel *)model {
    if ([model.subName intValue] < 10) {
        return  [NSString stringWithFormat:@"%@:0%@",model.name,model.subName];
    }else{
        return  [NSString stringWithFormat:@"%@:%@",model.name,model.subName];
    }
}

- (NSString *)getEndTime:(ZBaseUnitModel *)model {
    NSInteger temp = [self.course_min intValue]/60;
    NSInteger subTemp = [self.course_min intValue]%60;
    
    NSInteger hourTemp = [model.name intValue] + temp;
    NSInteger minTemp = [model.subName intValue] + subTemp;
    if (minTemp > 59) {
        minTemp -= 60;
        hourTemp++;
    }
    
    if (hourTemp > 24) {
        hourTemp -= 24;
    }
    
    ZBaseUnitModel *uModel = [[ZBaseUnitModel alloc] init];
    uModel.name = [NSString stringWithFormat:@"%ld",hourTemp];
    uModel.subName = [NSString stringWithFormat:@"%ld",minTemp];
    
    return [self getStartTime:uModel];
}

#pragma mark - 检查开始节数时间
- (void)checkStartAndEnd:(ZBaseUnitModel *)smodel{
    for (int i = 0; i < self.dataSources.count; i++) {
        ZBaseMenuModel *model = self.dataSources[i];
        if (model.isSelected) {
            if ([self checkStartAndEndTime:smodel units:model]) {
                [model.units addObject:smodel];
                [self initCellConfigArr];
                [self.iRightTableView reloadData];
            }
        }
    }
}

- (BOOL)checkStartAndEndTime:(ZBaseUnitModel *)smodel units:(ZBaseMenuModel *)model{
    NSArray *tempStart = [smodel.name componentsSeparatedByString:@":"];
    NSArray *tempEnd = [smodel.subName componentsSeparatedByString:@":"];
    __block NSInteger startTime = (tempStart && tempStart.count > 0) ? [self checkO:tempStart[0]]:0;
    
    __block NSInteger endTime = (tempEnd && tempEnd.count > 0) ? [self checkO:tempEnd[0]]:0;
    for (int i = 0; i < model.units.count; i++) {
        ZBaseUnitModel *obj = model.units[i];
        NSArray *tempStartIn = [obj.name componentsSeparatedByString:@":"];
        NSArray *tempEndIn = [obj.subName componentsSeparatedByString:@":"];
        
        NSInteger tStartTime = (tempStartIn && tempStartIn.count > 0) ? [self checkO:tempStartIn[0]]:0;
        
        NSInteger tEndTime = (tempEndIn && tempEndIn.count > 0) ? [self checkO:tempEndIn[0]]:0;
        
        if (startTime < tEndTime && endTime > tStartTime) {
            [TLUIUtility showInfoHint:@"时间段不可重合"];
            return NO;
        }
    }
    return YES;
}

- (NSInteger )checkO:(NSString *)name {
    if (name && name.length > 0) {
        NSString *str3 = [name substringToIndex:1];//str3 = "this"
        if ([str3 isEqualToString:@"0"]) {
            NSString *str2 = [name substringWithRange:NSMakeRange(1,1)];//s
            return [str2 intValue];
        }
    }
    return [name intValue];
}

#pragma mark - 检查时间
- (void)checkSeletTime:(NSDateComponents *)date{
    for (int i = 0; i < self.dataSources.count; i++) {
        ZBaseMenuModel *model = self.dataSources[i];
        if (model.isSelected) {
            
            ZBaseUnitModel *smodel = [[ZBaseUnitModel alloc] init];
            smodel.name = [NSString stringWithFormat:@"%ld",(long)date.hour];
            smodel.subName = [NSString stringWithFormat:@"%ld",(long)date.minute];
            smodel.data = [NSString stringWithFormat:@"%@",[self getTime:date]];
            if (ValidStr(self.course_min)) {
                smodel.data =  [NSString stringWithFormat:@"%@~%@",[self getTime:date],[self getEndTime:smodel]];
                
                if ([self checkSeletTime:smodel units:model]) {
                    [model.units addObject:smodel];
                    [self initCellConfigArr];
                    [self.iRightTableView reloadData];
                }
            }else{
                [model.units addObject:smodel];
                [self initCellConfigArr];
                [self.iRightTableView reloadData];
            }
        }
    }
}

- (BOOL)checkSeletTime:(ZBaseUnitModel *)smodel units:(ZBaseMenuModel *)model{
    __block NSInteger startTime = [smodel.name intValue] *60 + [smodel.subName intValue];
    
    __block NSInteger endTime = [smodel.name intValue] *60 + [smodel.subName intValue] + [self.course_min intValue];
    for (int i = 0; i < model.units.count; i++) {
        ZBaseUnitModel *obj = model.units[i];
        NSInteger tStartTime = [obj.name intValue] *60 + [obj.subName intValue];
        
        NSInteger tEndTime = [obj.name intValue] *60 + [obj.subName intValue] + [self.course_min intValue];
        if (startTime < tEndTime && endTime > tStartTime) {
            [TLUIUtility showInfoHint:@"时间段不可重合"];
            return NO;
        }
    }
    return YES;
}
@end
