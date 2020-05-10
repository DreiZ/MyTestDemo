//
//  ZContactViewController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZContactViewController.h"
#import "ZSessionViewController.h"
#import "ZBaseLineCell.h"
#import <NIMGroupedUsrInfo.h>
#import "NTESGroupedContacts.h"
#import "NTESContactDataMember.h"

@interface ZContactViewController ()<NIMUserManagerDelegate,NIMSystemNotificationManagerDelegate>

@property (nonatomic,copy) NSArray *contact;
@property (nonatomic,strong) NTESGroupedContacts *contacts;

@end

@implementation ZContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareData];
    [self initCellConfigArr];
    [self.iTableView reloadData];
    
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (NIMKitInfo *user in self.dataSources) {
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title").titleLeft(user.showName)
        .imageLeft(user.avatarUrlString?user.avatarUrlString:@"http://wx2.sinaimg.cn/mw600/44f2ef1bgy1gemh0lvw6dj20gd0m8wge.jpg").imageLeftHeight(CGFloatIn750(70)).height(CGFloatIn750(90)).imageLeftRadius(YES).lineHidden(NO).marginLineLeft(CGFloatIn750(60)).marginLineRight(CGFloatIn750(30)).setData(user);
        
        ZCellConfig *messageCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:[ZBaseLineCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:messageCellConfig];
    }
}

#pragma mark - Table view data source
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ZLineCellModel *model = cellConfig.dataModel;
    NIMKitInfo *user = model.data;
    NIMSession *session = [NIMSession session:user.infoId type:NIMSessionTypeP2P];
    ZSessionViewController *vc = [[ZSessionViewController alloc] initWithSession:session];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 获取我的好友列表
- (void)prepareData{
    _contacts = [[NTESGroupedContacts alloc] init];
    for (NTESContactDataMember *user in _contacts.members) {
        [self.dataSources addObject:user.info];
        
    }
}


- (NSArray *)filterData:(NSMutableArray *)data{
    if (data) {
        if ([self.config respondsToSelector:@selector(filterIds)]) {
            NSArray *ids = [self.config filterIds];
            [data removeObjectsInArray:ids];
        }
        return data;
    }
    return nil;
}

#pragma mark - NIMSDK Delegate
- (void)onSystemNotificationCountChanged:(NSInteger)unreadCount
{
    [self refresh];
}

- (void)onLogin:(NIMLoginStep)step
{
    if (step == NIMLoginStepSyncOK) {
        if (self.isViewLoaded) {//没有加载view的话viewDidLoad里会走一遍prepareData
            [self refresh];
        }
    }
}

- (void)onUserInfoChanged:(NIMUser *)user
{
    [self refresh];
}

- (void)onFriendChanged:(NIMUser *)user{
    [self refresh];
}

- (void)onBlackListChanged
{
    [self refresh];
}

- (void)onMuteListChanged
{
    [self refresh];
}

- (void)refresh
{
    [self prepareData];
    [self initCellConfigArr];
}

@end

