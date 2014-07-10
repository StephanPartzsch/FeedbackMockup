#import "PFThankYouViewController.h"
#import "SWRevealViewController.h"


@implementation PFThankYouViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	_sidebarButton.target = self.revealViewController;
	_sidebarButton.action = @selector(revealToggle:);
	[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (IBAction)doOpenUrl:(id)sender
{
	[[UIApplication sharedApplication]
					openURL:[NSURL URLWithString:@"href=http://www.p3-group.com/de/p3-communications-gmbh-46215.html"]];
}

@end