//
//  ZStudentStarStudentListVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"
#import "ZCollectionViewController.h"
#import "ZOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZStudentStarStudentListVC : ZCollectionViewController
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) ZStoresListModel *listModel;
@end

NS_ASSUME_NONNULL_END
