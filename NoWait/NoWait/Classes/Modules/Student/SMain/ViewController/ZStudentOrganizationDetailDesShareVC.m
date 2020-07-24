//
//  ZStudentOrganizationDetailDesShareVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailDesShareVC.h"
#import "ZStudentOrganizationDetailIntroLabelCell.h"
#import "ZStudentShareQrcodeCell.h"
#import "ZStudentShareImageCell.h"
#import "ZUMengShareManager.h"

#import "ZShareView.h"

@interface ZStudentOrganizationDetailDesShareVC ()

@end

@implementation ZStudentOrganizationDetailDesShareVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.isHidenNaviBar = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_resetMainView(^{
        self.iTableView.scrollEnabled = NO;
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        CGFloat cellHeight = 0;
        {
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(60))];
            cellHeight = cellHeight + CGFloatIn750(60);
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title")
            .zz_cellHeight(CGFloatIn750(60))
            .zz_marginLeft(CGFloatIn750(70))
            .zz_lineHidden(YES)
            .zz_fontLeft([UIFont boldFontContent])
            .zz_titleRight(@"似锦APP")
            .zz_alignmentRight(NSTextAlignmentRight)
            .zz_fontRight([UIFont boldSystemFontOfSize:CGFloatIn750(40)])
            .zz_colorRight([UIColor colorTextBlack])
            .zz_colorDarkRight([UIColor colorTextBlackDark]);
            
            ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [weakSelf.cellConfigArr addObject:titleCellConfig];
            
            cellHeight = cellHeight + CGFloatIn750(60);
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(58))];
            
            cellHeight = cellHeight + CGFloatIn750(58);
            
            ZCellConfig *imageCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentShareImageCell className] title:@"image" showInfoMethod:@selector(setImage:) heightOfCell:KScreenHeight > 736 ? CGFloatIn750(360):CGFloatIn750(280) cellType:ZCellTypeClass dataModel:self.detailModel.image];
            [weakSelf.cellConfigArr addObject:imageCellConfig];
            
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
            cellHeight = cellHeight + (KScreenHeight > 736 ? CGFloatIn750(360):CGFloatIn750(280));
            cellHeight = cellHeight + CGFloatIn750(40);
            
            ZLineCellModel *priceModel = ZLineCellModel.zz_lineCellModel_create(@"title")
            .zz_cellHeight(CGFloatIn750(60))
            .zz_marginLeft(CGFloatIn750(30))
            .zz_lineHidden(YES)
            .zz_fontLeft([UIFont boldSystemFontOfSize:CGFloatIn750(36)])
            .zz_titleLeft([NSString stringWithFormat:@"%@",weakSelf.detailModel.name]);
            
            ZCellConfig *priceCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(60) cellType:ZCellTypeClass dataModel:priceModel];
            [weakSelf.cellConfigArr addObject:priceCellConfig];
            cellHeight = cellHeight + CGFloatIn750(60);
            
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            cellHeight = cellHeight + CGFloatIn750(20);
            if (ValidArray(weakSelf.detailModel.stores_info) || ValidArray(weakSelf.detailModel.merchants_stores_tags)){
                ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
                mModel.rightFont = [UIFont fontContent];
                mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
                mModel.singleCellHeight = CGFloatIn750(60);
                mModel.cellHeight = CGFloatIn750(62);
                mModel.isHiddenLine = YES;
                NSMutableArray *labelArr = @[].mutableCopy;
                if (ValidArray(weakSelf.detailModel.stores_info)) {
                    [labelArr addObjectsFromArray:weakSelf.detailModel.stores_info];
                }
                if (ValidArray(weakSelf.detailModel.merchants_stores_tags)) {
                    [labelArr addObjectsFromArray:weakSelf.detailModel.merchants_stores_tags];
                }
                mModel.data = labelArr;
                mModel.cellTitle = @"tag";
                mModel.leftFont = [UIFont fontMax1Title];
                mModel.rightColor = [UIColor colorMain];
                mModel.rightDarkColor = [UIColor colorMainSub];
                ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailIntroLabelCell className] title:mModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationDetailIntroLabelCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
                [weakSelf.cellConfigArr addObject:textCellConfig];
                
                cellHeight = cellHeight + [ZStudentOrganizationDetailIntroLabelCell z_getCellHeight:mModel];
            }
            
            if (ValidArray(weakSelf.detailModel.coupons_list)){
                NSMutableArray *coupons = @[].mutableCopy;
                for (ZOriganizationCardListModel *cartModel in weakSelf.detailModel.coupons_list) {
                    [coupons addObject:cartModel.title];
                }
                ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
                mModel.rightFont = [UIFont fontContent];
                mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
                mModel.singleCellHeight = CGFloatIn750(60);
                mModel.cellHeight = CGFloatIn750(62);
                mModel.isHiddenLine = YES;
                mModel.data = coupons;
                mModel.cellTitle = @"label";
                mModel.leftFont = [UIFont fontMax1Title];
                mModel.rightColor = [UIColor colorRedForLabel];
                mModel.rightDarkColor = [UIColor colorRedForLabelSub];
                ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailIntroLabelCell className] title:mModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationDetailIntroLabelCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
                [weakSelf.cellConfigArr addObject:textCellConfig];
                
                cellHeight = cellHeight + [ZStudentOrganizationDetailIntroLabelCell z_getCellHeight:mModel];
            }
            
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            
            cellHeight = cellHeight + CGFloatIn750(40);
            ZLineCellModel *timeModel = ZLineCellModel.zz_lineCellModel_create(@"address")
            .zz_cellHeight(CGFloatIn750(60))
            .zz_marginLeft(CGFloatIn750(30))
            .zz_leftMultiLine(YES)
            .zz_lineHidden(YES)
            .zz_fontLeft([UIFont fontSmall])
            .zz_colorLeft([UIColor colorTextGray])
            .zz_colorDarkLeft([UIColor colorTextGrayDark])
            .zz_titleLeft([NSString stringWithFormat:@"%@%@",self.detailModel.brief_address,self.detailModel.address]);
            
            ZCellConfig *timeCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:timeModel] cellType:ZCellTypeClass dataModel:timeModel];
            [weakSelf.cellConfigArr addObject:timeCellConfig];
            
            cellHeight = cellHeight + [ZBaseLineCell z_getCellHeight:timeModel];
            
            ZLineCellModel *numModel = ZLineCellModel.zz_lineCellModel_create(@"num")
            .zz_cellHeight(CGFloatIn750(40))
            .zz_marginLeft(CGFloatIn750(30))
            .zz_lineHidden(YES)
            .zz_colorLeft([UIColor colorTextGray])
            .zz_colorDarkLeft([UIColor colorTextGrayDark])
            .zz_fontLeft([UIFont fontSmall])
            .zz_titleLeft([NSString stringWithFormat:@"营业时间：%@~%@",self.detailModel.opend_start,weakSelf.detailModel.opend_end]);
            
            ZCellConfig *numCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:numModel];
            [weakSelf.cellConfigArr addObject:numCellConfig];
            
            cellHeight = cellHeight + CGFloatIn750(40);
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            cellHeight = cellHeight + CGFloatIn750(20);
            
            CGFloat spaceHeigh = KScreenHeight - kTopHeight - cellHeight - CGFloatIn750(140) - CGFloatIn750(160);
            if (spaceHeigh < 0) {
                spaceHeigh = 1;
            }
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(spaceHeigh)];
            
            ZCellConfig *qrcodeCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentShareQrcodeCell className] title:@"qrcode" showInfoMethod:@selector(setImage:) heightOfCell:CGFloatIn750(140) cellType:ZCellTypeClass dataModel:nil];
            [weakSelf.cellConfigArr addObject:qrcodeCellConfig];
        }
    });
    self.zChain_reload_ui();
    
    [self setCoverImageView];
    [self showShare];
}


