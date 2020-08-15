//
//  ZCustomCalloutView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/8/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapCommonObj.h>

@protocol CustomCalloutViewTapDelegate <NSObject>

- (void)didDetailButtonTapped:(NSInteger)index;

@end


@interface ZCustomCalloutView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *poiArray;

@property (nonatomic, weak) id<CustomCalloutViewTapDelegate> delegate;

- (void)dismissCalloutView;

@end
