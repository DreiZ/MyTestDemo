//
//  ZOrganizationStudentUpStarVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationStudentUpStarVC.h"
#import "ZOriganizationTeachListCell.h"
#import "ZAddPhotosCell.h"
#import "ZOrganizationLessonAddPhotosCell.h"
#import "ZOriganizationTextViewCell.h"
#import "ZOriganizationIDCardCell.h"
#import "ZOrganizationCampusTextLabelCell.h"

#import "ZBaseUnitModel.h"
#import "ZAlertDataSinglePickerView.h"
#import "ZAlertDataPickerView.h"

#import "ZOrganizationCampusManageAddLabelVC.h"
#import "ZOrganizationTeacherLessonSelectVC.h"
#import "ZOriganizationStudentViewModel.h"
#import "ZOriganizationLessonViewModel.h"

@interface ZOrganizationStudentUpStarVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) NSString *des;
@property (nonatomic,strong) UIView *bottomView;

@end

@implementation ZOrganizationStudentUpStarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _images = @[].mutableCopy;
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"学员风采";
        model.leftFont = [UIFont boldFontTitle];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(92);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTextViewCell className] title:[ZOriganizationTextViewCell className] showInfoMethod:@selector(setIsBackColor:) heightOfCell:CGFloatIn750(274) cellType:ZCellTypeClass dataModel:@"yes"];
        
        [self.cellConfigArr addObject:textCellConfig];
        
        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:bottomCellConfig];
        
    }
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"学员风采";
        model.leftFont = [UIFont boldFontTitle];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(92);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
        
    {
        ZBaseMenuModel *model = [[ZBaseMenuModel alloc] init];
        NSMutableArray *menulist = @[].mutableCopy;
        for (int j = 0; j < self.images.count; j++) {
            ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
            if (j < _images.count) {
                if (![_images[j] isKindOfClass:[UIImage class]]) {
                    model.data = imageFullUrl(_images[j]);
                }else{
                    model.data = _images[j];
                }
                model.uid = [NSString stringWithFormat:@"%d", j];
            }
            
            model.isEdit = YES;
            [menulist addObject:model];
        }
        model.uid = @"9";
        model.name = @"添加图片";
        model.subName = @"选填";
        model.units = menulist;
        
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZAddPhotosCell className] title:[ZAddPhotosCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZAddPhotosCell z_getCellHeight:menulist] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:progressCellConfig];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"升级明星学员"];
}

- (void)setupMainView {
    [super setupMainView];
    
    self.iTableView.tableFooterView = self.bottomView;
}

