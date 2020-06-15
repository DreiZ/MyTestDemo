//
//  ZOrganizationStudentDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationStudentDetailVC.h"
#import "ZOriganizationTeachAddHeadImageCell.h"
#import "ZOrganizationLessonAddPhotosCell.h"
#import "ZOriganizationTeachHeadImageCell.h"

#import "ZStudentMineSignDetailVC.h"
#import "ZOrganizationStudentUpStarVC.h"
#import "ZOrganizationStudentAddVC.h"

@interface ZOrganizationStudentDetailVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIButton *navRightBtn;
@property (nonatomic,strong) UIView *bottomView;

@end

@implementation ZOrganizationStudentDetailVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTeachHeadImageCell className] title:[ZOriganizationTeachHeadImageCell className] showInfoMethod:@selector(setImage:) heightOfCell:[ZOriganizationTeachHeadImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:imageFullUrl(self.addModel.image)];
    [self.cellConfigArr addObject:progressCellConfig];
    
    NSMutableArray *textArr = @[@[@"真实姓名",SafeStr(self.addModel.name)],
                         @[@"手机号",SafeStr(self.addModel.phone)],
                         @[@"性别",[SafeStr(self.addModel.sex) intValue] == 1 ? @"男":@"女"],
                         @[@"出生日期",[SafeStr(self.addModel.birthday) timeStringWithFormatter:@"yyyy-MM-dd"]],
                         @[@"所属校区",SafeStr(self.addModel.stores_name)],
                         @[@"报名日期",[SafeStr(self.addModel.sign_up_at) timeStringWithFormatter:@"yyyy-MM-dd"]],
                         @[@"报名课程",SafeStr(self.addModel.courses_name)],
                         @[@"分配教师",SafeStr(self.addModel.teacher_name)]].mutableCopy;
    
    if (ValidStr(self.addModel.courses_class_id)) {
        NSString *statusStr = @"";
        switch ([self.addModel.status intValue]) {
            case 1:
                statusStr = @"待排课";
                break;
            case 2:
                statusStr = @"待开课";
                break;
            case 3:
                statusStr = @"已开课";
                break;
            case 4:
                statusStr = @"已结课";
                if ([self.addModel.end_class_type intValue] == 1) {
                    statusStr = @"已结课(已退款)";
                }
                break;
            case 5:
                statusStr = @"待补课";
                break;
            case 6:
                statusStr = @"已过期";
                break;
                
            default:
                break;
        }
        NSMutableArray *temp = @[@[@"课程进度", [NSString stringWithFormat:@"%@/%@节",SafeStr(self.addModel.now_progress),SafeStr(self.addModel.total_progress)]],
                          @[@"优惠明细", ValidStr(self.addModel.coupons_name) ?  SafeStr(self.addModel.coupons_name):@"未使用优惠券"],
        @[@"学员状态", statusStr],
                                 @[@"开课日期", [SafeStr(self.addModel.start_time) isEqualToString:@"0"]?@"": [SafeStr(self.addModel.start_time) timeStringWithFormatter:@"yyyy-MM-dd"]],
        @[@"班级名称", SafeStr(self.addModel.courses_class_name)],
        @[@"报名须知", @""]].mutableCopy;
        if ([[ZUserHelper sharedHelper].user.type intValue] != 2 && ValidStr(self.addModel.courses_class_id) && [self.addModel.courses_class_id intValue] != 0) {
            if ([self.addModel.status  intValue] == 3 || [self.addModel.status  intValue] == 3 || [self.addModel.status  intValue] == 4 || [self.addModel.status intValue] == 5) {
                [temp insertObject:@[@"签到详情", @"查看"] atIndex:4];
            }
        }
        [textArr addObjectsFromArray:temp];
    }
    
    for (int i = 0; i < textArr.count; i++) {
        if ([textArr[i][0] isEqualToString:@"开课日期"] && [textArr[i][1] length] == 0) {
            continue;
        }
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title")
        .zz_titleLeft(textArr[i][0])
        .zz_rightMultiLine(YES)
        .zz_cellHeight(CGFloatIn750(86))
        .zz_lineHidden(YES);
        model.zz_titleRight(textArr[i][1]);
        if ([textArr[i][0] isEqualToString:@"报名须知"]) {
            model.zz_fontLeft([UIFont boldFontContent]);
        }else{
            model.zz_fontLeft([UIFont fontContent]);
        }
        if ([textArr[i][0] isEqualToString:@"签到详情"]) {
            model.cellTitle = @"sign";
            model.rightImage = @"rightBlackArrowN";
        }
 
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:textCellConfig];
        
        if ([self.addModel.status  intValue] == 3 || [self.addModel.status  intValue] == 3 || [self.addModel.status  intValue] == 4) {
            if([textArr[i][0] isEqualToString:@"分配教师"]){
                [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(10))];
                  
                ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
                model.isHiddenLine = NO;
                model.lineLeftMargin = CGFloatIn750(30);
                model.lineRightMargin = CGFloatIn750(30);
                model.cellHeight = CGFloatIn750(2);
                  
              ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
              [self.cellConfigArr addObject:menuCellConfig];
              [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(10))];
            }
        }
        
        if ([textArr[i][0] isEqualToString:@"报名须知"]) {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"p_information")
            .zz_titleLeft(self.addModel.p_information)
            .zz_leftMultiLine(YES)
            .zz_cellHeight(CGFloatIn750(88))
            .zz_lineHidden(YES);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr  addObject:menuCellConfig];
        }
    }
    
    {
         [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
           
         ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
         model.isHiddenLine = NO;
         model.lineLeftMargin = CGFloatIn750(30);
         model.lineRightMargin = CGFloatIn750(30);
         model.cellHeight = CGFloatIn750(1);
           
       ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
       [self.cellConfigArr addObject:menuCellConfig];
         
       [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
    }
    
    if ([self.addModel.is_star intValue] == 1) {
        {
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = @"学员介绍";
            model.leftFont = [UIFont boldFontContent];
            model.isHiddenLine = YES;
            model.cellHeight = CGFloatIn750(52);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
          
            
            ZLineCellModel *mModel = ZLineCellModel.zz_lineCellModel_create(@"specialty_desc")
            .zz_titleLeft(self.addModel.specialty_desc)
            .zz_leftMultiLine(YES)
            .zz_cellHeight(CGFloatIn750(50))
            .zz_lineHidden(YES)
            .zz_colorDarkLeft([UIColor colorTextGrayDark])
            .zz_colorLeft([UIColor colorTextGray]);
            
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:mModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
            [self.cellConfigArr addObject:textCellConfig];
            
            [self.cellConfigArr addObject:getEmptyCellWithHeight(40)];
        }
            
        if (ValidArray(self.addModel.images_list)) {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = @"学员相册";
            model.leftFont = [UIFont boldFontContent];
            model.isHiddenLine = YES;
            model.cellHeight = CGFloatIn750(92);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }
        
        if (ValidArray(self.addModel.images_list)) {
            ZBaseMenuModel *model = [[ZBaseMenuModel alloc] init];
            
            NSMutableArray *menulist = @[].mutableCopy;
            
            for (int j = 0; j < self.addModel.images_list.count; j++) {
                ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
                model.isEdit = NO;
                model.data = self.addModel.images_list[j];
                [menulist addObject:model];
            }
            
            model.units = menulist;
            
            ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonAddPhotosCell className] title:[ZOrganizationLessonAddPhotosCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationLessonAddPhotosCell z_getCellHeight:menulist] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:progressCellConfig];
        }
    }
    if ([self.addModel.is_star intValue] == 1) {
        self.iTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(80))];
    }else{
        if ([[ZUserHelper sharedHelper].user.type intValue] != 6) {
            self.iTableView.tableFooterView = self.bottomView;
        }
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"学员详情"];
    
    if ([[ZUserHelper sharedHelper].user.type intValue] != 2) {
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn]];
    }
}

