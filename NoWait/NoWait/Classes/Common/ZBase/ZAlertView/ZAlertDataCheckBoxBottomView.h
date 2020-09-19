//
//  ZAlertDataCheckBoxBottomView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+PopGesture.h"
#import "XYTransitionProtocol.h"
#import "UIScrollView+EmptyDataSet.h"


@interface ZAlertDataCheckBoxBottomView : UIView <UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIButton *bottomBtn;

@property (nonatomic, getter=isLoading) BOOL loading;
@property (nonatomic, strong) NSString *emptyDataStr;
@property (nonatomic, strong) NSString *emptyImage;
@property (nonatomic,strong) void (^handleBlock)(NSInteger,id);

@property (nonatomic,strong) NSMutableArray *cellConfigArr;

+ (ZAlertDataCheckBoxBottomView *)sharedManager;

- (void)setName:(NSString *)title handlerBlock:(void(^)(NSInteger, id))handleBlock;
- (void)initMainView;
- (void)initCellConfigArr;
- (void)handleWithIndex:(NSInteger)index;

- (void)setTableViewRefreshHeader;
- (void)setTableViewRefreshFooter;
- (void)setTableViewEmptyDataDelegate;

+ (void)setAlertName:(NSString *)title handlerBlock:(void(^)(NSInteger,id))handleBlock ;


#pragma mark - tableview 数据处理
-(void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig;


-(void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig;
@end


