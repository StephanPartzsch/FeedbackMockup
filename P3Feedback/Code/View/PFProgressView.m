#import "PFProgressView.h"


@implementation PFProgressView

- (id)init
{
	NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ProgressView"
														  owner:nil
														options:nil];

	self = [arrayOfViews objectAtIndex:0.0];

	if (self)
	{
		[self setProgressToValue:0];
		[self performSelector:@selector(startProgress) withObject:nil afterDelay:0.3];
	}

	return self;
}

- (void)startProgress
{
	_timer = [NSTimer scheduledTimerWithTimeInterval:0.1
									 target:self
								   selector:@selector(makeProgress)
								   userInfo:nil
									repeats:YES];
}

- (void)makeProgress
{
	[self setProgressToValue:_progressView.progress + 0.04];
}

- (void)setProgressToValue:(float)value
{
	NSInteger percent = value * 100;
	_progressView.progress = value;
	_leftLabel.text = [NSString stringWithFormat:@"%i%%", percent];
	_rightLabel.text = [NSString stringWithFormat:@"%i/100", percent];

	if(_progressView.progress >= 1)
	{
		[_timer invalidate];
		_timer = nil;
	}
}

@end