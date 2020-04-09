//
//  ZOriganizationIDCardCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationIDCardCell.h"

@interface ZOriganizationIDCardCell ()

@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *rightImageView;

@end

@implementation ZOriganizationIDCardCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.rightImageView];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(CGFloatIn750(206));
        make.width.mas_equalTo(CGFloatIn750(336));
    }];
    
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(CGFloatIn750(206));
        make.width.mas_equalTo(CGFloatIn750(336));
    }];
    
    
    __weak typeof(self) weakSelf = self;
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [leftBtn bk_whenTapped:^{
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(0);
        }
    }];
    
    [self.contentView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.leftImageView);
    }];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [rightBtn bk_whenTapped:^{
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(1);
        }
    }];
    
    [self.contentView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.rightImageView);
    }];
}

#pragma mark -Getter
- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.backgroundColor = [UIColor grayColor];
    }
    return _leftImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.backgroundColor = [UIColor grayColor];
    }
    return _rightImageView;
}

- (void)setImages:(NSArray *)images {
    _images = images;
    if (images && images.count > 0) {
        id data = images[0];
        if ([data isKindOfClass:[UIImage class]]) {
            _leftImageView.image = data;
        }else{
            [_leftImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(data)] placeholderImage:[UIImage imageNamed:@"cardImageup"]];
        }
        
        if (images.count > 1) {
            id data = images[1];
            if ([data isKindOfClass:[UIImage class]]) {
                _rightImageView.image = data;
            }else{
                [_rightImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(data)] placeholderImage:[UIImage imageNamed:@"cardImageback"]];
            }
        }
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(256);
}
@end




