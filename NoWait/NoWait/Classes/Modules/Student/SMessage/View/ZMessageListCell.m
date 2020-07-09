//
//  ZMessageListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMessageListCell.h"
#import "ZBaseLineCell.h"

@interface ZMessageListCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end

@implementation ZMessageListCell

-(void)setupView {
    [super setupView];
    
    _cellConfigArr = @[].mutableCopy;
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(10));
    }];
    
    [self.contView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(24));
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(10));
    }];
    
    UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [detailBtn bk_addEventHandler:^(id sender) {
        if (self.handleBlock) {
            self.handleBlock(self.model, 1);
        };
    }forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:detailBtn];
    [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contView);
    }];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 0.5; //定义按的时间
    [self.contentView addGestureRecognizer:longPress];
}

- (void)btnLong:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        if (self.handleBlock) {
            self.handleBlock(self.model, 200);
        }
    }
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
    }
    return _iTableView;
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_contView, CGFloatIn750(20));
    }
    return _contView;
}


+(CGFloat)z_getCellHeight:(id)sender {
    if (sender && [sender isKindOfClass:[ZMessgeModel class]]) {
        CGFloat cellHeight = CGFloatIn750(64);
        ZMessgeModel *model = sender;
        cellHeight = cellHeight + [ZMessageListCell setTopTitle:model].heightOfCell;
        cellHeight = cellHeight + CGFloatIn750(20);
        switch ([model.notice intValue]) {
            case ZCustomNoticeTypeCourseAudit:                    //  课程审核通知
            case ZCustomNoticeTypePayment:                       //  支付交易通知
            case ZCustomNoticeTypeRefund:                          //  退款通知
            case ZCustomNoticeTypeMoneyBack:                      //  回款通知
            case ZCustomNoticeTypeCourseBegins:                   //  开课通知
            case ZCustomNoticeTypeCourseEnd:                      //  结课通知
            case ZCustomNoticeTypeCourseSign:                     //  签课通知
            case ZCustomNoticeTypeEvaluate:                        //  评价通知
            case ZCustomNoticeTypeCustom:
            {
                cellHeight = cellHeight + [ZMessageListCell setMessageContent:model].heightOfCell;
                cellHeight = cellHeight + CGFloatIn750(20);
                if (ValidStr(model.extra.store_name)) {
                    cellHeight = cellHeight + [ZMessageListCell setMessageSend:model].heightOfCell;
                    cellHeight = cellHeight + CGFloatIn750(20);
                }
                cellHeight = cellHeight + CGFloatIn750(2);
                cellHeight = cellHeight + CGFloatIn750(20);
                cellHeight = cellHeight + [ZMessageListCell setSeeDetail:@"查看详情"].heightOfCell;
                cellHeight = cellHeight + CGFloatIn750(20);
            }
                break;
            case ZCustomNoticeTypeAppointment:                     //  预约通知
            {
                cellHeight = cellHeight + [ZMessageListCell setMessageContent:model].heightOfCell;
                cellHeight = cellHeight + CGFloatIn750(20);
                cellHeight = cellHeight + [ZMessageListCell setMessageSend:model].heightOfCell;
                cellHeight = cellHeight + CGFloatIn750(20);
                cellHeight = cellHeight + CGFloatIn750(2);
                cellHeight = cellHeight + CGFloatIn750(20);
                cellHeight = cellHeight + [ZMessageListCell setSeeDetail:@"查看详情"].heightOfCell;
                cellHeight = cellHeight + CGFloatIn750(20);
            }
                break;
            case ZCustomNoticeTypeSettledIn :                        //  机构入驻通知
            case ZCustomNoticeTypeRegister:                       //  注册通知
            {
                cellHeight = cellHeight + [ZMessageListCell setMessageContent:model].heightOfCell;
                cellHeight = cellHeight + CGFloatIn750(20);
                
                cellHeight = cellHeight + CGFloatIn750(2);
                cellHeight = cellHeight + CGFloatIn750(20);
                cellHeight = cellHeight + [ZMessageListCell setSeeDetail:@"去完善"].heightOfCell;
                cellHeight = cellHeight + CGFloatIn750(20);
            }
                break;
            case ZCustomNoticeTypeNotice:                        //机构老师通知
            {
                if ([[ZUserHelper sharedHelper].user.type intValue] != 2 && [model.terminal intValue] == ZCustomChannleTypeTeacher) {
                    cellHeight = cellHeight + [ZMessageListCell setTeacher:model].heightOfCell;
                    cellHeight = cellHeight + CGFloatIn750(20);
                }
                
                cellHeight = cellHeight + [ZMessageListCell setMessageContent:model].heightOfCell;
                cellHeight = cellHeight + CGFloatIn750(30);
                cellHeight = cellHeight + [ZMessageListCell setMessageSend:model].heightOfCell;
                cellHeight = cellHeight + CGFloatIn750(20);
                
                if ([[ZUserHelper sharedHelper].user.type intValue] != 1) {
                    cellHeight = cellHeight + CGFloatIn750(2);
                    cellHeight = cellHeight + CGFloatIn750(20);
                    cellHeight = cellHeight + [ZMessageListCell setSeeDetail:[NSString stringWithFormat:@"查看收件人(%@)",model.extra.account_total]].heightOfCell;
                    cellHeight = cellHeight + CGFloatIn750(20);
                }else{
                    cellHeight = cellHeight + CGFloatIn750(20);
                }
            }
                break;
            default:
                
                break;
        }
        return cellHeight;
    }
    return 0;
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
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"ZSpaceEmptyCell"]){
//        ZSpaceEmptyCell *enteryCell = (ZSpaceEmptyCell *)cell;
        
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
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"seeDetail"]) {
        if (self.handleBlock) {
            self.handleBlock(self.model, 0);
        }
    }else{
        if (self.handleBlock) {
            self.handleBlock(self.model, 1);
        }
    }
}

