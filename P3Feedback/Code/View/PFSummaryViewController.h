#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class PFIssueData;
@class CLLocationManager;
@class CLGeocoder;


@interface PFSummaryViewController : UITableViewController <CLLocationManagerDelegate>

{
	NSDateFormatter *_dateFormatter;
	BOOL _datePickerIsShown;
	NSDate *_date;
	CLLocationManager *_locationManager;
	CLGeocoder *_geocoder;
}

@property (strong, nonatomic) PFIssueData *issueData;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end