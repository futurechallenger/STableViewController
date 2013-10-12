
STableViewController
====================================================================================================

STableViewController is a custom table view controller that supports **pull-to-refresh** and 
**load-more**. It was designed to have views and behaviors that can be easily customized.

See the demo project in `Demo/Demo.xcodeproj`.


Usage
----------------------------------------------------------------------------------------------------
To start, simply copy `STableViewController.h` and `STableViewController.m` into your project file.

STableViewController is not very useful on its own. It has to be subclassed to apply your custom
views and adjust any behavior. To get started quickly, you may include these files for reference:

 * `DemoTableViewController` is abandoned. You don't have to read this code.
 * `DemoRefreshViewController` is subclass of `STableViewController`, `DemoRefreshViewController` is subclass
    of `DemoRefreshBaseViewController`.
 * `DemoRefreshBaseViewController` take care of all functions about header view and footer show and hide.
 * `DemoRefreshViewController` handles things about load data and put data in the head of end of data source for refersh or load more actions.
 * `DemoTableHeaderView` & `DemoTableFooterView` - you can refer to these two classes. But now the `DemoHeaderView` & `DemoFooterView` are
    used in this project.
 
You may also opt to implement your own subclass for `STableViewController` and use your own
views for pull-to-refresh and load-more. And you have to refer to `DemoRefreshBaseViewController` (don't have to do any mofidication) 
& `DemoRefershViewController` to do things to your data.
to implement your own

See `STableViewController.h` for more information on the methods available.