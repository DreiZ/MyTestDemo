//
//  ZStudentOrganizationDetailDesVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailDesVC.h"
#import "ZBaseUnitModel.h"
#import "ZStudentDetailModel.h"
#import "ZMineStudentEvaListHadEvaCell.h"

#import "ZStudentOrganizationDetailTopCell.h"
//#import "ZStudentOrganizationDetailBannerCell.h"
#import "ZStudentOrganizationDetailIntroCell.h"
#import "ZStudentOrganizationDetailDesCell.h"
#import "ZStudentOrganizationLessonListCell.h"
#import "ZStudentOrganizationPersonnelMoreCell.h"
#import "ZStudentOrganizationPersonnelListCell.h"

#import "ZOrganizationDetailBottomView.h"


#import "ZStudentOrganizationLessonDetailVC.h"
#import "ZStudentStarStudentListVC.h"
#import "ZStudentStarCoachListVC.h"
#import "ZStudentStarCoachInfoVC.h"
#import "ZStudentStarStudentInfoVC.h"
#import "ZStudentOrganizationDetailIntroVC.h"
#import "ZStudentOrganizationLessonListVC.h"
#import "ZStudentOrganizationMapAddressVC.h"
#import "ZStudentTeacherDetailVC.h"
#import "ZStudentStudentDetailVC.h"
#import "ZStudentLessonDetailVC.h"

#import "ZOrganizationCouponListView.h"

@interface ZStudentOrganizationDetailDesVC ()
@property (nonatomic,strong) ZOrganizationDetailBottomView *bottomView;

@end

@implementation ZStudentOrganizationDetailDesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(88) + safeAreaBottom());
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

