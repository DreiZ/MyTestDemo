//
//  ZStudentMineSettingAboutUsVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingAboutUsVC.h"
#import "ZAlertView.h"

@interface ZStudentMineSettingAboutUsVC ()
@property (nonatomic,strong) UIView *topView;
@end

@implementation ZStudentMineSettingAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableViewGaryBack];
    [self initCellConfigArr];
    [self.iTableView reloadData];
    self.iTableView.tableHeaderView = self.topView;
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    NSString *temp = @"1.0.0";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    if ([infoDictionary objectForKey:@"CFBundleShortVersionString"]) {
        temp = [NSString stringWithFormat:@"v%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    }

    NSArray <NSArray *>*titleArr = @[@[@"当前版本", temp, @"version"],@[@"微信公众号", @"xiangcenter", @"weixin"]];

    for (int i = 0; i < titleArr.count; i++) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = titleArr[i][0];
        model.rightTitle = titleArr[i][1];
        model.leftFont = [UIFont fontContent];
        model.cellHeight = CGFloatIn750(110);
        model.cellTitle = titleArr[i][2];

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
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(470))];
        _topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        UIImageView *logoImageView = [[UIImageView alloc] init];
        logoImageView.image = [UIImage imageNamed:@"logo"];
        logoImageView.layer.masksToBounds = YES;
        [_topView addSubview:logoImageView];
        [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.topView);
            make.top.equalTo(self.topView.mas_top).offset(CGFloatIn750(80));
            make.width.height.mas_equalTo(CGFloatIn750(240));
        }];
        
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        nameLabel.text = @"似锦";
        nameLabel.numberOfLines = 0;
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [nameLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [_topView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.topView);
            make.top.equalTo(logoImageView.mas_bottom).offset(CGFloatIn750(28));
        }];
    }
    
    return _topView;
}


#pragma mark tableView ------delegate-----
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"weixin"]) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = @"xiangcenter";
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZAlertView setAlertWithTitle:@"已复制微信号到粘贴板" btnTitle:@"知道了" handlerBlock:^(NSInteger index) {
                
            }];
        });
    }
}

@end
