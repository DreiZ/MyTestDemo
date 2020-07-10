//
//  ZCircleMineModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseModel.h"

@interface ZCircleMinePersonModel : ZBaseModel
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *autograph;
@property (nonatomic,copy) NSString *dynamic;
@property (nonatomic,copy) NSString *enjoy;
@property (nonatomic,copy) NSString *fans;
@property (nonatomic,copy) NSString *follow;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *nick_name;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *follow_status;
@end


@interface ZCircleMinePersonNetModel : ZBaseNetworkBackModel
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,copy) NSString *total;
@end


@interface ZCircleMineDynamicPhotoModel : ZBaseModel
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *width;
@property (nonatomic,copy) NSString *height;
@property (nonatomic,copy) NSString *duration;
@end

@interface ZCircleMineDynamicModel : ZBaseModel
@property (nonatomic,strong) ZCircleMineDynamicPhotoModel *cover;
@property (nonatomic,copy) NSString *browse;// 浏览量
@property (nonatomic,copy) NSString *dynamic;
@property (nonatomic,copy) NSString *enjoy; // 喜欢量
@property (nonatomic,copy) NSString *has_video;// 是否有视频 0：否  1：是
@property (nonatomic,copy) NSString *is_many_image; // 是否是多图  0：否  1：是
@end

@interface ZCircleMineDynamicNetModel : ZBaseNetworkBackModel
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,copy) NSString *total;
@end

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

