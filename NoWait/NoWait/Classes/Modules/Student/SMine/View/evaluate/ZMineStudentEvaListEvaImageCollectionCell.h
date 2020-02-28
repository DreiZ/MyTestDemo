//
//  ZMineStudentEvaListEvaImageCollectionCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

@interface ZMineStudentEvaListEvaImageCollectionCell : ZBaseCell
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) void (^selectBlock)(NSInteger);
@end

