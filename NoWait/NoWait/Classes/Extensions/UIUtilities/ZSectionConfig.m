//
//  ZSectionConfig.m
//  NoWait
//
//  Created by zhuang zhang on 2020/8/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZSectionConfig.h"
#import "ZBaseView.h"

@implementation ZSectionConfig

ZCHAIN_CLASS_CREATE(ZSectionConfig, NSString *, zChain_section_create, title);

ZCHAIN_SECTIONCONFIG_IMPLEMENTATION(zz_className, NSString *, className);

ZCHAIN_SECTIONCONFIG_IMPLEMENTATION(zz_method, SEL, showInfoMethod);

ZCHAIN_SECTIONCONFIG_IMPLEMENTATION(zz_height, CGFloat, heightOfSection);

ZCHAIN_SECTIONCONFIG_IMPLEMENTATION(zz_data, id, dataModel);


-(ZSectionConfig *(^)(id (^)(id,id)))zz_handle {
    return ^ ZSectionConfig *(id (^handleBlock)(id, id)) {
        self.handleBlock = handleBlock;
        return self;
    };
}

#pragma mark - init
- (instancetype)init {
    self = [super init];
    if (self) {

        _title = @"section";

        _heightOfSection = 0;
    }
    return self;
}


#pragma mark - method
+ (instancetype)sectionConfigWithTitle:(NSString *)title
                             className:(NSString *)className
                        showInfoMethod:(SEL)showInfoMethod
                       heightOfSection:(CGFloat)heightOfSection {
    ZSectionConfig *sectionConfig = [ZSectionConfig new];
    
    sectionConfig.title = title;
    
    sectionConfig.className = className;

    sectionConfig.showInfoMethod = showInfoMethod;

    sectionConfig.heightOfSection = heightOfSection;
    
    return sectionConfig;
}

+ (instancetype)sectionConfigWithTitle:(NSString *)title
                             className:(NSString *)className
                        showInfoMethod:(SEL)showInfoMethod
                       heightOfSection:(CGFloat)heightOfSection
                             dataModel:(id)dataModel {
    ZSectionConfig *sectionConfig = [ZSectionConfig new];
    
    sectionConfig.title = title;
    
    sectionConfig.className = className;

    sectionConfig.showInfoMethod = showInfoMethod;

    sectionConfig.heightOfSection = heightOfSection;

    sectionConfig.dataModel = dataModel;

    return sectionConfig;
}

+ (instancetype)sectionConfigWithTitle:(NSString *)title
                             className:(NSString *)className
                        showInfoMethod:(SEL)showInfoMethod
                       heightOfSection:(CGFloat)heightOfSection
                             dataModel:(id)dataModel
                           handleBlock:(id(^)(id, id))handleBlock  {
    ZSectionConfig *sectionConfig = [ZSectionConfig new];
    
    sectionConfig.title = title;
    
    sectionConfig.className = className;

    sectionConfig.showInfoMethod = showInfoMethod;

    sectionConfig.heightOfSection = heightOfSection;

    sectionConfig.dataModel = dataModel;

    sectionConfig.handleBlock = handleBlock;
    
    return sectionConfig;
}


- (UIView *)sectionOfConfigWitDataModel:(id)dataModel {
    Class cellClass = NSClassFromString(self.className);
    
    if(dataModel) {
        self.dataModel = dataModel;
    }
    
    UIView *sectionView = [[cellClass alloc] init];
     
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if (self.showInfoMethod && [sectionView respondsToSelector:self.showInfoMethod]) {
            [sectionView performSelector:self.showInfoMethod withObject:self.dataModel];
        }
    #pragma clang diagnostic pop
    
    if ([sectionView isKindOfClass:[ZBaseView class]]) {
        ZBaseView *lSectionView = (ZBaseView *)sectionView;
        lSectionView.eventAction = self.handleBlock;
    }
    
    return sectionView;
}
@end
