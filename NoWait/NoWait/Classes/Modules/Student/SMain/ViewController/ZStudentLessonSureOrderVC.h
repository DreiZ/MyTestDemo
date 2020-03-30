//
//  ZStudentLessonSureOrderVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"
#import "ZOrderModel.h"


@interface ZStudentLessonSureOrderVC : ZTableViewViewController
@property (nonatomic,strong) ZOrderDetailModel *detailModel;
@property (nonatomic,strong) NSArray *coupons_list;

@end

