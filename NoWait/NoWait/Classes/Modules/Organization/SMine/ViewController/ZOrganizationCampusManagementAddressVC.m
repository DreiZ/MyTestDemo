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
 
    NSArray *tempArr = @[@"选择地址", @"详细地址"];
    NSArray *tempTitleArr = @[@"local", @"text"];
    for (int i = 0; i < tempArr.count; i++) {
        if (i == 0) {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(tempTitleArr[i]);
            model.zz_titleLeft(tempArr[0]);
            model.zz_titleRight([NSString stringWithFormat:@"%@",SafeStr(self.address)].length > 0 ? [NSString stringWithFormat:@"%@",SafeStr(self.brief_address)] : @"请选择地址");
            model.zz_lineHidden(YES);
            model.zz_cellHeight(CGFloatIn750(118));
            model.zz_fontLeft([UIFont boldFontTitle]);
            model.zz_imageRight(@"hnglocaladdress");
            model.zz_imageRightHeight(CGFloatIn750(20));
            model.zz_rightMultiLine(YES);
           
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }else{
            ZBaseTextFieldCellModel *model = [[ZBaseTextFieldCellModel alloc] init];
            model.leftTitle = tempArr[i];
            model.placeholder = tempArr[i];
            model.content = self.address;
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
            model.max = 50;
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"校区地址"];
    
    __weak typeof(self) weakSelf = self;
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont fontSmall]];
    [sureBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.addressBlock) {
            weakSelf.addressBlock(weakSelf.province, weakSelf.city, weakSelf.county, weakSelf.brief_address, weakSelf.address,weakSelf.latitude,weakSelf.longitude);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:sureBtn]];
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
     if ([cellConfig.title isEqualToString:@"local"]){
         ZOrganizationCampusManagementLocalAddressVC *avc = [[ZOrganizationCampusManagementLocalAddressVC alloc] init];
         avc.addressBlock = ^(NSString *province, NSString *city, NSString *county, NSString *brief_address, NSString *address,double latitude, double longitude) {
             weakSelf.province = province;
             weakSelf.city = city;
             weakSelf.county = county;
             weakSelf.brief_address = brief_address;
             weakSelf.address = address;
             weakSelf.latitude = latitude;
             weakSelf.longitude = longitude;
             [weakSelf initCellConfigArr];
             [weakSelf.iTableView reloadData];
         };
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
