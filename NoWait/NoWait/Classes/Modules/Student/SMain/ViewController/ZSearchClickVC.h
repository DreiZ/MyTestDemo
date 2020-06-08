//
//  ZSearchClickVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"
#import "ZTableViewViewController.h"
#import "ZSearchFieldView.h"
#import "ZHistoryModel.h"

@interface ZSearchClickVC : ZTableViewViewController
@property (nonatomic,strong) ZSearchFieldView *searchView;
@property (nonatomic,strong) NSString *searchType;

@property (nonatomic,strong) NSString *navTitle;
- (void)valueChange:(NSString *)text;
- (void)searchClick:(NSString *)text;
- (void)cancleBtnOnClick;

@end

