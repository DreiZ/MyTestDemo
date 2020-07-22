//
//  ZOrganizationTopFilterView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTopFilterView.h"
#import "ZOrganizationStudentTopFilterSeaarchView.h"
#import "AppDelegate.h"
#import "ZOriganizationTeacherViewModel.h"

@interface ZOrganizationTopFilterView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) ZOrganizationStudentTopFilterSeaarchView *fileterView;
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UITableView *iTableView;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@property (nonatomic,assign) NSInteger currentPage;
@end

@implementation ZOrganizationTopFilterView

static ZOrganizationTopFilterView *sharedManager;

+ (ZOrganizationTopFilterView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZOrganizationTopFilterView alloc] init];
        }
    }
    return sharedManager;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}


#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = RGBAColor(1, 1, 1, 0.5);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    self.cellConfigArr = @[].mutableCopy;
    self.dataSources = @[].mutableCopy;
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backBtn bk_addEventHandler:^(id sender) {
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(602 + 88));
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(290));
    }];
    
    [self.contView addSubview:self.fileterView];
    [self.fileterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(106));
    }];
    
    [self.contView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contView);
        make.top.equalTo(self.fileterView.mas_bottom).offset(CGFloatIn750(2));
    }];
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
    [self.contView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.fileterView);
        make.height.mas_equalTo(0.5);
    }];
    
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.layer.cornerRadius = 6;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    
    return _contView;
}


- (ZOrganizationStudentTopFilterSeaarchView *)fileterView {
    if (!_fileterView) {
        __weak typeof(self) weakSelf = self;
        _fileterView = [[ZOrganizationStudentTopFilterSeaarchView alloc] init];
        _fileterView.isInside = YES;
        _fileterView.filterBlock = ^(NSInteger sindex, id data) {
            if (sindex == weakSelf.index) {
                weakSelf.fileterView.openIndex = 3;
                [weakSelf removeFromSuperview];
            }else{
                weakSelf.index = sindex;
                weakSelf.fileterView.openIndex = sindex;
                [weakSelf.iTableView reloadData];
            }
        };
    }
    return _fileterView;
}
#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.showsHorizontalScrollIndicator = NO;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } 
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
    return _iTableView;
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
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"ZSpaceEmptyCell"]){
//        ZSpaceEmptyCell *enteryCell = (ZSpaceEmptyCell *)cell;
        
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
    ZBaseSingleCellModel *model = cellConfig.dataModel;
    if (self.completeBlock) {
        self.completeBlock(self.index, model.data);
    }
    [self removeFromSuperview];
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    if (index == 0) {
        [self.iTableView tt_addLoadMoreFooterWithAction:^{
            [self refreshMoreData];
        }];
        [self initCellConfigArr];
        [self.iTableView reloadData];
        [self refreshData];
    }else{
         [self.iTableView tt_removeLoadMoreFooter];
        
        [self.cellConfigArr removeAllObjects];
        //0:全部 1：待排课 2：待开课 3：已开课 4：已结课 5：待补课 6：已过期
        NSArray *titleArr = @[@"全部",@"待排课",@"待开课",@"已开课",@"已结课",@"待补课",@"已过期"];
        for (int i = 0; i < titleArr.count; i++) {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = titleArr[i];
            model.leftFont = [UIFont fontSmall];
            model.isHiddenLine = YES;
            model.data = titleArr[i];
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
}

- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
    
    ZOriganizationTeacherListModel *lModel = [[ZOriganizationTeacherListModel alloc] init];
    lModel.teacherID = @"0";
    lModel.teacher_name = @"全部教师";
    [self.dataSources insertObject:lModel atIndex:0];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationTeacherListModel *listModel = self.dataSources[i];
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = listModel.teacher_name;
        model.leftFont = [UIFont fontSmall];
        model.isHiddenLine = YES;
        model.data = listModel;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(80) cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
}

- (void)showFilter {
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
    [self.iTableView reloadData];
}

- (void)showFilterWithIndex:(NSInteger)index {
    self.index = index;
    self.fileterView.openIndex = index;
    
    [self showFilter];
}

- (void)setLeftName:(NSString *)left right:(NSString *)right {
    [self.fileterView setLeftName:left right:right];
}

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationTeacherViewModel getTeacherList:param completeBlock:^(BOOL isSuccess, ZOriganizationTeacherListNetModel *data) {
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
    [ZOriganizationTeacherViewModel getTeacherList:param completeBlock:^(BOOL isSuccess, ZOriganizationTeacherListNetModel *data) {
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
       [param setObject:self.schoolID forKey:@"stores_id"];
       [param setObject:@"0" forKey:@"status"];
    return param;
}
@end
