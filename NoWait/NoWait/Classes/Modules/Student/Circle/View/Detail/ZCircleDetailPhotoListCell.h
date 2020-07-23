//
//  ZCircleDetailPhotoListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "SJNestedCollectionView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZCircleDetailPhotoListCell : ZBaseCell
@property (nonatomic,strong) NSMutableArray *imageList;
@property (nonatomic,strong) void (^seeBlock)(NSInteger);
@property (nonatomic,strong) void (^handleBlock)(ZBaseCell *,UICollectionView *,NSIndexPath*,ZFileUploadDataModel*);
@end

NS_ASSUME_NONNULL_END
