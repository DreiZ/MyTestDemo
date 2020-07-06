//
//  ZSearchHistoryView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZSearchHistoryView.h"
#import "ZDBMainStore.h"
#import "ZHistoryModel.h"
#import "ZLabelListCell.h"
#import "ZHotListCell.h"

@interface ZSearchHistoryView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZSearchHistoryView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    _cellConfigArr = @[].mutableCopy;
    
    [self addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.showsHorizontalScrollIndicator = NO;
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
        }
        _iTableView.scrollEnabled = NO;
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _iTableView;
}

#pragma mark - tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    __weak typeof(self) weakSelf = self;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if([cellConfig.title isEqualToString:@"history"]){
        ZLabelListCell *lcell = (ZLabelListCell *)cell;
        lcell.handleBlock = ^(NSString * text) {
            if (weakSelf.searchBlock) {
                weakSelf.searchBlock(text);
            }
        };
    }else if([cellConfig.title isEqualToString:@"hot"]){
        ZHotListCell *lcell = (ZHotListCell *)cell;
        lcell.menuBlock = ^(id data) {
            if (weakSelf.searchBlock) {
                weakSelf.searchBlock(data);
            }
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
    
}

#pragma mark - cellConfig
- (void)initCellConfigArr {
    [self.cellConfigArr removeAllObjects];
    if(ValidArray(self.hotList)){
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"type")
        .zz_titleLeft(@"搜索发现")
        .zz_lineHidden(YES)
        .zz_cellHeight(CGFloatIn750(50))
        .zz_fontLeft([UIFont boldFontTitle]);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZCellConfig *historyCellConfig = [ZCellConfig cellConfigWithClassName:[ZHotListCell className] title:@"hot" showInfoMethod:@selector(setList:) heightOfCell:[ZHotListCell z_getCellHeight:self.hotList] cellType:ZCellTypeClass dataModel:self.hotList];

        [self.cellConfigArr addObject:historyCellConfig];
    }
    
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
    ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"type")
    .zz_titleLeft(@"历史搜索")
    .zz_lineHidden(YES)
    .zz_cellHeight(CGFloatIn750(50))
    .zz_fontLeft([UIFont boldFontTitle]);
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
    
    NSArray *mainArr = [[ZDBMainStore shareManager] searchHistorysByID:self.searchType];
    __block NSMutableArray *tempArr = @[].mutableCopy;
    [mainArr enumerateObjectsUsingBlock:^(ZHistoryModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tempArr addObject:SafeStr(obj.search_title)];
    }];
    
    ZCellConfig *historyCellConfig = [ZCellConfig cellConfigWithClassName:[ZLabelListCell className] title:@"history" showInfoMethod:@selector(setTitleArr:) heightOfCell:[ZLabelListCell z_getCellHeight:tempArr] cellType:ZCellTypeClass dataModel:tempArr];

    [self.cellConfigArr addObject:historyCellConfig];
    
    [self.iTableView reloadData];
}

- (void)reloadHistoryData {
    [self initCellConfigArr];
    
    [self.iTableView reloadData];
}

- (void)setHotList:(NSArray *)hotList {
    _hotList = hotList;
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}
@end
