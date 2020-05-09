//
//  ZChainCommon.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#ifndef ZChainCommon_h
#define ZChainCommon_h

#pragma mark - 属性 链式
#define ZCHAIN_PROPERTY @property (nonatomic, copy, readonly)

#define ZCHAIN_BLOCK(ZZClass,methodName,ZZParamType) ZZClass(^methodName)(ZZParamType);

#define ZCHAIN_IMPLEMENTATION(ZZClass,methodName,ZZParamType,attribute) -(ZZClass(^)(ZZParamType))methodName { \
    return ^ ZZClass(ZZParamType value) {\
        self.attribute = value;\
        return self;\
    };\
}


#pragma mark - 创建 链式
#define ZCHAIN_OBJ_CREATE(ZZClass,ZZParamType,methodName) +(ZZClass(^)(ZZParamType))methodName;

#define ZCHAIN_CLASS_CREATE(ZZClass,ZZParamType,methodName,attribute)\
+(ZZClass *(^)(ZZParamType))methodName {\
    return ^ ZZClass*(ZZParamType value) {\
        ZZClass* obj = [[ZZClass alloc] init];\
        obj.attribute = value;\
        return obj;\
    };\
}
#endif /* ZChainCommon_h */
