//
//  ZCellConfig.m
//  ZQingSongGuang
//
//  Created by zzz on 2018/7/22.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZCellConfig.h"


@implementation ZCellConfig

ZCHAIN_CLASS_CREATE(ZCellConfig, NSString *, zChain_create, title);

ZCHAIN_CELLCONFIG_IMPLEMENTATION(zChain_className, NSString *, className);

ZCHAIN_CELLCONFIG_IMPLEMENTATION(zChain_method, SEL, showInfoMethod);

ZCHAIN_CELLCONFIG_IMPLEMENTATION(zChain_height, CGFloat, heightOfCell);

ZCHAIN_CELLCONFIG_IMPLEMENTATION(zChain_type, ZCellType, cellType);

ZCHAIN_CELLCONFIG_IMPLEMENTATION(zChain_detail, NSString *, detail);

ZCHAIN_CELLCONFIG_IMPLEMENTATION(zChain_remark, NSString *, remark);

ZCHAIN_CELLCONFIG_IMPLEMENTATION(zChain_data, id, dataModel);

ZCHAIN_CELLCONFIG_IMPLEMENTATION(zChain_size, CGSize, sizeOfCell);

-(ZCellConfig *(^)(id (^)(id,id)))zChain_handle {
    return ^ ZCellConfig *(id (^handleBlock)(id, id)) {
        self.handleBlock = handleBlock;
        return self;
    };
}

#pragma mark - init
- (instancetype)init {
    self = [super init];
    if (self) {
        
        _className = [ZBaseCell className];

        _title = @"ZBaseCell";
        
        _heightOfCell = 0;

        _cellType = ZCellTypeClass;
        
        _sizeOfCell = CGSizeMake(0, 0);
    }
    return self;
}


#pragma mark - method
+ (instancetype)cellConfigWithClassName:(NSString *)className
                                  title:(NSString *)title
                         showInfoMethod:(SEL)showInfoMethod
                           heightOfCell:(CGFloat)heightOfCell
                               cellType:(ZCellType)cellType
{
    ZCellConfig *cellConfig = [ZCellConfig new];
    
    cellConfig.className = className;
    cellConfig.title = title;
    cellConfig.showInfoMethod = showInfoMethod;
    cellConfig.heightOfCell = heightOfCell;
    cellConfig.cellType = cellType;
    return cellConfig;
}


+ (instancetype)cellConfigWithClassName:(NSString *)className
                                  title:(NSString *)title
                         showInfoMethod:(SEL)showInfoMethod
                           heightOfCell:(CGFloat)heightOfCell
                               cellType:(ZCellType)cellType
                              dataModel:(id)dataModel
{
    ZCellConfig *cellConfig = [ZCellConfig new];
    
    cellConfig.className = className;
    cellConfig.title = title;
    cellConfig.showInfoMethod = showInfoMethod;
    cellConfig.heightOfCell = heightOfCell;
    cellConfig.cellType = cellType;
    cellConfig.dataModel = dataModel;
    return cellConfig;
}

+ (instancetype)cellConfigWithClassName:(NSString *)className
                                  title:(NSString *)title
                         showInfoMethod:(SEL)showInfoMethod
                           heightOfCell:(CGFloat)heightOfCell
                               cellType:(ZCellType)cellType
                              dataModel:(id)dataModel
                            handleBlock:(id(^)(id, id))handleBlock
{
    ZCellConfig *cellConfig = [ZCellConfig new];
    
    cellConfig.className = className;
    cellConfig.title = title;
    cellConfig.showInfoMethod = showInfoMethod;
    cellConfig.heightOfCell = heightOfCell;
    cellConfig.cellType = cellType;
    cellConfig.dataModel = dataModel;
    cellConfig.handleBlock = handleBlock;
    return cellConfig;
}


+ (instancetype)cellConfigWithClassName:(NSString *)className
                                  title:(NSString *)title
                         showInfoMethod:(SEL)showInfoMethod
                             sizeOfCell:(CGSize)sizeOfCell
                               cellType:(ZCellType)cellType
                              dataModel:(id)dataModel
{
    ZCellConfig *cellConfig = [ZCellConfig new];
    
    cellConfig.className = className;
    cellConfig.title = title;
    cellConfig.showInfoMethod = showInfoMethod;
    cellConfig.sizeOfCell = sizeOfCell;
    cellConfig.cellType = cellType;
    cellConfig.dataModel = dataModel;
    return cellConfig;
}


+ (instancetype)cellConfigWithClassName:(NSString *)className
                                  title:(NSString *)title
                         showInfoMethod:(SEL)showInfoMethod
                             sizeOfCell:(CGSize)sizeOfCell
                               cellType:(ZCellType)cellType
                              dataModel:(id)dataModel
                            handleBlock:(id(^)(id, id))handleBlock
{
    ZCellConfig *cellConfig = [ZCellConfig new];
    
    cellConfig.className = className;
    cellConfig.title = title;
    cellConfig.showInfoMethod = showInfoMethod;
    cellConfig.sizeOfCell = sizeOfCell;
    cellConfig.cellType = cellType;
    cellConfig.dataModel = dataModel;
    cellConfig.handleBlock = handleBlock;
    return cellConfig;
}


/// 根据cellConfig生成cell，重用ID为cell类名
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView
                                         dataModel:(id)dataModel
{
    Class cellClass = NSClassFromString(self.className);
    
    if(dataModel)
    {
        self.dataModel = dataModel;
    }
    
    // 重用cell
    NSString *cellID = self.className;
    if (self.cellType == ZCellTypeClass) {
        [tableView registerClass:cellClass forCellReuseIdentifier:self.className];
    }else {
        UINib *cellNib = [UINib nibWithNibName:self.className bundle:nil];
        [tableView registerNib:cellNib forCellReuseIdentifier:self.className];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
 
    // 设置cell
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (self.showInfoMethod && [cell respondsToSelector:self.showInfoMethod]) {
        [cell performSelector:self.showInfoMethod withObject:self.dataModel];
    }
#pragma clang diagnostic pop
    if ([cell isKindOfClass:[ZBaseCell class]]) {
        ZBaseCell *lcell = (ZBaseCell *)cell;
        lcell.eventAction = self.handleBlock;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

/// 根据cellConfig生成cell，重用ID为cell类名
- (UICollectionViewCell *)cellOfCellConfigWithCollection:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath dataModel:(id)dataModel{
    
    Class cellClass = NSClassFromString(self.className);
    
    if(dataModel)
    {
        self.dataModel = dataModel;
    }
    
    // 重用cell
    NSString *cellID = self.className;
    if (self.cellType == ZCellTypeClass) {
        [collectionView registerClass:cellClass forCellWithReuseIdentifier:self.className];
    }else {
        UINib *cellNib = [UINib nibWithNibName:self.className bundle:nil];
        [collectionView registerNib:cellNib forCellWithReuseIdentifier:self.className];
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if (self.showInfoMethod && [cell respondsToSelector:self.showInfoMethod]) {
            [cell performSelector:self.showInfoMethod withObject:self.dataModel];
        }
    #pragma clang diagnostic pop
    
    if ([cell isKindOfClass:[ZBaseCollectionViewCell class]]) {
        ZBaseCollectionViewCell *lcell = (ZBaseCollectionViewCell *)cell;
        lcell.eventAction = self.handleBlock;
    }
    
    return cell;
}
@end
