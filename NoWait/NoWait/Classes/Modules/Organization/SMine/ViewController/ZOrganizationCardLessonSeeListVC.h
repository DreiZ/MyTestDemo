//
//  ZOrganizationCardLessonSeeListVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"


@interface ZOrganizationCardLessonSeeListVC : ZTableViewViewController
@property (nonatomic,strong) NSString *coupons_id;
@property (nonatomic,strong) NSString *stores_id;

@property (nonatomic,assign) BOOL isAll;
@end


