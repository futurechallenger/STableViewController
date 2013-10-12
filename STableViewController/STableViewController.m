//
// STableViewController.m
//
// @author Shiki
//

#import "STableViewController.h"

#define DEFAULT_HEIGHT_OFFSET 52.0f


@implementation STableViewController

@synthesize demoTableView;
@synthesize headerView;
@synthesize footerView;

@synthesize isDragging;
@synthesize isRefreshing;
@synthesize isLoadingMore;

@synthesize canLoadMore;
@synthesize pullToRefreshEnabled;
@synthesize clearsSelectionOnViewWillAppear;

/*
 *
 */
- (void) initialize
{
    pullToRefreshEnabled = YES;
    canLoadMore = YES;
    clearsSelectionOnViewWillAppear = YES;
}

#pragma mark - Init & dealloc

- (id) init
{
    if ((self = [super init]))
        [self initialize];
    return self;
}

- (void) dealloc
{
    [self releaseViewComponents];
    [super dealloc];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
        [self initialize];
    return self;
}

#pragma mark - View lefe cycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.demoTableView = [[[UITableView alloc] init] autorelease];
    demoTableView.frame = self.view.bounds;
    demoTableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    demoTableView.dataSource = self;
    demoTableView.delegate = self;
    
    [self.view addSubview:demoTableView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (clearsSelectionOnViewWillAppear) {
        NSIndexPath *selected = [self.demoTableView indexPathForSelectedRow];
        if (selected)
            [self.demoTableView deselectRowAtIndexPath:selected animated:animated];
    }
}

- (void) viewDidUnload
{
    [self releaseViewComponents];
    [super viewDidUnload];
}

#pragma mark - Pull to Refresh

- (void) setHeaderView:(UIView *)aView
{
    if (!demoTableView)
        return;
    
    if (headerView && [headerView isDescendantOfView:demoTableView])
        [headerView removeFromSuperview];
    [headerView release]; headerView = nil;
    
    if (aView) {
        headerView = [aView retain];
        
        CGRect f = headerView.frame;
        headerView.frame = CGRectMake(f.origin.x, 0 - f.size.height, f.size.width, f.size.height);
        headerViewFrame = headerView.frame;
        
        [demoTableView addSubview:headerView];
    }
}

- (CGFloat) headerRefreshHeight
{
    if (!CGRectIsEmpty(headerViewFrame))
        return headerViewFrame.size.height;
    else
        return DEFAULT_HEIGHT_OFFSET;
}

- (void) pinHeaderView
{
    [UIView animateWithDuration:0.3 animations:^(void) {
        self.demoTableView.contentInset = UIEdgeInsetsMake([self headerRefreshHeight], 0, 0, 0);
    }];
}

- (void) unpinHeaderView
{
    [UIView animateWithDuration:0.3 animations:^(void) {
        self.demoTableView.contentInset = UIEdgeInsetsZero;
    }];
}

- (void) willBeginRefresh
{
    if (pullToRefreshEnabled)
        [self pinHeaderView];
}

- (void) willShowHeaderView:(UIScrollView *)scrollView
{
    
}

- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
    
}

- (BOOL) refresh
{
    if (isRefreshing)
        return NO;
    
    [self willBeginRefresh];
    isRefreshing = YES;
    return YES;
}

- (void) refreshCompleted
{
    isRefreshing = NO;
    
    if (pullToRefreshEnabled)
        [self unpinHeaderView];
}

#pragma mark - Load More

- (void) setFooterView:(UIView *)aView
{
    if (!demoTableView)
        return;
    
    demoTableView.tableFooterView = nil;
    [footerView release]; footerView = nil;
    
    if (aView) {
        footerView = [aView retain];
        
        demoTableView.tableFooterView = footerView;
    }
}

- (void) willBeginLoadingMore
{
    
}

- (void) loadMoreCompleted
{
    isLoadingMore = NO;
}

- (BOOL) loadMore
{
    if (isLoadingMore)
        return NO;
    
    [self willBeginLoadingMore];
    isLoadingMore = YES;
    return YES;
}

- (CGFloat) footerLoadMoreHeight
{
    if (footerView)
        return footerView.frame.size.height;
    else
        return DEFAULT_HEIGHT_OFFSET;
}

- (void) setFooterViewVisibility:(BOOL)visible
{
    if (visible && self.demoTableView.tableFooterView != footerView)
        self.demoTableView.tableFooterView = footerView;
    else if (!visible)
        self.demoTableView.tableFooterView = nil;
}

#pragma mark -

- (void) allLoadingCompleted
{
    if (isRefreshing)
        [self refreshCompleted];
    if (isLoadingMore)
        [self loadMoreCompleted];
}

#pragma mark - UIScrollViewDelegate

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (isRefreshing)
        return;
    isDragging = YES;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!isRefreshing && isDragging && scrollView.contentOffset.y < 0) {
        [self headerViewDidScroll:scrollView.contentOffset.y < 0 - [self headerRefreshHeight]
                       scrollView:scrollView];
    } else if (!isLoadingMore && canLoadMore) {
        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
        if (scrollPosition < [self footerLoadMoreHeight]) {
            [self loadMore];
        }
    }
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (isRefreshing)
        return;
    
    isDragging = NO;
    if (scrollView.contentOffset.y <= 0 - [self headerRefreshHeight]) {
        if (pullToRefreshEnabled)
            [self refresh];
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark -

- (void) releaseViewComponents
{
    [headerView release]; headerView = nil;
    [footerView release]; footerView = nil;
    [demoTableView release]; demoTableView = nil;
}

@end
