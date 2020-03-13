//
//  ZOrganizationSearchVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOrganizationTeacherSearchTopView.h"

//购买课程流程
typedef NS_ENUM(NSInteger, ZSearchType) {
    ZSearchTypeLesson,  //课程
    ZSearchTypeLessonOrder,  //搜索学员订单
    ZSearchTypeClass,  //搜索班级
    ZSearchTypeStudentOrder,  //搜索学生订单
    ZSearchTypeOrganizationCart,     //搜索卡券
};

@interface ZOrganizationSearchVC : ZTableViewViewController
@property (nonatomic,strong) ZOrganizationTeacherSearchTopView *searchView;

@property (nonatomic,strong) NSString *navTitle;
@property (nonatomic,assign) ZSearchType searchType;
- (void)valueChange:(NSString *)text;
@end


