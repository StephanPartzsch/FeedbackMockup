#import "PFSpeedTestViewController.h"
#import "SWRevealViewController.h"

@implementation PFSpeedTestViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	_sidebarButton.target = self.revealViewController;
	_sidebarButton.action = @selector(revealToggle:);
	[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

@end