//
//  DemoRefreshBaseViewController.m
//  Demo
//
//  Created by Li challenger on 13-10-11.
//
//

#import "DemoRefreshBaseViewController.h"
#import "DemoHeaderView.h"
#import "DemoFooterView.h"

@interface DemoRefreshBaseViewController ()

@end

@implementation DemoRefreshBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.items = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // header & footer view
    CGRect frame = CGRectMake(0, 0, 320, 50);
	DemoHeaderView *hv = [[DemoHeaderView alloc]initWithFrame:frame];
    DemoFooterView *fv = [[DemoFooterView alloc]initWithFrame:frame];
    self.headerView = hv;
    self.footerView = fv;
    [hv release];
    [fv release];
}

#pragma mark - Pull to refresh & load more

- (void) pinHeaderView{
    [super pinHeaderView];
    
    DemoHeaderView *hv = (DemoHeaderView *)self.headerView;
    [hv.activityIndicator startAnimating];
    hv.infoLabel.text = @"Loading...";
}

- (void) unpinHeaderView{
    [super unpinHeaderView];
    
    [[(DemoHeaderView *)self.headerView activityIndicator] stopAnimating];
}

- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
    DemoHeaderView *hv = (DemoHeaderView *)self.headerView;
    if (willRefreshOnRelease) {
        hv.infoLabel.text = @"Release to refresh...";
    }
    else{
        hv.infoLabel.text = @"Pull down to refresh...";
    }
}

- (BOOL) refresh{
    if (![super refresh]) {
        return NO;
    }
    
    // Do your async call here
    // This is just a dummy data loader:
    [self performSelector:@selector(additemsOnRefresh) withObject:nil afterDelay:2.0];
    // See -addItemsOnTop for more info on how to finish loading
    
    // Call this to indicate that we have finished "refreshing".
    // This will then result in the headerView being unpinned (-unpinHeaderView will be called).
    //    [self refreshCompleted];
    
    return YES;
}

//
// The method -loadMore was called and will begin fetching data for the next page (more).
// Do custom handling of -footerView if you need to.
//
- (void) willBeginLoadingMore
{
    DemoFooterView *fv = (DemoFooterView *)self.footerView;
    fv.infoLabel.text = @"Loading...";
    [fv.activityIndicator startAnimating];
}

//
// Do UI handling after the "load more" process was completed. In this example, -footerView will
// show a "No more items to load" text.
//
- (void) loadMoreCompleted
{
    [super loadMoreCompleted];
    
    DemoFooterView *fv = (DemoFooterView *)self.footerView;
    [fv.activityIndicator stopAnimating];
    
    if (!self.canLoadMore) {
        // Do something if there are no more items to load
        
        // We can hide the footerView by: [self setFooterViewVisibility:NO];
        
        // Just show a textual info that there are no more items to load
        fv.infoLabel.hidden = NO;
    }
}

- (BOOL) loadMore
{
    if (![super loadMore])
        return NO;
    
    // Do your async loading here
    [self performSelector:@selector(additemsOnAddMore) withObject:nil afterDelay:2.0];
    // See -addItemsOnBottom for more info on what to do after loading more items
    
    // we have finished loading more items
    //    [self loadMoreCompleted];
    
    return YES;
}

#pragma mark - Dummy data methods

- (void) additemsOnRefresh
{
    NSLog(@"");
}

- (void) additemsOnAddMore
{
    NSLog(@"");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
