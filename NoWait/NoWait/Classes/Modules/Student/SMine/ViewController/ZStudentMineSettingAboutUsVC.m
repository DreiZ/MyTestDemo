//
//  ZStudentMineSettingAboutUsVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingAboutUsVC.h"

#import "ZStudentMineFeedbackVC.h"

@interface ZStudentMineSettingAboutUsVC ()
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UILabel *versionLabel;
@end
@implementation ZStudentMineSettingAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableViewGaryBack];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    NSArray <NSArray *>*titleArr = @[@[@"特别声明", @"rightBlackArrowN"],@[@"使用帮助", @"rightBlackArrowN"],@[@"给我评分", @"rightBlackArrowN"],@[@"商务合作", @"rightBlackArrowN"],@[@"意见反馈", @"rightBlackArrowN"]];
    
    for (int i = 0; i < titleArr.count; i++) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = titleArr[i][0];
        model.rightImage = titleArr[i][1];
        model.leftFont = [UIFont fontContent];
        model.cellHeight = CGFloatIn750(110);
        model.cellTitle = titleArr[i][0];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        if (i == 2) {
            ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
            [self.cellConfigArr addObject:topCellConfig];
        }
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"关于"];
}


#pragma mark lazy loading...
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(500))];
        _topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        UIImageView *logoImageView = [[UIImageView alloc] init];
        logoImageView.image = [UIImage imageNamed:@"loginLogo"];
        logoImageView.layer.masksToBounds = YES;
        [_topView addSubview:logoImageView];
        [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.topView);
            make.top.equalTo(self.topView.mas_top).offset(CGFloatIn750(90));
        }];
        
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
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
        _versionLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        _versionLabel.text = @"V12.1";
        _versionLabel.numberOfLines = 1;
        _versionLabel.textAlignment = NSTextAlignmentCenter;
        [_versionLabel setFont:[UIFont fontTitle]];
    }
    return _versionLabel;
}

#pragma mark tableView ------delegate-----
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"意见反馈"]) {
        ZStudentMineFeedbackVC *fvc = [[ZStudentMineFeedbackVC alloc] init];
        [self.navigationController pushViewController:fvc animated:YES];
    }
   
}

@end
