//
//  ZCircleDetailPhotosItemCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCollectionViewCell.h"
#import "SJPlayerSuperImageView.h"

@interface ZCircleDetailPhotosItemCell : ZBaseCollectionViewCell
@property (nonatomic,strong) SJPlayerSuperImageView *detailImageView;
@property (nonatomic,strong) UIImageView *playerImageView;
@property (nonatomic,strong) ZFileUploadDataModel *model;

@property (nonatomic,strong) void (^delBlock)(void);
@property (nonatomic,strong) void (^seeBlock)(void);
@end
