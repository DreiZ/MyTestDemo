//
//  ZCircleDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleDetailVC.h"
#import "ZCircleDetailHeaderView.h"
#import "ZCircleDetailBottomView.h"

#import "ZCircleDetailUserCell.h"
#import "ZCircleDetailLabelCell.h"
#import "ZCircleDetailSchoolCell.h"
#import "ZCircleDetailEvaListCell.h"
#import "ZCircleDetailPhotoListCell.h"

#import "ZCircleDetailEvaSectionView.h"

@interface ZCircleDetailVC ()
@property (nonatomic,strong) ZCircleDetailHeaderView *headerView;
@property (nonatomic,strong) ZCircleDetailBottomView *bottomView;

@end

@implementation ZCircleDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.zChain_resetMainView(^{
        self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        self.iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        self.iTableView.layer.cornerRadius = CGFloatIn750(16);
        
        [self.view addSubview:self.headerView];
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(90) + safeAreaTop());
        }];
        
        [self.view addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(90) + safeAreaBottom());
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(30));
            make.top.equalTo(self.headerView.mas_bottom).offset(CGFloatIn750(20));
            make.bottom.equalTo(self.bottomView.mas_top).offset(-CGFloatIn750(20));
        }];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];
        NSMutableArray *section1Arr = @[].mutableCopy;
        {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailUserCell className] title:@"ZCircleDetailUserCell" showInfoMethod:nil heightOfCell:[ZCircleDetailUserCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            
            [section1Arr addObject:menuCellConfig];
        }
        
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title")
            .zz_cellHeight(CGFloatIn750(40))
            .zz_lineHidden(YES)
            .zz_titleLeft(@"迪桑圣诞快乐给你了卡萨丁那个路口时都能分类考试拿过来卡尔安慰范围分为安慰法")
            .zz_leftMultiLine(YES)
            .zz_fontLeft([UIFont boldFontTitle])
            .zz_spaceLine(CGFloatIn750(8))
            .zz_cellWidth(KScreenWidth - CGFloatIn750(60));
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [section1Arr addObject:menuCellConfig];
        }
        {
            NSMutableArray *photos = @[].mutableCopy;
            for (int i = 0; i < 5; i++) {
                ZFileUploadDataModel *dataModel = [[ZFileUploadDataModel alloc] init];
                dataModel.taskType = ZUploadTypeImage;
                dataModel.image_url = @"https://wx2.sinaimg.cn/mw690/7868cc4cly1gbjvdczc04j22c02wsu0y.jpg";
                dataModel.taskType = ZUploadTypeImage;
                dataModel.taskState = ZUploadStateWaiting;
                [photos addObject:dataModel];
            }
            
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailPhotoListCell className] title:@"ZCircleDetailPhotoListCell" showInfoMethod:@selector(setImageList:) heightOfCell:[ZCircleDetailPhotoListCell z_getCellHeight:photos] cellType:ZCellTypeClass dataModel:photos];
            [section1Arr addObject:menuCellConfig];
        }
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"info")
            .zz_cellHeight(CGFloatIn750(42))
            .zz_lineHidden(YES)
            .zz_titleLeft(@"迪桑圣诞快乐给你了卡萨丁那个路口时都能分类考试拿过来卡尔安慰范围分为安慰法迪桑圣诞快乐给你了卡萨丁那个路口时都能分类考试拿过来卡尔安慰范围分为安慰法迪桑圣诞快乐给你了卡萨丁那个路口时都能分类考试拿过来卡尔安慰范围分为安慰法迪桑圣诞快乐给你了卡萨丁那个路口时都能分类考试拿过来卡尔安慰范围分为安慰法迪桑圣诞快乐给你了卡萨丁那个路口时都能分类考试拿过来卡尔安慰范围分为安慰法迪桑圣诞快乐给你了卡萨丁那个路口时都能分类考试拿过来卡尔安慰范围分为安慰法迪桑圣诞快乐给你了卡萨丁那个路口时都能分类考试拿过来卡尔安慰范围分为安慰法迪桑圣诞快乐给你了卡萨丁那个路口时都能分类考试拿过来卡尔安慰范围分为安慰法")
            .zz_leftMultiLine(YES)
            .zz_fontLeft([UIFont fontContent])
            .zz_spaceLine(CGFloatIn750(12))
            .zz_cellWidth(KScreenWidth - CGFloatIn750(60));
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [section1Arr addObject:menuCellConfig];
        }
        
        {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailLabelCell className] title:@"label" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleDetailLabelCell z_getCellHeight:@[@"时高时低",@"告诉对方",@"时低",@"对方"]] cellType:ZCellTypeClass dataModel:@[@"时高时低",@"告诉对方",@"时低",@"对方"]];
            [section1Arr addObject:menuCellConfig];
        }
        {
            [section1Arr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailSchoolCell className] title:@"school" showInfoMethod:nil heightOfCell:[ZCircleDetailSchoolCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            [section1Arr addObject:menuCellConfig];
        }
        [section1Arr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
        
        [self.cellConfigArr addObject:section1Arr];
        
        {
            NSMutableArray *section2Arr = @[].mutableCopy;
            ZOrderEvaListModel *model = [[ZOrderEvaListModel alloc] init];
            model.des = @"读书卡还的上gas电话格拉苏蒂很给力喀什东路kg阿萨德感受到了开发";
            model.student_image = @"https://wx2.sinaimg.cn/mw690/7868cc4cgy1gfyvqm9agkj21sc1sc1l1.jpg";
            model.nick_name = @"都发了哈萨克动感";
            model.update_at = @"123213212";
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailEvaListCell className] title:@"school" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleDetailEvaListCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [section2Arr addObject:menuCellConfig];
            [section2Arr addObject:menuCellConfig];
            [section2Arr addObject:menuCellConfig];
            
            [self.cellConfigArr addObject:section2Arr];
        }
        
    }).zChain_block_setViewForHeaderInSection(^UIView *(UITableView *tableView, NSInteger section) {
        if (section == 1) {
            ZCircleDetailEvaSectionView *sectionView = [[ZCircleDetailEvaSectionView alloc] init];
            
            return sectionView;
        }else {
            return nil;
        }
    }).zChain_block_setHeightForHeaderInSection(^CGFloat(UITableView *tableView, NSInteger section) {
        if (section == 1) {
            return CGFloatIn750(80);
        }
        return 0;
    });
    self.zChain_block_setNumberOfSectionsInTableView(^NSInteger(UITableView *tableView) {
        return self.cellConfigArr.count;
    });
    self.zChain_block_setNumberOfRowsInSection(^NSInteger(UITableView *tableView, NSInteger section) {
        NSArray *sectionArr = self.cellConfigArr[section];
        return sectionArr.count;
    });
    self.zChain_block_setCellForRowAtIndexPath(^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        NSArray *sectionArr = self.cellConfigArr[indexPath.section];
        ZCellConfig *cellConfig = [sectionArr objectAtIndex:indexPath.row];
           ZBaseCell *cell;
        cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
           
        return cell;
    });
    self.zChain_block_setHeightForRowAtIndexPath(^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        NSArray *sectionArr = self.cellConfigArr[indexPath.section];
        ZCellConfig *cellConfig = sectionArr[indexPath.row];
        CGFloat cellHeight =  cellConfig.heightOfCell;
        return cellHeight;
    });
    
    self.zChain_reload_ui();
}

- (ZCircleDetailHeaderView *)headerView {
    if (!_headerView) {
        __weak typeof(self) weakSelf = self;
        _headerView = [[ZCircleDetailHeaderView alloc] init];
        _headerView.handleBlock = ^(NSInteger index) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _headerView.title = @"阿尕十大歌手看到您的开始那棵树的";
    }
    
    return _headerView;
}

- (ZCircleDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[ZCircleDetailBottomView alloc] init];
        _bottomView.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                
            }else if(index == 1){
                
            }else{
                
            }
        };
    }
    return _bottomView;
}
@end
