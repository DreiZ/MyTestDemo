//
//  ZOrganizationTrachingScheduleOutlineErweimaVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTrachingScheduleOutlineErweimaVC.h"
#import "ZAddStudentCodeView.h"
#import "ZUMengShareManager.h"

@interface ZOrganizationTrachingScheduleOutlineErweimaVC ()
@property (nonatomic,strong) ZAddStudentCodeView *codeImageView;
@property (nonatomic,strong) UIButton *navLeftBtn;

@end

@implementation ZOrganizationTrachingScheduleOutlineErweimaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _codeAddModel = [[ZOriganizationStudentCodeAddModel alloc] init];
    self.iTableView.tableFooterView = self.codeImageView;
    self.codeImageView.model = self.codeAddModel;
}

- (void)setNavigation {
    [super setNavigation];
    [self.navigationItem setTitle:@"班级二维码"];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn]];
}

- (ZAddStudentCodeView *)codeImageView {
    if (!_codeImageView) {
        __weak typeof(self) weakSelf = self;
        _codeImageView = [[ZAddStudentCodeView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth-CGFloatIn750(60), CGFloatIn750(180) + CGFloatIn750(762) + CGFloatIn750(120) - CGFloatIn750(70))];
        _codeImageView.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                [[ZUMengShareManager sharedManager] shareUIWithType:0 Title:SafeStr(weakSelf.codeAddModel.courses_name) detail:[NSString stringWithFormat:@"赶紧扫描二维码加入课程跟着%@一起学习%@吧",SafeStr(weakSelf.codeAddModel.teacher_name),SafeStr(weakSelf.codeAddModel.courses_name)] image:weakSelf.codeImageView.userImageView.image url:SafeStr(weakSelf.codeAddModel.url) vc:weakSelf];
            }else if (index == 2){
                UIImage *shortImage = [ZPublicTool snapshotForView:weakSelf.codeImageView.topView];
                if (shortImage) {
                    [ZPublicTool saveImageToPhoto:shortImage];
                }
                
            }else if (index == 1){
                
            }
        };
    }
    return _codeImageView;
}


- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_navLeftBtn setTitle:@"" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor blackColor], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontMaxTitle]];
        [_navLeftBtn setImage:isDarkModel() ? [UIImage imageNamed:@"navleftBackDark"] : [UIImage imageNamed:@"navleftBack"] forState:UIControlStateNormal];
        [_navLeftBtn bk_whenTapped:^{
             
               NSArray *viewControllers = self.navigationController.viewControllers;
               NSArray *reversedArray = [[viewControllers reverseObjectEnumerator] allObjects];
               
               ZViewController *target;
               for (ZViewController *controller in reversedArray) {
                   if ([controller isKindOfClass:[NSClassFromString(@"ZOrganizationTeachingScheduleLessonVC") class]]) {
                       target = controller;
                       break;
                   }
               }
               
               if (target) {
                   [weakSelf.navigationController popToViewController:target animated:YES];
                   return;
               }
               [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _navLeftBtn;
}

@end
