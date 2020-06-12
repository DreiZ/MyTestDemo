//
//  ZAlertDateWeekAndHourPickerView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAlertDateWeekAndHourPickerView.h"
#import "AppDelegate.h"
#import "ZPublicTool.h"

@interface ZAlertDateWeekAndHourPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIView *bottomContView;
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UITableView *iTableView;

@property (nonatomic,strong) UIPickerView *pickView;
@property (nonatomic,strong) NSMutableArray <ZAlertDataItemModel *> *data1;
@property (nonatomic,strong) NSMutableArray <ZAlertDataItemModel *> *data2;
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
 
@property (nonatomic,assign) NSInteger proIndex;
@property (nonatomic,assign) NSInteger cityIndex;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end

@implementation ZAlertDateWeekAndHourPickerView

static ZAlertDateWeekAndHourPickerView *sharedManager;

+ (ZAlertDateWeekAndHourPickerView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZAlertDateWeekAndHourPickerView alloc] init];
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
    
    CGFloat height = KScreenHeight - CGFloatIn750(312 + 20) - CGFloatIn750(114) - CGFloatIn750(30);
    CGFloat cellHeight = height / 7;
    CGFloat topContViewHeight = 0;
    if (cellHeight < CGFloatIn750(108)) {
        topContViewHeight = (CGFloatIn750(108) + CGFloatIn750(4)) * 7 + CGFloatIn750(114);
    }else {
        topContViewHeight = (CGFloatIn750(108) + CGFloatIn750(4)) * 7 + CGFloatIn750(114);
    }
    
    [self addSubview:self.bottomContView];
    [self.bottomContView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(292));
        make.width.mas_equalTo(CGFloatIn750(690));
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(30));
    }];
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(topContViewHeight);
        make.width.mas_equalTo(CGFloatIn750(690));
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.bottomContView.mas_top).offset(-CGFloatIn750(20));
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
    [rightBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
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
    
    [self.bottomContView addSubview:self.pickView];
    [self.pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomContView);
        make.left.equalTo(self.bottomContView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(self.bottomContView.mas_right).offset(CGFloatIn750(-60));
        make.top.equalTo(self.bottomContView.mas_top);
    }];
    
    //设置分割线
    for (UIView *line in self.bottomContView.subviews) {
        if (line.frame.size.height < 1) {//0.6667
            line.backgroundColor = [UIColor clearColor];
        }
    }
    
    UILabel *middleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    middleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    middleLabel.text = @"~";
    middleLabel.numberOfLines = 0;
    middleLabel.textAlignment = NSTextAlignmentCenter;
    [middleLabel setFont:[UIFont fontContent]];
    [self.bottomContView addSubview:middleLabel];
    [middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bottomContView);
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

- (UIView *)bottomContView {
    if (!_bottomContView) {
        _bottomContView = [[UIView alloc] init];
        ViewRadius(_bottomContView, CGFloatIn750(32));
        _bottomContView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
    }
    
    return _bottomContView;
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

- (UIPickerView *)pickView {
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] init];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
    }
    return _pickView;
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
    
    NSArray *weekArr = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期七"];
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
    
    self.data1 = @[].mutableCopy;
    self.data2 = @[].mutableCopy;
    
    self.proIndex = 0;
    self.cityIndex = 0;
    for (int i = 0; i < 24; i++) {
       ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
        if (i < 10) {
            model.name = [NSString stringWithFormat:@"0%d:00",i];
        }else{
            model.name = [NSString stringWithFormat:@"%d:00",i];
        }
       
       [self.data1 addObject:model];
    }
    
    for (int i = 0; i < 24; i++) {
       ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
        if (i < 10) {
            model.name = [NSString stringWithFormat:@"0%d:00",i];
        }else{
            model.name = [NSString stringWithFormat:@"%d:00",i];
        }
       
       [self.data2 addObject:model];
    }
    
    
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
    [self.pickView reloadAllComponents];
    [self setCellData];
    [self.iTableView reloadData];
}

+ (void)setAlertName:(NSString *)title handlerBlock:(void(^)(NSInteger))handleBlock  {
    [[ZAlertDateWeekAndHourPickerView sharedManager] setName:title handlerBlock:handleBlock];
}


#pragma mark -datapicker delegate

//自定义每个pickview的label
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UIView *sectionView = [[UIView alloc] init];
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
    [sectionView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(sectionView);
        make.height.mas_equalTo(0.5);
    }];

    UILabel* pickerLabel = [UILabel new];
    pickerLabel.numberOfLines = 0;
    pickerLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    [pickerLabel setFont:[UIFont fontContent]];
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];

    [sectionView addSubview:pickerLabel];
    [pickerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionView.mas_left).offset(CGFloatIn750(20));
        make.top.bottom.right.equalTo(sectionView);
    }];

    return sectionView;
}

#pragma mark --pickerView delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        _proIndex = row;
    }
    
    if (component == 1) {
        _cityIndex = row;
    }
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return self.data1[row].name;
    }else if (component == 1){
        return self.data2[row].name;
    }
    
    return nil;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return self.data1.count;
    }else if (component == 1){
        return self.data2.count;
    }
    
    return 0;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return CGFloatIn750(86);
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



