//
//  ZDBAdvertiserStore.h
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/12/18.
//  Copyright © 2018 承希-开发. All rights reserved.
//

#import "ZDBBaseStore.h"
#import "ZDAdvertiserStoreSQL.h"
#import "ZAdvertiserModel.h"

@interface ZDBAdvertiserStore : ZDBBaseStore

#pragma mark - 添加
/**
 *  添加广告
 */
- (BOOL)addAdvertiser:(ZBaseNetworkBannerModel *)Advertiser;

#pragma mark - 查询
/**
 *  获取与某个好友的聊天记录
 */
- (void)advertiserByAdvertiserID:(NSString *)AdvertiserID
                complete:(void (^)(ZBaseNetworkBannerModel *data))complete;


#pragma mark - 删除
/**
 *  删除单条广告消息
 */
- (BOOL)deleteAdvertiserByAdvertiserID:(NSString *)AdvertiserID;

@end

