//
//  ZStudentMineSettingMineVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingMineVC.h"
#import "ZCellConfig.h"
#import "ZStudentDetailModel.h"

#import "ZSpaceEmptyCell.h"
#import "ZStudentMineSignListCell.h"
#import "ZStudentLessonOrderCompleteCell.h"
#import "ZStudentMineSettingUserHeadImageCell.h"

#import "ZStudentMineSignDetailVC.h"
#import "ZStudentMineSettingMineEditVC.h"
#import "ZStudentMineSettingSexVC.h"
#import "ZDatePickerView.h"


@interface ZStudentMineSettingMineVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIImage *avterImage;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end
@implementation ZStudentMineSettingMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setDataSource];
    [self initCellConfigArr];
    [self setupMainView];
}

- (void)setDataSource {
    _dataSources = @[].mutableCopy;
    _cellConfigArr = @[].mutableCopy;
    
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
    
    NSArray <NSArray *>*titleArr = @[@[@"头像", self.avterImage ? self.avterImage:@"", @""], @[@"昵称", @"rightBlackArrowN", @"闯红灯的蜗牛"],@[@"性别", @"rightBlackArrowN", @"男"],@[@"出生日期", @"rightBlackArrowN", @"1990-2-21"]];
    
    for (int i = 0; i < titleArr.count; i++) {
        ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
        model.leftTitle = titleArr[i][0];
        
        model.rightTitle = titleArr[i][2];
        model.leftFont = [UIFont fontContent];
        model.rightColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        model.cellTitle = titleArr[i][0];
        
        if (i == 0) {
            model.rightImageH = titleArr[i][1];
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingUserHeadImageCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineSettingUserHeadImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
            
        }else{
            model.rightImage = titleArr[i][1];
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"设置"];
}

- (void)setupMainView {
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
    }
    return _iTableView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"ZStudentMineSignListCell"]){
        ZStudentMineSignListCell *enteryCell = (ZStudentMineSignListCell *)cell;
        enteryCell.handleBlock = ^(NSInteger type) {
            ZStudentMineSignDetailVC *dvc = [[ZStudentMineSignDetailVC alloc] init];
            
            [self.navigationController pushViewController:dvc animated:YES];
        };
        
    }
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
     if ([cellConfig.title isEqualToString:@"头像"]){
          __weak typeof(self) weakSelf = self;
            [ZPhotoManager sharedManager].maxImageSelected = 1;
            [[ZPhotoManager sharedManager] showSelectMenuWithCropSize:CGSizeMake(KScreenWidth, KScreenWidth) complete:^(NSArray<LLImagePickerModel *> *list) {
                if (list && list.count > 0) {
                    weakSelf.avterImage = list[0].image;
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                    
//                    NSString *imageFileName = [NSString stringWithFormat:@"%@.jpg",AliYunUserFilePath];
//                    [[ZFileUploadManger sharedManager] uploadImage:weakSelf.avterImage fileName:imageFileName complete:^(NSString *url, NSString *content_md5) {
//
//                    }];
                }
            }];
     }else if([cellConfig.title isEqualToString:@"昵称"]){
         ZStudentMineSettingMineEditVC *edit = [[ZStudentMineSettingMineEditVC alloc] init];
         [self.navigationController pushViewControllerAndSuicide:edit animated:YES];
     }else if([cellConfig.title isEqualToString:@"性别"]){
         ZStudentMineSettingSexVC *edit = [[ZStudentMineSettingSexVC alloc] init];
         [self.navigationController pushViewControllerAndSuicide:edit animated:YES];
     } else if([cellConfig.title isEqualToString:@"出生日期"]){
         [ZDatePickerView showTimePickerInView:self.view date:[NSDate new] dateSelect:^(NSDate *date) {
             DLog(@"----%f",[date timeIntervalSince1970]);
//             weakSelf.accountModel.birthday = [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]];
//             [weakSelf.iTableView reloadData];
         }];
     }
}

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
@end






