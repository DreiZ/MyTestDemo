//
//  ZOrganizationStudentCodeAddVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationStudentCodeAddVC.h"
#import "ZOriganizationStudentViewModel.h"
#import "ZAlertTeacherCheckBoxView.h"
#import "ZAlertLessonCheckBoxView.h"
#import "ZAddStudentCodeView.h"
#import "ZUMengShareManager.h"

@interface ZOrganizationStudentCodeAddVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) ZOriganizationStudentViewModel *viewModel;
@property (nonatomic,strong) ZAddStudentCodeView *codeImageView;

@end

@implementation ZOrganizationStudentCodeAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewGaryBack];
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [self initCellConfigArr];
}

- (void)setDataSource {
    [super setDataSource];
    _viewModel = [[ZOriganizationStudentViewModel alloc] init];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    NSArray *textArr = @[@[@"选择课程", SafeStr(self.viewModel.codeAddModel.courses_name), @"rightBlackArrowN",@"lesson"],
                         @[@"选择教师", SafeStr(self.viewModel.codeAddModel.teacher_name), @"rightBlackArrowN",@"teacher"]];
    
    for (int i = 0; i < textArr.count; i++) {
        NSArray *tArr = textArr[i];
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = tArr[0];
        model.rightImage = tArr[2];
        model.rightTitle = tArr[1];
        model.cellTitle = tArr[3];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(96);
        model.leftFont = [UIFont fontContent];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"二维码添加学员"];
}

- (void)setupMainView {
    [super setupMainView];
    
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(20);
    }];
    self.iTableView.tableFooterView = self.bottomView;
    ViewRadius(self.iTableView, CGFloatIn750(20));
}

#pragma mark - lazy loading...
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"生成二维码邀请学员" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
            if (!ValidStr(weakSelf.viewModel.codeAddModel.courses_name)) {
                [TLUIUtility showErrorHint:@"请选择班级"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.codeAddModel.teacher_name)) {
                [TLUIUtility showErrorHint:@"请选择教师"];
                return ;
            }
            [weakSelf updateData];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth-CGFloatIn750(60), CGFloatIn750(180))];
        _bottomView.layer.masksToBounds = YES;
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        
        
        UIView *topBtnView = [[UIView alloc] initWithFrame:CGRectZero];
        topBtnView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(topBtnView, CGFloatIn750(20));
        [_bottomView addSubview:topBtnView];
        [topBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bottomView);
            make.top.equalTo(self.bottomView.mas_top).offset(-CGFloatIn750(20));
            make.height.mas_equalTo(100);
        }];
        
        [_bottomView addSubview:self.bottomBtn];
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(60));
            make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-60));
            make.height.mas_equalTo(CGFloatIn750(80));
            make.top.equalTo(self.bottomView.mas_top).offset(CGFloatIn750(40));
        }];
        
        [_bottomView addSubview:self.codeImageView];
        [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topBtnView.mas_bottom).offset(CGFloatIn750(20));
            make.left.right.equalTo(self.bottomView);
            make.height.mas_equalTo(CGFloatIn750(742));
        }];
        
    }
    return _bottomView;
}

- (ZAddStudentCodeView *)codeImageView {
    if (!_codeImageView) {
        __weak typeof(self) weakSelf = self;
        _codeImageView = [[ZAddStudentCodeView alloc] init];
        _codeImageView.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                [[ZUMengShareManager sharedManager] shareUIWithType:0 Title:SafeStr(weakSelf.viewModel.codeAddModel.courses_name) detail:[NSString stringWithFormat:@"赶紧扫描二维码加入课程跟着%@一起学习%@吧",SafeStr(weakSelf.viewModel.codeAddModel.teacher_name),SafeStr(weakSelf.viewModel.codeAddModel.courses_name)] image:weakSelf.codeImageView.userImageView.image url:SafeStr(weakSelf.viewModel.codeAddModel.url) vc:weakSelf];
            }else if (index == 2){
                UIImage *shortImage = [ZPublicTool snapshotForView:weakSelf.codeImageView.topView];
                if (shortImage) {
                    [ZPublicTool saveImageToPhoto:shortImage];
                }
                
            }else if (index == 1){
                
            }
        };
    }
    return _codeImageView;
}

- (void)updateCode {
    _bottomView.frame = CGRectMake(0, 0, KScreenWidth-CGFloatIn750(60), CGFloatIn750(180) + CGFloatIn750(762) + CGFloatIn750(120) - CGFloatIn750(70));
    _codeImageView.model = self.viewModel.codeAddModel;
    self.iTableView.tableFooterView = self.bottomView;
}

- (void)updateData {
    NSMutableDictionary *params = @{}.mutableCopy;
   
    [params setObject:SafeStr(self.viewModel.codeAddModel.courses_id) forKey:@"course_id"];
    [params setObject:SafeStr(self.viewModel.codeAddModel.teacher_id) forKey:@"teacher_id"];
    [params setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
    
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@""];
    [ZOriganizationStudentViewModel addStudentQrcode:params completeBlock:^(BOOL isSuccess,  id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            ZOriganizationStudentCodeAddModel *model = data;
            weakSelf.viewModel.codeAddModel.image = model.image;
            weakSelf.viewModel.codeAddModel.url = model.url;
            weakSelf.viewModel.codeAddModel.nick_name = model.nick_name;
            [weakSelf updateCode];
            return ;
        }else {
            [TLUIUtility showErrorHint:data];
        }
    }];
}

#pragma mark tableView ------delegate-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig{
//    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"lessonTime"]) {
        
        
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"lesson"]) {
       [self.iTableView endEditing:YES];
       [ZAlertLessonCheckBoxView  setAlertName:@"选择课程" schoolID:[ZUserHelper sharedHelper].school.schoolID handlerBlock:^(NSInteger index,ZOriganizationLessonListModel *model) {
           if (model) {
               weakSelf.viewModel.codeAddModel.courses_id = model.lessonID;
               weakSelf.viewModel.codeAddModel.courses_name = model.short_name;
               [weakSelf initCellConfigArr];
               [weakSelf.iTableView reloadData];
           }
       }];
    }else if ([cellConfig.title isEqualToString:@"teacher"]) {
        [self.iTableView endEditing:YES];
        if (!ValidStr(self.viewModel.codeAddModel.courses_id)) {
            [TLUIUtility showErrorHint:@"请先选择课程"];
            return;
        }
        [ZAlertTeacherCheckBoxView setAlertName:@"选择教师" schoolID:self.viewModel.codeAddModel.courses_id handlerBlock:^(NSInteger index,ZOriganizationTeacherListModel *model) {
            if (model) {
                weakSelf.viewModel.codeAddModel.teacher_name = model.teacher_name;
                weakSelf.viewModel.codeAddModel.teacher_id  = model.teacherID;
                weakSelf.viewModel.codeAddModel.teacher_image = model.image;
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }
        }];
    }
}
@end

