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

#import "ZBaseUnitModel.h"

@interface ZCircleReleaseVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) ZCircleReleaseCloseView *closeView;

@property (nonatomic,strong) NSMutableArray *imageList;

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
        self.imageList = @[].mutableCopy;
    });
    
    self.zChain_resetMainView(^{
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
    });
    self.zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];
        
        ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
        cellModel.cellHeight = CGFloatIn750(80);
        cellModel.textAlignment = NSTextAlignmentLeft;
        cellModel.placeholder = @"与众不同的标题会有更多喜欢哦~";
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleReleaseTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleReleaseTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [self.cellConfigArr addObject:textCellConfig];
        
        {
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleReleaseAddPhotoCell className] title:@"ZCircleReleaseAddPhotoCell" showInfoMethod:@selector(setImageList:) heightOfCell:[ZCircleReleaseAddPhotoCell z_getCellHeight:self.imageList] cellType:ZCellTypeClass dataModel:self.imageList];
            [self.cellConfigArr addObject:textCellConfig];
        }
    });
    self.zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZCircleReleaseAddPhotoCell"]) {
            ZCircleReleaseAddPhotoCell *lcell = (ZCircleReleaseAddPhotoCell *)cell;
            lcell.addBlock = ^{
                [[ZImagePickerManager sharedManager] setVideoWithMaxCount:9 - self.imageList.count SelectMenu:^(NSArray<ZImagePickerModel *> *list) {
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

                            [weakSelf.imageList addObject:dataModel];
                        }
                        self.zChain_reload_ui();
                    }
                }];
            };
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
