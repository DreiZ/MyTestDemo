//
//  ZCustomCalloutView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/8/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCustomCalloutView.h"
#import "ZClusterTableViewCell.h"


const NSInteger kArrorHeight = 10;
const NSInteger kCornerRadius = 6;

const NSInteger kWidth = 260;
const NSInteger kMaxHeight = 200;

const NSInteger kTableViewMargin = 4;
const NSInteger kCellHeight = 44;


@interface ZCustomCalloutView()

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation ZCustomCalloutView

- (void)setPoiArray:(NSArray *)poiArrayy
{
    _poiArray = [NSArray arrayWithArray:poiArrayy];
    CGFloat totalHeight = kCellHeight * self.poiArray.count + kArrorHeight + 2 *kTableViewMargin;
    CGFloat height = MIN(totalHeight, kMaxHeight);

    self.frame = CGRectMake(0, 0, kWidth, height);
    
    self.tableview.frame = CGRectMake(kCornerRadius, kTableViewMargin, kWidth - kCornerRadius * 2, height - kArrorHeight - kTableViewMargin * 2);
    
    [self setNeedsDisplay];
    [self.tableview reloadData];
}

- (void)dismissCalloutView
{
    self.poiArray = nil;
    [self removeFromSuperview];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.poiArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZClusterTableViewCell *cell = [ZClusterTableViewCell z_cellWithTableView:tableView];
    

    AMapPOI *poi = [self.poiArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = poi.name;
    cell.detailLabel.text = poi.address;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AMapPOI *poi = [self.poiArray objectAtIndex:indexPath.row];
    if (self.detailBlock) {
        self.detailBlock(poi);
    }
}

#pragma mark - TapGesture

- (void)detailBtnTap:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(didDetailButtonTapped:)])
    {
        [self.delegate didDetailButtonTapped:button.tag];
    }
}

#pragma mark - draw rect

- (void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

- (void)drawInContext:(CGContextRef)context
{
    CGContextSetLineWidth(context, 3.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor);
    
    [self drawPath:context];
    CGContextFillPath(context);
}

- (void)drawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = kCornerRadius;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);

    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx+kArrorHeight, maxy, radius);
    CGContextClosePath(context);
}

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];

        self.tableview = [[UITableView alloc] init];
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        
        [self addSubview:self.tableview];
    }
    return self;
}



@end

