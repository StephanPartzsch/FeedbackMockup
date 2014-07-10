#import "PFSpeedtestViewController.h"
#import "SWRevealViewController.h"

@implementation PFSpeedtestViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	_sidebarButton.target = self.revealViewController;
	_sidebarButton.action = @selector(revealToggle:);
	[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

@end