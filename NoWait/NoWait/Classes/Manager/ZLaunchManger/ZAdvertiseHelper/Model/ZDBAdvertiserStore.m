//
//  ZDBAdvertiserStore.m
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/12/18.
//  Copyright © 2018 承希-开发. All rights reserved.
//

#import "ZDBAdvertiserStore.h"

@implementation ZDBAdvertiserStore
- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [ZDBManager sharedInstance].messageQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            DLog(@"DB: 聊天记录表创建失败");
        }
    }
    return self;
}

- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_ADVERTISER_TABLE, ADVERTISER_TABLE_NAME];
    return [self createTable:ADVERTISER_TABLE_NAME withSQL:sqlString];
}

- (BOOL)addAdvertiser:(ZBaseNetworkBannerModel *)Advertiser
{
    if (Advertiser == nil || Advertiser.bannerId == nil || Advertiser.type == nil || Advertiser.name == nil || Advertiser.title == nil || Advertiser.image == nil || Advertiser.url == nil || Advertiser.content == nil || Advertiser.status == nil || Advertiser.drive == nil || Advertiser.directive == nil || Advertiser.parameter == nil) {
        return NO;
    }
    
    
    NSString *sqlString = [NSString stringWithFormat:SQL_ADD_ADVERTISER, ADVERTISER_TABLE_NAME];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        TLNoNilString(Advertiser.bannerId),
                        TLNoNilString(Advertiser.type),
                        TLNoNilString(Advertiser.name),
                        TLNoNilString(Advertiser.title),
                        TLNoNilString(Advertiser.image),
                        TLNoNilString(Advertiser.url),
                        TLNoNilString(Advertiser.content),
                        TLNoNilString(Advertiser.status),
                        TLNoNilString(Advertiser.drive),
                        TLNoNilString(Advertiser.directive),
                        TLNoNilString(Advertiser.parameter),
                        @"", @"", @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}

- (void)advertiserByAdvertiserID:(NSString *)AdvertiserID complete:(void (^)(ZBaseNetworkBannerModel *))complete {
    __block ZBaseNetworkBannerModel *bannerModel;
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:
                           SQL_SELECT_ADVERTISER,
                           ADVERTISER_TABLE_NAME];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            bannerModel = [self p_createDBAdvertiserByFMResultSet:retSet];
            [data insertObject:bannerModel atIndex:0];
        }
        [retSet close];
    }];
    if (data && data.count > 0) {
        complete(bannerModel);
    }else{
        complete(nil);
    }
}


- (BOOL)deleteAdvertiserByAdvertiserID:(NSString *)AdvertiserID {
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_ADVERTISER, ADVERTISER_TABLE_NAME];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}


#pragma mark - Private Methods -
- (ZBaseNetworkBannerModel *)p_createDBAdvertiserByFMResultSet:(FMResultSet *)retSet
{

    ZBaseNetworkBannerModel *banner = [[ZBaseNetworkBannerModel alloc] init];
    banner.bannerId = [retSet stringForColumn:@"bannerId"];
    banner.type = [retSet stringForColumn:@"type"];
    banner.name = [retSet stringForColumn:@"name"];
    banner.title = [retSet stringForColumn:@"title"];
    
    banner.image = [retSet stringForColumn:@"image"];
    banner.url = [retSet stringForColumn:@"url"];
    banner.content = [retSet stringForColumn:@"content"];
    banner.status = [retSet stringForColumn:@"status"];
    
    banner.drive = [retSet stringForColumn:@"drive"];
    banner.directive = [retSet stringForColumn:@"directive"];
    banner.parameter = [retSet stringForColumn:@"parameter"];
    
    return banner;
}
@end
