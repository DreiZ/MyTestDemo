//
//  ZCircleMineModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseModel.h"


@interface ZCircleMineModel : ZBaseModel
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *autograph;
@property (nonatomic,copy) NSString *dynamic;
@property (nonatomic,copy) NSString *enjoy;
@property (nonatomic,copy) NSString *fans;
@property (nonatomic,copy) NSString *follow;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *nick_name;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *follow_status;// 1:未关注  2：已关注  3：互相关注
@property (nonatomic,assign) BOOL isMine;
@end