- (void)setCoverImageView {
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.image = [UIImage imageNamed:@"shareLesson2"];
    topImageView.layer.masksToBounds = YES;
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iTableView.mas_left);
        make.top.equalTo(self.iTableView.mas_top);
        make.width.mas_equalTo(CGFloatIn750(154));
        make.height.mas_equalTo(CGFloatIn750(176));
    }];
    
    UIImageView *bottomImageView = [[UIImageView alloc] init];
    bottomImageView.image = [UIImage imageNamed:@"shareLesson3"];
    bottomImageView.layer.masksToBounds = YES;
    [self.view addSubview:bottomImageView];
    [bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iTableView.mas_left).offset(CGFloatIn750(34));
        make.bottom.equalTo(self.iTableView.mas_bottom).offset(-CGFloatIn750(100));
        make.width.mas_equalTo(CGFloatIn750(236));
        make.height.mas_equalTo(CGFloatIn750(136));
    }];
    
    UIImageView *rightImageView = [[UIImageView alloc] init];
    rightImageView.image = [UIImage imageNamed:@"shareLesson1"];
    rightImageView.layer.masksToBounds = YES;
    [self.view addSubview:rightImageView];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.iTableView.mas_right).offset(-CGFloatIn750(34));
        make.top.equalTo(self.iTableView.mas_top).offset(CGFloatIn750(60 + 58 +  80)+(KScreenHeight > 736 ? CGFloatIn750(360):CGFloatIn750(280)));
        make.width.mas_equalTo(CGFloatIn750(112));
        make.height.mas_equalTo(CGFloatIn750(130));
    }];

    [self setNavRight];
}

- (void)setNavRight {
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    [sureBtn setTitle:@"分享" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont fontSmall]];
    [sureBtn bk_addEventHandler:^(id sender) {
        [self showShare];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:sureBtn]];
}

- (void)showShare {
    [ZShareView setPre_title:@"分享" reduce_weight:[NSString stringWithFormat:@"（%@）",self.detailModel.name] after_title:@"到微信" handlerBlock:^(NSInteger index) {
        UIImage *shareImage = [ZPublicTool snapshotForView:self.iTableView];
        [[ZUMengShareManager sharedManager] shareUIWithType:index image:shareImage vc:self];
    }];
}
@end

