#import "PFFeedbackViewController.h"
#import "SWRevealViewController.h"
#import "PFProgressView.h"
#import "PFSummaryViewController.h"
#import "PFIssueData.h"

@implementation PFFeedbackViewController

objection_requires(@"issueData")

- (void)awakeFromNib
{
	[super awakeFromNib];
	[[JSObjection defaultInjector] injectDependencies:self];
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	_sidebarButton.target = self.revealViewController;
	_sidebarButton.action = @selector(revealToggle:);
	[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *cellIdentifier = [tableView cellForRowAtIndexPath:indexPath].reuseIdentifier;

	if([cellIdentifier hasPrefix:@"what_"])
	{
		_issueData.problem = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
	}

	if([cellIdentifier hasPrefix:@"where_"])
	{
		_issueData.location = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
	}

	if([cellIdentifier hasPrefix:@"when_"])
	{
		_issueData.frequency = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
		[self showSpeedTestQuestion];
	}
}

- (void)showSpeedTestQuestion
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Speedtest durchführen bei dem Kosten entsehen können?" message:nil delegate:self cancelButtonTitle:@"Nein" otherButtonTitles:@"Ja", nil];
	[alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
	if([title isEqualToString:@"Ja"])
		[self showSpeedTestProgress];
}

- (void)showSpeedTestProgress
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Führe Speedtest durch..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
	PFProgressView *progressView = [PFProgressView new];
	[alertView setValue:progressView forKey:@"accessoryView"];
	[alertView show];

	[alertView performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:@1 afterDelay:3.0];
	[self performSelector:@selector(showSummary) withObject:nil afterDelay:3.0];
}

- (void)showSummary
{
	[self performSegueWithIdentifier:@"show_summary" sender:self];
}

@end