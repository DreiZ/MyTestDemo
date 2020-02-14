//
//  ZStudentLessonNoticeView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonNoticeView.h"
#import "ZSpaceEmptyCell.h"
#import "ZStudentLessonSectionTitleCell.h"
#import "ZStudentLessonDetailLessonListCell.h"

@interface ZStudentLessonNoticeView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end

@implementation ZStudentLessonNoticeView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.iTableView];
      [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.bottom.right.equalTo(self);
          make.top.equalTo(self.mas_top).offset(CGFloatIn750(0));
      }];
    
    [self setData];
}

- (void)setData {
    _cellConfigArr = @[].mutableCopy;
    self.loading = YES;
    [self resetData];
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[ZStudentLessonTableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _iTableView.estimatedRowHeight = 0;
        _iTableView.estimatedSectionHeaderHeight = 0;
        _iTableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.showsHorizontalScrollIndicator = NO;
        _iTableView.alwaysBounceVertical = YES;
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.backgroundColor = KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor);
        _iTableView.emptyDataSetSource = self;
        _iTableView.emptyDataSetDelegate = self;
//        _iTableView.tableHeaderView = self.menuView;
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
    if ([cellConfig.title isEqualToString:@"ZRecordWeightMoreCell"]) {
       
    }
}


#pragma mark *** UIScrollViewDelegate ***
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    OffsetType type = self.mainVC.offsetType;
    
    if (scrollView.contentOffset.y <= 0) {
        self.offsetType = OffsetTypeMin;
    } else {
        self.offsetType = OffsetTypeCenter;
    }
    
    if (type == OffsetTypeMin) {
        scrollView.contentOffset = CGPointZero;
    }
    if (type == OffsetTypeCenter) {
        scrollView.contentOffset = CGPointZero;
    }
    
}

#pragma mark *** other ***
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


#pragma mark -- setdata--
- (void)resetData {
    [_cellConfigArr removeAllObjects];
//    //须知
//    ZStudentDetailSectionModel *model = [[ZStudentDetailSectionModel alloc] init];
//    model.title = @"须知";
//    model.isShowRight = NO;
//    ZCellConfig *lessonTitleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonSectionTitleCell className] title:[ZStudentLessonSectionTitleCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonSectionTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
//    [_cellConfigArr addObject:lessonTitleCellConfig];
//    
    NSMutableArray *list = @[].mutableCopy;
    NSArray <NSArray *>*des = @[@[@"预约须知",@"提前一天预约"], @[@"退款须知",@"购买后20天内免费，30天后退款费80%"],@[@"退款人",@"打分数档搭嘎搭嘎"]];
    for (int i = 0; i < des.count; i++) {
        ZStudentDetailDesListModel *model = [[ZStudentDetailDesListModel alloc] init];
        model.desTitle = des[i][0];
        model.desSub = des[i][1];
        [list addObject:model];
    }
    
    ZCellConfig *lessonDesCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonDetailLessonListCell className] title:[ZStudentLessonDetailLessonListCell className] showInfoMethod:@selector(setList:) heightOfCell:[ZStudentLessonDetailLessonListCell z_getCellHeight:list] cellType:ZCellTypeClass dataModel:list];
    [_cellConfigArr addObject:lessonDesCellConfig];
    
    
    [self.iTableView reloadData];
}


-(void)setNoticeModel:(ZStudentDetailNoticeModel *)noticeModel {
    _noticeModel = noticeModel;
    [self resetData];
    [self.iTableView reloadData];
}
@end

