//
//  ZStudentLessonBuySelectViem.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonBuySelectViem.h"
#import "ZStudentLessonTeacherCell.h"
#import "ZStudentLessonTeacherSelectedCell.h"

@interface ZStudentLessonBuySelectViem ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@property (nonatomic,strong) UIButton *bottomBtn;

@end

@implementation ZStudentLessonBuySelectViem


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
        [_bottomBtn setTitle:@"提交订单" forState:UIControlStateNormal];
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
    __weak typeof(self) weakSelf = self;
     cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"ZStudentLessonTeacherCell"]) {
        ZStudentLessonTeacherCell *lcell = (ZStudentLessonTeacherCell *)cell;
        lcell.handleBlock = ^(ZOriganizationLessonTeacherModel *model) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(model);
            }
            weakSelf.orderModel.teacher_name = model.teacher_name;
            weakSelf.orderModel.teacher_id = model.teacher_id;
            weakSelf.orderModel.teacher_image = model.image;
            weakSelf.orderModel.price = model.price;
            
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
    if (!self.model) {
        return;
    }
    NSMutableDictionary *data = @{}.mutableCopy;
    if (ValidStr(self.orderModel.teacher_name)) {
        [data setObject:[NSString stringWithFormat:@"￥%@",self.orderModel.price] forKey:@"name"];
        [data setObject:[NSString stringWithFormat:@"已选教师%@",self.orderModel.teacher_name] forKey:@"lesson"];
        [data setObject:SafeStr(self.orderModel.teacher_image) forKey:@"image"];
    }else{
        [data setObject:[NSString stringWithFormat:@"￥%@起",self.model.price] forKey:@"name"];
        [data setObject:@"请选择教师" forKey:@"lesson"];
    }
    [data setObject:@"selectTeacher" forKey:@"teacher"];
    {
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonTeacherSelectedCell className] title:[ZStudentLessonTeacherSelectedCell className] showInfoMethod:@selector(setData:) heightOfCell:[ZStudentLessonTeacherSelectedCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:data];
        [self.cellConfigArr addObject:menuCellConfig];
        
    }
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"可选教师";
        model.leftFont = [UIFont boldFontTitle];
        model.cellHeight = CGFloatIn750(50);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
    }
    
    {
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonTeacherCell className] title:[ZStudentLessonTeacherCell className] showInfoMethod:@selector(setTeacher_list:) heightOfCell:[ZStudentLessonTeacherCell z_getCellHeight:self.model.teacher_list] cellType:ZCellTypeClass dataModel:self.model.teacher_list];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
}

- (void)setModel:(ZOriganizationLessonDetailModel *)model {
    _model = model;
    [self initCellConfigArr];
    [self.iTableView reloadData];
}
@end



