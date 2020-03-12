//
//  ZOrganizationLessonDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonDetailVC.h"
#import "ZOrganizationLessonDetailHeaderCell.h"
#import "ZOrganizationLessonDetailPriceCell.h"
#import "ZTextFieldMultColCell.h"
#import "ZBaseUnitModel.h"

@interface ZOrganizationLessonDetailVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIView *topNavView;

@end

@implementation ZOrganizationLessonDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
    [self refreshData];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.topNavView];
    [self.topNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kTopHeight);
    }];
    
    [self.view addSubview:self.navLeftBtn];
    [self.navLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(50));
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.bottom.equalTo(self.topNavView.mas_bottom).offset(-CGFloatIn750(17));
    }];
}

- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(50), CGFloatIn750(50))];
        [_navLeftBtn setBackgroundColor:[UIColor colorGrayBG] forState:UIControlStateNormal];
        [_navLeftBtn setImage:[UIImage imageNamed:@"navleftBack"] forState:UIControlStateNormal];
        ViewRadius(_navLeftBtn, CGFloatIn750(25));
        [_navLeftBtn bk_whenTapped:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _navLeftBtn;
}

- (UIView *)topNavView {
    if (!_topNavView) {
        _topNavView = [[UIView alloc] init];
        _topNavView.backgroundColor = [UIColor colorMain];
        _topNavView.alpha = 0;
    }
    return _topNavView;
}

- (ZOriganizationLessonAddModel *)addModel {
    if (!_addModel) {
        _addModel = [[ZOriganizationLessonAddModel alloc] init];
    }
    return _addModel;
}

#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
   
    if (Offset_y > CGFloatIn750(420)) {
        self.topNavView.alpha = (Offset_y - CGFloatIn750(420))/CGFloatIn750(50);
    }else {
        self.topNavView.alpha = 0;
    }
}


#pragma mark - setDetailData
- (void)setLessonName {
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = self.addModel.short_name;
    model.rightTitle = self.addModel.school;
    model.isHiddenLine = YES;
    model.leftFont = [UIFont boldFontMax1Title];
    model.rightFont = [UIFont fontContent];
    model.cellHeight = CGFloatIn750(46);
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    
    [self.cellConfigArr addObject:menuCellConfig];
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.isHiddenLine = NO;
        model.cellHeight = CGFloatIn750(34);
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
}

