//
//  ZIDICardmagePickerController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/24.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZIDICardmagePickerController.h"

@interface ZIDICardmagePickerController ()

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *detailLabel;

@property (nonatomic, strong)UIImageView *headImageView;

@property (nonatomic, strong)CAShapeLayer *shapeLayer;

@end

@implementation ZIDICardmagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeupUI];
}


- (void)makeupUI
{
    //
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor colorWithRed:0xff/255.f green:0xbc/255.f blue:0x2e/255.f alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"拍摄正面身份证";
    [self.view addSubview:self.titleLabel];
    
    //
    self.detailLabel = [[UILabel alloc]init];
    self.detailLabel.textColor = [UIColor whiteColor];
    self.detailLabel.font = [UIFont systemFontOfSize:14];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    self.detailLabel.text = @"将身份证放入虚线框内，亮度均匀";
    [self.view addSubview:self.detailLabel];
    
    self.headImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_kaluli_zhengmian"]];
    [self.view addSubview:self.headImageView];

}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 10, self.view.bounds.size.width, 28);
    self.detailLabel.frame = CGRectMake(0, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height, self.view.bounds.size.width, 22);
    
    float kWidth = 240;
    float kHeight = 360;
//    float kScreenHeight = self.bounds.size.height;
    // 375
    float scale = kScreenWidth/375.f;
    
    CGRect cropRect = CGRectMake((kScreenWidth-kWidth)/2.f*scale, 78*scale, kWidth*scale, kHeight*scale);
    [self setCropRect:cropRect];
    
    self.headImageView.frame = CGRectMake(cropRect.origin.x+50*scale, cropRect.origin.y+212*scale, 140*scale, 112*scale);
}


- (void)setCropRect:(CGRect)cropRect
{
    if (self.shapeLayer)
    {
        [self.shapeLayer removeFromSuperlayer];
        self.shapeLayer = nil;
    }
    
    self.shapeLayer = [[CAShapeLayer alloc] init];
    [self.shapeLayer setStrokeColor:[UIColor blackColor].CGColor];
    [self.shapeLayer setLineWidth:1];
    [self.shapeLayer setLineJoin:kCALineJoinRound];
    [self.shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:3],nil]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRoundedRect(path, nil, cropRect, 3.f, 3.f);
    CGPathAddRect(path, nil, self.view.bounds);

    [self.shapeLayer setFillRule:kCAFillRuleEvenOdd];
    [self.shapeLayer setPath:path];
    [self.shapeLayer setFillColor:[UIColor blackColor].CGColor];
    [self.shapeLayer setOpacity:0.6];
    [self.shapeLayer setNeedsDisplay];

    [self.view.layer insertSublayer:self.shapeLayer atIndex:0];
}

@end
