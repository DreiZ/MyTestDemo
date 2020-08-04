//
//  ZSectionConfig.h
//  NoWait
//
//  Created by zhuang zhang on 2020/8/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define ZCHAIN_SECTIONCONFIG_PROPERTY(methodName,ZZParamType) ZCHAIN_PROPERTY ZCHAIN_BLOCK(ZSectionConfig *, methodName, ZZParamType)

#define ZCHAIN_SECTIONCONFIG_IMPLEMENTATION(methodName,ZZParamType,attribute) ZCHAIN_IMPLEMENTATION(ZSectionConfig *,methodName,ZZParamType,attribute)


@interface ZSectionConfig : NSObject

/// 标题，通过 其对应的 cellConfig.title 进行判断
@property (nonatomic, strong) NSString *title;

/// className (uiview)
@property (nonatomic, strong) NSString *className;

/// 显示数据模型的方法
@property (nonatomic, assign) SEL showInfoMethod;

/// section高度
@property (nonatomic, assign) CGFloat heightOfSection;

@property (nonatomic, strong) id dataModel;

@property (nonatomic, strong) id (^handleBlock)(id, id);


ZCHAIN_OBJ_CREATE(ZSectionConfig *, NSString *title, zChain_section_create)

ZCHAIN_SECTIONCONFIG_PROPERTY(zChain_className, NSString *);

ZCHAIN_SECTIONCONFIG_PROPERTY(zChain_method, SEL);

ZCHAIN_SECTIONCONFIG_PROPERTY(zChain_height, CGFloat);

ZCHAIN_SECTIONCONFIG_PROPERTY(zChain_data, id);

ZCHAIN_SECTIONCONFIG_PROPERTY(zChain_handle, id (^)(id, id));

/**
 便利构造器

 @param title 标题，可用做cell直观的区分
 @param showInfoMethod 此类section用来显示数据模型的方法， 如@selector(showInfo:)
 @param heightOfSection 此类section的高度
 @return section 描述
 */
+ (instancetype)sectionConfigWithTitle:(NSString *)title
                             className:(NSString *)className
                         showInfoMethod:(SEL)showInfoMethod
                       heightOfSection:(CGFloat)heightOfSection;


+ (instancetype)sectionConfigWithTitle:(NSString *)title
                             className:(NSString *)className
                        showInfoMethod:(SEL)showInfoMethod
                       heightOfSection:(CGFloat)heightOfSection
                              dataModel:(id)dataModel;


+ (instancetype)sectionConfigWithTitle:(NSString *)title
                             className:(NSString *)className
                        showInfoMethod:(SEL)showInfoMethod
                       heightOfSection:(CGFloat)heightOfSection
                             dataModel:(id)dataModel
                           handleBlock:(id(^)(id, id))handleBlock;

- (UIView *)sectionOfConfigWitDataModel:(id)dataModel;
@end

NS_ASSUME_NONNULL_END
