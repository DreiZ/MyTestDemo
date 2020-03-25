//
//  ZOrganizationCouponListView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCouponListView.h"
#import "AppDelegate.h"
#import "ZStudentOrganizationCouponCell.h"

@interface ZOrganizationCouponListView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZOrganizationCouponListView

static ZOrganizationCouponListView *sharedManager;

+ (ZOrganizationCouponListView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZOrganizationCouponListView alloc] init];
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
        make.bottom.equalTo(self).offset(CGFloatIn750(32));
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
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(70));
    }];
    
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(40));
        make.bottom.equalTo(self.bottomBtn.mas_top).offset(-CGFloatIn750(100));
    }];
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldFontContent]];
        [_bottomBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            [self removeFromSuperview];
        }];
    }
    return _bottomBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel  = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor colorTextBlack];
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
        _contView.backgroundColor = [UIColor whiteColor];
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


- (void)setAlertWithTitle:(NSString *)title ouponList:(NSArray *)couponList handlerBlock:(void (^)(NSInteger))handleBlock {
    self.titleLabel.text = title;
    
    ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationCouponCell className] title:@"ZStudentOrganizationCouponCell" showInfoMethod:nil heightOfCell:[ZStudentOrganizationCouponCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:orCellCon1fig];
    [self.cellConfigArr addObject:orCellCon1fig];
    [self.cellConfigArr addObject:orCellCon1fig];
    [self.iTableView reloadData];
    
    
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
}


+ (void)setAlertWithTitle:(NSString *)title ouponList:(NSArray *)couponList handlerBlock:(void (^)(NSInteger))handleBlock  {
    [[ZOrganizationCouponListView sharedManager] setAlertWithTitle:title ouponList:couponList handlerBlock:handleBlock];
}
@end
