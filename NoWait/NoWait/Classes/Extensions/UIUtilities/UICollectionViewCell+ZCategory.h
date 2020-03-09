//
//  UICollectionViewCell+ZCategory.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZCollectionViewCellPrototol <NSObject>
@optional
+(CGSize)z_getCellSize:(id)sender;
@end

@interface UICollectionViewCell (ZCategory)<ZCollectionViewCellPrototol>
+(instancetype)z_cellWithCollection:(UICollectionView *)collection indexPath:(NSIndexPath *)indexPath;
@end


