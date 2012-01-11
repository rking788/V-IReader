//
//  PTMasterViewController.h
//  V=IReader
//
//  Created by Rob King on 1/11/12.
//  Copyright (c) 2012 University of Maine. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTDetailViewController;

@interface PTMasterViewController : UITableViewController

@property (strong, nonatomic) PTDetailViewController *detailViewController;

@end
