//
//  PTMasterViewController.m
//  V=IReader
//
//  Created by Rob King on 1/11/12.
//  Copyright (c) 2012 University of Maine. All rights reserved.
//

#import "PTMasterViewController.h"
#import "PTDetailViewController.h"
#import "PTFeedEntry.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

#define TITLE_TAG   30
#define PREVIEW_TAG 31

@implementation PTMasterViewController

@synthesize entryCell = _entryCell;
@synthesize detailViewController = _detailViewController;
@synthesize entryArr = _entryArr;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Articles";
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.clearsSelectionOnViewWillAppear = NO;
            self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        }
    }
    return self;
}
							
- (void)dealloc
{
    [_detailViewController release];
    [_entryArr release];
    [_entryCell release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Do any additional setup after loading the view, typically from a nib.
    //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    //    [self.tableView selectRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition UITableViewScrollPositionMiddle];
    //}
    
    // Make an asynchronous request for the Feed data
    NSURL *url = [NSURL URLWithString: @"https://ajax.googleapis.com/ajax/services/feed/load?q=http://feeds.feedburner.com/ommalik&v=1.0"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)viewDidUnload
{
    [self setEntryCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

// There will only be one section in the TableView (for now?)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.entryArr count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArticleEntryCell";
    static NSString *CellNib = @"PTArticleCell_iPhone";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {        
        [[NSBundle mainBundle] loadNibNamed: CellNib owner:self options:nil];
        
        cell = self.entryCell;
    }

    // Assign the article title to the cell's title field
    UILabel* titleLbl = (UILabel*) [cell viewWithTag: TITLE_TAG];
    [titleLbl setText: [[self.entryArr objectAtIndex: indexPath.row] title]];
    
    /* By setting the style to None in the Nib and setting the style to 
     * single line here, the empty rows will not have separators
     */
    [tableView setSeparatorStyle: UITableViewCellSeparatorStyleSingleLine];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    if (!self.detailViewController) {
	        self.detailViewController = [[[PTDetailViewController alloc] initWithNibName:@"PTDetailViewController_iPhone" bundle:nil] autorelease];
            
	    }
        
        [self.detailViewController setDetailItem: [self.entryArr objectAtIndex: indexPath.row]];
        [self.navigationController pushViewController:self.detailViewController animated:YES];
    }
    else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        if(self.detailViewController){
            [self.detailViewController setDetailItem: [self.entryArr objectAtIndex: indexPath.row]];
        }
    }
}

#pragma mark - ASIHTTPRequestDelegate Protocol Methods

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    
    NSDictionary* responseDict = [responseString objectFromJSONString];
    
    NSDictionary* dataDict = [responseDict objectForKey: @"responseData"];
    NSDictionary* feedDict = [dataDict objectForKey: @"feed"];
    
    NSArray* entriesArr = [feedDict objectForKey: @"entries"];

    // Fill an array with the entries from the JSON response
    NSMutableArray* tempArr = [[NSMutableArray alloc] initWithCapacity: [entriesArr count]];
    for(NSDictionary* entry in entriesArr){
        PTFeedEntry* fEntry = [[PTFeedEntry alloc] initWithJSONEntry: entry];

        [tempArr addObject: fEntry];
        
        [fEntry release];
    }
    
    // Create an immutable copy from the temporary mutable array
    self.entryArr = [NSArray arrayWithArray: (NSArray*) tempArr];
    [tempArr release];
    
    // Reload the data in the table when processing is finished
    [self.tableView reloadData];
    
    // On the iPad select the first story so it is displayed in the Detail View
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self.tableView selectRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];

    // TODO: If an error occurred then display an error message for the 
    // user to try again later
    
}



@end
