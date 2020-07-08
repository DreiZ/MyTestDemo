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

#import <IQKeyboardManager.h>
#import "XHInputView.h"

@interface ZCircleDetailVC ()<XHInputViewDelagete>
@property (nonatomic,strong) ZCircleDetailHeaderView *headerView;
@property (nonatomic,strong) ZCircleDetailBottomView *bottomView;

@end

@implementation ZCircleDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

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
            .zz_spaceLine(CGFloatIn750(16))
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
    }).zChain_block_setNumberOfSectionsInTableView(^NSInteger(UITableView *tableView) {
        return self.cellConfigArr.count;
    }).zChain_block_setNumberOfRowsInSection(^NSInteger(UITableView *tableView, NSInteger section) {
        NSArray *sectionArr = self.cellConfigArr[section];
        return sectionArr.count;
    }).zChain_block_setCellForRowAtIndexPath(^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        NSArray *sectionArr = self.cellConfigArr[indexPath.section];
        ZCellConfig *cellConfig = [sectionArr objectAtIndex:indexPath.row];
           ZBaseCell *cell;
        cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
           
        return cell;
    }).zChain_block_setHeightForRowAtIndexPath(^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
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
        __weak typeof(self) weakSelf = self;
        _bottomView = [[ZCircleDetailBottomView alloc] init];
        _bottomView.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                [weakSelf showXHInputViewWithStyle:InputViewStyleLarge];
            }else if(index == 1){
                
            }else{
                
            }
        };
    }
    return _bottomView;
}


-(void)showXHInputViewWithStyle:(InputViewStyle)style{
    
    [XHInputView showWithStyle:style configurationBlock:^(XHInputView *inputView) {
        /** 请在此block中设置inputView属性 */
        
        /** 代理 */
        inputView.delegate = self;
        inputView.font = [UIFont fontContent];
        inputView.placeholderColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        inputView.sendButtonBackgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        inputView.sendButtonFont = [UIFont fontTitle];
        inputView.sendButtonTitle = @"发布";
        
        /** 占位符文字 */
        inputView.placeholder = @"评论：嘴巴嘟嘟的舞蹈学校";
        /** 设置最大输入字数 */
        inputView.maxCount = 1200;
        /** 输入框颜色 */
        inputView.textViewBackgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        /** 更多属性设置,详见XHInputView.h文件 */
        
    } sendBlock:^BOOL(NSString *text) {
        if(text.length){
            NSLog(@"输入的信息为:%@",text);
//            _textLab.text = text;
            return YES;//return YES,收起键盘
        }else{
            NSLog(@"显示提示框-请输入要评论的的内容");
            return NO;//return NO,不收键盘
        }
    }];
    
}

#pragma mark - XHInputViewDelagete
/** XHInputView 将要显示 */
-(void)xhInputViewWillShow:(XHInputView *)inputView{
    
     /** 如果你工程中有配置IQKeyboardManager,并对XHInputView造成影响,请在XHInputView将要显示时将其关闭 */
    
     [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
     [IQKeyboardManager sharedManager].enable = NO;

}

/** XHInputView 将要影藏 */
-(void)xhInputViewWillHide:(XHInputView *)inputView{
    
     /** 如果你工程中有配置IQKeyboardManager,并对XHInputView造成影响,请在XHInputView将要影藏时将其打开 */
    
     [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
     [IQKeyboardManager sharedManager].enable = YES;
}
@end
