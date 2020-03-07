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
#import "ZStudentOrganizationDetailDesCell.h"
#import "ZStudentOrganizationLessonListCell.h"
#import "ZStudentOrganizationPersonnelMoreCell.h"
#import "ZStudentOrganizationPersonnelListCell.h"


#import "ZStudentOrganizationLessonDetailVC.h"
#import "ZStudentStarStudentListVC.h"
#import "ZStudentStarCoachListVC.h"
#import "ZStudentStarCoachInfoVC.h"
#import "ZStudentStarStudentInfoVC.h"

@interface ZStudentOrganizationDetailDesVC ()

@end

@implementation ZStudentOrganizationDetailDesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
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
    
    ZCellConfig *desCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailDesCell className] title:[ZStudentOrganizationDetailDesCell className] showInfoMethod:nil heightOfCell:[ZStudentOrganizationDetailDesCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
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
        ZCellConfig *lessonMoreCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelMoreCell className] title:[ZStudentOrganizationPersonnelMoreCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationPersonnelMoreCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
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

- (void)setupMainView {
    [super setupMainView];
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(100));
        make.top.equalTo(self.view.mas_top).offset(1);
    }];
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig
{
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"starStudent"]){
        ZStudentOrganizationPersonnelListCell *lcell = (ZStudentOrganizationPersonnelListCell *)cell;
        lcell.menuBlock = ^(ZStudentDetailPersonnelModel *model) {
            ZStudentStarStudentInfoVC *ivc = [[ZStudentStarStudentInfoVC alloc] init];
            [weakSelf.navigationController pushViewController:ivc animated:YES];
        };
 
    }else if ([cellConfig.title isEqualToString:@"starCoach"]){
        ZStudentOrganizationPersonnelListCell *lcell = (ZStudentOrganizationPersonnelListCell *)cell;
        lcell.menuBlock = ^(ZStudentDetailPersonnelModel *model) {
            ZStudentStarCoachInfoVC *ivc = [[ZStudentStarCoachInfoVC alloc] init];
            [weakSelf.navigationController pushViewController:ivc animated:YES];
        };
    }
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationLessonListCell"]) {
        ZStudentOrganizationLessonDetailVC *lessond_vc = [[ZStudentOrganizationLessonDetailVC alloc] init];
        
        [self.navigationController pushViewController:lessond_vc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"moreStarStudent"]){
        ZStudentStarStudentListVC *lvc = [[ZStudentStarStudentListVC alloc] init];
        [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"moreStarCoach"]){
        ZStudentStarCoachListVC *lvc = [[ZStudentStarCoachListVC alloc] init];
        [self.navigationController pushViewController:lvc animated:YES];
    }
}

@end
