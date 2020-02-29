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

#import "ZStudentDetailModel.h"

#import "ZAlertDataPickerView.h"
#import "ZAlertDateHourPickerView.h"
#import "ZAlertDataSinglePickerView.h"
#import "ZAlertDateWeekAndHourPickerView.h"
#import "ZAlertDataModel.h"
#import "ZOrganizationTimeSelectVC.h"

#import "ZOriganizationLessonViewModel.h"

@interface ZOrganizationLessonAddVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) ZOriganizationLessonViewModel *viewModel;

@property (nonatomic,strong) NSMutableArray <ZAlertDataItemModel*> *items;
@end

@implementation ZOrganizationLessonAddVC

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)setDataSource {
    [super setDataSource];
    _items = @[].mutableCopy;
    _viewModel = [[ZOriganizationLessonViewModel alloc] init];
    _viewModel.addModel = [[ZOriganizationLessonAddModel alloc] init];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *addImageCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonAddImageCell className] title:[ZOrganizationLessonAddImageCell className] showInfoMethod:nil heightOfCell:[ZOrganizationLessonAddImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:addImageCellConfig];
    
    NSArray *titleArr = @[@[@"请输入课程名称", @"lessonName",self.viewModel.addModel.lessonName,@8],@[@"请输入课程简介",@"lessonIntro",self.viewModel.addModel.lessonIntro,@6]];
    
    for (int i = 0 ; i < titleArr.count; i++) {
        ZBaseTextFieldCellModel *model = [[ZBaseTextFieldCellModel alloc] init];
        model.placeholder = titleArr[i][0];
        model.content = titleArr[i][2];
        model.cellTitle = titleArr[i][1];
        model.max = [titleArr[i][3] intValue];
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
        model.cellTitle = @"lessonPrice";
        model.content = self.viewModel.addModel.lessonPrice;
        model.placeholder = @"0";
        model.isHiddenLine = NO;
        model.rightTitle = @"元";
        model.formatterType = ZFormatterTypeDecimal;
        model.max = 6;
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
        NSArray *textArr = @[@[@"适用校区", @"请选择适用校区", @NO, @"rightBlackArrowN", @"", @"school",self.viewModel.addModel.school],
                             @[@"课程级别", @"请选择课程级别", @NO, @"rightBlackArrowN", @"", @"class",self.viewModel.addModel.level],
                             @[@"单节课时", @"请输入单节课时", @YES, @"", @"小时", @"time",self.viewModel.addModel.singleTime],
                             @[@"课程节数", @"请输入课程节数", @YES, @"", @"节", @"num",self.viewModel.addModel.lessonNum],
                             @[@"班级人数", @"请输入班级人数", @YES, @"", @"人", @"peoples",self.viewModel.addModel.lessonPeoples]];
        
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
            cellModel.content = textArr[i][6];
            
            if ([cellModel.cellTitle isEqualToString:@"num"]) {
                cellModel.formatterType = ZFormatterTypeDecimal;
                cellModel.max = 2;
            }else if ([cellModel.cellTitle isEqualToString:@"peoples"]){
                cellModel.formatterType = ZFormatterTypeNumber;
                cellModel.max = 3;
            }
            
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }
    }
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(21) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"是否接受预约体验";
        model.leftFont = [UIFont boldFontTitle];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(74);
        model.rightImage = @"selectedCycle";//unSelectedCycle
        model.rightMargin = CGFloatIn750(50);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
        {
            NSArray *textArr = @[@[@"体验课价格", @"0", @YES, @"", @"元", @"tiMoney",self.viewModel.addModel.orderPrice],
                                 @[@"单次体验时长 ", @"0", @YES, @"", @"分钟", @"min",self.viewModel.addModel.orderMin],
                                 @[@"可体验时间段", @"", @NO, @"rightBlackArrowN", @"", @"timeToTime",[NSString stringWithFormat:@"%@~%@",self.viewModel.addModel.orderTimeBegin,self.viewModel.addModel.orderTimeBegin]]];
            
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
    [self.navigationItem setTitle:@"新增课程"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
    [self.navigationItem setRightBarButtonItem:item];
}

- (void)setupMainView {
    [super setupMainView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(180))];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(30));
    }];
    
    self.iTableView.tableFooterView = bottomView;
}

#pragma mark - lazy loading...
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
//        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(106), CGFloatIn750(48))];
        [_navLeftBtn setTitle:@"预览" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontContent]];
        [_navLeftBtn bk_whenTapped:^{
            
        }];
    }
    return _navLeftBtn;
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
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"lessonName"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.lessonName = text;
        };
    }else if ([cellConfig.title isEqualToString:@"lessonIntro"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.lessonIntro = text;
        };
    }else if ([cellConfig.title isEqualToString:@"lessonPrice"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.orderPrice = text;
        };
    }else if ([cellConfig.title isEqualToString:@"time"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.singleTime = text;
        };
    }else if ([cellConfig.title isEqualToString:@"num"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.lessonNum = text;
        };
    }else if ([cellConfig.title isEqualToString:@"lessonPrice"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.orderPrice = text;
        };
    }else if ([cellConfig.title isEqualToString:@"lessonPrice"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.orderPrice = text;
        };
    }else if ([cellConfig.title isEqualToString:@"lessonPrice"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.orderPrice = text;
        };
    }else if ([cellConfig.title isEqualToString:@"lessonPrice"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.orderPrice = text;
        };
    }
    
    
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
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
        [[ZDatePickerManager sharedManager] showDatePickerWithTitle:@"出生日期" type:PGDatePickerModeDate viewController:self handle:^(NSDateComponents * date) {
            
        }];
    } else if ([cellConfig.title isEqualToString:@"lessonTime"]) {
        [ZAlertDateWeekAndHourPickerView setAlertName:@"选择时间段" handlerBlock:^(NSInteger index) {
            
        }];
//        ZOrganizationTimeSelectVC *svc = [[ZOrganizationTimeSelectVC alloc] init];
//        [self.navigationController pushViewController:svc animated:YES];
    }
}
@end
