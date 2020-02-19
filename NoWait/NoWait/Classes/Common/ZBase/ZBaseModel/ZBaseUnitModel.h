//
//  ZBaseUnitModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface ZBaseUnitModel : NSObject
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *uid;

@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,strong) id data;

@end


@interface ZBaseMenuModel : NSObject
@property (nonatomic,strong) NSArray <ZBaseUnitModel *> *units;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *uid;

@end
NS_ASSUME_NONNULL_END
