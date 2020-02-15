//
//  ZStudentMineSettingAboutUsVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingAboutUsVC.h"
#import "ZCellConfig.h"
#import "ZStudentDetailModel.h"

#import "ZSpaceEmptyCell.h"
#import "ZStudentLessonOrderCompleteCell.h"

#import "ZStudentMineFeedbackVC.h"

@interface ZStudentMineSettingAboutUsVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UILabel *versionLabel;


@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end
@implementation ZStudentMineSettingAboutUsVC

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
    
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
    
    NSArray <NSArray *>*titleArr = @[@[@"特别声明", @"rightBlackArrow"],@[@"使用帮助", @"rightBlackArrow"],@[@"给我评分", @"rightBlackArrow"],@[@"商务合作", @"rightBlackArrow"],@[@"意见反馈", @"rightBlackArrow"]];
    
    for (int i = 0; i < titleArr.count; i++) {
        ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
        model.leftTitle = titleArr[i][0];
        model.rightImage = titleArr[i][1];
        model.leftFont = [UIFont fontContent];
        model.rightColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray]);
        model.cellTitle = titleArr[i][0];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        if (i == 2) {
            ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG])];
            [self.cellConfigArr addObject:topCellConfig];
        }
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"关于"];
}

- (void)setupMainView {
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(0);
    }];
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
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
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG]);
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.tableHeaderView = self.topView;
    }
    return _iTableView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(500))];
        _topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
        
        UIImageView *logoImageView = [[UIImageView alloc] init];
        logoImageView.image = [UIImage imageNamed:@"loginLogo"];
        logoImageView.layer.masksToBounds = YES;
        [_topView addSubview:logoImageView];
        [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.topView);
            make.top.equalTo(self.topView.mas_top).offset(CGFloatIn750(90));
        }];
        
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
        nameLabel.text = @"艺动";
        nameLabel.numberOfLines = 0;
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [nameLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [_topView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.topView);
            make.top.equalTo(logoImageView.mas_bottom).offset(CGFloatIn750(28));
        }];
        
        [_topView addSubview:self.versionLabel];
        [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.topView);
            make.top.equalTo(nameLabel.mas_bottom).offset(CGFloatIn750(28));
        }];
        
    }
    
    return _topView;
}

- (UILabel *)versionLabel {
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _versionLabel.textColor = [UIColor  colorMain];
        _versionLabel.text = @"V12.1";
        _versionLabel.numberOfLines = 1;
        _versionLabel.textAlignment = NSTextAlignmentCenter;
        [_versionLabel setFont:[UIFont fontTitle]];
    }
    return _versionLabel;
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
    if ([cellConfig.title isEqualToString:@"ZStudentMineSignListCell"]){
       
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
    if ([cellConfig.title isEqualToString:@"意见反馈"]) {
        ZStudentMineFeedbackVC *fvc = [[ZStudentMineFeedbackVC alloc] init];
        [self.navigationController pushViewController:fvc animated:YES];
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








