#import <Foundation/Foundation.h>


@interface PFProgressView : UIView
{
	NSTimer *_timer;
}

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end