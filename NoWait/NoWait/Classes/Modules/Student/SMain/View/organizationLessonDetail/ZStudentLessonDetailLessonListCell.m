//
//  ZStudentLessonDetailLessonListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonDetailLessonListCell.h"
#import "ZStudentLessonDetailLessonItemCell.h"
#import "ZStudentLessonDetailLessonSubtitleCell.h"
#import "ZSpaceEmptyCell.h"

@interface ZStudentLessonDetailLessonListCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@property (nonatomic,strong) UIView *bottomLineView;

@end


@implementation ZStudentLessonDetailLessonListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    self.contentView.backgroundColor = KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor);
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cellConfigArr = @[].mutableCopy;
    
    [self.contentView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = KAdaptAndDarkColor(KLineColor, [UIColor colorBlackBG]);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    self.bottomLineView = bottomLineView;
}


#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.scrollEnabled = NO;
        _iTableView.backgroundColor = KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor);
    }
    return _iTableView;
}

- (NSMutableArray *)cellConfigArr {
    if (!_cellConfigArr) {
        [_cellConfigArr removeAllObjects];
    }
    return _cellConfigArr;
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


#pragma mark - setdata
- (void)setList:(NSArray<ZStudentDetailDesListModel *> *)list {
    _list = list;
    
    [self setData];
}

- (void)setNoSpacelist:(NSArray<ZStudentDetailDesListModel *> *)noSpacelist {
    _list = noSpacelist;
    [self setDataWithoutSpace];
}

- (void)setData {
    [_cellConfigArr removeAllObjects];
    
    ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(14) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor)];
    [_cellConfigArr addObject:spacCellConfig];


    [self setDataWithoutSpace];
    
    
    ZCellConfig *spacBottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(14) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor)];
    [_cellConfigArr addObject:spacBottomCellConfig];
 
    [self.iTableView reloadData];
}

- (void)setDataWithoutSpace {
    for (int i = 0; i < self.list.count; i++) {
           ZStudentDetailDesListModel *model = self.list[i];
           
           if (model.desTitle) {
               ZCellConfig *itemCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonDetailLessonSubtitleCell className] title:[ZStudentLessonDetailLessonSubtitleCell className] showInfoMethod:@selector(setDetail:) heightOfCell:[ZStudentLessonDetailLessonSubtitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model.desTitle];
               [_cellConfigArr addObject:itemCellConfig];
           }
           
           if (model.desSub) {
               ZCellConfig *itemCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonDetailLessonItemCell className] title:[ZStudentLessonDetailLessonItemCell className] showInfoMethod:@selector(setDetail:) heightOfCell:[ZStudentLessonDetailLessonItemCell z_getCellHeight:model.desSub] cellType:ZCellTypeClass dataModel:model.desSub];
               [_cellConfigArr addObject:itemCellConfig];
           }
       }
}

- (void)setIsHiddenBottomLine:(BOOL)isHiddenBottomLine {
    _isHiddenBottomLine = isHiddenBottomLine;
    self.bottomLineView.hidden = isHiddenBottomLine;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    NSArray *list = sender;
    if (list && list.count > 0) {
        CGFloat cellHeight = 0.01;
        for (int i = 0; i < list.count; i++) {
            ZStudentDetailDesListModel *model = list[i];
            if (model.desTitle && model.desTitle.length > 0) {
                cellHeight += [ZStudentLessonDetailLessonSubtitleCell z_getCellHeight:nil];
            }
            
            if (model.desSub && model.desSub) {
                cellHeight += [ZStudentLessonDetailLessonItemCell z_getCellHeight:model.desSub];
            }
        }
        
        return cellHeight  + CGFloatIn750(32);
    }else{
        return 0.01;
    }
}
@end
