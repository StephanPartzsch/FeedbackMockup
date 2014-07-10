#import "PFSidebarViewController.h"
#import "SWRevealViewController.h"


@implementation PFSidebarViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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