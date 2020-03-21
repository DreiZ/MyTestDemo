//
//  ZAlertDataCheckBoxBottomView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAlertDataCheckBoxBottomView.h"
#import "AppDelegate.h"
#import "ZPublicTool.h"

@interface ZAlertDataCheckBoxBottomView ()

@property (nonatomic,strong) id data;

@end

@implementation ZAlertDataCheckBoxBottomView

static ZAlertDataCheckBoxBottomView *sharedManager;

+ (ZAlertDataCheckBoxBottomView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZAlertDataCheckBoxBottomView alloc] init];
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
    
    
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
       bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
       [topView addSubview:bottomLineView];
       [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.bottom.equalTo(topView);
           make.height.mas_equalTo(1);
       }];
       
    [self.contView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(80));
        make.bottom.equalTo(self.contView.mas_bottom).offset(-safeAreaBottom());
    }];
    
    [self.contView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(topView.mas_bottom);
        make.bottom.equalTo(self.bottomBtn.mas_top);
    }];
}

- (void)handleWithIndex:(NSInteger)index{
    
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

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldFontContent]];
        [_bottomBtn setBackgroundColor:[UIColor colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1, nil);
            }
        }];
    }
    return _bottomBtn;
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
    [self initCellConfigArr];
}


- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
}

