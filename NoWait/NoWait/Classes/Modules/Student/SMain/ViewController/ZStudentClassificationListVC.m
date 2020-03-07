//
//  ZStudentClassificationListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentClassificationListVC.h"
#import "ZStudentMainModel.h"
#import "ZStudentMainOrganizationListCell.h"
#import "ZStudentMainFiltrateSectionView.h"

@interface ZStudentClassificationListVC ()
@property (nonatomic,strong) ZStudentMainFiltrateSectionView *sectionView;
@end

@implementation ZStudentClassificationListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgation];
    [self initCellConfigArr];
}

- (void)setNavgation {
    self.isHidenNaviBar = NO;
    
    [self.navigationItem setTitle:self.vcTitle];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < 10; i++) {
        ZStudentOrganizationListModel *model = [[ZStudentOrganizationListModel alloc] init];
        if (i%5 == 0) {
            model.image = @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1gcl9l56hc7j30xc0m8gol.jpg";
        }else if ( i%5 == 1){
            model.image = @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcl9enz0bcj318y0u0h0v.jpg";
        }else if ( i%5 == 2){
            model.image = @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcl90ruhzpj30u011i44s.jpg";
        }else if ( i%5 == 3){
            model.image = @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcl8kmicgrj318y0u0ae4.jpg";
        }else{
            model.image = @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcl8abyp14j30u011g0yz.jpg";
                
        }
        
        ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZStudentMainOrganizationListCell className] title:@"ZStudentMainOrganizationListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMainOrganizationListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:orCellCon1fig];
    }
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.sectionView];
    [self.sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.sectionView.mas_bottom);
    }];
}
#pragma mark - lazy loading
- (ZStudentMainFiltrateSectionView *)sectionView {
    if (!_sectionView) {
//        __weak typeof(self) weakSelf = self;
        _sectionView = [[ZStudentMainFiltrateSectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(88))];
        _sectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorGrayLine]);
        _sectionView.titleSelect = ^(NSInteger index) {
            
        };
    }
    return _sectionView;
}
@end
