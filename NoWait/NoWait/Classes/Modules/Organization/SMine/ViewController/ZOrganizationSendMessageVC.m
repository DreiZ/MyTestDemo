//
//  ZOrganizationSendMessageVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSendMessageVC.h"
#import "ZOriganizationStudentViewModel.h"
#import "ZTableViewListCell.h"
#import "ZOriganizationTextViewCell.h"
#import "ZOrganizationStudentSelectVC.h"

@interface ZOrganizationSendMessageVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) ZOriganizationStudentViewModel *viewModel;
@property (nonatomic,strong) NSString *message;

@end

@implementation ZOrganizationSendMessageVC

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
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"收件人:";
        if ([self.type isEqualToString:@"2"]) {
            model.rightImage = @"rightBlackArrowN";
        }
        
        model.rightTitle = [NSString stringWithFormat:@"已选择%ld人",self.studentList.count];
        model.cellTitle = @"student";
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(106);
        model.leftFont = [UIFont fontContent];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    if (self.lessonName) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = self.lessonName;
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(86);
        model.leftFont = [UIFont fontContent];
        model.cellTitle = @"gray";
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    {
        ZBaseTextFieldCellModel *model = [[ZBaseTextFieldCellModel alloc] init];
        model.leftMargin = CGFloatIn750(18);
        model.rightMargin = CGFloatIn750(20);
        model.contentSpace = CGFloatIn750(10);
        model.placeholder = @"编辑通知内容";
        model.textAlignment = NSTextAlignmentLeft;
        model.isHiddenLine = NO;
        model.max = 500;
        model.cellHeight = CGFloatIn750(120);
        model.textFont = [UIFont fontContent];
        model.subTitleColor = [UIColor colorGrayBG];
        model.subTitleDarkColor = [UIColor colorGrayBGDark];
        model.rightColor = [UIColor colorTextGray];
        model.rightDarkColor = [UIColor colorTextGrayDark];
        model.content = self.message;

        ZCellConfig *moreIntputCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseTextViewCell className] title:[ZBaseTextViewCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseTextViewCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:moreIntputCellConfig];
    }
    
    if (self.storesName) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = self.storesName;
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(86);
        model.leftFont = [UIFont fontContent];
        model.cellTitle = @"gray";
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"编辑通知"];
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
        [_bottomBtn setTitle:@"发送通知" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
            if (!ValidArray(weakSelf.studentList)) {
                [TLUIUtility showErrorHint:@"请选择学员"];
                return ;
            }
            if (!ValidStr(weakSelf.message)) {
                [TLUIUtility showErrorHint:@"请输入消息内容"];
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
        
    }
    return _bottomView;
}


- (void)updateData {
    NSMutableDictionary *params = @{}.mutableCopy;
    NSMutableArray *ids = @[].mutableCopy;
    
    NSMutableDictionary *extra = @{}.mutableCopy;
    NSMutableArray *name = @[].mutableCopy;
   for (ZOriganizationStudentListModel *model in self.studentList) {
           NSMutableDictionary *para = @{}.mutableCopy;
       if (model && model.account_id) {
           [para setObject:model.account_id forKey:@"account_id"];
           [para setObject:self.lessonName forKey:@"title"];
           [name addObject:model.name];
           [ids addObject:para];
       }
    
   }
    [extra setObject:name forKey:@"name"];
    [params setObject:extra forKey:@"extra"];
    [params setObject:ids forKey:@"receive"];
    [params setObject:SafeStr(self.teacherName) forKey:@"sender1"];
    [params setObject:SafeStr(self.storesName) forKey:@"sender2"];
    [params setObject:SafeStr(self.message) forKey:@"content"];
    if ([ZUserHelper sharedHelper].stores) {
        [params setObject:SafeStr([ZUserHelper sharedHelper].stores.stores_id) forKey:@"stores_id"];
    }
    if ([ZUserHelper sharedHelper].school) {
        [params setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
    }
    [params setObject:SafeStr(self.type) forKey:@"type"];
    
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@""];
    [ZOriganizationStudentViewModel addMessage:params completeBlock:^(BOOL isSuccess,  id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:data];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            return ;
        }else {
            [TLUIUtility showErrorHint:data];
        }
    }];
}

#pragma mark tableView ------delegate-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig{
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"gray"]) {
        ZSingleLineCell *lcell = (ZSingleLineCell *)cell;
        lcell.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        
    }else if ([cellConfig.title isEqualToString:@"ZBaseTextViewCell"]) {
        ZBaseTextViewCell *lcell = (ZBaseTextViewCell *)cell;
        lcell.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        lcell.valueBlock = ^(NSString * text) {
            weakSelf.message = text;
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"student"] && [self.type isEqualToString:@"2"]) {
       [self.iTableView endEditing:YES];
        ZOrganizationStudentSelectVC *svc = [[ZOrganizationStudentSelectVC alloc] init];
        svc.ids = self.studentList;
        svc.bottomBlock = ^(NSArray * students) {
            weakSelf.studentList = [[NSMutableArray alloc] initWithArray:students];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
        [self.navigationController pushViewController:svc animated:YES];
    }
}
@end


