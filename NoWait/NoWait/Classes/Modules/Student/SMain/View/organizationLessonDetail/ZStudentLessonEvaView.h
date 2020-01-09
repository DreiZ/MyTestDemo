//
//  ZStudentLessonEvaView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZStudentLessonDetailBaseView.h"
#import "ZStudentOrganizationLessonDetailVC.h"
#import "ZStudentLessonTableView.h"
#import "ZStudentDetailModel.h"


@interface ZStudentLessonEvaView : ZStudentLessonDetailBaseView
@property (nonatomic,weak) ZStudentOrganizationLessonDetailVC *mainVC;
@property (nonatomic,strong) ZStudentLessonTableView *iTableView;
@property (nonatomic,assign) OffsetType offsetType;

@property (nonatomic,strong) ZStudentDetailEvaModel *evaModel;
@end

