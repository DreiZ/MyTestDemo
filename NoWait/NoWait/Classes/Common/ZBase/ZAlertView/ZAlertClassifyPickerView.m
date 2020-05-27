//
//  ZAlertClassifyPickerView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAlertClassifyPickerView.h"
#import "ZStudentLessonSelectTimeCell.h"
#import "ZOrganizationSchoolTypeCell.h"

@interface ZAlertClassifyPickerView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *rightTableView;
@property (nonatomic,strong) UILabel *lessonTitleLabel;
@property (nonatomic,strong) UIButton *sureBtn;
@property (nonatomic,strong) UIView *contView;

@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@property (nonatomic,strong) NSMutableArray *rightCellConfigArr;

@end

@implementation ZAlertClassifyPickerView

static ZAlertClassifyPickerView *sharedManager;

+ (ZAlertClassifyPickerView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZAlertClassifyPickerView alloc] init];
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

#pragma mark - 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor(RGBAColor(0, 0, 0, 0.8), RGBAColor(1, 1, 1, 0.8));
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    UIButton *backBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [backBtn bk_addEventHandler:^(id sender) {
        [self closeView];
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(434/812.0f * KScreenHeight);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(- safeAreaBottom());
    }];

    __weak typeof(self) weakSelf = self;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(134));
        make.left.right.top.equalTo(self.contView);
    }];
    
    UIButton *closeBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [closeBtn setTitle:@"取消" forState:UIControlStateNormal];
    [closeBtn.titleLabel setFont:[UIFont fontContent]];
    [closeBtn setTitleColor:[UIColor colorTextGray1] forState:UIControlStateNormal];
    [closeBtn bk_addEventHandler:^(id sender) {
        [weakSelf closeView];
    } forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(80));
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.top.bottom.equalTo(topView);
    }];
    
    [topView addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).offset(-CGFloatIn750(30));
        make.top.bottom.equalTo(topView);
        make.width.mas_equalTo(CGFloatIn750(80));
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [topView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(topView);
        make.bottom.equalTo(topView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    [topView addSubview:self.lessonTitleLabel];
    [self.lessonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX).offset(-0);
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    [self.contView addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(topView.mas_bottom).offset(CGFloatIn750(0));
        make.bottom.equalTo(self.contView.mas_bottom).offset(CGFloatIn750(-0));
    }];

    [self.funBackView addSubview:self.leftTableView];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.funBackView);
        make.right.equalTo(self.funBackView.mas_left).offset(CGFloatIn750(174));
    }];
    
    [self.funBackView addSubview:self.rightTableView];
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.funBackView);
        make.left.equalTo(self.leftTableView.mas_right).offset(0.5);
    }];
    
    UIView *middleLine = [[UIView alloc] initWithFrame:CGRectZero];
    middleLine.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [self.funBackView addSubview:middleLine];
    [middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.funBackView);
        make.width.mas_equalTo(1);
        make.left.equalTo(self.leftTableView.mas_right);
    }];
    
}

#pragma mark - Getter
- (UIView *)funBackView {
    if (!_funBackView) {
        _funBackView = [[UIView alloc] init];
        _funBackView.layer.masksToBounds = YES;
        _funBackView.clipsToBounds = YES;
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _funBackView;
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.clipsToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_contView, CGFloatIn750(12));
    }
    return _contView;
}


- (UIButton *)sureBtn {
    if (!_sureBtn) {
        __weak typeof(self) weakSelf = self;
        _sureBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor colorMain] forState:UIControlStateNormal];
        [_sureBtn.titleLabel setFont:[UIFont fontContent]];
        [_sureBtn bk_addEventHandler:^(id sender) {
            NSMutableArray *selectArr = @[].mutableCopy;
            for (int i = 0; i < weakSelf.classifys.count; i++) {
                ZMainClassifyOneModel *model = weakSelf.classifys[i];
                if (model.isSelected) {
                    for (int j = 0; j < model.secondary.count; j++) {
                        ZMainClassifyOneModel *tmodel = model.secondary[j];
                        if (tmodel.isSelected) {
                            [selectArr addObject:tmodel];
                        }
                    }
                }
            }
            if (weakSelf.sureBlock) {
                weakSelf.sureBlock(selectArr);
            }
            [weakSelf closeView];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

-(UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _leftTableView.estimatedRowHeight = 0;
        _leftTableView.estimatedSectionHeaderHeight = 0;
        _leftTableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            _leftTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.showsHorizontalScrollIndicator = NO;
        _leftTableView.alwaysBounceVertical = YES;
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
//        _iTableView.tableHeaderView = self.menuView;
    }
    return _leftTableView;
}


-(UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _rightTableView.estimatedRowHeight = 0;
        _rightTableView.estimatedSectionHeaderHeight = 0;
        _rightTableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            _rightTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        _rightTableView.showsVerticalScrollIndicator = NO;
        _rightTableView.showsHorizontalScrollIndicator = NO;
        _rightTableView.alwaysBounceVertical = YES;
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
//        _iTableView.tableHeaderView = self.menuView;
    }
    return _rightTableView;
}

