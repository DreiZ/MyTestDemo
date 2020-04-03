//
//  ZFeedBackViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseViewModel.h"
#import "ZMineModel.h"


@interface ZFeedBackViewModel : ZBaseViewModel
@property (nonatomic,strong) ZMineFeedBackModel *model;

+ (void)addFeedback:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;
@end


