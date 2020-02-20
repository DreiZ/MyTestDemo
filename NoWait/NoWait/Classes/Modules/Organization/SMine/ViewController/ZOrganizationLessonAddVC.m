//
//  ZOrganizationLessonAddVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonAddVC.h"
#import "ZOrganizationLessonAddImageCell.h"
#import "ZOrganizationLessonAddPhotosCell.h"
#import "ZOrganizationLessonTypeCell.h"
#import "ZOrganizationLessonTypeCell.h"

#import "ZStudentDetailModel.h"

#import "ZAlertDataPickerView.h"
#import "ZAlertDateHourPickerView.h"
#import "ZAlertDataSinglePickerView.h"
#import "ZAlertDateWeekAndHourPickerView.h"
#import "ZAlertDataModel.h"

@interface ZOrganizationLessonAddVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIButton *bottomBtn;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@property (nonatomic,strong) NSMutableArray <ZAlertDataItemModel*> *items;
@end

@implementation ZOrganizationLessonAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setDataSource];
    [self initCellConfigArr];
    [self setupMainView];
}

- (void)setDataSource {
    _dataSources = @[].mutableCopy;
    _cellConfigArr = @[].mutableCopy;
    _items = @[].mutableCopy;
}

- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
    
    
    ZCellConfig *addImageCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonAddImageCell className] title:[ZOrganizationLessonAddImageCell className] showInfoMethod:nil heightOfCell:[ZOrganizationLessonAddImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:addImageCellConfig];
    
    NSArray *titleArr = @[@"请输入课程名称",@"请输入课程简介"];
    for (int i = 0 ; i < titleArr.count; i++) {
        ZBaseTextFieldCellModel *model = [[ZBaseTextFieldCellModel alloc] init];
        model.placeholder = titleArr[i];
        model.textColor = [UIColor colorTextGray];
        model.leftContentWidth = CGFloatIn750(0);
        model.isHiddenLine = YES;
        model.textAlignment = NSTextAlignmentLeft;
        model.isHiddenInputLine = YES;
        model.textFont = i == 0 ?  [UIFont boldFontMax1Title] : [UIFont fontContent];
        model.cellHeight = CGFloatIn750(116);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineLeftMargin = CGFloatIn750(30);
        model.textFieldHeight = CGFloatIn750(110);
        model.isTextEnabled = YES;
        model.leftMargin = CGFloatIn750(10);

        ZCellConfig *nameCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:nameCellConfig];
    }
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"课程详情";
        model.leftFont = [UIFont boldFontTitle];
        model.rightImage = @"rightBlackArrowN";
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    
    {
        ZBaseTextFieldCellModel *model = [[ZBaseTextFieldCellModel alloc] init];
        model.leftTitle = @"课程价格";
        model.placeholder = @"0";
        model.isHiddenLine = NO;
        model.rightTitle = @"元";
        model.cellHeight = CGFloatIn750(116);
        model.textFieldHeight = CGFloatIn750(110);
        model.textColor = [UIColor colorTextGray];
        
        ZCellConfig *nameCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:nameCellConfig];
    }
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"课程相册";
        model.leftFont = [UIFont boldFontTitle];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(92);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
        ZBaseMenuModel *model = [[ZBaseMenuModel alloc] init];
        
        NSMutableArray *menulist = @[].mutableCopy;
        for (int j = 0; j < 9; j++) {
            ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
//            model.name = tempArr[j][0];
//            model.imageName = tempArr[j][1];
//            model.uid = tempArr[j][2];
            [menulist addObject:model];
        }
        
        model.units = menulist;
        
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonAddPhotosCell className] title:[ZOrganizationLessonAddPhotosCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationLessonAddPhotosCell z_getCellHeight:menulist] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:progressCellConfig];
    }
    
    {
        NSArray *textArr = @[@[@"适用校区", @"请选择适用校区", @NO, @"rightBlackArrowN", @"", @"school"],
                             @[@"课程级别", @"请选择课程级别", @NO, @"rightBlackArrowN", @"", @"class"],
                             @[@"单节课时", @"请输入单节课时", @YES, @"", @"小时", @"time"],
                             @[@"课程节数", @"请输入课程节数", @YES, @"", @"节", @"num"],
                             @[@"班级人数", @"请输入班级人数", @YES, @"", @"人", @"peoples"]];
        
        for (int i = 0; i < textArr.count; i++) {
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            cellModel.isTextEnabled = [textArr[i][2] boolValue];
            cellModel.rightImage = textArr[i][3];
            cellModel.rightTitle = textArr[i][4];
            cellModel.cellTitle = textArr[i][5];
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(116);
            cellModel.textColor = [UIColor colorTextGray];
            
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }
    }
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(21) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [_cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"是否接受预约体验";
        model.leftFont = [UIFont boldFontTitle];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(74);
        model.rightImage = @"studentSelect";
        model.rightMargin = CGFloatIn750(50);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
        {
            NSArray *textArr = @[@[@"体验课价格", @"0", @YES, @"", @"元", @"tiMoney"],
                                 @[@"单次体验时长 ", @"0", @YES, @"", @"分钟", @"min"],
                                 @[@"可体验时间段", @"", @NO, @"rightBlackArrowN", @"", @"timeToTime"]];
            
            for (int i = 0; i < textArr.count; i++) {
                ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
                cellModel.leftTitle = textArr[i][0];
                cellModel.placeholder = textArr[i][1];
                cellModel.isTextEnabled = [textArr[i][2] boolValue];
                cellModel.rightImage = textArr[i][3];
                cellModel.rightTitle = textArr[i][4];
                cellModel.cellTitle = textArr[i][5];
                cellModel.isHiddenLine = YES;
                cellModel.cellHeight = CGFloatIn750(74);
                cellModel.textColor = [UIColor colorTextGray];
                cellModel.leftFont = [UIFont fontContent];
                
                ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
                [self.cellConfigArr addObject:textCellConfig];
            }
            
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.isHiddenLine = NO;
            model.cellHeight = CGFloatIn750(30);
            model.lineLeftMargin = CGFloatIn750(30);
            model.lineRightMargin = CGFloatIn750(30);
            
            ZCellConfig *spaceLineCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:spaceLineCellConfig];
        }
    }
    {
        ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
        cellModel.leftTitle = @"课程有效期";
        cellModel.placeholder = @"请输入课程有效期";
        cellModel.isTextEnabled = YES;
        cellModel.rightTitle = @"月";
        cellModel.cellTitle = @"validityTime";
        cellModel.isHiddenLine = YES;
        cellModel.cellHeight = CGFloatIn750(116);
        cellModel.textColor = [UIColor colorTextGray];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [self.cellConfigArr addObject:textCellConfig];
    }
    
    {
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonTypeCell className] title:@"type" showInfoMethod:nil heightOfCell:[ZOrganizationLessonTypeCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
        cellModel.leftTitle = @"选择时间";
        cellModel.isTextEnabled = NO;
        cellModel.leftFont = [UIFont fontContent];
        cellModel.cellTitle = @"lessonTime";
        cellModel.rightImage = @"rightBlackArrowN";
        cellModel.isHiddenLine = YES;
        cellModel.cellHeight = CGFloatIn750(50);
        cellModel.textColor = [UIColor colorTextGray];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [self.cellConfigArr addObject:textCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.isHiddenLine = NO;
        model.cellHeight = CGFloatIn750(30);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        
        ZCellConfig *spaceLineCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:spaceLineCellConfig];
    }
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"购买须知";
        model.leftFont = [UIFont boldFontTitle];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(119);
        model.rightImage = @"rightBlackArrowN";
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"新增课程"];
}

