//
//  ZCircleReleaseVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleReleaseVC.h"
#import "ZCircleReleaseCloseView.h"
#import "ZCircleReleaseTextFieldCell.h"
#import "ZCircleReleaseAddPhotoCell.h"
#import "ZCircleReleaseDetailTextViewCell.h"

#import "ZBaseUnitModel.h"
#import "ZCircleReleaseViewModel.h"

#import "ZCircleReleaseSelectSchoolVC.h"
#import "ZCircleReleaseAddLabelVC.h"
#import "ZOrganizationCampusManagementLocalAddressVC.h"

@interface ZCircleReleaseVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) ZCircleReleaseCloseView *closeView;
@property (nonatomic,strong) ZCircleReleaseViewModel *releaseViewModel;
@end

@implementation ZCircleReleaseVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_updateDataSource(^{
        self.releaseViewModel = [[ZCircleReleaseViewModel alloc] init];
    }).zChain_resetMainView(^{
        [self.view addSubview:self.closeView];
        [self.closeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).offset(safeAreaTop());
            make.height.mas_equalTo(CGFloatIn750(80));
        }];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFloatIn750(180))];
        bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        [self.view addSubview:bottomView];
        [self.view addSubview:self.bottomBtn];
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
            make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
            make.height.mas_equalTo(CGFloatIn750(80));
            make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(20));
        }];
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
            make.height.mas_equalTo(CGFloatIn750(80));
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(bottomView.mas_top);
            make.top.equalTo(self.closeView.mas_bottom);
        }];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];
        
        ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
        cellModel.cellHeight = CGFloatIn750(80);
        cellModel.textAlignment = NSTextAlignmentLeft;
        cellModel.placeholder = @"与众不同的标题会有更多喜欢哦~";
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleReleaseTextFieldCell className] title:@"title" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleReleaseTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [self.cellConfigArr addObject:textCellConfig];
        
        {
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleReleaseAddPhotoCell className] title:@"ZCircleReleaseAddPhotoCell" showInfoMethod:@selector(setImageList:) heightOfCell:[ZCircleReleaseAddPhotoCell z_getCellHeight:self.releaseViewModel.model.imageArr] cellType:ZCellTypeClass dataModel:self.releaseViewModel.model.imageArr];
            [self.cellConfigArr addObject:textCellConfig];
        }
        
        {
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleReleaseDetailTextViewCell className] title:@"ZCircleReleaseDetailTextViewCell" showInfoMethod:nil heightOfCell:[ZCircleReleaseDetailTextViewCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            [self.cellConfigArr addObject:textCellConfig];
        }
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"line")
            .zz_lineHidden(NO)
            .zz_cellHeight(CGFloatIn750(4));
            
             ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

             [self.cellConfigArr  addObject:menuCellConfig];
        }
        {
            NSString *label = @"添加标签";
            NSString *labelHad = @"0";
            if (ValidArray(self.releaseViewModel.model.labelArr)) {
                for (int i = 0; i < self.releaseViewModel.model.labelArr.count; i++) {
                    if (i == 0) {
                        label = [NSString stringWithFormat:@"%@",self.releaseViewModel.model.labelArr[i]];
                    }else {
                        label = [NSString stringWithFormat:@"%@，%@",label,self.releaseViewModel.model.labelArr[i]];
                    }
                }
                labelHad = @"1";
            }
            
            NSString *address = @"所在位置";
            NSString *addressHad = @"0";
            if (ValidStr(self.releaseViewModel.model.address)) {
                address = self.releaseViewModel.model.address;
                addressHad = @"1";
            }
            
            NSString *stores_name = @"校区打卡";
            NSString *stores_nameHad = @"0";
            if (ValidStr(self.releaseViewModel.model.stores_name)) {
                stores_name = self.releaseViewModel.model.stores_name;
                stores_nameHad = @"1";
            }
            
            NSArray *tempArr = @[@[@"finderLabelNo",label,@"rightBlackArrowN",labelHad,@"finderLabel"],
            @[@"finderLocationNo",address,@"rightBlackArrowN",addressHad,@"finderLocationGreen"],
            @[@"finderSchoolNo",stores_name,@"rightBlackArrowN",stores_nameHad,@"finderSchool"]];
            
            [tempArr enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(obj[0])
                .zz_titleLeft(obj[1])
                .zz_imageLeft(obj[0])
                .zz_lineHidden(NO)
                .zz_cellHeight(CGFloatIn750(84))
                .zz_imageRight(obj[2])
                .zz_leftMultiLine(YES)
                .zz_imageRightHeight(CGFloatIn750(14))
                .zz_imageLeftHeight(CGFloatIn750(28))
                .zz_spaceLine(CGFloatIn750(8))
                .zz_imageLeftWidth(CGFloatIn750(28));
                if ([obj[3] intValue] == 1) {
                    model.zz_colorLeft([UIColor colorMain])
                    .zz_colorDarkBack([UIColor colorMain])
                    .zz_imageLeft(obj[4]);
                }else {
                    model.zz_colorLeft([UIColor colorTextBlack])
                    .zz_colorDarkBack([UIColor colorTextBlackDark])
                    .zz_imageLeft(obj[0]);
                }
                
                 ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

                 [self.cellConfigArr  addObject:menuCellConfig];
            }];
        }
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZCircleReleaseAddPhotoCell"]) {
            ZCircleReleaseAddPhotoCell *lcell = (ZCircleReleaseAddPhotoCell *)cell;
            lcell.addBlock = ^{
                [[ZImagePickerManager sharedManager] setVideoWithMaxCount:9 - self.releaseViewModel.model.imageArr.count SelectMenu:^(NSArray<ZImagePickerModel *> *list) {
                    if (list && list.count > 0){
                        for (ZImagePickerModel *model in list) {
                            ZFileUploadDataModel *dataModel = [[ZFileUploadDataModel alloc] init];
                            if (model.isVideo) {
                                dataModel.image = model.image;
                                dataModel.taskType = ZUploadTypeVideo;
                                dataModel.asset = model.asset;
                                dataModel.taskState = ZUploadStateWaiting;
        //                            dataModel.filePath = [model.mediaURL absoluteString];
                            }else{
                                dataModel.image = model.image;
                                dataModel.asset = model.asset;
                                dataModel.taskType = ZUploadTypeImage;
                                dataModel.taskState = ZUploadStateWaiting;
                            }

                            [weakSelf.releaseViewModel.model.imageArr addObject:dataModel];
                        }
                        self.zChain_reload_ui();
                    }
                }];
            };
        }else if([cellConfig.title isEqualToString:@"ZCircleReleaseDetailTextViewCell"]){
            ZCircleReleaseDetailTextViewCell *lcell = (ZCircleReleaseDetailTextViewCell *)cell;
            lcell.max = 1500;
            lcell.content = self.releaseViewModel.model.content;
            lcell.textChangeBlock = ^(NSString *text) {
                DLog(@"text change %@",text);
                self.releaseViewModel.model.content = text;
            };
        }else if([cellConfig.title isEqualToString:@"title"]){
            ZCircleReleaseTextFieldCell *lcell = (ZCircleReleaseTextFieldCell *)cell;
            lcell.valueChangeBlock = ^(NSString * text) {
                self.releaseViewModel.model.title = text;
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"finderLabelNo"]) {
            ZCircleReleaseAddLabelVC *lvc = [[ZCircleReleaseAddLabelVC alloc] init];
            lvc.list = self.releaseViewModel.model.labelArr;
            lvc.handleBlock = ^(NSArray *lableArr) {
                [self.releaseViewModel.model.labelArr removeAllObjects];
                [self.releaseViewModel.model.labelArr addObjectsFromArray:lableArr];
                self.zChain_reload_ui();
            };
            [self.navigationController pushViewController:lvc animated:YES];
        }else if ([cellConfig.title isEqualToString:@"finderLocationNo"]) {
            ZOrganizationCampusManagementLocalAddressVC *avc = [[ZOrganizationCampusManagementLocalAddressVC alloc] init];
            avc.addressBlock = ^(NSString *province, NSString *city, NSString *county, NSString *brief_address, NSString *address,double latitude, double longitude) {
                weakSelf.releaseViewModel.model.province = province;
                weakSelf.releaseViewModel.model.city = city;
                weakSelf.releaseViewModel.model.county = county;
                weakSelf.releaseViewModel.model.brief_address = brief_address;
                weakSelf.releaseViewModel.model.address = address;
                weakSelf.releaseViewModel.model.latitude = latitude;
                weakSelf.releaseViewModel.model.longitude = longitude;
                weakSelf.zChain_reload_ui();
            };
            [self.navigationController pushViewController:avc animated:YES];
        }else if ([cellConfig.title isEqualToString:@"finderSchoolNo"]) {
            ZCircleReleaseSelectSchoolVC *svc = [[ZCircleReleaseSelectSchoolVC alloc] init];
            [self.navigationController pushViewController:svc animated:YES];
        }
    });
    
    self.zChain_reload_ui();
}


#pragma mark - lazy loading...
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
//        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"发布" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

- (ZCircleReleaseCloseView *)closeView {
    if (!_closeView) {
        __weak typeof(self) weakSelf = self;
        _closeView = [[ZCircleReleaseCloseView alloc] init];
        _closeView.backBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    
    return _closeView;
}
@end
