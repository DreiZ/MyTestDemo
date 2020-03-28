//
//  ZStudentLessonOrderMoreInputCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"


@interface ZStudentLessonOrderMoreInputCell : ZBaseCell
@property (nonatomic,assign) ZFormatterType formatterType;
@property (nonatomic,strong) NSString *isBackColor;
@property (nonatomic,assign) NSInteger max;
@property (nonatomic,strong) NSString *hint;
@property (nonatomic,strong) NSString *content;


@property (nonatomic,strong) void (^textChangeBlock)(NSString *);
@end

