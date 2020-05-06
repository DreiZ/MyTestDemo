//
//  ZRewardRankingVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZRewardRankingVC.h"
#import "ZRewardRankingCell.h"
#import "ZRewardRankingBottomView.h"

@interface ZRewardRankingVC ()
@property (nonatomic,strong) ZRewardRankingBottomView *bottomView;

@end

@implementation ZRewardRankingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"奖励排行"];
}

- (void)setupMainView {
    [super setupMainView];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(120));
        make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

#pragma mark - lazy loading
- (ZRewardRankingBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[ZRewardRankingBottomView alloc] init];
        
    }
    return _bottomView;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZRewardRankingCell className] title:@"ZRewardRankingCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZRewardRankingCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];

    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:menuCellConfig];
    
}
@end
