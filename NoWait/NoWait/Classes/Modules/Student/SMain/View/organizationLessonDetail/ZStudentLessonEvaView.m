//
//  ZStudentLessonEvaView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonEvaView.h"
#import "ZSpaceEmptyCell.h"
#import "ZStudentLessonDetailEvaListCell.h"

@interface ZStudentLessonEvaView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end

@implementation ZStudentLessonEvaView


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
        _iTableView.backgroundColor = KWhiteColor;
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

    ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:KWhiteColor];
    [_cellConfigArr addObject:spacCellConfig];

    NSArray *eva = @[@"挺好的，不错，坚持下来肯定有结果",
                    @"还不错，加油",@"要坚持下去，我自己坚持下来，效果很明显，加油吧少年，我们还要很长时间才能做出很好的效果",
                    @"加油不错",
    @"这家还不错，欢迎大家前来锻炼，教练小姐姐很漂亮，器材很新，很干净，很好看，到董事更多"];
    for (int i = 0; i < 15; i++) {
        ZStudentDetailEvaListModel *model = [[ZStudentDetailEvaListModel alloc] init];
        model.userImage = [NSString stringWithFormat:@"studentHeadImage%d",i%5 + 1];
        model.userName = @"天黑有灯";
        model.evaDes = eva[i%5];
        model.star = @"4.5";
        model.time = @"2019-10-23";
        ZCellConfig *lessonTitleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonDetailEvaListCell className] title:[ZStudentLessonDetailEvaListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonDetailEvaListCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [_cellConfigArr addObject:lessonTitleCellConfig];

        
    }
    
    
    [self.iTableView reloadData];
}


-(void)setEvaModel:(ZStudentDetailEvaModel *)evaModel {
    _evaModel = evaModel;
    [self resetData];
    [self.iTableView reloadData];
}
@end

