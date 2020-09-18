//
//  ZTeacherClassFormFilterView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/9/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherClassFormFilterView.h"

@interface ZTeacherClassFormFilterView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZTeacherClassFormFilterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    _dataSources = @[].mutableCopy;
    _cellConfigArr = @[].mutableCopy;
    
    __weak typeof(self) weakSelf = self;
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backBtn bk_whenTapped:^{
        [weakSelf removeFromSuperview];
    }];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(CGFloatIn750(280));
        make.height.mas_equalTo(CGFloatIn750(350));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(80));
    }];
    [self.contView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contView);
    }];
    
    
    [self initCellConfigArr];
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        ViewRadius(_contView, CGFloatIn750(8));
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWithHexString:@"aaaaaa"], [UIColor colorWithHexString:@"444444"]);
        ViewShadowRadius(_contView, CGFloatIn750(10), CGSizeMake(2, 2), 0.5, isDarkModel() ? [UIColor colorGrayBG] : [UIColor colorGrayBGDark]);
    }
    return _contView;
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.contView.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
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
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
    }
    return _iTableView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    cell.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    ZLineCellModel *dataModel = cellConfig.dataModel;
    
    ZBaseLineCell *lcell = (ZBaseLineCell *)cell;
    if (dataModel.leftImage) {
        lcell.leftImageView.tintColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        lcell.leftImageView.image = [[UIImage imageNamed:dataModel.leftImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    return cellConfig.heightOfCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.handleBlock) {
        self.handleBlock(self.dataSources[indexPath.row]);
        [self removeFromSuperview];
    }
}


#pragma mark - setdata
- (void)initCellConfigArr {
    [self.cellConfigArr removeAllObjects];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationClassListModel *dataModel = self.dataSources[i];
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"content")
        .zz_cellHeight(CGFloatIn750(70))
        .zz_lineHidden(YES)
        .zz_titleLeft(dataModel.name)
        .zz_leftMultiLine(YES)
        .zz_fontLeft([UIFont fontContent])
        .zz_spaceLine(CGFloatIn750(8))
        .zz_cellWidth(CGFloatIn750(280));
        if ([dataModel.classID isEqualToString:self.model.classID]) {
            model.zz_imageLeft(@"finderFollowYes");
            model.zz_imageLeftWidth(CGFloatIn750(24));
            model.zz_imageLeftHeight(CGFloatIn750(24));
        }
        

        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    [self.iTableView reloadData];
}

- (void)setDataSources:(NSMutableArray *)dataSources {
    _dataSources = dataSources;
    
    [self initCellConfigArr];
}
@end
