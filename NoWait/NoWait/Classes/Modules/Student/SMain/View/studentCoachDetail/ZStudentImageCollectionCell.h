//
//  ZStudentImageCollectionCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewListCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZStudentImageCollectionCell : ZTableViewListCell
@property (nonatomic,strong) NSArray *images;

@property (nonatomic,strong) void (^menuBlock)(NSInteger);
@end

NS_ASSUME_NONNULL_END
