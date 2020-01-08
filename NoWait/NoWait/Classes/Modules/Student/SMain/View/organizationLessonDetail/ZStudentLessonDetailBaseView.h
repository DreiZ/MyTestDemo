//
//  ZStudentLessonDetailBaseView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

@interface ZStudentLessonDetailBaseView : UIView <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
//是否在加载中
@property (nonatomic, getter=isLoading) BOOL loading;
@property (nonatomic, strong) NSString *emptyDataStr;
@property (nonatomic, strong) void (^refreshDataBlock)(void);

- (void)refreshData;
@end

