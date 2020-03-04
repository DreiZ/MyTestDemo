//
//  ZOrganizationSearchVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"

//购买课程流程
typedef NS_ENUM(NSInteger, ZSearchType) {
    ZSearchTypeLesson,  //课程
};

@interface ZOrganizationSearchVC : ZTableViewViewController
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) ZSearchType searchType;
@end


