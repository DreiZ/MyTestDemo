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
@property (nonatomic,strong) NSString *subName;
@property (nonatomic,strong) NSString *uid;

@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,strong) id data;
@property (nonatomic,assign) BOOL isEdit;
@end


@interface ZBaseMenuModel : NSObject
@property (nonatomic,strong) NSMutableArray <ZBaseUnitModel *> *units;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic,assign) BOOL isSelected;
@end
NS_ASSUME_NONNULL_END
