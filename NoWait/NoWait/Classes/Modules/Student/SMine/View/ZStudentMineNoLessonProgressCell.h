//
//  ZStudentMineNoLessonProgressCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/5.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"


@interface ZStudentMineNoLessonProgressCell : ZBaseCell
@property (nonatomic,strong) void (^moreBlock)(NSInteger);
@end

