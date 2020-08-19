//
//  ZTeacherClassDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherClassDetailVC.h"
#import "ZTextFieldMultColCell.h"
#import "ZBaseUnitModel.h"

#import "ZOrganizationClassDetailStudentListVC.h"
#import "ZOrganizationClassDetailStudentListAddVC.h"
#import "ZOriganizationClassViewModel.h"

#import "ZOrganizationTrachingScheduleOutlineErweimaVC.h"

#import "ZAlertMoreView.h"

@interface ZTeacherClassDetailVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) ZOriganizationClassDetailModel *model;
@end

@implementation ZTeacherClassDetailVC

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loading = YES;
    [self initCellConfigArr];
}

- (void)setDataSource {
    [super setDataSource];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
//    self.model.status  = @"3";
//     0：全部 1：待开班 2：已开班 3：已结班
    NSString *status = @"";
    switch ([SafeStr(self.model.status) intValue]) {
        case 1:
            status = @"待开班";
            break;
        case 2:
            status = @"已开班";
            break;
        case 3:
            status = @"已结班";
            break;
            
        default:
            break;
    }
    status = [NSString stringWithFormat:@"%@/%@节   %@",ValidStr(self.model.now_progress)? self.model.now_progress:@"0",ValidStr(self.model.now_progress)? self.model.total_progress:@"0", status];
    
    NSArray *textArr = @[@[@"校区名称", @"", @"", @"schoolName",SafeStr(self.model.stores_name)],
                         @[@"班级名称", @"", @"", @"className",SafeStr(self.model.name)],
                         @[@"班级人数", @"", @"", @"",[NSString stringWithFormat:@"%@/%@人",SafeStr(self.model.nums),SafeStr(self.model.limit_nums)]],
                         @[@"班级状态", @"", @"", @"classStutas",status],
                         @[@"课程名称", @"", @"", @"lessonName",SafeStr(self.model.stores_courses_name)],
                         @[@"教师名称", @"", @"", @"techerName",SafeStr(self.model.teacher_name)],
                         @[@"开课日期", @"", @"", @"openTime",[self.model.start_time isEqualToString:@"0"]? @"":SafeStr([self.model.start_time timeStringWithFormatter:@"yyyy-MM-dd"])],
                         @[@"学员列表", @"查看", @"rightBlackArrowN", @"studentList",@"查看"],
                         @[@"班级签到", @"查看", @"rightBlackArrowN", @"detail",@"查看"],
                         @[@"上课时间", @"", @"", @"beginTime",@""]];
    
    for (int i = 0; i < textArr.count; i++) {
        if ([textArr[i][3] isEqualToString:@"detail"]) {
            if ([self.model.now_progress intValue] == 0) {
                continue;
            }
        }
        if ([textArr[i][3] isEqualToString:@"beginTime"]) {
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            cellModel.isTextEnabled = NO;
            cellModel.rightImage = textArr[i][2];
            cellModel.cellTitle = textArr[i][3];
            cellModel.content = textArr[i][4];
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(86);
            cellModel.leftFont = [UIFont fontContent];
            cellModel.rightFont = [UIFont fontContent];
            cellModel.rightColor = [UIColor colorTextGray];
            cellModel.rightDarkColor = [UIColor colorTextGrayDark];
            
            
            NSMutableArray *multArr = @[].mutableCopy;
            NSMutableArray *tempArr = @[].mutableCopy;
            for (int i = 0; i < self.model.classes_dateArr.count; i++) {
                ZBaseMenuModel *menuModel = self.model.classes_dateArr[i];
                
                if (menuModel && menuModel.units && menuModel.units.count > 0) {
                    NSMutableArray *tempSubArr = @[].mutableCopy;
                    [tempSubArr addObject:menuModel.name];
                    NSString *subTitle = @"";
                    for (int k = 0; k < menuModel.units.count; k++) {
                        ZBaseUnitModel *unitModel = menuModel.units[k];
                        if (subTitle.length == 0) {
                            subTitle = [NSString stringWithFormat:@"%@",unitModel.data];
                        }else{
                            subTitle = [NSString stringWithFormat:@"%@   %@",subTitle,unitModel.data];
                        }
                    }
                    [tempSubArr addObject:subTitle];
                    
                    [tempArr addObject:tempSubArr];
                }
            }
            
            for (int j = 0; j < tempArr.count; j++) {
                ZLineCellModel *mModel = ZLineCellModel.zz_lineCellModel_create(@"sub")
                .zz_titleLeft(tempArr[j][0])
                .zz_titleRight(tempArr[j][1])
                .zz_lineHidden(YES)
                .zz_rightMultiLine(YES)
                .zz_alignmentRight(NSTextAlignmentLeft)
                .zz_marginLeft(CGFloatIn750(2))
                .zz_marginRight(CGFloatIn750(2))
                .zz_cellHeight(CGFloatIn750(44))
                .zz_fontLeft([UIFont fontSmall])
                .zz_fontRight([UIFont fontSmall])
                .zz_colorLeft([UIColor colorTextGray])
                .zz_colorDarkLeft([UIColor colorTextGrayDark])
                .zz_colorRight([UIColor colorTextGray])
                .zz_colorDarkRight([UIColor colorTextGrayDark])
                .zz_cellWidth(KScreenWidth - cellModel.leftContentWidth - cellModel.leftMargin - cellModel.rightMargin - cellModel.contentSpace * 2);
                
                [multArr addObject:mModel];
            }
            cellModel.data = multArr;
            
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldMultColCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldMultColCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }else{
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            cellModel.isTextEnabled = NO;
            cellModel.rightImage = textArr[i][2];
            cellModel.cellTitle = textArr[i][3];
            cellModel.content = textArr[i][4];
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(86);
            cellModel.rightFont = [UIFont fontContent];
            cellModel.leftFont = [UIFont fontContent];
            cellModel.rightColor = [UIColor colorTextGray];
            cellModel.rightDarkColor = [UIColor colorTextGrayDark];
            
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }
    }
    if ([self.model.status intValue] == 3) {
        self.bottomView.hidden = YES;
        [self.navigationItem setRightBarButtonItem:nil] ;
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
            make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
            make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
            make.top.equalTo(self.view.mas_top).offset(-CGFloatIn750(0));
        }];
    }else{
//        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn]] ;
        self.bottomView.hidden = NO;
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(182));
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
            make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
            make.bottom.equalTo(self.bottomView.mas_top).offset(-CGFloatIn750(0));
            make.top.equalTo(self.view.mas_top).offset(-CGFloatIn750(0));
        }];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"班级详情"];
}

