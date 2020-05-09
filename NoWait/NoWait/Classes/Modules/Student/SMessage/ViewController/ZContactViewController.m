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

@interface ZContactViewController ()

@property (nonatomic,copy) NSArray *contact;

@end

@implementation ZContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    _contact =  @[
         @"lilei",
         @"lintao",
         @"tom",
         @"lily",
         @"lucy",
         @"lilei",
    ];
    
    for (NSString *data in self.contact) {
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title").titleLeft(data);
//        model.leftTitle = data;
        ZCellConfig *messageCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:[ZBaseLineCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:messageCellConfig];
    }
}

#pragma mark - Table view data source
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ZLineCellModel *model = cellConfig.dataModel;
    NSString *sessionId = model.leftTitle;
    NIMSession *session = [NIMSession session:sessionId type:NIMSessionTypeP2P];
    ZSessionViewController *vc = [[ZSessionViewController alloc] initWithSession:session];
    [self.navigationController pushViewController:vc animated:YES];
}
@end

