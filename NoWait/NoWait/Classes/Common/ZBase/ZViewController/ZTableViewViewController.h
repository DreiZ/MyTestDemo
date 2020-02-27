//
//  ZTableViewViewController.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZTableViewViewController : ZViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;

@end

NS_ASSUME_NONNULL_END