-(ZOrganizationDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[ZOrganizationDetailBottomView alloc] init];
    }
    return _bottomView;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    NSMutableArray *mList = @[].mutableCopy;
    for (int i = 0; i < 8; i ++) {
        ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
        model.name = @"独山港是";
        if (i%5 == 0) {
            model.imageName = @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1gcl9l56hc7j30xc0m8gol.jpg";
        }else if ( i%5 == 1){
            model.imageName = @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcl9enz0bcj318y0u0h0v.jpg";
        }else if ( i%5 == 2){
            model.imageName = @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcl90ruhzpj30u011i44s.jpg";
        }else if ( i%5 == 3){
            model.imageName = @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcl8kmicgrj318y0u0ae4.jpg";
        }else{
            model.imageName = @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcl8abyp14j30u011g0yz.jpg";
                
        }
        [mList addObject:model];
    }
    ZCellConfig *bannerCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailTopCell className] title:[ZStudentOrganizationDetailTopCell className] showInfoMethod:@selector(setList:) heightOfCell:[ZStudentOrganizationDetailTopCell z_getCellHeight:mList] cellType:ZCellTypeClass dataModel:mList];
    [self.cellConfigArr addObject:bannerCellConfig];
    
    ZCellConfig *desCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailIntroCell className] title:[ZStudentOrganizationDetailIntroCell className] showInfoMethod:nil heightOfCell:[ZStudentOrganizationDetailIntroCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:desCellConfig];
    
    {
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
        [self.cellConfigArr addObject:spacCellConfig];
        
        ZStudentDetailOrderSubmitListModel *moreModel = [[ZStudentDetailOrderSubmitListModel alloc] init];
        moreModel.leftTitle = @"明星教练";
        ZCellConfig *lessonMoreCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelMoreCell className] title:@"moreStarCoach" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationPersonnelMoreCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:moreModel];
        [self.cellConfigArr addObject:lessonMoreCellConfig];
        
        NSArray *entryArr = @[@[@"赵忠",@"http://wx1.sinaimg.cn/mw600/006Gs6QQly1gcknb2ejnyj30j60t6qbn.jpg"],@[@"张丽",@"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcl80isz84j30u00u0jwi.jpg"],@[@"马克",@"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcl7zwzov9j30u018y1kx.jpg"],@[@"张丽",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl7u7pskfj30u011hn2c.jpg"],@[@"张思思",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl7pza70dj30u01a4tuy.jpg"],@[@"许倩倩",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl7fhvi5tj30ds0kumz8.jpg"],@[@"吴楠",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl77552l7j30qo0hsgpo.jpg"],@[@"闫晶晶",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl74tqdyfj30gk0cbqfk.jpg"]];
        
        NSMutableArray *peoples = @[].mutableCopy;
        for (int i = 0; i < entryArr.count; i++) {
            ZStudentDetailPersonnelModel *model = [[ZStudentDetailPersonnelModel alloc] init];
            model.image = entryArr[i][1];
            model.name = entryArr[i][0];
            model.skill = entryArr[i][0];
            [peoples addObject:model];
        }
        
        ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelListCell className] title:@"starCoach" showInfoMethod:@selector(setPeopleslList:) heightOfCell:[ZStudentOrganizationPersonnelListCell z_getCellHeight:peoples] cellType:ZCellTypeClass dataModel:peoples];
        [self.cellConfigArr addObject:coachCellConfig];
    }
    
    {
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:spacCellConfig];
        
        ZStudentDetailOrderSubmitListModel *moreModel = [[ZStudentDetailOrderSubmitListModel alloc] init];
        moreModel.leftTitle = @"明星学员";
        ZCellConfig *lessonMoreCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelMoreCell className] title:@"moreStarStudent" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationPersonnelMoreCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:moreModel];
        [self.cellConfigArr addObject:lessonMoreCellConfig];
        
        NSArray *entryArr = @[@[@"赵忠",@"http://wx1.sinaimg.cn/mw600/006Gs6QQly1gcknb2ejnyj30j60t6qbn.jpg"],@[@"张丽",@"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcl80isz84j30u00u0jwi.jpg"],@[@"马克",@"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcl7zwzov9j30u018y1kx.jpg"],@[@"张丽",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl7u7pskfj30u011hn2c.jpg"],@[@"张思思",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl7pza70dj30u01a4tuy.jpg"],@[@"许倩倩",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl7fhvi5tj30ds0kumz8.jpg"],@[@"吴楠",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl77552l7j30qo0hsgpo.jpg"],@[@"闫晶晶",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl74tqdyfj30gk0cbqfk.jpg"]];
        
        NSMutableArray *peoples = @[].mutableCopy;
        for (int i = 0; i < entryArr.count; i++) {
            ZStudentDetailPersonnelModel *model = [[ZStudentDetailPersonnelModel alloc] init];
            model.image = entryArr[i][1];
            model.name = entryArr[i][0];
            model.skill = entryArr[i][0];
            [peoples addObject:model];
        }
        
        ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelListCell className] title:@"starStudent" showInfoMethod:@selector(setPeopleslList:) heightOfCell:[ZStudentOrganizationPersonnelListCell z_getCellHeight:peoples] cellType:ZCellTypeClass dataModel:peoples];
        [self.cellConfigArr addObject:coachCellConfig];
    }
    
    {
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:spacCellConfig];
        
        ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
        model.leftTitle = @"热门课程";
        model.rightTitle = @"全部课程";
        model.cellTitle = @"allLesson";
        ZCellConfig *lessonMoreCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelMoreCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationPersonnelMoreCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:lessonMoreCellConfig];
        
        NSArray *entryssArr = @[@[@"赵忠",@"http://wx1.sinaimg.cn/mw600/006Gs6QQly1gcknb2ejnyj30j60t6qbn.jpg"],@[@"张丽",@"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcl80isz84j30u00u0jwi.jpg"],@[@"马克",@"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcl7zwzov9j30u018y1kx.jpg"],@[@"张丽",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl7u7pskfj30u011hn2c.jpg"],@[@"张思思",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl7pza70dj30u01a4tuy.jpg"],@[@"许倩倩",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl7fhvi5tj30ds0kumz8.jpg"],@[@"吴楠",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl77552l7j30qo0hsgpo.jpg"],@[@"闫晶晶",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl74tqdyfj30gk0cbqfk.jpg"]];
        
        for (int i = 0; i < entryssArr.count; i++) {
            ZStudentLessonListModel *model = [[ZStudentLessonListModel alloc] init];
            model.image = entryssArr[i][1];
            
            ZCellConfig *lessonCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationLessonListCell className] title:[ZStudentOrganizationLessonListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationLessonListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:lessonCellConfig];
        }
        {
            ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
            [self.cellConfigArr addObject:spacCellConfig];
            ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
                model.leftTitle = @"机构评价";
            ZCellConfig *lessonMoreCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelMoreCell className] title:[ZStudentOrganizationPersonnelMoreCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationPersonnelMoreCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:lessonMoreCellConfig];
        }
        
        {
            ZStudentOrderEvaModel *evaModel = [[ZStudentOrderEvaModel alloc] init];
            evaModel.orderImage = @"lessonOrder";
            evaModel.orderNum = @"23042039523452";
            evaModel.lessonTitle = @"仰泳";
            evaModel.lessonTime = @"2019-10-26";
            evaModel.lessonCoach = @"高圆圆";
            evaModel.lessonOrg = @"上飞天俱乐部";
            evaModel.coachStar = @"3.4";
            evaModel.coachEva = @"吊柜好尬施工阿红化工诶按文化宫我胡搜ID哈工我哈山东IG后is阿活动IG华东师范";
            evaModel.coachEvaImages = @[@"studentListItem2",@"studentListItem2",@"studentListItem2",@"studentListItem2",@"studentListItem2",@"studentListItem2"];

            evaModel.orgStar = @"4.5";
            evaModel.orgEva = @"反反复复付受到法律和";
            evaModel.orgEvaImages =  @[@"studentListItem2",@"studentListItem2",@"studentListItem2",@"studentListItem2",@"studentListItem2",@"studentListItem2"];;
            
            
            ZCellConfig *evaCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaListHadEvaCell className] title:[ZMineStudentEvaListHadEvaCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZMineStudentEvaListHadEvaCell z_getCellHeight:evaModel] cellType:ZCellTypeClass dataModel:evaModel];
            
            ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
            [self.cellConfigArr addObject:evaCellConfig];
            
            [self.cellConfigArr addObject:spacCellConfig];
            [self.cellConfigArr addObject:evaCellConfig];
            [self.cellConfigArr addObject:spacCellConfig];
            [self.cellConfigArr addObject:evaCellConfig];
            [self.cellConfigArr addObject:spacCellConfig];
        }
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"范德萨俱乐部"];
}


