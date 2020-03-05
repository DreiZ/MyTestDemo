//
//  ZOrganizationCampusManagementAddressVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCampusManagementAddressVC.h"
#import "ZBaseCellModel.h"
#import "ZOrganizationCampusManagementLocalAddressVC.h"

@interface ZOrganizationCampusManagementAddressVC ()

@end

@implementation ZOrganizationCampusManagementAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
 
    NSArray *tempArr = @[@"选择地址",@"地标信息", @"所属场所"];
    NSArray *tempTitleArr = @[@"local",@"text", @"text"];
    for (int i = 0; i < tempArr.count; i++) {
        ZBaseTextFieldCellModel *model = [[ZBaseTextFieldCellModel alloc] init];
        model.leftTitle = tempArr[i];
        model.placeholder = tempArr[i];
        //        model.subitle = @"(必选)";
        model.leftContentWidth = CGFloatIn750(0);
        model.isHiddenInputLine = YES;
        model.textAlignment = NSTextAlignmentLeft;
        model.cellHeight = CGFloatIn750(120);
        model.cellTitle = tempTitleArr[i];
        if (i == 0) {
            model.rightImage = @"hnglocaladdress";
            model.rightImageWidth = CGFloatIn750(10);
            model.isTextEnabled = NO;
        }

        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"校区地址"];
    
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = [UIColor  colorMain];
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont fontSmall]];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:sureBtn]];
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
//    __weak typeof(self) weakSelf = self;
     if ([cellConfig.title isEqualToString:@"local"]){
         ZOrganizationCampusManagementLocalAddressVC *avc = [[ZOrganizationCampusManagementLocalAddressVC alloc] init];
         [self.navigationController pushViewController:avc animated:YES];
     }else if ([cellConfig.title isEqualToString:@"user"]){
        
     }
}

#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    // darkmodel change
    [self initCellConfigArr];
    [self.iTableView reloadData];
}
@end
