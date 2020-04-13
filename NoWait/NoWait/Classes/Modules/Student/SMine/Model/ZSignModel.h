//
//  ZSignModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseModel.h"


@interface ZSignInfoListModel : ZBaseModel
@property (nonatomic,strong) NSString *nums;
@property (nonatomic,strong) NSString *sign_time;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,assign) BOOL isOrganzation;

@end

@interface ZSignInfoModel : ZBaseModel
@property (nonatomic,strong) NSString *courses_name;
@property (nonatomic,strong) NSArray <ZSignInfoListModel *>*list;
@property (nonatomic,strong) NSString *now_progress;
@property (nonatomic,strong) NSString *replenish_nums;
@property (nonatomic,strong) NSString *total_progress;
@property (nonatomic,strong) NSString *truancy_nums;
@property (nonatomic,strong) NSString *vacate_nums;
@property (nonatomic,strong) NSString *wait_progress;
@end

@interface ZSignModel : ZBaseModel

@end

