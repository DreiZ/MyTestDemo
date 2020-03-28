//
//  ZStudentMineEvaEditVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOrderModel.h"

@interface ZStudentMineEvaEditVC : ZTableViewViewController
@property (nonatomic,strong) ZOrderListModel *listModel;
@property (nonatomic,strong) ZOrderDetailModel *detailModel;
@property (nonatomic,strong) ZOrderEvaDetailModel *evaDetailModel;

@end


