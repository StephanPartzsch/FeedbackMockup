#import "PFSidebarViewController.h"
#import "SWRevealViewController.h"


@implementation PFSidebarViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//	self = [super initWithStyle:style];
//	if (self) {
//		// Custom initialization
//	}
//	return self;
//}

- (void)viewDidLoad
{
	[super viewDidLoad];
//	self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
//	self.tableView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
//	self.tableView.separatorColor = [UIColor colorWithWhite:0.15f alpha:0.2f];

	_menuItems = @[@"title", @"speedtest", @"feedback_title", @"feedback", @"settings", @"about_title", @"imprint", @"licenses", @"termsOfUse"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

	return cell;
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
	if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] )
	{
		SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;

		swSegue.performBlock = ^(SWRevealViewControllerSegue*revealViewControllerSegue, UIViewController*segueSourceViewController, UIViewController*segueDestinationViewController)
		{
			UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
			[navController setViewControllers: @[segueDestinationViewController] animated: NO ];
			[self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
		};
	}

}

@end