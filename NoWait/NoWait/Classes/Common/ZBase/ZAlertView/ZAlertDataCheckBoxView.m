//
//  ZAlertDataCheckBoxView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAlertDataCheckBoxView.h"
#import "AppDelegate.h"
#import "ZPublicTool.h"

@interface ZAlertDataCheckBoxView ()< UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
 
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end

@implementation ZAlertDataCheckBoxView

static ZAlertDataCheckBoxView *sharedManager;

+ (ZAlertDataCheckBoxView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZAlertDataCheckBoxView alloc] init];
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
    self.backgroundColor = adaptAndDarkColor(RGBAColor(0, 0, 0, 0.8), RGBAColor(1, 1, 1, 0.8));
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
    
    CGFloat height = KScreenHeight - CGFloatIn750(850) -  CGFloatIn750(30);

    CGFloat topContViewHeight = CGFloatIn750(850);
    if (height < CGFloatIn750(60)) {
        topContViewHeight = - CGFloatIn750(114);
    }
    
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(topContViewHeight);
        make.width.mas_equalTo(CGFloatIn750(690));
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(40));
    }];
    
    
    UIView *topView = [[UIView alloc] init];
    [self.contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(116));
        make.left.right.top.equalTo(self.contView);
    }];
    
    [topView addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topView);
    }];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]) forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont fontContent]];
    [leftBtn bk_addEventHandler:^(id sender) {
        if (self.handleBlock) {
            self.handleBlock(0);
        }
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(136));
        make.left.equalTo(topView);
        make.bottom.equalTo(topView);
        make.top.equalTo(topView);
    }];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [rightBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateNormal];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont fontContent]];
    [rightBtn bk_addEventHandler:^(id sender) {
        if (self.handleBlock) {
            self.handleBlock(1);
        }
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(136));
        make.right.equalTo(topView);
        make.bottom.equalTo(topView);
        make.top.equalTo(topView);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
       bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
       [topView addSubview:bottomLineView];
       [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.bottom.equalTo(topView);
           make.height.mas_equalTo(1);
       }];
       
    [self.contView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contView);
        make.top.equalTo(topView.mas_bottom);
    }];
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
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
        _iTableView.scrollEnabled = YES;
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
    }
    return _iTableView;
}


- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        ViewRadius(_contView, CGFloatIn750(32));
        _contView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
    }
    
    return _contView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.text = @"0";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont boldFontContent]];
    }
    return _nameLabel;
}

#pragma mark - fun
- (void)setCellData {
    [_cellConfigArr removeAllObjects];
    
    CGFloat height = KScreenHeight - CGFloatIn750(312 + 20) - CGFloatIn750(114) - CGFloatIn750(20);
    CGFloat cellHeight = height / 7;
    
    CGFloat singleHeight = 0;
    
    if (cellHeight < CGFloatIn750(108)) {
        singleHeight = cellHeight - CGFloatIn750(4);
    }else {
        singleHeight = CGFloatIn750(108);
    }
    
    NSArray *weekArr = @[@"李毅",@"上刀山",@"何时能",@"维格娜丝",@"史蒂夫",@"官方的",@"史蒂夫"];
    for (int i = 0; i < weekArr.count; i++) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = weekArr[i];
        model.leftMargin = CGFloatIn750(60);
        model.rightMargin = CGFloatIn750(60);
        model.cellHeight = singleHeight;
        model.leftFont = [UIFont fontMaxTitle];
        model.rightImage = @"selectedCycle";//unSelectedCycle
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:@"week" showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
        
    }
}

- (void)setName:(NSString *)title handlerBlock:(void(^)(NSInteger))handleBlock {
    self.handleBlock = handleBlock;
    self.nameLabel.text = title;
    
    
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
    [self setCellData];
    [self.iTableView reloadData];
}

+ (void)setAlertName:(NSString *)title handlerBlock:(void(^)(NSInteger))handleBlock  {
    [[ZAlertDataCheckBoxView sharedManager] setName:title handlerBlock:handleBlock];
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
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

@end