#pragma mark lazy loading...
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(160))];
        _bottomView.layer.masksToBounds = YES;
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        [_bottomView addSubview:self.bottomBtn];
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(60));
            make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-60));
            make.height.mas_equalTo(CGFloatIn750(80));
            make.centerY.equalTo(self.bottomView.mas_centerY);
        }];
    }
    return _bottomView;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            if (!ValidStr(self.des)) {
                [TLUIUtility showErrorHint:@"您还没有填写任何内容"];
                return ;
            }
            [weakSelf updatePhotosStep1WithOtherParams:@{}.mutableCopy];
        }];
    }
    return _bottomBtn;
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZAddPhotosCell"]) {
        ZAddPhotosCell *tCell = (ZAddPhotosCell *)cell;
        tCell.seeBlock = ^(NSInteger index) {
            [[ZPhotoManager sharedManager] showBrowser:weakSelf.images withIndex:index];
        } ;
        
        tCell.menuBlock = ^(NSInteger index, BOOL isAdd) {
            [weakSelf.iTableView endEditing:YES];
            if (isAdd) {
                [ZPhotoManager sharedManager].maxImageSelected = 9 - weakSelf.images.count;
                
                [[ZPhotoManager sharedManager] showSelectMenu:^(NSArray<LLImagePickerModel *> *list) {
                    if (list && list.count > 0){;
                        for (LLImagePickerModel *model in list) {
                            [weakSelf.images addObject:model.image];
                        }
                        [weakSelf initCellConfigArr];
                        [weakSelf.iTableView reloadData];
                    }
                }];
            }else{
                if (index < weakSelf.images.count) {
                    [weakSelf.images removeObjectAtIndex:index];
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                }
            }
        };
    }else if ([cellConfig.title isEqualToString:@"ZOriganizationTextViewCell"]){
        ZOriganizationTextViewCell *lcell = (ZOriganizationTextViewCell *)cell;
        lcell.max = 400;
        lcell.hint = @"说点什么吧";
        lcell.textChangeBlock = ^(NSString * text) {
            weakSelf.des = text;
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    
}

- (NSInteger)checkIsHavePhotos {
    NSInteger index = 0;
    for (int i = 0; i < self.images.count; i++) {
        id temp = self.images[i];
        if ([temp isKindOfClass:[UIImage class]]) {
            index++;
        }else if ([temp isKindOfClass:[NSString class]]){
            NSString *tempStr = temp;
            if (tempStr.length > 0) {
                index++;
            }
        }
    }
    return index;
}

- (void)updatePhotosStep1WithOtherParams:(NSMutableDictionary *)otherDict {
    if ([self checkIsHavePhotos] > 0) {
        [TLUIUtility showLoading:@"上传课程相册中"];
        NSInteger tindex = 0;
        [self updatePhotosStep2WithImage:tindex otherParams:otherDict];
    }else{
        [self updateOtherDataWithParams:otherDict];
    }
    
}

 - (void)updatePhotosStep2WithImage:(NSInteger)index otherParams:(NSMutableDictionary *)otherDict {
     [self updatePhotosStep3WithImage:index otherParams:otherDict complete:^(BOOL isSuccess, NSInteger index) {
         if (index == self.images.count-1) {
             [self updateOtherDataWithParams:otherDict];
         }else{
             index++;
             [self updatePhotosStep2WithImage:index otherParams:otherDict];
         }
    }];
}

- (void)updatePhotosStep3WithImage:(NSInteger)index otherParams:(NSMutableDictionary *)otherDict complete:(void(^)(BOOL, NSInteger))complete{
    [TLUIUtility showLoading:[NSString stringWithFormat:@"上传图片中 %ld/%ld",index+1,self.images.count]];
    
    id temp = self.images[index];
    UIImage *image;
    if ([temp isKindOfClass:[UIImage class]]) {
        image = temp;
       
    }
    if (!image) {
        complete(YES,index);
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel uploadImageList:@{@"type":@"3",@"imageKey":@{@"file":image}} completeBlock:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            [weakSelf.images replaceObjectAtIndex:index withObject:message];
            complete(YES,index);
        }else{
            [TLUIUtility hiddenLoading];
            [TLUIUtility showErrorHint:message];
        }
    }];
}


- (void)updateOtherDataWithParams:(NSMutableDictionary *)otherDict {
    if (ValidStr(self.addModel.studentID)) {
        [otherDict setObject:self.addModel.studentID  forKey:@"id"];
    }
    
    [otherDict setObject:self.des forKey:@"specialty_desc"];
    if ([self checkIsHavePhotos] > 0) {
        NSMutableArray *photos = @[].mutableCopy;
        for (int i = 0; i < self.images.count; i++) {
            NSString *temp = self.images[i];
            if (ValidStr(temp)) {
                [photos addObject:temp];
            }
        }
        if (photos.count > 0) {
            [otherDict setObject:photos forKey:@"images"];
        }
    }
    
    [TLUIUtility showLoading:@"上传其他数据"];
    [ZOriganizationStudentViewModel starStudent:otherDict completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [self.navigationController popViewControllerAnimated:YES];
            return ;
        }else {
            [TLUIUtility showErrorHint:message];
        }
    }];
}

@end
