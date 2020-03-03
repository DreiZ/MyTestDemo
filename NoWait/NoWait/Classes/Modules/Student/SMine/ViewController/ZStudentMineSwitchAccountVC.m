//
//  ZStudentMineSwitchAccountVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/12.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSwitchAccountVC.h"
#import "ZAccountViewController.h"

#import "ZUserHelper.h"
#import "ZLaunchManager.h"
#import "ZAccountViewController.h"

@interface ZStudentMineSwitchAccountVC ()

@end

@implementation ZStudentMineSwitchAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableViewGaryBack];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    NSArray *userList = [[ZUserHelper sharedHelper] userList];
    
    for (int i = 0; i < userList.count; i++) {
        if ([userList[i] isKindOfClass:[ZUser class]]) {
            ZUser *user = userList[i];
            
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.cellHeight = CGFloatIn750(106);
            model.leftTitle = user.phone;
            model.cellTitle = @"user";
            model.leftImage = @"http://ww1.sinaimg.cn/mw600/bdd98093gy1gbp87csne1j20go0gotbs.jpg";
            if (i == userList.count-1) {
                model.isHiddenLine = YES;
            }
            if ([user.userID isEqualToString:[ZUserHelper sharedHelper].user_id]) {
                model.rightImage = @"selectedCycle";
            }else{
                model.rightImage = @"unSelectedCycle";
            }
            model.data = user;
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
    
    if (self.cellConfigArr.count < 2) {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
        [self.cellConfigArr addObject:topCellConfig];
        
        
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"换个新账号登录";
        model.rightImage = isDarkModel() ? @"rightBlackArrowDarkN" : @"rightBlackArrowN";
        model.cellTitle = @"switch";
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    } 
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"切换账号"];
}

#pragma mark tableView ------delegate-----
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
     if ([cellConfig.title isEqualToString:@"switch"]){
         ZAccountViewController *loginvc = [[ZAccountViewController alloc] init];
         loginvc.loginSuccess = ^{
             [weakSelf initCellConfigArr];
             [weakSelf.iTableView reloadData];
         };
         loginvc.isSwitch = YES;
         [self.navigationController pushViewController:loginvc animated:YES];
     }else if ([cellConfig.title isEqualToString:@"user"]){
         ZBaseSingleCellModel *cellModel = (ZBaseSingleCellModel *)cellConfig.dataModel;
         ZUser *user = cellModel.data;
         [[ZUserHelper sharedHelper] switchUser:user];
         [self initCellConfigArr];
         [self.iTableView reloadData];
     }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return nil;
    }
    UIView *sectionView = [[UIView alloc] init];
    sectionView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    hintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
    hintLabel.text = @"向心力账号";
    [hintLabel setFont:[UIFont fontSmall]];
    [sectionView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(sectionView.mas_centerY);
    }];
    return sectionView;
}


#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    // darkmodel change
    [self initCellConfigArr];
    [self.iTableView reloadData];
}
@end