#pragma mark - setcellconfig
- (void)setModel:(ZMessgeModel *)model {
    _model = model;
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)initCellConfigArr {
    [self.cellConfigArr removeAllObjects];
    
    [self.cellConfigArr addObject:[ZMessageListCell setTopTitle:self.model]];
    [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:nil]];
    switch ([self.model.notice intValue]) {
        case ZCustomNoticeTypeCourseAudit:                    //  课程审核通知
        case ZCustomNoticeTypePayment:                       //  支付交易通知
        case ZCustomNoticeTypeRefund:                          //  退款通知
        case ZCustomNoticeTypeMoneyBack:                      //  回款通知
        case ZCustomNoticeTypeCourseBegins:                   //  开课通知
        case ZCustomNoticeTypeCourseEnd:                      //  结课通知
        case ZCustomNoticeTypeCourseSign:                     //  签课通知
        case ZCustomNoticeTypeEvaluate:                        //  评价通知
        case ZCustomNoticeTypeCustom:
        {
            [self.cellConfigArr addObject:[ZMessageListCell setMessageContent:self.model]];
            [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:nil]];
            if (ValidStr(self.model.extra.store_name)) {
                [self.cellConfigArr addObject:[ZMessageListCell setMessageSend:self.model]];
                [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:nil]];
            }
            [self.cellConfigArr addObject:[ZMessageListCell setLineCell:CGFloatIn750(2)]];
            [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:@"seeDetail"]];
            [self.cellConfigArr addObject:[ZMessageListCell setSeeDetail:@"查看详情"]];
            [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:@"seeDetail"]];
        }
            break;
        case ZCustomNoticeTypeAppointment:                     //  预约通知
        {
            [self.cellConfigArr addObject:[ZMessageListCell setMessageContent:self.model]];
            [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:nil]];
            [self.cellConfigArr addObject:[ZMessageListCell setMessageSend:self.model]];
            [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:nil]];
            
            [self.cellConfigArr addObject:[ZMessageListCell setLineCell:CGFloatIn750(2)]];
            [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:@"seeDetail"]];
            [self.cellConfigArr addObject:[ZMessageListCell setSeeDetail:@"查看详情"]];
            [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:@"seeDetail"]];
        }
            break;
        case ZCustomNoticeTypeSettledIn :                        //  机构入驻通知
        case ZCustomNoticeTypeRegister:                       //  注册通知
        {
            [self.cellConfigArr addObject:[ZMessageListCell setMessageContent:self.model]];
            [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:nil]];
            
            [self.cellConfigArr addObject:[ZMessageListCell setLineCell:CGFloatIn750(2)]];
            [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:@"seeDetail"]];
            [self.cellConfigArr addObject:[ZMessageListCell setSeeDetail:@"去完善"]];
            [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:@"seeDetail"]];
        }
            break;
        case ZCustomNoticeTypeNotice:                        //机构老师通知
        {
            if ([[ZUserHelper sharedHelper].user.type intValue] != 2 && [self.model.terminal intValue] == ZCustomChannleTypeTeacher) {
                [self.cellConfigArr addObject:[ZMessageListCell setTeacher:self.model]];
                [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:nil]];
            }
            
            [self.cellConfigArr addObject:[ZMessageListCell setMessageContent:self.model]];
            [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(30) cellTitle:nil]];
            [self.cellConfigArr addObject:[ZMessageListCell setMessageSend:self.model]];
            [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:nil]];
            
            if ([[ZUserHelper sharedHelper].user.type intValue] != 1) {
                [self.cellConfigArr addObject:[ZMessageListCell setLineCell:CGFloatIn750(2)]];
                [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:@"seeDetail"]];
                [self.cellConfigArr addObject:[ZMessageListCell setSeeDetail:[NSString stringWithFormat:@"查看收件人(%@)",self.model.extra.account_total]]];
                [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:@"seeDetail"]];
            }else{
                [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:@"seeDetail"]];
            }
        }
            break;
        default:
            
            break;
    }
    [self.iTableView reloadData];
}

