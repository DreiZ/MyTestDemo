//
//  ZCirclePhotosItemCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCollectionViewCell.h"

@interface ZCirclePhotosItemCell : ZBaseCollectionViewCell
@property (nonatomic,strong) UIImageView *detailImageView;
@property (nonatomic,strong) UIImageView *playerImageView;
@property (nonatomic,strong) ZFileUploadDataModel *model;

@property (nonatomic,assign) BOOL isEdit;

@property (nonatomic,strong) void (^delBlock)(void);
@property (nonatomic,strong) void (^seeBlock)(void);
@end

