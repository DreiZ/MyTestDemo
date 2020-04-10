//
//  ZOrganizationStudentManageVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"

#import "ZOrganizationStudentTopFilterSeaarchView.h"
#import "ZOriganizationTeachSearchTopHintView.h"
#import "ZOriganizationModel.h"

@interface ZOrganizationStudentManageVC : ZTableViewViewController
@property (nonatomic,strong) UIButton *navRightBtn;
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UIButton *sendBtn;
@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) NSMutableDictionary *param;
@property (nonatomic,assign) BOOL isEdit;

@property (nonatomic,strong) ZOrganizationStudentTopFilterSeaarchView *filterView;
@property (nonatomic,strong) ZOriganizationTeachSearchTopHintView *searchTopView;

- (NSMutableArray *)getSelectedData ;
- (void)setIsEdit:(BOOL)isEdit;
- (void)selectDataEdit:(BOOL)isEdit;
- (void)leftBtnOnClick;
@end

