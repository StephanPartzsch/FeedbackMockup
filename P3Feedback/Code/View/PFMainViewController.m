//
//  PFMainViewController.m
//  P3Feedback
//
//  Created by Stephan Partzsch on 09.07.14.
//  Copyright (c) 2014 P3. All rights reserved.
//

#import "PFMainViewController.h"
#import "SWRevealViewController.h"


@implementation PFMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	_sidebarButton.target = self.revealViewController;
	_sidebarButton.action = @selector(revealToggle:);
	[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

@end
