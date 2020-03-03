//
//  ZOrganizationCardAddVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCardAddVC.h"
#import "ZOrganizationCardAddLessonListVC.h"

@interface ZOrganizationCardAddVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIButton *navLeftBtn;

@end

@implementation ZOrganizationCardAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    NSArray *textArr = @[@[@"类型", @"请选择可用课程", @NO, @"rightBlackArrowN", @"type",@30, @""],
                         @[@"名称", @"10字以内", @YES, @"", @"name",@10, @""],
                         @[@"面额", @"0", @YES, @"", @"price",@6, @"元"],
                         @[@"满减条件", @"不填写则无条件限制", @YES, @"", @"tiaojian",@6, @"元"],
                         @[@"有效时间", @"不填写则无时间限制", @NO, @"rightBlackArrowN", @"time", @30, @""],
                         @[@"发行量", @"最大发行量不能超过1000张", @YES, @"", @"num",@3, @"张"],
                         @[@"每人限领", @"0", @YES, @"", @"preNum",@3, @"张"]];
    
    for (int i = 0; i < textArr.count; i++) {
       ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
        cellModel.leftTitle = textArr[i][0];
        cellModel.placeholder = textArr[i][1];
        cellModel.isTextEnabled = [textArr[i][2] boolValue];
        cellModel.rightImage = textArr[i][3];
        cellModel.cellTitle = textArr[i][4];
        cellModel.max = [textArr[i][5] intValue];
        cellModel.rightTitle = textArr[i][6];
        cellModel.isHiddenLine = YES;
        cellModel.cellHeight = CGFloatIn750(110);
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [self.cellConfigArr addObject:textCellConfig];
        
    }
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"卡券状态";
        model.rightTitle = @"默认启用";
        model.isHiddenLine = YES;
        model.leftFont = [UIFont boldFontTitle];
        model.cellHeight = CGFloatIn750(110);
        model.cellTitle = @"status";
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"新增卡券"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
    [self.navigationItem setLeftBarButtonItem:item];
}

- (void)setupMainView {
    [super setupMainView];
   
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFloatIn750(200))];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.iTableView.tableFooterView = bottomView;
    
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(80));
    }];
}


#pragma mark - lazy loading...
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(106), CGFloatIn750(48))];
        [_navLeftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontContent]];
        [_navLeftBtn bk_whenTapped:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _navLeftBtn;
}


- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
//        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"发布优惠券" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            
        }];
    }
    return _bottomBtn;
}


#pragma mark tableView ------delegate-----
-(void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"type"]) {
        ZOrganizationCardAddLessonListVC *lvc = [[ZOrganizationCardAddLessonListVC alloc] init];
        [self.navigationController pushViewController:lvc animated:YES];
    }
}
@end
