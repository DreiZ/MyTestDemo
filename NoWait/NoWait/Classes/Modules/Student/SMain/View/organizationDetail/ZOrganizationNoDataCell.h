//
//  ZOrganizationNoDataCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/24.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"


typedef NS_ENUM(NSUInteger, ZNoDataType) {
    /*! 未知*/
    ZNoDataTypeAll           = 0,
    /*! 课程 */
    ZNoDataTypeLesson,
    /*! 教师 */
    ZNoDataTypeTeacher,
    /*! 评价 */
    ZNoDataTypeEva,
    /*!  介绍*/
    ZNoDataTypeInfo,
    /*!  相册*/
    ZNoDataTypePhoto,
};

@interface ZOrganizationNoDataCell : ZBaseCell
@property (nonatomic,strong) NSString *type;
@end

