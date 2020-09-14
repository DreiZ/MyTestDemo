//
//  ZCircleRecommendSchoolVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/9/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCollectionViewController.h"


@interface ZCircleRecommendSchoolVC : ZCollectionViewController
@property (nonatomic,assign) BOOL isAttention;
@property (nonatomic,copy) NSString *stores_id;
@property (nonatomic,copy) NSString *stores_name;

@property (nonatomic,strong) NSDictionary *routeDict;
@end

