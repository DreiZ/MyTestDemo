//
//  ZStudentLessonNoticeView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZStudentOrganizationLessonDetailVC.h"
#import "ZStudentLessonTableView.h"

@interface ZStudentLessonNoticeView : UIView
@property (nonatomic,weak) ZStudentOrganizationLessonDetailVC *mainVC;
@property (nonatomic,strong) ZStudentLessonTableView *iTableView;
@property (nonatomic,assign) OffsetType offsetType;
@end