+ (ZCellConfig *)setTopTitle:(ZMessgeModel *)messageModel {
//标题;
    NSString *image = @"";
    NSString *type = @"";
    switch ([messageModel.type intValue]) {
        case ZCustomChannleTypeInteract:
        {
            type = @"互动消息";
            image = @"messageTypeHudong";
        }
            break;
        case ZCustomChannleTypeSystem:
        {
            type = @"系统消息";
            image = @"messageTypeSystem";
        }
            break;
        case ZCustomChannleTypeStore:
        {
            type = @"校区消息";
            image = @"messageTypeSchool";
        }
            break;
        case ZCustomChannleTypeTeacher:
        {
            type = @"教师消息";
            image = @"messageTypeStore";
        }
            break;
        case ZCustomChannleTypeStudent:
        {
            type = @"学员消息";
            image = @"messageTypeSystem";
        }
            break;
        case ZCustomChannleTypeCustom:
        {
            type = @"通知消息";
            image = @"ZCustomChannleTypeCustom";
        }
            break;
            
        default:
            
            break;
    }
    ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"message")
        .zz_imageLeft(image).zz_titleLeft(type)
        .zz_fontLeft([UIFont boldFontTitle])
        .zz_fontRight([UIFont fontSmall])
        .zz_titleRight(SafeStr(messageModel.time)).zz_colorRight([UIColor colorTextGray1])
        .zz_colorDarkRight([UIColor colorTextGray1Dark])
        .zz_imageLeftHeight(CGFloatIn750(30))
        .zz_lineHidden(YES)
        .zz_cellHeight(CGFloatIn750(54));

    ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
    return tempCellConfig;
}

+ (ZCellConfig *)setMessageContent:(ZMessgeModel *)messageModel {
    ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"message")
    .zz_titleLeft(SafeStr(messageModel.body))
    .zz_fontLeft([UIFont fontContent])
    .zz_colorLeft([UIColor colorTextGray])
    .zz_colorDarkLeft([UIColor colorTextGrayDark])
    .zz_cellWidth(KScreenWidth - CGFloatIn750(60))
    .zz_marginRight(CGFloatIn750(32))
    .zz_leftMultiLine(YES)
    .zz_lineHidden(YES)
    .zz_cellHeight(CGFloatIn750(36))
    .zz_spaceLine(CGFloatIn750(12));

    ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    return tempCellConfig;
}

+ (ZCellConfig *)setMessageSend:(ZMessgeModel *)messageModel {
    ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"message")
    .zz_titleRight(SafeStr(messageModel.extra.store_name))
        .zz_colorRight([UIColor colorTextBlack])
        .zz_colorDarkRight([UIColor colorTextBlackDark])
        .zz_fontRight([UIFont boldFontSmall])
        .zz_lineHidden(YES)
        .zz_cellHeight(CGFloatIn750(30));

    ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

    return tempCellConfig;
}

+ (ZCellConfig *)setSeeDetail:(NSString *)seeDetail {
    ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"seeDetail")
    .zz_titleLeft(SafeStr(seeDetail))
    .zz_fontLeft([UIFont fontSmall])
    .zz_imageRight(@"rightBlackArrowN")
    .zz_imageRightHeight(CGFloatIn750(12))
    .zz_lineHidden(YES)
    .zz_cellHeight(CGFloatIn750(54));

    ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    return tempCellConfig;
}

+ (ZCellConfig *)setTeacher:(ZMessgeModel *)messageModel {
    ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"message")
        .zz_titleLeft(SafeStr(messageModel.extra.teacher))
        .zz_imageLeft(SafeStr(messageModel.extra.teacher_image))
        .zz_imageLeftHeight(CGFloatIn750(44))
        .zz_lineHidden(YES)
    .zz_cellHeight(CGFloatIn750(74)).zz_imageLeftRadius(YES);

    ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    
    return tempCellConfig;
}

+ (ZCellConfig *)setEmptyCell:(CGFloat)height cellTitle:(NSString *)cellTitle{
    ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:cellTitle ? cellTitle:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:height cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
    return cellConfig;
}

+ (ZCellConfig *)setLineCell:(CGFloat)height {
     ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"message")
       .zz_lineHidden(NO)
       .zz_cellHeight(height)
       .zz_contentSpaceLeft(CGFloatIn750(46))
       .zz_contentSpaceRight(CGFloatIn750(46));

    ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    return tempCellConfig;
}
@end
