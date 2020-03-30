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

@interface ZStudentLessonSelectOrderLessonView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@property (nonatomic,strong) UIButton *bottomBtn;

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
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"预约时间" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldFontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            if (weakSelf.bottomBlock) {
                weakSelf.bottomBlock();
            }
        }];
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
     cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    
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
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonTeacherSelectedCell className] title:[ZStudentLessonTeacherSelectedCell className] showInfoMethod:nil heightOfCell:[ZStudentLessonTeacherSelectedCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [self.cellConfigArr addObject:menuCellConfig];
        
    }
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"￥500.00 起";
        model.leftFont = [UIFont boldSystemFontOfSize:CGFloatIn750(40)];
        model.cellHeight = CGFloatIn750(50);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"请选择教师";
        model.leftFont = [UIFont fontSmall];
        model.cellHeight = CGFloatIn750(50);
        model.isHiddenLine = YES;
        model.leftColor = [UIColor colorTextGray1];
        model.leftDarkColor = [UIColor colorTextGray1Dark];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(50))];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"可预约课程";
        model.leftFont = [UIFont boldFontTitle];
        model.cellHeight = CGFloatIn750(60);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonTeacherCell className] title:[ZStudentLessonTeacherCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonTeacherCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(80))];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"体验时长";
        model.leftFont = [UIFont boldFontTitle];
        model.cellHeight = CGFloatIn750(50);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = @"0分钟";
            model.leftFont = [UIFont fontContent];
            model.cellHeight = CGFloatIn750(50);
            model.isHiddenLine = YES;
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
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
            model.leftTitle = @"0分钟";
            model.leftFont = [UIFont fontContent];
            model.cellHeight = CGFloatIn750(50);
            model.isHiddenLine = YES;
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
}

- (void)setDetailModel:(ZStoresDetailModel *)detailModel {
    _detailModel = detailModel;
    [self initCellConfigArr];
    [self.iTableView reloadData];
}
@end
