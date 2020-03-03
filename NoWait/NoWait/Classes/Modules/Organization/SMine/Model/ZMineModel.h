//
//  ZMineModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseModel.h"


@interface ZMineModel : ZBaseModel

@end

@interface ZMineFeedBackModel : ZBaseModel
@property (nonatomic,strong) NSString *des;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSMutableArray *images;
@end