- (void)setupMainView {
    [super setupMainView];
    if ([[ZUserHelper sharedHelper].user.type intValue] != 2) {
        self.iTableView.tableFooterView = self.bottomView;
    }
}


#pragma mark - lazy loading...
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(140)+ safeAreaBottom())];
        _bottomView.layer.masksToBounds = YES;
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        [_bottomView addSubview:self.bottomBtn];
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(60));
            make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-60));
            make.height.mas_equalTo(CGFloatIn750(80));
            make.top.equalTo(self.bottomView.mas_top).offset(CGFloatIn750(20));
        }];
    }
    return _bottomView;
}


- (UIButton *)navRightBtn {
     if (!_navRightBtn) {
         __weak typeof(self) weakSelf = self;
         _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
         [_navRightBtn setTitle:@"编辑" forState:UIControlStateNormal];
         [_navRightBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
         [_navRightBtn.titleLabel setFont:[UIFont fontContent]];
         [_navRightBtn bk_addEventHandler:^(id sender) {
             ZOrganizationStudentAddVC *avc = [[ZOrganizationStudentAddVC alloc] init];
             avc.viewModel.addModel = weakSelf.addModel;
             avc.isEdit = YES;
             [weakSelf.navigationController pushViewController:avc animated:YES];
         } forControlEvents:UIControlEventTouchUpInside];
     }
     return _navRightBtn;
}
  
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"升级明星学员" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
            ZOrganizationStudentUpStarVC *uvc = [[ZOrganizationStudentUpStarVC alloc] init];
            uvc.addModel = weakSelf.addModel;
            [weakSelf.navigationController pushViewController:uvc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

- (ZOriganizationStudentAddModel *)addModel {
    if (!_addModel) {
        _addModel = [[ZOriganizationStudentAddModel alloc] init];
    }
    return _addModel;
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:[ZOriganizationTeachHeadImageCell className]]) {
        ZOriganizationTeachHeadImageCell *lcell = (ZOriganizationTeachHeadImageCell *)cell;
        __weak typeof(self) weakSelf = self;
        lcell.isTeacher = NO;
        lcell.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                if (ValidClass(weakSelf.addModel.image, [UIImage class]) || ValidStr(weakSelf.addModel.image)) {
                    [[ZPhotoManager sharedManager] showBrowser:@[weakSelf.addModel.image] withIndex:0];
                }
            }else{
                
            }
        };
    }
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"sign"]) {
        ZStudentMineSignDetailVC *dvc = [[ZStudentMineSignDetailVC alloc] init];
        dvc.student_id = self.addModel.studentID;
        dvc.courses_class_id = self.addModel.courses_class_id;
        [self.navigationController pushViewController:dvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"address"]){
       
    }
}

- (void)refreshData {
    __weak typeof(self) weakSelf = self;
    self.loading = YES;
    [ZOriganizationStudentViewModel getStudentDetail:@{@"id":SafeStr(self.addModel.studentID)} completeBlock:^(BOOL isSuccess, ZOriganizationStudentAddModel *addModel) {
        if (isSuccess) {
            weakSelf.addModel = addModel;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}
@end