- (void)setIntro {
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = self.addModel.short_name;
    model.leftFont = [UIFont fontContent];
    model.lineLeftMargin = CGFloatIn750(30);
    model.lineRightMargin = CGFloatIn750(30);
    model.isHiddenLine = NO;
    model.cellHeight = CGFloatIn750(114);
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    
    [self.cellConfigArr addObject:menuCellConfig];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    [self setImagesAndPrice];
    [self setLessonName];
    [self setIntro];
    
    
    
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"单节课时";
        model.leftFont = [UIFont boldFontContent];
        model.cellHeight = CGFloatIn750(50);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZBaseSingleCellModel *model1 = [[ZBaseSingleCellModel alloc] init];
        model1.leftTitle = [NSString stringWithFormat:@"%@分钟/节",self.addModel.course_min];
        model1.leftFont = [UIFont fontContent];
        model1.cellHeight = CGFloatIn750(42);
        model1.isHiddenLine = YES;
        
        ZCellConfig *menu1CellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model1.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model1] cellType:ZCellTypeClass dataModel:model1];
        [self.cellConfigArr addObject:menu1CellConfig];
        
        {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.lineLeftMargin = CGFloatIn750(30);
            model.lineRightMargin = CGFloatIn750(30);
            model.isHiddenLine = NO;
            model.cellHeight = CGFloatIn750(30);
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
    
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"课程节数";
        model.leftFont = [UIFont boldFontContent];
        model.cellHeight = CGFloatIn750(50);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZBaseSingleCellModel *model1 = [[ZBaseSingleCellModel alloc] init];
        model1.leftTitle = [NSString stringWithFormat:@"%@节",self.addModel.course_number];
        model1.leftFont = [UIFont fontContent];
        model1.cellHeight = CGFloatIn750(42);
        model1.isHiddenLine = YES;
        
        ZCellConfig *menu1CellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model1.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model1] cellType:ZCellTypeClass dataModel:model1];
        [self.cellConfigArr addObject:menu1CellConfig];
        
        {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.lineLeftMargin = CGFloatIn750(30);
            model.lineRightMargin = CGFloatIn750(30);
            model.isHiddenLine = NO;
            model.cellHeight = CGFloatIn750(30);
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
    
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.cellHeight = CGFloatIn750(2);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.isHiddenLine = NO;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
        {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.cellHeight = CGFloatIn750(24);
            model.isHiddenLine = YES;
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.cellHeight = CGFloatIn750(64);
        model.isHiddenLine = YES;
        model.leftTitle = @"课程详情";
        model.leftFont = [UIFont boldFontContent];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.singleCellHeight = CGFloatIn750(80);
        model.isHiddenLine = YES;
        model.rightTitle = @"购买须知阿搜嘎施工泡泡机构怕监管局奥普生物工具欧派搜苹果申达股份是的噶啥公司的公司颇高和平时估计散热片结构颇尔搜谱机构评价二批溶解股票而打工我活动费IG后IE让你嗨";
        model.leftFont = [UIFont fontContent];
        model.isHiddenLine = NO;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
        if (self.addModel.is_experience) {
            {
                ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
                model.cellHeight = CGFloatIn750(30);
                model.isHiddenLine = YES;
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [self.cellConfigArr addObject:menuCellConfig];
            }
            
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.cellHeight = CGFloatIn750(48);
            model.isHiddenLine = YES;
            model.leftTitle = @"接受课程预约";
            model.leftFont = [UIFont boldFontContent];
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
            
            NSArray *titleArr = @[[NSString stringWithFormat:@"体验课价格：￥%@",self.addModel.orderPrice],[NSString stringWithFormat:@"单节体验时长：%@分钟",self.addModel.orderMin],[NSString stringWithFormat:@"可体验时间段：%@-%@",self.addModel.orderTimeBegin,self.addModel.orderTimeEnd]];
            for (int i = 0; i < titleArr.count; i++) {
                ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
                model.cellHeight = CGFloatIn750(54);
                model.isHiddenLine = YES;
                model.leftTitle = @"购买须知";
                model.leftFont = [UIFont fontSmall];
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [self.cellConfigArr addObject:menuCellConfig];
            }
            
            {
                ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
                model.cellHeight = CGFloatIn750(30);
                model.lineLeftMargin = CGFloatIn750(30);
                model.lineRightMargin = CGFloatIn750(30);
                model.isHiddenLine = NO;
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [self.cellConfigArr addObject:menuCellConfig];
            }
        }
    }
    
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"课程有效期";
        model.leftFont = [UIFont boldFontContent];
        model.cellHeight = CGFloatIn750(50);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZBaseSingleCellModel *model1 = [[ZBaseSingleCellModel alloc] init];
        model1.leftTitle = [NSString stringWithFormat:@"%@月",self.addModel.valid_at];
        model1.leftFont = [UIFont fontContent];
        model1.cellHeight = CGFloatIn750(42);
        model1.isHiddenLine = YES;
        
        ZCellConfig *menu1CellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model1.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model1] cellType:ZCellTypeClass dataModel:model1];
        [self.cellConfigArr addObject:menu1CellConfig];
        
        {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.lineLeftMargin = CGFloatIn750(30);
            model.lineRightMargin = CGFloatIn750(30);
            model.isHiddenLine = NO;
            model.cellHeight = CGFloatIn750(30);
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = self.addModel.type.length > 0 ? @"固定开课时间":@"人满开课";
        model.leftFont = [UIFont boldFontContent];
        model.cellHeight = CGFloatIn750(114);
        model.isHiddenLine = NO;
        model.lineRightMargin = CGFloatIn750(30);
        model.lineLeftMargin = CGFloatIn750(30);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"固定开课时间";
        model.leftFont = [UIFont boldFontContent];
        model.cellHeight = CGFloatIn750(54);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
    }
    {
           NSMutableArray *tempArr = @[].mutableCopy;
           for (int i = 0; i < self.addModel.fix_time.count; i++) {
               ZBaseMenuModel *menuModel = self.addModel.fix_time[i];
               
               if (menuModel && menuModel.units && menuModel.units.count > 0) {
                   NSMutableArray *tempSubArr = @[].mutableCopy;
                   [tempSubArr addObject:menuModel.name];
                   NSString *subTitle = @"";
                   for (int k = 0; k < menuModel.units.count; k++) {
                       ZBaseUnitModel *unitModel = menuModel.units[k];
                       if (subTitle.length == 0) {
                           subTitle = [NSString stringWithFormat:@"%@~%@",[self getStartTime:unitModel],[self getEndTime:unitModel]];
                       }else{
                           subTitle = [NSString stringWithFormat:@"%@   %@~%@",subTitle,[self getStartTime:unitModel],[self getEndTime:unitModel]];
                       }
                   }
                   [tempSubArr addObject:subTitle];
                   
                   [tempArr addObject:tempSubArr];
               }
           }
           
//           for (int j = 0; j < tempArr.count; j++) {
//               ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
//               mModel.cellWidth = KScreenWidth - cellModel.leftContentWidth - cellModel.leftMargin - cellModel.rightMargin - cellModel.contentSpace * 2;
//               mModel.rightFont = [UIFont fontSmall];
//               mModel.leftFont = [UIFont fontSmall];
//               mModel.rightColor = [UIColor colorTextGray];
//               mModel.leftColor = [UIColor colorTextGray];
//               mModel.rightDarkColor = [UIColor colorTextGrayDark];
//               mModel.leftDarkColor = [UIColor colorTextGrayDark];
//               mModel.singleCellHeight = CGFloatIn750(44);
//               mModel.rightTitle = tempArr[j][1];
//               mModel.leftTitle = tempArr[j][0];
//               mModel.leftContentSpace = CGFloatIn750(4);
//               mModel.rightContentSpace = CGFloatIn750(16);
//               mModel.leftMargin = CGFloatIn750(2);
//               mModel.rightMargin = CGFloatIn750(2);
//               mModel.isHiddenLine = YES;
//               mModel.textAlignment = NSTextAlignmentLeft;
//               
//               [multArr addObject:mModel];
//           }
           
//        NSArray *tempArr = @[@[@"周一 | ", @"12:00~14:00   12:00~14:00   12:00~14:00   12:00~14:00   12:00~14:00"],@[@"周一 | ", @"12:00~14:00   12:00~14:00   12:00~14:00   12:00~14:00   12:00~14:00"]];
        for (int j = 0; j < tempArr.count; j++) {
            ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
            mModel.rightFont = [UIFont fontSmall];
            mModel.leftFont = [UIFont fontSmall];
            mModel.rightColor = [UIColor colorTextGray];
            mModel.leftColor = [UIColor colorTextGray];
            mModel.rightDarkColor = [UIColor colorTextGrayDark];
            mModel.leftDarkColor = [UIColor colorTextGrayDark];
            mModel.singleCellHeight = CGFloatIn750(50);
            mModel.rightTitle = tempArr[j][1];
            mModel.leftTitle = tempArr[j][0];
            mModel.leftContentSpace = CGFloatIn750(4);
            mModel.rightContentSpace = CGFloatIn750(4);
            mModel.leftMargin = CGFloatIn750(30);
            mModel.rightMargin = CGFloatIn750(30);
            mModel.isHiddenLine = YES;
            
            
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateLineCell className] title:mModel.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateLineCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
            [self.cellConfigArr addObject:textCellConfig];
        }
       
        
        
    }
    
    [self.iTableView reloadData];
}

