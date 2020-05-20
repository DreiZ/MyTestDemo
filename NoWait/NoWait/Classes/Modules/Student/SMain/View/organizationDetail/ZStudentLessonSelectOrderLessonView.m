//
//  ZStudentLessonSelectOrderLessonView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonSelectOrderLessonView.h"
#import "ZStudentLessonTeacherCell.h"
#import "ZStudentLessonTeacherSelectedCell.h"
#import "ZOriganizationLessonViewModel.h"

@interface ZStudentLessonSelectOrderLessonView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) NSMutableDictionary *param;
@property (nonatomic,strong) NSMutableArray *dataSources;


@end

@implementation ZStudentLessonSelectOrderLessonView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor clearColor], [UIColor clearColor]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;

    _param = @{}.mutableCopy;
    _dataSources = @[].mutableCopy;
    
    [self addSubview:self.backView];
    [self.backView addSubview:self.bottomBtn];
    [self.backView addSubview:self.iTableView];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(40));
    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-CGFloatIn750(40)-safeAreaBottom());
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.backView.mas_top).offset(CGFloatIn750(40));
        make.bottom.equalTo(self.bottomBtn.mas_top);
    }];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

#pragma mark -Getter
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_backView, CGFloatIn750(40));
    }
    return _backView;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"预约时间" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldFontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.bottomBlock) {
                weakSelf.bottomBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _iTableView.estimatedRowHeight = 0;
        _iTableView.estimatedSectionHeaderHeight = 0;
        _iTableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.showsHorizontalScrollIndicator = NO;
        _iTableView.alwaysBounceVertical = YES;
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
//        _iTableView.tableHeaderView = self.menuView;
    }
    return _iTableView;
}


- (NSMutableArray *)cellConfigArr {
    if (!_cellConfigArr) {
        _cellConfigArr = @[].mutableCopy;
    }
    return _cellConfigArr;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    __weak typeof(self) weakSelf = self;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"ZStudentLessonTeacherCell"]) {
        ZStudentLessonTeacherCell *lcell = (ZStudentLessonTeacherCell *)cell;
        lcell.handleLessonBlock = ^(ZOriganizationLessonListModel *model) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(model);
            }
            weakSelf.listModel = model;

            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
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
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
}


- (void)initCellConfigArr {
    [self.cellConfigArr removeAllObjects];
    if (!self.detailModel) {
        return;
    }
    {
        NSMutableDictionary *data = @{}.mutableCopy;
        if (ValidStr(self.listModel.name)) {
            [data setObject:[NSString stringWithFormat:@"￥%@",self.listModel.experience_price] forKey:@"name"];
            [data setObject:[NSString stringWithFormat:@"%@",self.listModel.name] forKey:@"lesson"];
            [data setObject:SafeStr(self.listModel.image_url) forKey:@"image"];
        }else{
            [data setObject:@"-" forKey:@"name"];
            [data setObject:@"请选择预约课程" forKey:@"lesson"];
        }
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonTeacherSelectedCell className] title:[ZStudentLessonTeacherSelectedCell className] showInfoMethod:@selector(setData:) heightOfCell:[ZStudentLessonTeacherSelectedCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:data];
        [self.cellConfigArr addObject:menuCellConfig];
        
    }
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"可预约课程";
        model.leftFont = [UIFont boldFontTitle];
        model.cellHeight = CGFloatIn750(60);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    if (self.dataSources.count > 0) {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonTeacherCell className] title:[ZStudentLessonTeacherCell className] showInfoMethod:@selector(setList:) heightOfCell:[ZStudentLessonTeacherCell z_getCellHeight:self.dataSources] cellType:ZCellTypeClass dataModel:self.dataSources];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    if (self.listModel) {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(60))];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"体验时长";
        model.leftFont = [UIFont boldFontTitle];
        model.cellHeight = CGFloatIn750(50);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = [NSString stringWithFormat:@"%@分钟",ValidStr(self.listModel.experience_duration) ? self.listModel.experience_duration:@"0"];
            model.leftFont = [UIFont fontContent];
            model.cellHeight = CGFloatIn750(50);
            model.isHiddenLine = YES;
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
        {
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
            
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = @"正式时长";
            model.leftFont = [UIFont boldFontTitle];
            model.cellHeight = CGFloatIn750(50);
            model.isHiddenLine = YES;
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
            {
                ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
                model.leftTitle = [NSString stringWithFormat:@"%@分钟",ValidStr(self.listModel.total_course_min) ? self.listModel.total_course_min:@"0"];
                model.leftFont = [UIFont fontContent];
                model.cellHeight = CGFloatIn750(50);
                model.isHiddenLine = YES;
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [self.cellConfigArr addObject:menuCellConfig];
            }
        }
    }
}

- (void)setDetailModel:(ZStoresDetailModel *)detailModel {
    _detailModel = detailModel;
    [self initCellConfigArr];
    [self.iTableView reloadData];
    [self refreshData];
}


#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel getOrderLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }
    }];
}

- (void)refreshMoreData {
    self.currentPage++;
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel getOrderLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }
    }];
}


- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
    [param setObject:self.detailModel.schoolID forKey:@"stores_id"];
    return param;
}
@end
