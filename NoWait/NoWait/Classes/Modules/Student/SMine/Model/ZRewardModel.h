//
//  ZRewardModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseModel.h"


@interface ZRewardReflectHandleModel : ZBaseModel
@property (nonatomic,copy) NSString *amount;
@property (nonatomic,copy) NSString *aliPay;
@property (nonatomic,copy) NSString *realName;
@end

@interface ZRewardReflectDetailListModel : ZBaseModel
@property (nonatomic,copy) NSString *amount;
@property (nonatomic,copy) NSString *nick_name;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *created_at;
@end


@interface ZRewardReflectDetailModel : ZBaseModel
@property (nonatomic,copy) NSString *total;
@property (nonatomic,copy) NSArray <ZRewardReflectDetailListModel *>*list;
@end

@interface ZRewardReflectListModel : ZBaseModel
@property (nonatomic,copy) NSString *alipay;
@property (nonatomic,copy) NSString *amount;
@property (nonatomic,copy) NSString *created_at;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *tip;
@property (nonatomic,copy) NSString *real_name;
@end


@interface ZRewardReflectModel : ZBaseModel
@property (nonatomic,copy) NSString *total;
@property (nonatomic,copy) NSArray <ZRewardReflectListModel *>*list;
@end

@interface ZRewardRankingMyModel : ZBaseModel
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *total_amount;
@property (nonatomic,copy) NSString *rank_desc;
@property (nonatomic,copy) NSString *prev;

@end

@interface ZRewardRankingListModel : ZBaseModel
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *total_amount;
@property (nonatomic,copy) NSString *nick_name;
@property (nonatomic,copy) NSString *index;
@property (nonatomic,copy) NSString *max_amount;
@end

@interface ZRewardRankingModel : ZBaseModel
@property (nonatomic,strong) ZRewardRankingMyModel *rank;
@property (nonatomic,copy) NSString *total;
@property (nonatomic,copy) NSArray <ZRewardRankingListModel *>*list;
@end

@interface ZRewardTeamListModel : ZBaseModel
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *nick_name;
@property (nonatomic,copy) NSString *inviter;
@property (nonatomic,copy) NSString *level;
@end

@interface ZRewardTeamModel : ZBaseModel
@property (nonatomic,strong) NSArray <ZRewardTeamListModel *>*list;
@property (nonatomic,copy) NSString *total;
@end


@interface ZRewardInfoModel : ZBaseModel
@property (nonatomic,copy) NSString *inviter_code;
@property (nonatomic,copy) NSString *inviter;
@property (nonatomic,copy) NSString *bonus;
@property (nonatomic,copy) NSString *cash_out_amount;
@property (nonatomic,copy) NSString *cash_out;
@property (nonatomic,copy) NSString *alipay;
@property (nonatomic,copy) NSString *real_name;
@property (nonatomic,copy) NSString *inviter_url;
@property (nonatomic,copy) NSString *qrcode;
@end

@interface ZRewardModel : ZBaseModel

@end