- (void)setupMainView {
    [super setupMainView];
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFloatIn750(182))];
    _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.view addSubview:_bottomView];
    
    [self.bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(0));
        make.height.mas_equalTo(CGFloatIn750(96));
        make.top.equalTo(self.bottomView.mas_top);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(182));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
        make.bottom.equalTo(self.bottomView.mas_top).offset(-CGFloatIn750(0));
        make.top.equalTo(self.view.mas_top).offset(-CGFloatIn750(0));
    }];
}


#pragma mark - lazy loading...
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(118), CGFloatIn750(50))];
        [_navLeftBtn setTitle:@"加入学员" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontSmall]];
        [_navLeftBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        ViewRadius(_navLeftBtn, CGFloatIn750(25));
        [_navLeftBtn bk_addEventHandler:^(id sender) {
            NSArray *weekArr = @[@[@"新增线上学员",@"listadd",@"add"],@[@"二维码新增学员",@"erweimlist",@"code"]];
            [ZAlertMoreView setMoreAlertWithTitleArr:weekArr handlerBlock:^(NSString *index) {
                if ([index isEqualToString:@"code"]) {
                    ZOriganizationStudentCodeAddModel *addModel = [[ZOriganizationStudentCodeAddModel alloc] init];
                    ZOrganizationTrachingScheduleOutlineErweimaVC *avc = [[ZOrganizationTrachingScheduleOutlineErweimaVC alloc] init];
                    avc.class_id = weakSelf.model.classID;
                    addModel.class_name = weakSelf.model.name;
                    addModel.teacher_name = weakSelf.model.teacher_name;
                    addModel.teacher_image = weakSelf.model.teacher_image;
                    addModel.image = weakSelf.model.stores_course_image;
                    addModel.courses_name = weakSelf.model.stores_courses_name;
                    [weakSelf.navigationController pushViewController:avc animated:YES];
                }else{
                    ZOrganizationClassDetailStudentListAddVC *avc = [[ZOrganizationClassDetailStudentListAddVC alloc] init];
                    avc.model = weakSelf.model;
                    [weakSelf.navigationController pushViewController:avc animated:YES];
                }
            }];
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navLeftBtn;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"发通知" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
            NSMutableDictionary *param = @{}.mutableCopy;
            [param setObject:@"1" forKey:@"page"];
            [param setObject:@"100" forKey:@"page_size"];
            [param setObject:self.model.stores_id forKey:@"stores_id"];
            [param setObject:self.model.classID forKey:@"courses_class_id"];
            [ZOriganizationClassViewModel getClassStudentList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
                    weakSelf.loading = NO;
                    if (isSuccess && data) {
                        ZSendMessageModel *mvc = [[ZSendMessageModel alloc] init];
                        mvc.storesName = self.model.stores_name;
                        mvc.lessonName = self.model.stores_courses_name;
                        mvc.type = @"3";
                        mvc.teacherName = self.model.teacher_name;
                        mvc.teacherImage = self.model.teacher_image;
                        mvc.studentList = [[NSMutableArray alloc] initWithArray:data.list];
                        routePushVC(ZRoute_mine_sendMessage, mvc, nil);
                    }else{
                    }
                }];
        }forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

- (ZOriganizationClassDetailModel *)model {
    if (!_model) {
        _model = [[ZOriganizationClassDetailModel alloc] init];
    }
    return _model;
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
//    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"beginTime"]) {
        
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
//    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"studentList"]) {
        ZOrganizationClassDetailStudentListVC *lvc = [[ZOrganizationClassDetailStudentListVC  alloc] init];
        lvc.isEnd = [self.model.status intValue] == 3;
        lvc.model = self.model;
//        lvc.type = [[ZUserHelper sharedHelper].user.type intValue] == 2 ? 1:2;
        [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"detail"]){
        routePushVC(ZRoute_mine_classSignDetail, @{@"isTeacher":@YES,@"model":self.model}, nil);
    }
}


- (void)refreshData {
    __weak typeof(self) weakSelf = self;
    self.loading = YES;
    [ZOriganizationClassViewModel getClassDetail:@{@"id":SafeStr(self.classID)} completeBlock:^(BOOL isSuccess, ZOriganizationClassDetailModel *addModel) {
        self.loading = NO;
        if (isSuccess) {
            weakSelf.model = addModel;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}

@end

#pragma mark - RouteHandler
@interface ZTeacherClassDetailVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZTeacherClassDetailVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_teacherClassDetail;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZTeacherClassDetailVC *routevc = [[ZTeacherClassDetailVC alloc] init];
    if (request.prts && [request.prts isKindOfClass:[NSDictionary class]] && [request.prts objectForKey:@"id"]) {
        routevc.classID = request.prts[@"id"];
    }
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
