//
//  ZCellConfig.m
//  ZQingSongGuang
//
//  Created by zzz on 2018/7/22.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZCellConfig.h"


@implementation ZCellConfig
/**
 * @brief 便利构造器
 *
 * @param className:类名;
 * @param title:标题，可用做cell直观的区分;
 * @param showInfoMethod:此类cell用来显示数据模型的方法， 如@selector(showInfo:);
 * @param heightOfCell:此类cell的高度;
 *
 *
 */
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
    }
    else
    {
        UINib *cellNib = [UINib nibWithNibName:self.className bundle:nil];
        [tableView registerNib:cellNib forCellReuseIdentifier:self.className];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    //    if (!cell) {
    //        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    //    }
    
    // 设置cell
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (self.showInfoMethod && [cell respondsToSelector:self.showInfoMethod]) {
        [cell performSelector:self.showInfoMethod withObject:self.dataModel];
    }
#pragma clang diagnostic pop
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
    }
    else
    {
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
    
    return cell;
}
@end
