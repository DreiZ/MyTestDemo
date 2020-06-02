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


//设置block 链式
#define BLOCKTYPE(ZZParamBackType,ZZParamType) ZZParamBackType(^)(ZZParamType)
#define BLOCKPARAMTYPE(ZZParamBackType,ZZParamType,value) ZZParamBackType (^value)(ZZParamType)

#define  ZCHAIN_BLOCK_IMPLEMENTATION(ZZClass, methodName, attribute, ZZParamBackType, ZZParamType)  -(ZZClass(^)(BLOCKTYPE(ZZParamBackType, ZZParamType)))methodName {\
    return ^ ZZClass(BLOCKPARAMTYPE(ZZParamBackType, ZZParamType, value)) {\
        self.attribute = value;\
        return self;\
    };\
}


//设置block 多参数-2 链式
#define BLOCKTWOTYPE(ZZParamBackType,ZZParamOneType,ZZParamTwoType) ZZParamBackType(^)(ZZParamOneType,ZZParamTwoType)
#define BLOCKTWOPARAMTYPE(ZZParamBackType,ZZParamOneType,ZZParamTwoType,value) ZZParamBackType (^value)(ZZParamOneType,ZZParamTwoType)

#define  ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZZClass, methodName, attribute, ZZParamBackType, ZZParamOneType,ZZParamTwoType)  -(ZZClass(^)(BLOCKTWOTYPE(ZZParamBackType, ZZParamOneType,ZZParamTwoType)))methodName {\
    return ^ ZZClass(BLOCKTWOPARAMTYPE(ZZParamBackType, ZZParamOneType,ZZParamTwoType, value)) {\
        self.attribute = value;\
        return self;\
    };\
}

//设置block 多参数-3 链式
#define BLOCKTHREETYPE(ZZParamBackType,ZZParamOneType,ZZParamTwoType,ZZParamThreeType) ZZParamBackType(^)(ZZParamOneType,ZZParamTwoType,ZZParamThreeType)
#define BLOCKTHREEPARAMTYPE(ZZParamBackType,ZZParamOneType,ZZParamTwoType,ZZParamThreeType,value) ZZParamBackType (^value)(ZZParamOneType,ZZParamTwoType,ZZParamThreeType)

#define  ZCHAIN_BLOCKTHREE_IMPLEMENTATION(ZZClass, methodName, attribute, ZZParamBackType, ZZParamOneType,ZZParamTwoType,ZZParamThreeType)  -(ZZClass(^)(BLOCKTHREETYPE(ZZParamBackType, ZZParamOneType,ZZParamTwoType,ZZParamThreeType)))methodName {\
    return ^ ZZClass(BLOCKTHREEPARAMTYPE(ZZParamBackType, ZZParamOneType,ZZParamTwoType,ZZParamThreeType, value)) {\
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
