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
            .zz_fontLeft([UIFont boldFontContent])
            .zz_titleRight(@"似锦APP")
            .zz_lineHidden(YES)
            .zz_alignmentRight(NSTextAlignmentRight)
            .zz_fontRight([UIFont boldSystemFontOfSize:CGFloatIn750(40)])
            .zz_colorRight([UIColor colorTextBlack])
            .zz_colorDarkRight([UIColor colorTextBlackDark]);
            
            ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [weakSelf.cellConfigArr addObject:titleCellConfig];
            
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(58))];
            cellHeight = cellHeight + CGFloatIn750(60);
            cellHeight = cellHeight + CGFloatIn750(58);
            
            ZCellConfig *imageCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentShareImageCell className] title:@"image" showInfoMethod:@selector(setImage:) heightOfCell:KScreenHeight > 736 ? CGFloatIn750(360):CGFloatIn750(280) cellType:ZCellTypeClass dataModel:self.addModel.image_url];
            [weakSelf.cellConfigArr addObject:imageCellConfig];

            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
            cellHeight = cellHeight + (KScreenHeight > 736 ? CGFloatIn750(360):CGFloatIn750(280));
            cellHeight = cellHeight + CGFloatIn750(40);

            ZLineCellModel *priceModel = ZLineCellModel.zz_lineCellModel_create(@"title")
            .zz_cellHeight(CGFloatIn750(60))
            .zz_marginLeft(CGFloatIn750(30))
            .zz_lineHidden(YES)
            .zz_fontLeft([UIFont boldSystemFontOfSize:CGFloatIn750(36)])
            .zz_titleLeft([NSString stringWithFormat:@"￥%@",self.addModel.price]);
            if (ValidStr(weakSelf.addModel.experience_price)) {
                priceModel.zz_titleLeft([NSString stringWithFormat:@"￥%@(体验价￥%@)",weakSelf.addModel.price,weakSelf.addModel.experience_price]);
            }

            ZCellConfig *priceCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(60) cellType:ZCellTypeClass dataModel:priceModel];
            [weakSelf.cellConfigArr addObject:priceCellConfig];
            
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            cellHeight = cellHeight + CGFloatIn750(60);
            cellHeight = cellHeight + CGFloatIn750(20);

            ZLineCellModel *nameModel = ZLineCellModel.zz_lineCellModel_create(@"name")
            .zz_cellHeight(CGFloatIn750(60))
            .zz_marginLeft(CGFloatIn750(30))
            .zz_lineHidden(YES)
            .zz_fontLeft([UIFont boldFontTitle])
            .zz_titleLeft(weakSelf.addModel.name);

            ZCellConfig *nameCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(60) cellType:ZCellTypeClass dataModel:nameModel];
            [weakSelf.cellConfigArr addObject:nameCellConfig];
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];

            cellHeight = cellHeight + CGFloatIn750(60);
            cellHeight = cellHeight + CGFloatIn750(20);
            cellHeight = cellHeight + CGFloatIn750(20);

            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            ZLineCellModel *timeModel = ZLineCellModel.zz_lineCellModel_create(@"time")
            .zz_cellHeight(CGFloatIn750(60))
            .zz_marginLeft(CGFloatIn750(30))
            .zz_lineHidden(YES)
            .zz_fontLeft([UIFont fontSmall])
            .zz_colorLeft([UIColor colorTextGray])
            .zz_colorDarkLeft([UIColor colorTextGrayDark])
            .zz_titleLeft([NSString stringWithFormat:@"%@分钟/节",self.addModel.course_min]);

            ZCellConfig *timeCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:timeModel];
            [weakSelf.cellConfigArr addObject:timeCellConfig];

            cellHeight = cellHeight + CGFloatIn750(40);

            ZLineCellModel *numModel = ZLineCellModel.zz_lineCellModel_create(@"num")
            .zz_cellHeight(CGFloatIn750(40))
            .zz_marginLeft(CGFloatIn750(30))
            .zz_colorLeft([UIColor colorTextGray])
            .zz_colorDarkLeft([UIColor colorTextGrayDark])
            .zz_fontLeft([UIFont fontSmall])
            .zz_lineHidden(YES)
            .zz_titleLeft([NSString stringWithFormat:@"共%@节",weakSelf.addModel.course_min]);

            ZCellConfig *numCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:numModel];
            [weakSelf.cellConfigArr addObject:numCellConfig];
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];

            cellHeight = cellHeight + CGFloatIn750(20);
            cellHeight = cellHeight + CGFloatIn750(40);

            CGFloat spaceHeigh = KScreenHeight - kTopHeight - cellHeight - CGFloatIn750(160) - CGFloatIn750(140);
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
        make.top.equalTo(self.iTableView.mas_top).offset(CGFloatIn750(60 + 58 + 80)+(KScreenHeight > 736 ? CGFloatIn750(360):CGFloatIn750(280)));
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

#pragma mark - RouteHandler
@interface ZStudentLessonDetailShareVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentLessonDetailShareVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_main_lessonShare;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentLessonDetailShareVC *routevc = [[ZStudentLessonDetailShareVC alloc] init];
    if (request.prts && [request.prts isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDict = request.prts;
        if ([tempDict objectForKey:@"isOrder"]) {
            routevc.isOrder = [tempDict[@"isOrder"] boolValue];
        }
        if ([tempDict objectForKey:@"addModel"]) {
            routevc.addModel = tempDict[@"addModel"];
        }
    }
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
