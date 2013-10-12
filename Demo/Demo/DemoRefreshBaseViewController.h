//
//  DemoRefreshBaseViewController.h
//  Demo
//
//  Created by Li challenger on 13-10-11.
//
//

#import "STableViewController.h"

@interface DemoRefreshBaseViewController : STableViewController

@property (nonatomic, retain) NSMutableArray *items;

- (void) additemsOnRefresh;
- (void) additemsOnAddMore;

@end
