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
#import "ZMultiseriateContentLeftLineCell.h"

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
                         @[@"身份证号码",SafeStr(self.addModel.id_card)],
                         @[@"所属校区",SafeStr(self.addModel.stores_name)],
                         @[@"报名日期",[SafeStr(self.addModel.sign_up_at) timeStringWithFormatter:@"yyyy-MM-dd"]],
                         @[@"报名课程",SafeStr(self.addModel.courses_name)],
                         @[@"分配教师",SafeStr(self.addModel.teacher_name)],
                         @[@"紧急联系人姓名",SafeStr(self.addModel.emergency_name)],
                         @[@"紧急联系人电话",SafeStr(self.addModel.emergency_phone)],
                         @[@"紧急联系人关系",SafeStr(self.addModel.emergency_contact)]].mutableCopy;
    
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
        @[@"开课日期", [SafeStr(self.addModel.start_time) timeStringWithFormatter:@"yyyy-MM-dd"]],
        @[@"班级名称", SafeStr(self.addModel.courses_class_name)],
        
        @[@"报名须知", @""]].mutableCopy;
        
        if ([self.addModel.status  intValue] == 3 || [self.addModel.status  intValue] == 3 || [self.addModel.status  intValue] == 4 || [self.addModel.status intValue] == 5) {
            [temp insertObject:@[@"签到详情", @"查看"] atIndex:4];
        }
        [textArr addObjectsFromArray:temp];
    }
    for (int i = 0; i < textArr.count; i++) {
        
       ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
        cellModel.leftTitle = textArr[i][0];
        cellModel.isTextEnabled = NO;
        cellModel.isHiddenLine = YES;
        if ([textArr[i][0] isEqualToString:@"报名须知"]) {
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
            cellModel.cellHeight = CGFloatIn750(48);
        }else{
            cellModel.cellHeight = CGFloatIn750(108);
        }
        
        if ([textArr[i][0] isEqualToString:@"签到详情"]) {
            cellModel.cellTitle = @"sign";
            cellModel.rightImage = @"rightBlackArrowN";
        }
        
        cellModel.content = textArr[i][1];
        cellModel.textColor = [UIColor colorTextGray];
        cellModel.textDarkColor = [UIColor colorTextGrayDark];
        cellModel.leftContentWidth = CGFloatIn750(324);
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [self.cellConfigArr addObject:textCellConfig];
        
        if ([self.addModel.status  intValue] == 3 || [self.addModel.status  intValue] == 3 || [self.addModel.status  intValue] == 4) {
            if(i == 11){
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
        }
        
        if ([textArr[i][0] isEqualToString:@"报名须知"]) {
            ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
            model.rightTitle = self.addModel.p_information;
            model.isHiddenLine = YES;
            model.cellWidth = KScreenWidth ;
            model.singleCellHeight = CGFloatIn750(86);
            model.cellHeight = CGFloatIn750(88);
            model.lineSpace = CGFloatIn750(10);
            model.rightFont = [UIFont fontContent];
            model.rightColor = [UIColor colorTextGray];
            model.rightDarkColor =  [UIColor colorTextGrayDark];
            
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
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
            model.leftFont = [UIFont boldFontTitle];
            model.isHiddenLine = YES;
            model.cellHeight = CGFloatIn750(52);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
          
            
            ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
            mModel.rightFont = [UIFont fontContent];
            mModel.rightColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
            mModel.singleCellHeight = CGFloatIn750(50);
            mModel.rightTitle = self.addModel.specialty_desc;
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:mModel.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
            [self.cellConfigArr addObject:textCellConfig];
            
            [self.cellConfigArr addObject:getEmptyCellWithHeight(40)];
        }
            
        if (ValidArray(self.addModel.images_list)) {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = @"学员相册";
            model.leftFont = [UIFont boldFontTitle];
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
        self.iTableView.tableFooterView = self.bottomView;
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"学员详情"];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn]];
}

- (void)setupMainView {
    [super setupMainView];
    
    self.iTableView.tableFooterView = self.bottomView;
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
         [_navRightBtn bk_whenTapped:^{
             ZOrganizationStudentAddVC *avc = [[ZOrganizationStudentAddVC alloc] init];
             avc.viewModel.addModel = weakSelf.addModel;
             avc.isEdit = YES;
             [weakSelf.navigationController pushViewController:avc animated:YES];
         }];
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
        [_bottomBtn bk_whenTapped:^{
            ZOrganizationStudentUpStarVC *uvc = [[ZOrganizationStudentUpStarVC alloc] init];
            uvc.addModel = weakSelf.addModel;
            [weakSelf.navigationController pushViewController:uvc animated:YES];
        }];
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
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"sign"]) {
        ZStudentMineSignDetailVC *dvc = [[ZStudentMineSignDetailVC alloc] init];
        dvc.student_id = self.addModel.studentID;
        dvc.courses_class_id = self.addModel.courses_class_id;
        dvc.type = 2;
        
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
