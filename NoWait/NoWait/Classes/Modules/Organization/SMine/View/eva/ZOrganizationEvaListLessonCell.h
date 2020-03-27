//
//  ZOrganizationEvaListLessonCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationEvaListLessonCell : ZBaseCell
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) ZOrderEvaListModel *model;
@property (nonatomic,strong) ZOrderEvaDetailModel *detailModel;

@end

NS_ASSUME_NONNULL_END
