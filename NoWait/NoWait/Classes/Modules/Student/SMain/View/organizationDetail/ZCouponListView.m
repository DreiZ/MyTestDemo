//
//  ZCouponListView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/31.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCouponListView.h"
#import "AppDelegate.h"
#import "ZStudentOrganizationCouponCell.h"
#import "ZOriganizationCardViewModel.h"

@interface ZCouponListView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableDictionary *param;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) NSString *type;

@property (nonatomic,strong) void (^handleBlock)(ZOriganizationCardListModel *);
@end

@implementation ZCouponListView

static ZCouponListView *sharedManager;

+ (ZCouponListView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZCouponListView alloc] init];
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
    
    _cellConfigArr = @[].mutableCopy;
    _dataSources = @[].mutableCopy;
    _param = @{}.mutableCopy;
    
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
        make.height.mas_equalTo(CGFloatIn750(610 + CGFloatIn750(190)));
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(0);
    }];
    
    [self.contView addSubview:self.iTableView];
    [self.contView addSubview:self.titleLabel];
    [self.contView addSubview:self.bottomBtn];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(40));
    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(88));
        make.bottom.equalTo(self.contView.mas_bottom).offset(-safeAreaBottom());
    }];
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self.bottomBtn addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.bottomBtn);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(40));
        make.bottom.equalTo(self.bottomBtn.mas_top).offset(-CGFloatIn750(0));
    }];
    
    [self setTableViewRefreshFooter];
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldFontContent]];
        [_bottomBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
            if ([self.type isEqualToString:@"use"]) {
                if (self.handleBlock) {
                    self.handleBlock(nil);
                }
            }
            [self removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel  = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont boldFontContent]];
        
    }
    return _titleLabel;
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.layer.cornerRadius = 16;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    
    return _contView;
}

#pragma mark - lazy loading...
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
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _iTableView;
}


- (void)setTableViewRefreshHeader {
    __weak typeof(self) weakSelf = self;
    [self.iTableView tt_addRefreshHeaderWithAction:^{
        [weakSelf refreshData];
    }];
}

- (void)setTableViewRefreshFooter {
    __weak typeof(self) weakSelf = self;
    
    [self.iTableView tt_addLoadMoreFooterWithAction:^{
        [weakSelf refreshMoreData];
    }];
    
    [self.iTableView tt_removeLoadMoreFooter];
}

#pragma mark - tableView -------datasource-----
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
    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationCouponCell"]) {
        ZStudentOrganizationCouponCell *lcell = (ZStudentOrganizationCouponCell *)cell;
        lcell.handleBlock = ^(ZOriganizationCardListModel *model) {
            if (self.handleBlock ) {
                self.handleBlock(model);
            }
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
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

#pragma mark - setdata
- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
    
    for (ZOriganizationCardListModel *listModel in self.dataSources) {
        if ([self.type isEqualToString:@"use"]) {
            listModel.isUse = YES;
        }
        ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationCouponCell className] title:@"ZStudentOrganizationCouponCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationCouponCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:listModel];
        [self.cellConfigArr addObject:orCellCon1fig];
    }
}

- (void)setAlertWithTitle:(NSString *)title handlerBlock:(void (^)(ZOriganizationCardListModel *))handleBlock {
    self.titleLabel.text = title;
    _handleBlock = handleBlock;
    
    if ([self.type isEqualToString:@"use"]) {
        [_bottomBtn setTitle:@"不使用优惠券" forState:UIControlStateNormal];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]) forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark])  forState:UIControlStateNormal];
    }else{
        [_bottomBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
    }
    
    [self refreshData];
    
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
}



+ (void)setAlertWithTitle:(NSString *)title type:(NSString *)type stores_id:(NSString *)stores_id course_id:(NSString *)course_id teacher_id:(NSString *)teacher_id handlerBlock:(void (^)(ZOriganizationCardListModel * _Nonnull))handleBlock {
    [[ZCouponListView sharedManager].param removeAllObjects];
    [[ZCouponListView sharedManager].dataSources removeAllObjects];
    [[ZCouponListView sharedManager].cellConfigArr removeAllObjects];
    
    if (ValidStr(stores_id)) {
        [[ZCouponListView sharedManager].param setObject:SafeStr(stores_id) forKey:@"stores_id"];
    }
    if (ValidStr(course_id)) {
        [[ZCouponListView sharedManager].param setObject:SafeStr(course_id) forKey:@"course_id"];
    }
    if (ValidStr(teacher_id)) {
        [[ZCouponListView sharedManager].param setObject:SafeStr(teacher_id) forKey:@"teacher_id"];
        [[ZCouponListView sharedManager].param setObject:@"1" forKey:@"use_status"];
    }
    [ZCouponListView sharedManager].type = type;
    [[ZCouponListView sharedManager] setAlertWithTitle:title  handlerBlock:handleBlock];
}


#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    [self setPostCommonData];
    [self refreshHeadData:_param];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    if ([self.type isEqualToString:@"school"]) {
        [ZOriganizationCardViewModel getLessonCardList:param completeBlock:^(BOOL isSuccess, ZOriganizationCardListNetModel *data) {
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
    }else if ([self.type isEqualToString:@"lesson"]){
        [ZOriganizationCardViewModel getLessonCardList:_param completeBlock:^(BOOL isSuccess, ZOriganizationCardListNetModel *data) {
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
    }else if ([self.type isEqualToString:@"use"]){
        [ZOriganizationCardViewModel getUseCardLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationCardListNetModel *data) {
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
    
}

- (void)refreshMoreData {
    self.currentPage++;
    [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    if ([self.type isEqualToString:@"school"]) {
        [ZOriganizationCardViewModel getLessonCardList:_param completeBlock:^(BOOL isSuccess, ZOriganizationCardListNetModel *data) {
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
    }else if ([self.type isEqualToString:@"lesson"]){
        [ZOriganizationCardViewModel getLessonCardList:_param completeBlock:^(BOOL isSuccess, ZOriganizationCardListNetModel *data) {
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
    }else if ([self.type isEqualToString:@"use"]){
        [ZOriganizationCardViewModel getUseCardLessonList:_param completeBlock:^(BOOL isSuccess, ZOriganizationCardListNetModel *data) {
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
}


- (void)setPostCommonData {
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];;
    [_param setObject:@"1" forKey:@"status"];
}

@end