- (void)setupMainView {
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(170))];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(20));
    }];
    
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
    self.iTableView.tableFooterView = bottomView;
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
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
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
    return _iTableView;
}


- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
//        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"提交审核" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldFontTitle]];
        [_bottomBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{

        }];
    }
    return _bottomBtn;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"school"]) {
        NSMutableArray *items = @[].mutableCopy;
        NSArray *temp = @[@"舞蹈",@"球类",@"教育",@"书法"];
        for (int i = 0; i < temp.count; i++) {
            ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
            model.name = temp[i];
            
            NSMutableArray *subItems = @[].mutableCopy;
            
            NSArray *temp = @[@"篮球",@"排球",@"乒乓球",@"足球"];
            for (int i = 0; i < temp.count; i++) {
                ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
                model.name = temp[i];
                [subItems addObject:model];
            }
            model.ItemArr = subItems;
            [items addObject:model];
        }
        
        [self.items removeAllObjects];
        [self.items addObjectsFromArray:items];
        [ZAlertDataPickerView setAlertName:@"校区选择" items:self.items handlerBlock:^(NSInteger index) {
            
        }];
    }else if ([cellConfig.title isEqualToString:@"class"]) {
        NSMutableArray *items = @[].mutableCopy;
        NSArray *temp = @[@"初级",@"中级",@"高级"];
        for (int i = 0; i < temp.count; i++) {
           ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
           model.name = temp[i];
           [items addObject:model];
        }

        [self.items removeAllObjects];
        [self.items addObjectsFromArray:items];
        [ZAlertDataSinglePickerView setAlertName:@"级别选择" items:self.items handlerBlock:^(NSInteger index) {
           
        }];
    } else if ([cellConfig.title isEqualToString:@"timeToTime"]) {
        [ZAlertDateHourPickerView setAlertName:@"选择时间段" handlerBlock:^(NSInteger index) {
            
        }];
    } else if ([cellConfig.title isEqualToString:@"lessonTime"]) {
        [ZAlertDateWeekAndHourPickerView setAlertName:@"选择时间段" handlerBlock:^(NSInteger index) {
            
        }];
    }
    
    
}

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
@end



