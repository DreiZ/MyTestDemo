//
//  ZBaseUnitModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZSendMessageModel : NSObject
@property (nonatomic,strong) NSMutableArray *studentList;
@property (nonatomic,strong) NSString *lessonName;
@property (nonatomic,strong) NSString *storesName;
@property (nonatomic,strong) NSString *teacherName;
@property (nonatomic,strong) NSString *teacherImage;
@property (nonatomic,strong) NSString *type;
@end

@interface ZAgreementModel : NSObject
@property (nonatomic,copy) NSString *navTitle;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *url;
@end

@interface ZBaseTextVCModel : NSObject
@property (nonatomic,strong) NSString *text;
@property (nonatomic,assign) NSInteger max;
@property (nonatomic,assign) ZFormatterType formatter;
@property (nonatomic,copy) NSString *navTitle;
@property (nonatomic,copy) NSString *hitStr;
@property (nonatomic,copy) NSString *showHitStr;
@property (nonatomic,copy) NSString *placeholder;
@end

@interface ZBaseUnitModel : NSObject
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *subName;
@property (nonatomic,strong) NSString *uid;

@property (nonatomic,assign) BOOL istransformDark;
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,strong) id data;
@property (nonatomic,assign) BOOL isEdit;
@end


@interface ZBaseMenuModel : NSObject
@property (nonatomic,strong) NSMutableArray <ZBaseUnitModel *> *units;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *subName;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic,assign) BOOL isSelected;

@end
NS_ASSUME_NONNULL_END