#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig
{
    
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationDetailTopCell"]){
           ZStudentOrganizationDetailTopCell *lcell = (ZStudentOrganizationDetailTopCell *)cell;
        lcell.selectBlock = ^(ZBaseUnitModel * model) {
               ZStudentOrganizationDetailIntroVC *ivc = [[ZStudentOrganizationDetailIntroVC alloc] init];
               [weakSelf.navigationController pushViewController:ivc animated:YES];
           };
    
       }else if ([cellConfig.title isEqualToString:@"starStudent"]){
        ZStudentOrganizationPersonnelListCell *lcell = (ZStudentOrganizationPersonnelListCell *)cell;
        lcell.menuBlock = ^(ZStudentDetailPersonnelModel *model) {
            ZStudentStudentDetailVC *dvc = [[ZStudentStudentDetailVC alloc] init];
            [self.navigationController pushViewController:dvc animated:YES];
//            ZStudentStarStudentInfoVC *ivc = [[ZStudentStarStudentInfoVC alloc] init];
//            [weakSelf.navigationController pushViewController:ivc animated:YES];
        };
 
    }else if ([cellConfig.title isEqualToString:@"starCoach"]){
        ZStudentOrganizationPersonnelListCell *lcell = (ZStudentOrganizationPersonnelListCell *)cell;
        lcell.menuBlock = ^(ZStudentDetailPersonnelModel *model) {
            ZStudentTeacherDetailVC *mvc = [[ZStudentTeacherDetailVC alloc] init];
            [weakSelf.navigationController pushViewController:mvc animated:YES];
//            ZStudentStarCoachInfoVC *ivc = [[ZStudentStarCoachInfoVC alloc] init];
//            [weakSelf.navigationController pushViewController:ivc animated:YES];
        };
    }else if ([cellConfig.title isEqualToString:@"ZStudentOrganizationDetailIntroCell"]){
        ZStudentOrganizationDetailIntroCell *lcell = (ZStudentOrganizationDetailIntroCell *)cell;
        lcell.handleBlock = ^(NSInteger index) {
            if (index == 1) {
                ZStudentOrganizationMapAddressVC *avc = [[ZStudentOrganizationMapAddressVC alloc] init];
                [weakSelf.navigationController pushViewController:avc animated:YES];
            }else if (index == 2){
                [ZOrganizationCouponListView setAlertWithTitle:@"优惠" ouponList:@[] handlerBlock:^(NSInteger index) {
                    
                }];
            }
        };
    }
    
    
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationLessonListCell"]) {
        ZStudentLessonDetailVC *dvc = [[ZStudentLessonDetailVC alloc] init];
        [self.navigationController pushViewController:dvc animated:YES];
//        ZStudentOrganizationLessonDetailVC *lessond_vc = [[ZStudentOrganizationLessonDetailVC alloc] init];
//        
//        [self.navigationController pushViewController:lessond_vc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"moreStarStudent"]){
        ZStudentStarStudentListVC *lvc = [[ZStudentStarStudentListVC alloc] init];
        [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"moreStarCoach"]){
        ZStudentStarCoachListVC *lvc = [[ZStudentStarCoachListVC alloc] init];
        [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"allLesson"]){
        ZStudentOrganizationLessonListVC *lvc = [[ZStudentOrganizationLessonListVC alloc] init];
        [self.navigationController pushViewController:lvc animated:YES];
    }
    
    
}

@end
