//
//  ZStudentMineSettingAboutUsVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingAboutUsVC.h"
#import "ZAlertView.h"
#import "ZAgreementVC.h"
@interface ZStudentMineSettingAboutUsVC ()
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIView *bottomView;
@end

@implementation ZStudentMineSettingAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHidenNaviBar = NO;
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"关于").zChain_setTableViewWhite();
    self.zChain_resetMainView(^{
        [self.view addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(240));
            make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
        }];
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.view);
            make.bottom.equalTo(self.bottomView.mas_top);
        }];
        self.iTableView.tableHeaderView = self.topView;
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        NSString *temp = @"1.0.0";
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        if ([infoDictionary objectForKey:@"CFBundleShortVersionString"]) {
            temp = [NSString stringWithFormat:@"v%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
        }

        NSArray <NSArray *>*titleArr = @[@[@"当前版本", temp, @"version"],@[@"微信公众号", @"xiangcenter", @"weixin"]];

        for (int i = 0; i < titleArr.count; i++) {
            ZLineCellModel *model =  ZLineCellModel.zz_lineCellModel_create(titleArr[i][2]);
            model.zz_titleLeft(titleArr[i][0]);
            model.zz_titleRight(titleArr[i][1]);
            model.zz_cellHeight(CGFloatIn750(110));
            model.zz_fontLeft([UIFont fontContent]);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [weakSelf.cellConfigArr addObject:menuCellConfig];

            if (i == 2) {
                [weakSelf.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
            }
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"weixin"]) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = @"xiangcenter";
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZAlertView setAlertWithTitle:@"已复制微信号到粘贴板" btnTitle:@"知道了" handlerBlock:^(NSInteger index) {
                    
                }];
            });
        }
    });
    
    self.zChain_reload_ui();
    [ZPublicTool settingCheckUpdateVersion];
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

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(470))];
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        nameLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        nameLabel.text = @"Copyright © 2019 xiangcenter.com\n徐州向心力网络科技有限公司 版权所有";
        nameLabel.numberOfLines = 0;
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [nameLabel setFont:[UIFont fontMin]];
        [_bottomView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bottomView);
            make.bottom.equalTo(self.bottomView.mas_bottom).offset(-CGFloatIn750(18));
        }];
        [ZPublicTool setLineSpacing:CGFloatIn750(8) label:nameLabel];
        
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [leftBtn setTitle:@"用户协议" forState:UIControlStateNormal];
        [leftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [leftBtn.titleLabel setFont:[UIFont boldFontSmall]];
        [leftBtn bk_whenTapped:^{
            ZAgreementVC *avc = [[ZAgreementVC alloc] init];
            avc.navTitle = @"似锦服务条款";
            avc.type = @"service_agreement";
            avc.url = @"http://www.xiangcenter.com/User/useragreement.html";
            [self.navigationController pushViewController:avc animated:YES];
        }];
        [_bottomView addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFloatIn750(40));
            make.right.equalTo(self.bottomView.mas_centerX).offset(-4);
            make.bottom.equalTo(nameLabel.mas_top).offset(-CGFloatIn750(0));
        }];
        
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [rightBtn setTitle:@"隐私政策" forState:UIControlStateNormal];
        [rightBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [rightBtn.titleLabel setFont:[UIFont boldFontSmall]];
        [rightBtn bk_whenTapped:^{
            ZAgreementVC *avc = [[ZAgreementVC alloc] init];
            avc.navTitle = @"似锦隐私协议";
            avc.type = @"privacy_policy";
            avc.url = @"http://www.xiangcenter.com/User/privacyprotocol.html";
            [self.navigationController pushViewController:avc animated:YES];
        }];
        [_bottomView addSubview:rightBtn];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.height.mas_equalTo(CGFloatIn750(40));
            make.left.equalTo(self.bottomView.mas_centerX).offset(4);
           make.bottom.equalTo(nameLabel.mas_top).offset(-CGFloatIn750(0));
        }];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        [_bottomView addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bottomView);
            make.centerY.equalTo(rightBtn);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(CGFloatIn750(14));
        }];
        
        UIView *leftLineView = [[UIView alloc] initWithFrame:CGRectZero];
        leftLineView.backgroundColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        [_bottomView addSubview:leftLineView];
        [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(leftBtn.titleLabel.mas_bottom).offset(0);
            make.left.right.equalTo(leftBtn.titleLabel);
            make.height.mas_equalTo(0.5);
        }];
        
        UIView *rightLineView = [[UIView alloc] initWithFrame:CGRectZero];
        rightLineView.backgroundColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        [_bottomView addSubview:rightLineView];
        [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(rightBtn.titleLabel.mas_bottom).offset(0);
            make.left.right.equalTo(rightBtn.titleLabel);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _bottomView;
}
@end
