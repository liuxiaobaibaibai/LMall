//
//  lwCustomCalloutView.m
//  shopCart
//
//  Created by lw on 16/4/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwCustomCalloutView.h"

#import "lwCustomAnnotationView.h"

#define padding 5
#define kArrorHeight        10
#define kPortraitMargin     5
#define kPortraitWidth      70
#define kPortraitHeight     50

#define kTitleWidth         120
#define kTitleHeight        20

@interface lwCustomCalloutView()

@property (nonatomic, strong) UIImageView *portraitView;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *navButton;

@end


@implementation lwCustomCalloutView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    // 添加图片，即商户图
    self.portraitView = [[UIImageView alloc] init];
    self.portraitView.contentMode = UIViewContentModeScaleAspectFit;
    self.portraitView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.portraitView];
    
    // 添加标题，即商户名
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.text = @"titletitletitletitle";
    [self addSubview:self.titleLabel];
    
    // 添加副标题，即商户地址
    self.subtitleLabel = [[UILabel alloc] init];
    self.subtitleLabel.font = [UIFont systemFontOfSize:12];
    self.subtitleLabel.textColor = [UIColor grayColor];
    self.subtitleLabel.text = @"subtitleLabelsubtitleLabelsubtitleLabel";
    [self addSubview:self.subtitleLabel];
    
    self.navButton = [[UIButton alloc] init];
    [self.navButton setTitle:@"导航" forState:UIControlStateNormal];
    [self.navButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navButton setBackgroundColor:RGB(75, 187, 251)];
    [self.navButton.layer setBorderWidth:1.0];
    [self.navButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.navButton.layer setCornerRadius:5.0];
    [self.navButton.layer setMasksToBounds:YES];
    [self addSubview:self.navButton];
    [self.navButton addTarget:self action:@selector(navButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_portraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-padding*2);
        make.right.mas_equalTo(_titleLabel.mas_left).with.offset(-padding);
        make.right.mas_equalTo(_subtitleLabel.mas_left).with.offset(-padding);
        make.width.mas_equalTo(50);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(padding);
        make.left.mas_equalTo(_portraitView.mas_right).with.offset(padding);
        make.right.mas_equalTo(_navButton.mas_left).with.offset(-padding);
        make.bottom.mas_equalTo(_subtitleLabel.mas_top).with.offset(-padding);
        make.centerX.mas_equalTo(_subtitleLabel.mas_centerX);
        make.height.mas_equalTo(_subtitleLabel.mas_height);
    }];
    
    [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(padding);
        make.bottom.mas_equalTo(-padding*2);
        make.left.mas_equalTo(_portraitView.mas_right).with.offset(padding);
        make.right.mas_equalTo(_navButton.mas_left).with.offset(-padding);
        make.centerX.mas_equalTo(_titleLabel.mas_centerX);
        make.height.mas_equalTo(_titleLabel.mas_height);
    }];
    
    [_navButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(padding*2);
        make.bottom.mas_equalTo(-padding*4);
        make.left.mas_equalTo(_titleLabel.mas_right).with.offset(padding);
        make.left.mas_equalTo(_subtitleLabel.mas_right).with.offset(padding);
        make.right.mas_equalTo(-padding);
        make.width.mas_equalTo(50);
    }];

}

- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
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
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}


- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setSubtitle:(NSString *)subtitle
{
    self.subtitleLabel.text = subtitle;
}

- (void)setImage:(UIImage *)image
{
    self.portraitView.image = image;
}

- (void)navButtonClick:(UIButton *)btn{
    [lwCommon turnByTurn:((lwCustomAnnotationView *)self.superview).annotation.coordinate EndAddressName:((lwCustomAnnotationView *)self.superview).annotation.title PhoneNo:@"13921292817"];
}

@end
