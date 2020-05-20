//
//  ZStudentLessonSelectOrderTimeView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonSelectOrderTimeView.h"
#import "ZStudentLessonSelectTimeCell.h"

@interface ZStudentLessonSelectOrderTimeView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *rightTableView;
@property (nonatomic,strong) UILabel *lessonTitleLabel;
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIButton *lastStepBtn;


@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@property (nonatomic,strong) NSMutableArray *rightCellConfigArr;

@end

@implementation ZStudentLessonSelectOrderTimeView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;

    __weak typeof(self) weakSelf = self;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(102));
        make.left.right.top.equalTo(self);
    }];
    
    UIButton *closeBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [closeBtn setImage:[UIImage imageNamed:@"lessonSelectClose"] forState:UIControlStateNormal];
    [closeBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.closeBlock) {
            weakSelf.closeBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(80));
        make.right.equalTo(topView.mas_right).offset(-CGFloatIn750(20));
        make.top.bottom.equalTo(topView);
    }];
    
    [topView addSubview:self.lastStepBtn];
    [self.lastStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(10));
        make.top.bottom.equalTo(topView);
        make.width.mas_equalTo(CGFloatIn750(90));
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayBGDark]);
    [topView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(topView);
        make.height.mas_equalTo(0.5);
    }];
    
    [topView addSubview:self.lessonTitleLabel];
    [self.lessonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX).offset(-0);
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    UIImageView *lessonImageView = [[UIImageView alloc] init];
//    lessonImageView.image = [UIImage imageNamed:@"lesssonTimeHint"];
    lessonImageView.layer.masksToBounds = YES;
    [topView addSubview:lessonImageView];
    [lessonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lessonTitleLabel.mas_left).offset(-CGFloatIn750(20));
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    [self addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-safeAreaBottom());
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    [self addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(topView.mas_bottom).offset(CGFloatIn750(0));
        make.bottom.equalTo(self.bottomBtn.mas_top).offset(CGFloatIn750(-0));
    }];
    
    [self.funBackView addSubview:self.leftTableView];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.funBackView);
        make.right.equalTo(self.funBackView.mas_left).offset(CGFloatIn750(300));
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

#pragma mark -Getter
- (UIView *)funBackView {
    if (!_funBackView) {
        _funBackView = [[UIView alloc] init];
        _funBackView.layer.masksToBounds = YES;
        _funBackView.clipsToBounds = YES;
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _funBackView;
}


- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"提交预约" forState:UIControlStateNormal];
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

- (UIButton *)lastStepBtn {
    if (!_lastStepBtn) {
        __weak typeof(self) weakSelf = self;
        _lastStepBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_lastStepBtn setImage:isDarkModel() ? [UIImage imageNamed:@"navleftBackDark"] : [UIImage imageNamed:@"navleftBack"] forState:UIControlStateNormal];
        [_lastStepBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.lastStepBlock) {
                weakSelf.lastStepBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _lastStepBtn;
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
        _lessonTitleLabel.text = @"请选择预约时间";
        _lessonTitleLabel.numberOfLines = 1;
        _lessonTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonTitleLabel setFont:[UIFont boldFontContent]];
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

#pragma mark tableView -------datasource-----
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
        
         return cell;
        
    }else{
        ZCellConfig *cellConfig = [_rightCellConfigArr objectAtIndex:indexPath.row];
         ZBaseCell *cell;
         cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
         return cell;
    }
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
        CGFloat cellHeight =  cellConfig.heightOfCell;
        return cellHeight;
    }else {
        ZCellConfig *cellConfig = _rightCellConfigArr[indexPath.row];
        CGFloat cellHeight =  cellConfig.heightOfCell;
        return cellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 14.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 20)];
    if (tableView == self.leftTableView) {
        sectionView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }else{
        sectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    
    sectionView.layer.masksToBounds = YES;
    return sectionView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 20)];
    if (tableView == self.leftTableView) {
       sectionView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }else{
       sectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    sectionView.layer.masksToBounds = YES;
    return sectionView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        for (int i = 0; i < _list.count; i++) {
               ZOriganizationLessonExperienceTimeModel *model = _list[i];
               if (i == indexPath.row) {
                   model.isTimeSelected = YES;
               }else{
                   model.isTimeSelected = NO;
               }
           }
           [self resetLeftArr];
    }else{
        ZCellConfig *cellConfig = [_rightCellConfigArr objectAtIndex:indexPath.row];
        if ([cellConfig.title isEqualToString:@"subTime"]) {
            [self setRightTableSelect:indexPath];
        }
    }
}

- (void)setRightTableSelect:(NSIndexPath *)indexPath {
    for (int i = 0; i < _list.count; i++) {
        ZOriganizationLessonExperienceTimeModel *model = _list[i];
        if (model.isTimeSelected) {
            NSArray *timeArr = model.timeArr;
            for (int k = 0; k < timeArr.count; k++) {
                ZOriganizationLessonExperienceTimeSubModel *smodel = timeArr[k];
                if (indexPath.row == k) {
                    smodel.isSubTimeSelected = YES;
                    if (self.timeBlock) {
                        ZOriganizationLessonExperienceTimeModel *timeModel = [[ZOriganizationLessonExperienceTimeModel alloc] init];
                        timeModel.date = model.date;
                        timeModel.time = smodel.time;
                        self.timeBlock(timeModel);
                    }
                }else{
                    smodel.isSubTimeSelected = NO;
                }
            }
            [self resetRightArr];
            [self.rightTableView reloadData];
        }
    }
}

#pragma mark 类型
-(void)setList:(NSArray<ZOriganizationLessonExperienceTimeModel *> *)list{
    _list = list;
    self.lastStepBtn.hidden = NO;
    if (list && list.count > 0) {
        ZOriganizationLessonExperienceTimeModel *tModel = list[0];
        tModel.isTimeSelected = YES;
    }
    [self resetLeftArr];
}

- (void)resetLeftArr {
    [self.cellConfigArr removeAllObjects];
    for (int i = 0; i < _list.count; i++) {
        ZOriganizationLessonExperienceTimeModel *model = _list[i];
    
        ZCellConfig *timeCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonSelectTimeCell className] title:[ZStudentLessonSelectTimeCell className] showInfoMethod:@selector(setTimeModel:) heightOfCell:[ZStudentLessonSelectTimeCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:timeCellConfig];
    }
    
    [self.leftTableView reloadData];
    [self resetRightArr];
}

- (void)resetRightArr {
    [self.rightCellConfigArr removeAllObjects];
    for (int i = 0; i < _list.count; i++) {
        ZOriganizationLessonExperienceTimeModel *model = _list[i];
        if (model.isTimeSelected) {
            NSArray *timeArr = model.timeArr;
            for (int k = 0; k < timeArr.count; k++) {
                ZOriganizationLessonExperienceTimeSubModel *smodel = timeArr[k];
                ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
                model.leftTitle = smodel.time;
                model.leftFont = [UIFont fontContent];
                model.cellHeight = CGFloatIn750(106);
                model.isHiddenLine = YES;
                model.rightImage = smodel.isSubTimeSelected ? @"selectedCycle":@"unSelectedCycle";
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:@"subTime" showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [self.rightCellConfigArr addObject:menuCellConfig];
            }
        }
    }
    
    [self.rightTableView reloadData];
}

#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    // darkmodel change
    [_lastStepBtn setImage:isDarkModel() ? [UIImage imageNamed:@"navleftBackDark"] : [UIImage imageNamed:@"navleftBack"] forState:UIControlStateNormal];
}
@end
