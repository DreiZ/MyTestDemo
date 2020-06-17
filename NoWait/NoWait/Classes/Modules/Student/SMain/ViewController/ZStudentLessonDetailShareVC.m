//
//  ZStudentLessonDetailShareVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonDetailShareVC.h"
#import "ZStudentShareQrcodeCell.h"
#import "ZStudentShareImageCell.h"
#import "ZUMengShareManager.h"

#import "ZShareView.h"

@interface ZStudentLessonDetailShareVC ()

@end

@implementation ZStudentLessonDetailShareVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.isHidenNaviBar = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zChain_resetMainView(^{
        self.iTableView.scrollEnabled = NO;
    });
    self.zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];
        CGFloat cellHeight = 0;
        {
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(60))];
            
            cellHeight = cellHeight + CGFloatIn750(60);
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title")
            .zz_cellHeight(CGFloatIn750(60))
            .zz_marginLeft(CGFloatIn750(70))
            .zz_fontLeft([UIFont boldFontContent])
            .zz_titleRight(@"似锦APP")
            .zz_alignmentRight(NSTextAlignmentRight)
            .zz_fontRight([UIFont boldSystemFontOfSize:CGFloatIn750(40)])
            .zz_colorRight([UIColor colorTextBlack])
            .zz_colorDarkRight([UIColor colorTextBlackDark]);
            
            ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:titleCellConfig];
            
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(58))];
            cellHeight = cellHeight + CGFloatIn750(60);
            cellHeight = cellHeight + CGFloatIn750(58);
            
            ZCellConfig *imageCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentShareImageCell className] title:@"image" showInfoMethod:@selector(setImage:) heightOfCell:CGFloatIn750(360) cellType:ZCellTypeClass dataModel:self.addModel.image_url];
            [self.cellConfigArr addObject:imageCellConfig];
            
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
            cellHeight = cellHeight + CGFloatIn750(360);
            cellHeight = cellHeight + CGFloatIn750(40);
            
            ZLineCellModel *priceModel = ZLineCellModel.zz_lineCellModel_create(@"title")
            .zz_cellHeight(CGFloatIn750(60))
            .zz_marginLeft(CGFloatIn750(30))
            .zz_fontLeft([UIFont boldSystemFontOfSize:CGFloatIn750(56)])
            .zz_titleLeft([NSString stringWithFormat:@"体验价￥%@",self.addModel.experience_price]);
            
            ZCellConfig *priceCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(60) cellType:ZCellTypeClass dataModel:priceModel];
            [self.cellConfigArr addObject:priceCellConfig];
            
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            cellHeight = cellHeight + CGFloatIn750(60);
            cellHeight = cellHeight + CGFloatIn750(20);
            
            ZLineCellModel *nameModel = ZLineCellModel.zz_lineCellModel_create(@"name")
            .zz_cellHeight(CGFloatIn750(60))
            .zz_marginLeft(CGFloatIn750(30))
            .zz_fontLeft([UIFont boldFontTitle])
            .zz_titleLeft(self.addModel.name);
            
            ZCellConfig *nameCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(60) cellType:ZCellTypeClass dataModel:nameModel];
            [self.cellConfigArr addObject:nameCellConfig];
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            cellHeight = cellHeight + CGFloatIn750(60);
            cellHeight = cellHeight + CGFloatIn750(20);
            cellHeight = cellHeight + CGFloatIn750(20);
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            ZLineCellModel *timeModel = ZLineCellModel.zz_lineCellModel_create(@"time")
            .zz_cellHeight(CGFloatIn750(60))
            .zz_marginLeft(CGFloatIn750(30))
            .zz_fontLeft([UIFont fontSmall])
            .zz_colorLeft([UIColor colorTextGray])
            .zz_colorDarkLeft([UIColor colorTextGrayDark])
            .zz_titleLeft([NSString stringWithFormat:@"%@分钟/节",self.addModel.course_min]);
            
            ZCellConfig *timeCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:timeModel];
            [self.cellConfigArr addObject:timeCellConfig];
            cellHeight = cellHeight + CGFloatIn750(40);
            
            ZLineCellModel *numModel = ZLineCellModel.zz_lineCellModel_create(@"num")
            .zz_cellHeight(CGFloatIn750(40))
            .zz_marginLeft(CGFloatIn750(30))
            .zz_colorLeft([UIColor colorTextGray])
            .zz_colorDarkLeft([UIColor colorTextGrayDark])
            .zz_fontLeft([UIFont fontSmall])
            .zz_titleLeft([NSString stringWithFormat:@"共%@节",self.addModel.course_min]);
            
            ZCellConfig *numCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:numModel];
            [self.cellConfigArr addObject:numCellConfig];
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            cellHeight = cellHeight + CGFloatIn750(20);
            cellHeight = cellHeight + CGFloatIn750(40);
            
            CGFloat spaceHeigh = KScreenHeight - kTopHeight - cellHeight - CGFloatIn750(360) - CGFloatIn750(140)- CGFloatIn750(160);
            
            [self.cellConfigArr addObject:getEmptyCellWithHeight(spaceHeigh)];
            
            ZCellConfig *qrcodeCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentShareQrcodeCell className] title:@"qrcode" showInfoMethod:@selector(setImage:) heightOfCell:CGFloatIn750(140) cellType:ZCellTypeClass dataModel:nil];
            [self.cellConfigArr addObject:qrcodeCellConfig];
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
        make.top.equalTo(self.iTableView.mas_top).offset(CGFloatIn750(60 + 58 + 360 + 80));
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
    [ZShareView setPre_title:@"分享" reduce_weight:[NSString stringWithFormat:@"（%@）",self.addModel.name] after_title:@"到微信" handlerBlock:^(NSInteger index) {
        UIImage *shareImage = [ZPublicTool snapshotForView:self.iTableView];
        [[ZUMengShareManager sharedManager] shareUIWithType:index image:shareImage vc:self];
    }];
}
@end
