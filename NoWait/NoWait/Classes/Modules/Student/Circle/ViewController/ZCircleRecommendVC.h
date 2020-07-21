//
//  ZCircleRecommendVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"
#import "ZCollectionViewController.h"

@interface ZCircleRecommendVC : ZCollectionViewController
@property (nonatomic,assign) BOOL isAttention;
@property (nonatomic,copy) NSString *stores_id;
@property (nonatomic,copy) NSString *stores_name;
@end

