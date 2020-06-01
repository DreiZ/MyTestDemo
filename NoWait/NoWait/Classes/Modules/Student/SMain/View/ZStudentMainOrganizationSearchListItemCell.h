//
//  ZStudentMainOrganizationSearchListItemCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZOriganizationModel.h"
#import "ZBaseCollectionViewCell.h"

@interface ZStudentMainOrganizationSearchListItemCell : ZBaseCollectionViewCell
@property (nonatomic,strong) UILabel *pricebLabel;
@property (nonatomic,strong) UILabel *clubLabel;
@property (nonatomic,strong) UILabel *minLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UIImageView *clubImageView;
@property (nonatomic,strong) ZStoresCourse *model;

@end


