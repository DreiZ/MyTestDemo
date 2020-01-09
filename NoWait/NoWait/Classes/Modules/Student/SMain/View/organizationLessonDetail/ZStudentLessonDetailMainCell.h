//
//  ZStudentLessonDetailMainCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentDetailModel.h"

#import "ZStudentLessonDetailView.h"
#import "ZStudentLessonNoticeView.h"
#import "ZStudentLessonEvaView.h"
#import "ZStudentOrganizationLessonDetailVC.h"

@interface ZStudentLessonDetailMainCell : ZBaseCell
@property (nonatomic,weak) ZStudentOrganizationLessonDetailVC *mainVC;

@property (nonatomic,strong) UIScrollView *iScrollView;
@property (nonatomic,strong) ZStudentLessonDetailView *iDetilView;
@property (nonatomic,strong) ZStudentLessonNoticeView *iNoticeView;
@property (nonatomic,strong) ZStudentLessonEvaView *iEvaView;

@property (nonatomic,strong) ZStudentDetailEvaModel *evaModel;
@property (nonatomic,strong) ZStudentDetailNoticeModel *noticeModel;
@property (nonatomic,strong) ZStudentDetailDesModel *desModel;

@end

