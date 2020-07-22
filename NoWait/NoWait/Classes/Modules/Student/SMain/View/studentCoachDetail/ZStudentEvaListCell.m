//
//  ZStudentEvaListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentEvaListCell.h"
#import "ZOrganizationEvaListUserInfoCell.h"
#import "ZStudentEvaListReEvaCell.h"

@interface ZStudentEvaListCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZStudentEvaListCell

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
    [super setupView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.cellConfigArr = @[].mutableCopy;
    [self.contentView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(-4));
    }];
}

#pragma mark lazy loading...
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
        } else {
            
        }
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.layer.masksToBounds = YES;
        _iTableView.scrollEnabled = NO;
        _iTableView.clipsToBounds = YES;
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
//    __weak typeof(self) weakSelf = self;
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
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"ZOrganizationEvaListEvaBtnCell"]) {
        
    }
    if (self.evaBlock) {
        self.evaBlock(1);
    }
}

+ (CGFloat)z_getCellHeight:(id)sender {
    ZOrderEvaListModel *evaModel = sender;
    
    CGFloat cellHeight = 0;
    {
        cellHeight += CGFloatIn750(24);
        cellHeight += [ZOrganizationEvaListUserInfoCell z_getCellHeight:nil];
        cellHeight += CGFloatIn750(10);
    }
    
    if (ValidStr(evaModel.des)) {
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"des");
        model.zz_titleLeft(evaModel.des);
        model.zz_leftMultiLine(YES);
        model.zz_marginLeft(CGFloatIn750(86));
        model.zz_marginRight(CGFloatIn750(30));
        model.zz_cellHeight(CGFloatIn750(62));
        model.zz_fontLeft([UIFont fontContent]);
        
        cellHeight += [ZBaseLineCell z_getCellHeight:model];
    }
    {
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"des");
        model.zz_cellHeight(CGFloatIn750(46));
        
        cellHeight += [ZBaseLineCell z_getCellHeight:model];
    }
    
    if ([evaModel.is_reply intValue] == 1) {
     cellHeight += [ZStudentEvaListReEvaCell z_getCellHeight:evaModel.reply_desc];
     cellHeight += CGFloatIn750(20);
    }
    
    return  cellHeight;
}

- (void)setModel:(ZOrderEvaListModel *)model {
    _model = model;
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)initCellConfigArr {
    [self.cellConfigArr removeAllObjects];
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(24))];
        ZCellConfig *top1CellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListUserInfoCell className] title:[ZOrganizationEvaListUserInfoCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationEvaListUserInfoCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.model];
        [self.cellConfigArr addObject:top1CellConfig];
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(10))];
    }
    
    if (ValidStr(self.model.des)) {
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"des");
        model.zz_titleLeft(self.model.des);
        model.zz_lineHidden(YES);
        model.zz_leftMultiLine(YES);
        model.zz_marginLeft(CGFloatIn750(86));
        model.zz_marginRight(CGFloatIn750(30));
        model.zz_cellHeight(CGFloatIn750(62));
        model.zz_fontLeft([UIFont fontContent]);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr  addObject:menuCellConfig];
    }
    if ([_model.is_reply intValue] == 1) {
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentEvaListReEvaCell className] title:[ZStudentEvaListReEvaCell className] showInfoMethod:@selector(setData:) heightOfCell:[ZStudentEvaListReEvaCell z_getCellHeight:_model.reply_desc] cellType:ZCellTypeClass dataModel:@{@"title":_model.isTeacher ? SafeStr(_model.teacher_name):SafeStr(_model.stores_name),@"content":SafeStr(_model.reply_desc)}];
        [self.cellConfigArr addObject:orderCellConfig];
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
    }
    {
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"des");
        model.zz_titleLeft(self.model.stores_courses_name);
        model.zz_lineHidden(YES);
        model.zz_marginLeft(CGFloatIn750(86));
        model.zz_marginRight(CGFloatIn750(30));
        model.zz_cellHeight(CGFloatIn750(46));
        model.zz_fontLeft([UIFont fontMin]);
        model.zz_colorLeft([UIColor colorTextGray1]);
        model.zz_colorDarkLeft([UIColor colorTextGray1]);

        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr  addObject:menuCellConfig];
    }
}

@end
