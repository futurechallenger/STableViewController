//
//  DemoFooterView.h
//  Demo
//
//  Created by Li challenger on 13-10-11.
//
//

#import <UIKit/UIKit.h>

@interface DemoFooterView : UIView

@property (nonatomic, retain) UILabel *infoLabel;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

- (void) redecorateSubviews;

@end
