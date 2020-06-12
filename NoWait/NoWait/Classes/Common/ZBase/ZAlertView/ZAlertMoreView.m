//
//  ZAlertMoreView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/31.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAlertMoreView.h"
#import "AppDelegate.h"
#import "ZPublicTool.h"

@interface ZAlertMoreView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UIView *contView;

@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) void (^handleBlock)(NSString *);
 
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@property (nonatomic,strong) NSArray *titleArr;

@end

@implementation ZAlertMoreView

static ZAlertMoreView *sharedManager;

+ (ZAlertMoreView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZAlertMoreView alloc] init];
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
        [self closeView];
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(108)*4);
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_bottom).offset(-CGFloatIn750(108)*2 - safeAreaBottom());
    }];
       
    [self.contView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contView);
        make.top.equalTo(self.contView.mas_top);
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
        _iTableView.scrollEnabled = NO;
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


#pragma mark - fun
- (void)setCellData {
    [_cellConfigArr removeAllObjects];
    
    for (int i = 0; i < _titleArr.count; i++) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = _titleArr[i][0];
        model.leftImage = _titleArr[i][1];
        model.leftMargin = CGFloatIn750(44);
        model.cellHeight = CGFloatIn750(106);
        model.leftFont = [UIFont fontContent];
        model.isHiddenLine = NO;
        model.lineLeftMargin = CGFloatIn750(88);
        model.lineRightMargin = CGFloatIn750(88);
        model.cellTitle = _titleArr[i][2];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:[ZSingleLineCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
        
    }
}


- (void)closeView {
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setTitleArr:(NSArray *)titleArr handlerBlock:(void(^)(NSString *))handleBlock {
    self.handleBlock = handleBlock;
    _titleArr = titleArr;
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

+ (void)setMoreAlertWithTitleArr:(NSArray *)titleArr handlerBlock:(void(^)(NSString *))handleBlock  {
    [[ZAlertMoreView sharedManager] setTitleArr:titleArr handlerBlock:handleBlock];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"ZSingleLineCell"]){
        ZBaseSingleCellModel *model = cellConfig.dataModel;
        if (self.handleBlock) {
            self.handleBlock(model.cellTitle);
        }
        [self closeView];
    }
    
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




