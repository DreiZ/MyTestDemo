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
    self.isHidenNaviBar = NO;
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"关于").zChain_setTableViewGary();
    self.zChain_resetMainView(^{
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
@end