- (UILabel *)lessonTitleLabel {
    if (!_lessonTitleLabel) {
        _lessonTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _lessonTitleLabel.text = @"选择类型";
        _lessonTitleLabel.numberOfLines = 1;
        _lessonTitleLabel.textAlignment = NSTextAlignmentCenter;
        [_lessonTitleLabel setFont:[UIFont boldFontTitle]];
    }
    return _lessonTitleLabel;
}

- (NSMutableArray *)cellConfigArr {
    if (!_cellConfigArr) {
        _cellConfigArr = @[].mutableCopy;
    }
    return _cellConfigArr;
}

- (NSMutableArray *)rightCellConfigArr {
    if (!_rightCellConfigArr) {
        _rightCellConfigArr = @[].mutableCopy;
    }
    return _rightCellConfigArr;
}

#pragma mark - tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return _cellConfigArr.count;
    }else{
        return _rightCellConfigArr.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    __weak typeof(self) weakSelf = self;
    if (tableView == self.leftTableView) {
        ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
         ZBaseCell *cell;
         cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
        if ([cellConfig.title isEqualToString:@"ZStudentLessonSelectTimeCell"]) {
            ZStudentLessonSelectTimeCell *lcell = (ZStudentLessonSelectTimeCell *)cell;
            lcell.titleLabel.font = [UIFont fontSmall];
        }
         return cell;
        
    }else{
        ZCellConfig *cellConfig = [_rightCellConfigArr objectAtIndex:indexPath.row];
         ZBaseCell *cell;
         cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
        
         return cell;
    }
}

#pragma mark - tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
        CGFloat cellHeight = cellConfig.heightOfCell;
        return cellHeight;
    }else {
        ZCellConfig *cellConfig = _rightCellConfigArr[indexPath.row];
        CGFloat cellHeight = cellConfig.heightOfCell;
        return cellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.rightTableView) {
        return CGFloatIn750(30);
    }
    return CGFloatIn750(20);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFloatIn750(20);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 20)];
    if (tableView == self.leftTableView) {
        sectionView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }else {
        sectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    
    sectionView.layer.masksToBounds = YES;
    return sectionView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 20)];
   if (tableView == self.leftTableView) {
       sectionView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
   }else {
       sectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
   }
   sectionView.layer.masksToBounds = YES;
   return sectionView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        for (int i = 0; i < _classifys.count; i++) {
           ZMainClassifyOneModel  *model = _classifys[i];
           if (i == indexPath.row) {
               model.isSelected = YES;
           }else{
               model.isSelected = NO;
               [model.secondary enumerateObjectsUsingBlock:^(ZMainClassifyOneModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                   obj.isSelected = NO;
               }];
           }
        }
       [self resetLeftArr];
    }else{
//        ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
        
    }
}

#pragma mark - 类型
-(void)setClassifys:(NSArray<ZMainClassifyOneModel *> *)classifys {
    _classifys = classifys;
    __block BOOL isSelected = NO;
    [classifys enumerateObjectsUsingBlock:^(ZMainClassifyOneModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected) {
            isSelected = YES;
        }
    }];
    
    if (!isSelected && ValidArray(classifys)) {
        classifys[0].isSelected = YES;
    }
    [self resetLeftArr];
}

- (void)resetLeftArr {
    [self.cellConfigArr removeAllObjects];
    for (int i = 0; i < _classifys.count; i++) {
        ZMainClassifyOneModel *model = _classifys[i];
        ZCellConfig *timeCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonSelectTimeCell className] title:[ZStudentLessonSelectTimeCell className] showInfoMethod:@selector(setClassifyModel:) heightOfCell:CGFloatIn750(80) cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:timeCellConfig];
    }
    
    [self.leftTableView reloadData];
    [self resetRightArr];
}

- (void)resetRightArr {
    [self.rightCellConfigArr removeAllObjects];
    for (int i = 0; i < _classifys.count; i++) {
        ZMainClassifyOneModel *model = _classifys[i];
        if (model.isSelected) {
            ZCellConfig *timeCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationSchoolTypeCell className] title:[ZOrganizationSchoolTypeCell className] showInfoMethod:@selector(setClassifysArr:) heightOfCell:[ZOrganizationSchoolTypeCell z_getCellHeight:model.secondary] cellType:ZCellTypeClass dataModel:model.secondary];
            [self.rightCellConfigArr addObject:timeCellConfig];
        }
    }
    
    [self.rightTableView reloadData];
}


- (void)setClassifyAlertWithClassifyArr:(NSArray *)classify handlerBlock:(void (^)(NSMutableArray *))handleBlock{
    _sureBlock = handleBlock;
    self.classifys = classify;
    
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    } completion:^(BOOL finished) {
        [self resetLeftArr];
    }];
}

- (void)closeView {
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+ (void)setClassifyAlertWithClassifyArr:(NSArray *)classify handlerBlock:(void (^)(NSMutableArray *))handleBlock {
    [[ZAlertClassifyPickerView sharedManager] setClassifyAlertWithClassifyArr:classify handlerBlock:handleBlock];
}
@end
