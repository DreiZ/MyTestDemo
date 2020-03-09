//
//  UICollectionViewCell+ZCategory.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "UICollectionViewCell+ZCategory.h"

@implementation UICollectionViewCell (ZCategory)
+(instancetype)z_cellWithCollection:(UICollectionView *)collection indexPath:(NSIndexPath *)indexPath
{
    NSString *cellName = [self className];
    NSString *nibPath = [[NSBundle mainBundle] pathForResource:cellName ofType:@"nib"];
    
    if (nibPath) {
        
        [collection registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellWithReuseIdentifier:self.className];
    }else{
        [collection registerClass:self forCellWithReuseIdentifier:self.className];
    }
    
    id cell = [collection dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    
    return cell;
}
@end