- (NSString *)getStartTime:(ZBaseUnitModel *)model {
    if ([model.subName intValue] < 10) {
        return  [NSString stringWithFormat:@"%@:0%@",model.name,model.subName];
    }else{
        return  [NSString stringWithFormat:@"%@:%@",model.name,model.subName];
    }
}

- (NSString *)getEndTime:(ZBaseUnitModel *)model {
    NSInteger temp = [self.addModel.course_min intValue]/60;
    NSInteger subTemp = [self.addModel.course_min intValue]%60;
    
    NSInteger hourTemp = [model.name intValue] + temp;
    NSInteger minTemp = [model.subName intValue] + subTemp;
    if (minTemp > 59) {
        minTemp -= 60;
        hourTemp++;
    }
    
    if (hourTemp > 24) {
        hourTemp -= 24;
    }
    
    
    ZBaseUnitModel *uModel = [[ZBaseUnitModel alloc] init];
    uModel.name = [NSString stringWithFormat:@"%ld",hourTemp];
    uModel.subName = [NSString stringWithFormat:@"%ld",minTemp];
    
    return [self getStartTime:uModel];
}

- (void)setImagesAndPrice {
    NSMutableArray *images = @[].mutableCopy;
    for (int i = 0; i < self.addModel.images.count; i++) {
        ZStudentBannerModel *model = [[ZStudentBannerModel alloc] init];
        id image = self.addModel.images[i];
        if ([image isKindOfClass:[UIImage class]]) {
            model.data = image;
            [images addObject:model];
        }else{
            NSString *imageStr = image;
            if (imageStr.length > 0) {
                model.data = image;
                [images addObject:model];
            }
        }
    }
    ZCellConfig *statisticsCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonDetailHeaderCell className] title:[ZOrganizationLessonDetailHeaderCell className] showInfoMethod:@selector(setList:) heightOfCell:[ZOrganizationLessonDetailHeaderCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:images];
    [self.cellConfigArr addObject:statisticsCellConfig];
    
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = self.addModel.price;
    model.rightTitle = self.addModel.course_number;
    
    ZCellConfig *priceCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonDetailPriceCell className] title:[ZOrganizationLessonDetailPriceCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationLessonDetailPriceCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:priceCellConfig];
}

- (void)refreshData {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel getLessonDetail:@{@"id":SafeStr(self.addModel.lessonID)} completeBlock:^(BOOL isSuccess, ZOriganizationLessonAddModel *addModel) {
        if (isSuccess) {
            weakSelf.addModel = addModel;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}
@end