- (void)setName:(NSString *)title handlerBlock:(void(^)(NSInteger, id))handleBlock {
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

+ (void)setAlertName:(NSString *)title handlerBlock:(void(^)(NSInteger, id))handleBlock  {
    [[ZAlertDataCheckBoxBottomView sharedManager] setName:title handlerBlock:handleBlock];
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
    [self zz_tableView:tableView cell:cell cellForRowAtIndexPath:indexPath cellConfig:cellConfig];
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
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    [self zz_tableView:tableView didSelectRowAtIndexPath:indexPath cellConfig:cellConfig];
}


#pragma mark - tableview 数据处理
-(void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    
}


-(void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig{
    
}



#pragma mark - DZNEmptyDataSetSource Methods
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (self.loading) {
        text = @"数据加载中...";
        font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0];
        textColor = [UIColor colorWithHexString:@"999999"];
        
        
        if (!text) {
            return nil;
        }
        
        if (font) [attributes setObject:font forKey:NSFontAttributeName];
        if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }else{
        if ([self getNetworkStatus]) {
            text = self.emptyDataStr;
            font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0];
            textColor = [UIColor colorWithHexString:@"222222"];
            
            
            if (!text) {
                return nil;
            }
            
        }else{
            NSString *title = @"天呐，您的网络好像出了点小问题...";
            NSString *subTitle = @"                  解决方案：";
            NSString *detailTitle = @"                             1、在设置中开启网络权限，\n                             2、换个网络更好的地方试试吧！";
            
            text = [NSString stringWithFormat:@"%@\n%@\n%@",title,subTitle,detailTitle];
            
            NSMutableAttributedString *attributedSting =  [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
            
            NSRange netRangeTitle = NSMakeRange([[attributedSting string] rangeOfString:title].location, [[attributedSting string] rangeOfString:title].length);
            NSRange netRangeSubtitle = NSMakeRange([[attributedSting string] rangeOfString:subTitle].location, [[attributedSting string] rangeOfString:subTitle].length);
            NSRange netRangeDetailTitle = NSMakeRange([[attributedSting string] rangeOfString:detailTitle].location, [[attributedSting string] rangeOfString:detailTitle].length);
            
            //标题
            [attributedSting addAttribute:NSFontAttributeName value:[UIFont fontContent] range:netRangeTitle];
            [attributedSting addAttribute:NSForegroundColorAttributeName value:[UIColor colorTextBlack] range:netRangeTitle];
            NSMutableParagraphStyle * titleParagraphStyle = [[NSMutableParagraphStyle alloc] init];
            [titleParagraphStyle setLineSpacing:CGFloatIn750(40)];
            [titleParagraphStyle setAlignment:NSTextAlignmentCenter];
            [attributedSting addAttribute:NSParagraphStyleAttributeName value:titleParagraphStyle range:netRangeTitle];
            
            //副标题
            [attributedSting addAttribute:NSFontAttributeName value:[UIFont fontContent] range:netRangeSubtitle];
            [attributedSting addAttribute:NSForegroundColorAttributeName value:[UIColor colorTextGray1] range:netRangeSubtitle];
            NSMutableParagraphStyle * subParagraphStyle = [[NSMutableParagraphStyle alloc] init];
            [subParagraphStyle setLineSpacing:CGFloatIn750(24)];
            [subParagraphStyle setAlignment:NSTextAlignmentLeft];
            [attributedSting addAttribute:NSParagraphStyleAttributeName value:subParagraphStyle range:netRangeSubtitle];
            
            //内容
            [attributedSting addAttribute:NSFontAttributeName value:[UIFont fontSmall] range:netRangeDetailTitle];
            [attributedSting addAttribute:NSForegroundColorAttributeName value:[UIColor colorTextGray1] range:netRangeDetailTitle];
            NSMutableParagraphStyle * detailParagraphStyle = [[NSMutableParagraphStyle alloc] init];
            [detailParagraphStyle setLineSpacing:CGFloatIn750(16)];
            [detailParagraphStyle setAlignment:NSTextAlignmentLeft];
            [attributedSting addAttribute:NSParagraphStyleAttributeName value:detailParagraphStyle range:netRangeDetailTitle];
            
            return attributedSting;
        }
        
        if (!text) {
            return nil;
        }
        
        if (font) [attributes setObject:font forKey:NSFontAttributeName];
        if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
        
        
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
}


- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.isLoading) {
        return [UIImage imageNamed:@"zphoto_number_icon"];
    }else{
        if ([self getNetworkStatus]) {
            return [UIImage imageNamed:_emptyImage? _emptyImage : @"emptyData"];
        }else{
            return [UIImage imageNamed: @"noNetwork"];
        }
    }
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    //    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    //    animation.duration = 0.25;
    //    animation.cumulative = YES;
    //    animation.repeatCount = MAXFLOAT;
    CGFloat duration = 0.8f;
    
    CGFloat height = 50.f;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    // 缩放
    CAKeyframeAnimation *animScale = [CAKeyframeAnimation animation];
    
    animScale.keyPath = @"transform.scale";
    
    // 0 ~ 1
    static CGFloat scale = 0.5;

    animScale.values = @[@(scale/(4.0/8.0)), @(scale/(5.0/8.0)), @(scale/(6.0/8.0)), @(scale/(7.0/8.0)), @(scale/(8.0/8.0)), @(scale/(7.0/8.0)), @(scale/(6.0/8.0)), @(scale/(5.0/8.0)), @(scale/(4.0/8.0))];
    
    animScale.keyTimes = @[ @(0), @(0.025), @(0.085), @(0.2), @(0.5), @(0.8), @(0.915), @(0.975), @(1) ];
    animScale.duration = duration;
    animScale.repeatCount = HUGE_VALF;
    animScale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    
    CGFloat currentTy = 0;
    
    animation.duration = duration;
    
    animation.values = @[@(currentTy), @(currentTy - height/4), @(currentTy-height/4*2), @(currentTy-height/4*3), @(currentTy - height), @(currentTy-height/4*3), @(currentTy -height/4*2), @(currentTy - height/4), @(currentTy)];
    
    animation.keyTimes = @[ @(0), @(0.025), @(0.085), @(0.2), @(0.5), @(0.8), @(0.915), @(0.975), @(1) ];
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation.repeatCount = HUGE_VALF;
    
    //    [sender.layer addAnimation:animation forKey:@"kViewShakerAnimationKey"];
    group.duration = duration;
    group.animations = @[animScale,animation];
    group.repeatCount = HUGE_VALF;
    return group;
}


- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -CGFloatIn750(60);
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return CGFloatIn750(40);
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if (self.isLoading) {
        return nil;
    }
    if (![self getNetworkStatus]) {
        return [UIImage imageNamed:@"emptyReload"];
    }else {
        return nil;
    }
    
}
#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    if (!self.isLoading) {
        return NO;
    }
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    self.loading = YES;
    [scrollView reloadEmptyDataSet];
    [self refreshData];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    self.loading = YES;
    [scrollView reloadEmptyDataSet];
    [self refreshData];
}


- (BOOL)getNetworkStatus {
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    if(mgr.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable){
        //        [[HNPublicTool shareInstance] showHudMessage:@"没有网络，请检查手机网络连接"];
        return NO;
    }else{
        return YES;
    }
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

- (void)setTableViewEmptyDataDelegate {
    self.iTableView.emptyDataSetSource = self;
    self.iTableView.emptyDataSetDelegate = self;
}

#pragma mark 初始化 datasource delegate
- (void)refreshData {
    
}

- (void)refreshMoreData {
    
}
@end





