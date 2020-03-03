//
//  ZOrganizationCardAddLessonListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCardAddLessonListVC.h"

@interface ZOrganizationCardAddLessonListVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;

@end

@implementation ZOrganizationCardAddLessonListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"课程名称1234";
        model.rightImage = @"unSelectedCycle";
        model.isHiddenLine = YES;
        model.leftFont = [UIFont fontTitle];
        model.cellHeight = CGFloatIn750(110);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
    }
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"选择课程"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
    [self.navigationItem setRightBarButtonItem:item];
}


#pragma mark - lazy loading...
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(106), CGFloatIn750(48))];
        [_navLeftBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontContent]];
        [_navLeftBtn bk_whenTapped:^{
        }];
    }
    return _navLeftBtn;
}


#pragma mark tableView ------delegate-----
-(void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"sex"]) {
       
    }
}
@end








