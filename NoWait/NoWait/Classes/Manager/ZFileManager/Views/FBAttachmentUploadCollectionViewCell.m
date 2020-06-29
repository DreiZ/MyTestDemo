//
//  FBAttachmentUploadCollectionViewCell.m
//  FengbangB
//
//  Created by fengbang on 2018/6/28.
//  Copyright © 2018年 com.fengbangstore. All rights reserved.
//

#import "FBAttachmentUploadCollectionViewCell.h"
#import "FBCustomUploadProgress.h"


@interface FBAttachmentUploadCollectionViewCell ()
@property (nonatomic, strong) UIImageView *resourceImageView;
@property (nonatomic, strong) UIButton *cleanButton;
@property (nonatomic, strong) FBCustomUploadProgress *progressView;
@property (nonatomic, strong) UILabel *stateLabel;

@end

/**最大的图片个数*/
extern NSInteger const kAttachmentPhotoMaxNumber;

@implementation FBAttachmentUploadCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

#pragma mark - private
- (void)setUI {
    [self setSubViewsUI];
}

- (void)setSubViewsUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *resourceImageView = [[UIImageView alloc] init];
    resourceImageView.contentMode = UIViewContentModeScaleAspectFill;
    resourceImageView.clipsToBounds = YES;
    resourceImageView.backgroundColor = HexColor(0xE6E6E6);
    [self.contentView addSubview:resourceImageView];
    self.resourceImageView = resourceImageView;
    
    UIButton *cleanButton = [[UIButton alloc] init];
    [cleanButton setBackgroundImage:[UIImage imageNamed:@"clean_attachment_icon"] forState:UIControlStateNormal];
    [cleanButton addTarget:self action:@selector(cleanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cleanButton];
    self.cleanButton = cleanButton;
    
    FBCustomUploadProgress *progressView = [[FBCustomUploadProgress alloc] init];
    [progressView configProgressBgColor:[UIColor colorWithWhite:0. alpha:.5] progressColor:[UIColor colorMain]];
    progressView.hidden = YES;
    progressView.presentlab.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:progressView];
    self.progressView = progressView;
    
    [self.contentView addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.resourceImageView.frame = self.contentView.bounds;
    CGFloat cleanButtonW = 30;
    self.cleanButton.frame = CGRectMake(self.resourceImageView.width - cleanButtonW, 0, cleanButtonW, cleanButtonW);
    self.progressView.frame = CGRectMake(5, self.contentView.height - 14 - 5, self.contentView.width - 10, 14);
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _stateLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1],[UIColor colorTextGray1Dark]);
        _stateLabel.backgroundColor = [UIColor colorWithWhite:0. alpha:.5];
        _stateLabel.numberOfLines = 1;
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        [_stateLabel setFont:[UIFont fontContent]];
    }
    return _stateLabel;
}

#pragma mark - setData
- (void)setTask:(ZFileUploadTask *)task {
    _task = task;
    
    self.resourceImageView.image = task.model.image;
//    [self showCleanIcon:!model.hiddenCleanIcon];
    [self configCellProgress:0.01];
    
    if (task.model.taskState != ZUploadStateFinished) {
        task.model.progressBlock = ^(int64_t nowProcress, int64_t totalProcress) {
            [self showProgress:YES];
            [self showCleanIcon:NO];
            [self configCellProgress:1.0f * nowProcress/totalProcress];
        };
        
        task.model.completeBlock = ^(id obj) {
            [self showCleanIcon:YES];
            [self showProgress:NO];
        };
        
        task.model.errorBlock = ^(NSError *error) {
            
        };
    }else if(task.model.taskState == ZUploadStateFinished) {
        [self showCleanIcon:YES];
        [self showProgress:NO];
    }
}

- (void)setTaskModel:(ZFileUploadDataModel *)taskModel {
    _taskModel = taskModel;
        
    self.resourceImageView.image = taskModel.image;
//    [self showCleanIcon:!model.hiddenCleanIcon];
    [self configCellProgress:0.01];
    
    if (taskModel.taskState != ZUploadStateFinished) {
        taskModel.progressBlock = ^(int64_t nowProcress, int64_t totalProcress) {
            [self showProgress:YES];
            [self showCleanIcon:NO];
            [self configCellProgress:1.0f * nowProcress/totalProcress];
            [self updateState];
            DLog(@"-------progressBlock");
        };
        
        taskModel.completeBlock = ^(id obj) {
            [self showCleanIcon:YES];
            [self showProgress:NO];
            [self updateState];
            DLog(@"-------completeBlock");
        };
        
        taskModel.errorBlock = ^(NSError *error) {
            [self updateState];
        };
    }else if(taskModel.taskState == ZUploadStateFinished) {
        [self showCleanIcon:YES];
        [self showProgress:NO];
    }
//    else if(taskModel.taskState == ZUploadStateFinished) {
//        [self showCleanIcon:YES];
//        [self showProgress:NO];
//    }
    
    [self updateState];
    
    [self showCleanIcon:NO];
}

- (void)updateState {
    if (_taskModel.taskState == ZUploadStateWaiting) {
        _stateLabel.text = @"等待上传";
    }else if (_taskModel.taskState == ZUploadStateOnGoing) {
        _stateLabel.text = @"";
    }else if (_taskModel.taskState == ZUploadStatePaused) {
        _stateLabel.text = @"暂停";
    }else if (_taskModel.taskState == ZUploadStateError) {
        _stateLabel.text = @"上传失败";
    }else if (_taskModel.taskState == ZUploadStateFinished) {
        _stateLabel.text = @"上传完成";
    }else if (_taskModel.taskState == ZUploadStateZiping) {
        _stateLabel.text = @"压缩中";
    }
    [self showCleanIcon:NO];
}

#pragma mark - public
- (void)configCellAdd {
    [self showCleanIcon:NO];
    [self showProgress:NO];
    self.resourceImageView.image = [UIImage imageNamed:@"add_attachment_icon"];
}

- (void)configCellProgress:(CGFloat)progress {
    [self.progressView setPresent:progress];
}

- (void)showProgress:(BOOL)show {
    self.progressView.hidden = !show;
}

- (void)showCleanIcon:(BOOL)show {
    self.cleanButton.hidden = !show;
}

#pragma mark - private
- (void)cleanButtonClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(configCellDelete:withOject:)]) {
        [self.delegate configCellDelete:self withOject:nil];
    }
}

@end

