//
//  DemoRefreshViewController.m
//  Demo
//
//  Created by Li challenger on 13-10-12.
//
//

#import "DemoRefreshViewController.h"

@interface DemoRefreshViewController ()

@end

@implementation DemoRefreshViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"Demo";
//    [self.demoTableView setBackgroundColor:[UIColor lightGrayColor]];
    
    // add sample items
    NSMutableArray *tempItems = [[NSMutableArray alloc] init];
    self.items = tempItems;
    [tempItems release];
    
    for (int i = 0; i < 20; i++)
        [self.items addObject:[self createRandomValue]];
}

- (void)fillInRefreshData
{
    for (int i = 0; i < 3; i++)
        [self.items insertObject:[self createRandomValue] atIndex:0];
    [self.demoTableView reloadData];
}

- (void)fillInLoadMoreData
{
    // load more data,
    // reload table view
    for (int i = 0; i < 5; i++)
        [self.items addObject:[self createRandomValue]];
    
    [self.demoTableView reloadData];
    
    if (self.items.count > 50)
        self.canLoadMore = NO; // signal that there won't be any more items to load
    else
        self.canLoadMore = YES;
    
    // Inform STableViewController that we have finished loading more items
    [self loadMoreCompleted];
}

//
// you can requets data from web or load data from you loca storage to the table view,
// then fill int the data with method: fillInRefreshData and then tell users the
// load is completed by methods: refreshCompleted.
//
- (void) additemsOnRefresh{
    [self fillInRefreshData];
    
    // when data is loaded and showed in tableview, the refresh is completed.
    [self refreshCompleted];
}

//
// how this method works is totally the same with the method: additemsOnRefresh.
// just in this methods, data will be added at the end of the data source.
//
- (void) additemsOnAddMore{
    [self fillInLoadMoreData];
    [self loadMoreCompleted];
}

//
// creat some data here to show how these things work.
//
- (NSString *) createRandomValue
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    return [NSString stringWithFormat:@"%@ %@", [dateFormatter stringFromDate:[NSDate date]],
            [NSNumber numberWithInt:rand()]];
}

#pragma mark - UITableView stuff

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
