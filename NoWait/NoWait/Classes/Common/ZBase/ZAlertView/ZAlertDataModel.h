//
//  ZAlertDataModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZAlertDataItemModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *ItemID;
@property (nonatomic,strong) NSMutableArray <ZAlertDataItemModel *>*ItemArr;
@property (nonatomic,assign) NSInteger rows;
@end


@interface ZAlertDataModel : NSObject

@end


