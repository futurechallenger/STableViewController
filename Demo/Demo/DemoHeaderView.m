//
//  DemoHeaderView.m
//  Demo
//
//  Created by Li challenger on 13-10-11.
//
//

#import "DemoHeaderView.h"

#define kInfoLabelHeight 30
#define kInfoLabelMargin 50

@implementation DemoHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _infoLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectZero];
        [self addSubview:_infoLabel];
        [self addSubview:_activityIndicator];
        
        [_infoLabel release];
        [_activityIndicator release];
    }
    return self;
}

- (void)dealloc
{
    self.infoLabel = nil;
    self.activityIndicator = nil;
    [super dealloc];
}

- (void) redecorateSubviews
{
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat width = CGRectGetWidth(self.frame);
    self.infoLabel.frame = CGRectMake(kInfoLabelMargin, (height - kInfoLabelHeight) / 2
                                      , width - 2 * kInfoLabelMargin, kInfoLabelHeight);
    self.activityIndicator.frame = CGRectMake(15, (height - kInfoLabelHeight) / 2, kInfoLabelHeight, kInfoLabelHeight);
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    [self redecorateSubviews];
}

@end
