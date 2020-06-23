//
//  ZOrganizationCardAddVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCardAddVC.h"
#import "ZOrganizationCardAddLessonListVC.h"
#import "ZAlertBeginAndEndTimeView.h"
#import "ZAlertTimeQuantumView.h"

#import "ZBaseUnitModel.h"
#import "ZAlertDataPickerView.h"
#import "ZAlertView.h"

#import "ZOrganizationCardLessonListVC.h"

@interface ZOrganizationCardAddVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIButton *navLeftBtn;

@end

@implementation ZOrganizationCardAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    NSString *ftitle = @"";
    if (ValidArray(self.viewModel.addModel.lessonList)) {
        if (self.viewModel.addModel.isAll) {
            ftitle = @"全部课程可用";
        }else{
            ftitle = @"部分课程可用";
        }
    }
    NSString *time = @"";
    if (self.viewModel.addModel.limit_start) {
        time = [NSString stringWithFormat:@"%@至%@",[self.viewModel.addModel.limit_start timeStringWithFormatter:@"yyyy-MM-dd"],[self.viewModel.addModel.limit_end timeStringWithFormatter:@"yyyy-MM-dd"]];
    }
    
    NSArray *textArr = @[@[@"类型", @"请选择可用课程", @NO, @"rightBlackArrowN", @"type",@30, @"",ftitle,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"名称", @"30字节以内", @YES, @"", @"name",@30, @"",SafeStr(self.viewModel.addModel.title),[NSNumber numberWithInt:ZFormatterTypeAnyByte]],
                         @[@"面额", @"0", @YES, @"", @"price",@6, @"元",SafeStr(self.viewModel.addModel.amount),[NSNumber numberWithInt:ZFormatterTypeNumber]],
                         @[@"满减条件", @"最低1元，默认满1元可用", @YES, @"", @"tiaojian",@6, @"元",SafeStr(self.viewModel.addModel.min_amount),[NSNumber numberWithInt:ZFormatterTypeDecimal]],
                         @[@"有效时间", @"不填写则无时间限制", @NO, @"rightBlackArrowN", @"time", @30, @"",time,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"发行量", @"最大发行量不能超过1000张", @YES, @"", @"num",@4, @"张",SafeStr(self.viewModel.addModel.nums),[NSNumber numberWithInt:ZFormatterTypeNumber]],
                         @[@"每人限领", @"0", @YES, @"", @"preNum",@3, @"张",SafeStr(self.viewModel.addModel.limit),[NSNumber numberWithInt:ZFormatterTypeNumber]]];
    
    for (int i = 0; i < textArr.count; i++) {
       ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
        cellModel.leftTitle = textArr[i][0];
        cellModel.placeholder = textArr[i][1];
        cellModel.isTextEnabled = [textArr[i][2] boolValue];
        cellModel.rightImage = textArr[i][3];
        cellModel.cellTitle = textArr[i][4];
        cellModel.max = [textArr[i][5] intValue];
        cellModel.rightTitle = textArr[i][6];
        cellModel.content = textArr[i][7];
        cellModel.formatterType = [textArr[i][8] intValue];
        cellModel.isHiddenLine = YES;
        cellModel.cellHeight = CGFloatIn750(86);
        cellModel.leftFont = [UIFont fontContent];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [self.cellConfigArr addObject:textCellConfig];
        
    }
    if (ValidArray(self.viewModel.addModel.lessonList)) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"可用课程";
        model.isHiddenLine = YES;
        model.leftFont = [UIFont boldFontTitle];
        model.cellHeight = CGFloatIn750(110);
        model.cellTitle = @"lessonList";
        model.rightImage = @"rightBlackArrowN";
        model.rightTitle = [NSString stringWithFormat:@"已选%ld门课程",self.viewModel.addModel.lessonList.count];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"卡券状态";
        model.rightTitle = [self.viewModel.addModel.status intValue] == 1 ? @"默认启用" : @"停用";
        model.isHiddenLine = YES;
        model.leftFont = [UIFont fontContent];
        model.cellHeight = CGFloatIn750(86);
        model.cellTitle = @"status";
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"新增卡券"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
    [self.navigationItem setLeftBarButtonItem:item];
}

- (void)setupMainView {
    [super setupMainView];
   
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFloatIn750(200))];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.iTableView.tableFooterView = bottomView;
    
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(80));
    }];
}


#pragma mark - lazy loading...
-(ZOriganizationCardViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZOriganizationCardViewModel alloc] init];
        _viewModel.addModel.status = @"1";
    }
    return _viewModel;
}

- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(106), CGFloatIn750(48))];
        [_navLeftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontContent]];
        [_navLeftBtn bk_addEventHandler:^(id sender) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navLeftBtn;
}


- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"发布优惠券" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
            if (!ValidArray(weakSelf.viewModel.addModel.lessonList)) {
                [TLUIUtility showErrorHint:@"请选择可用课程"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.title)) {
                [TLUIUtility showErrorHint:@"请输入卡券名称"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.amount)) {
                [TLUIUtility showErrorHint:@"请输入卡券面额"];
                return ;
            }
            if (ValidStr(weakSelf.viewModel.addModel.min_amount)) {
                if ([weakSelf.viewModel.addModel.min_amount intValue] < 1) {
                    [TLUIUtility showErrorHint:@"满减金额不得小于1元"];
                    return;
                }
            }
            
            if (!ValidStr(weakSelf.viewModel.addModel.nums)) {
                [TLUIUtility showErrorHint:@"请输入发行量"];
                return ;
            }
            
            if ([weakSelf.viewModel.addModel.nums intValue] > 1000) {
                [TLUIUtility showErrorHint:@"发行量不可大于1000"];
                return ;
            }
            
            if (!ValidStr(weakSelf.viewModel.addModel.limit)) {
                [TLUIUtility showErrorHint:@"请输入个人限领"];
                return ;
            }
            
            if ([weakSelf.viewModel.addModel.limit intValue] > [weakSelf.viewModel.addModel.nums intValue]) {
                [TLUIUtility showErrorHint:@"个人限领不可大于发行量"];
                return ;
            }
            
            if (ValidStr(weakSelf.viewModel.addModel.limit_end) && [weakSelf.viewModel.addModel.limit_end intValue] - [weakSelf.viewModel.addModel.limit_start intValue] < 60 * 60 * 24 ) {
                [TLUIUtility showErrorHint:@"有效期不得小于1天"];
                return;
            }
            NSMutableDictionary *params = @{}.mutableCopy;
            [params setObject:[ZUserHelper sharedHelper].school.schoolID forKey:@"stores_id"];
            [params setObject:self.viewModel.addModel.title forKey:@"title"];
            [params setObject:self.viewModel.addModel.amount forKey:@"amount"];
            
            [params setObject:self.viewModel.addModel.nums forKey:@"nums"];
            [params setObject:self.viewModel.addModel.limit forKey:@"limit"];
            [params setObject:self.viewModel.addModel.status forKey:@"status"];
//            if (!ValidStr(self.viewModel.addModel.min_amount)) {
//                 [ZAlertView setAlertWithTitle:@"不填写满减金额默认满1元可用" btnTitle:@"知道了" handlerBlock:^(NSInteger index) {
//
//                     }];
//            }
            
            if (ValidStr(self.viewModel.addModel.min_amount)) {
                [params setObject:self.viewModel.addModel.min_amount forKey:@"min_amount"];
            }else{
                [params setObject:@"1" forKey:@"min_amount"];
            }
            
            if (self.viewModel.addModel.isAll) {
                [params setObject:@"1" forKey:@"type"];
            }else{
                [params setObject:@"2" forKey:@"type"];
                
                NSMutableArray *lesssonList = @[].mutableCopy;
                for (ZOriganizationLessonListModel *model in self.viewModel.addModel.lessonList) {
                    [lesssonList addObject:model.lessonID];
                }
                [params setObject:lesssonList forKey:@"course_id"];
            }
            
            if (ValidStr(weakSelf.viewModel.addModel.limit_start)) {
                [params setObject:self.viewModel.addModel.limit_start forKey:@"limit_start"];
                [params setObject:self.viewModel.addModel.limit_end forKey:@"limit_end"];
            }
            
            [weakSelf updateDataWithParams:params];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}


- (void)updateDataWithParams:(NSMutableDictionary *)otherDict {
    [TLUIUtility showLoading:@""];
    [ZOriganizationCardViewModel addCart:otherDict completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [self.navigationController popViewControllerAnimated:YES];
            return ;
        }else {
            [TLUIUtility showErrorHint:message];
        }
    }];
}



#pragma mark tableView ------delegate-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"name"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.title = text;
        };
    }else  if ([cellConfig.title isEqualToString:@"price"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.amount = text;
        };
    }else  if ([cellConfig.title isEqualToString:@"tiaojian"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.min_amount = text;
        };
    }else  if ([cellConfig.title isEqualToString:@"num"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.nums = text;
        };
    }else  if ([cellConfig.title isEqualToString:@"preNum"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.limit = text;
        };
    }
}

-(void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;;
    if ([cellConfig.title isEqualToString:@"type"]) {
        [self.iTableView endEditing:YES];
        ZOrganizationCardAddLessonListVC *lvc = [[ZOrganizationCardAddLessonListVC alloc] init];
        lvc.handleBlock = ^(NSArray<ZOriganizationLessonListModel *> *list, BOOL isAll) {
            weakSelf.viewModel.addModel.lessonList = list;
            weakSelf.viewModel.addModel.isAll = isAll;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
        [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"time"]) {
        [self.iTableView endEditing:YES];
        [ZAlertBeginAndEndTimeView setAlertName:@"选择开始日期" subName:@"选择结束时间"  pickerMode:PGDatePickerModeDate handlerBlock:^(NSDateComponents *begin, NSDateComponents *end) {
            weakSelf.viewModel.addModel.limit_start = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:begin] timeIntervalSince1970]];
            weakSelf.viewModel.addModel.limit_end = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:end] timeIntervalSince1970]];
            
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }];
    }else if ([cellConfig.title isEqualToString:@"lessonList"]){
        [self.iTableView endEditing:YES];
        ZOrganizationCardLessonListVC *lvc = [[ZOrganizationCardLessonListVC alloc] init];
        lvc.lessonList = self.viewModel.addModel.lessonList;
        [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"status"]) {

    }
}
@end
