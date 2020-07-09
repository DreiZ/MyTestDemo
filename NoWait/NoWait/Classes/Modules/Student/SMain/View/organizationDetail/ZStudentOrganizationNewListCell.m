//
//  ZStudentOrganizationNewListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationNewListCell.h"
#import "ZStudentOrganizationHotListCell.h"

@interface ZStudentOrganizationNewListCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UITableView *iTableView;

@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end

@implementation ZStudentOrganizationNewListCell

-(void)setupView {
    [super setupView];
    _cellConfigArr = @[].mutableCopy;
    
    [self.contentView addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo([ZStudentOrganizationHotListCell z_getCellHeight:nil]);
    }];
    
    [self.funBackView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.funBackView);
    }];
}

#pragma mark - Getter
- (UIView *)funBackView {
    if (!_funBackView) {
        _funBackView = [[UIView alloc] init];
        _funBackView.layer.masksToBounds = YES;
        _funBackView.clipsToBounds = YES;
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorBlackBGDark]);
    }
    return _funBackView;
}


-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.backgroundColor = [UIColor whiteColor];
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
        }
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.layer.masksToBounds = YES;
        _iTableView.scrollEnabled = NO;
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
    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationHotListCell"]) {
        if (self.lessonBlock) {
            self.lessonBlock(cellConfig.dataModel);
        }
    }
}

#pragma mark - setModel
- (void)setModel:(ZStoresListModel *)model {
    [super setModel:model];
    [_cellConfigArr removeAllObjects];

    if (ValidArray(model.course)) {
        for (int i = 0; i < model.course.count; i++) {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationHotListCell className] title:@"ZStudentOrganizationHotListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationHotListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model.course[i]];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }
        self.funBackView.hidden = NO;
        
        [self.funBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(6));
            make.height.mas_equalTo([ZStudentOrganizationHotListCell z_getCellHeight:nil] * model.course.count);
        }];
    }else{
        self.funBackView.hidden = YES;
    }
    
    
    [self.iTableView reloadData];
}

+(CGFloat)z_getCellHeight:(id)sender {
    CGFloat cellHeight = [super z_getCellHeight:sender];
    ZStoresListModel *model = sender;
    if (model) {
        return cellHeight + (ValidArray(model.course)? model.course.count * [ZStudentOrganizationHotListCell z_getCellHeight:nil]:0);
    }else{
        return cellHeight;
    }
}
@end

