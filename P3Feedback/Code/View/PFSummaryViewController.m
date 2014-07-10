#import <CoreLocation/CoreLocation.h>
#import "PFSummaryViewController.h"
#import "SWRevealViewController.h"
#import "Objection.h"
#import "PFIssueData.h"


@implementation PFSummaryViewController

objection_requires(@"issueData")

static NSString *kDataCellId = @"dataCell";
static NSString *kDatePickerCellId = @"datePickerCell";
static NSString *kButtonCellId = @"buttonCell";
static NSInteger kDatePickerTag = 1;


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

	_datePickerIsShown = false;
	_date = [NSDate new];

	_locationManager = [[CLLocationManager alloc] init];
	_geocoder = [[CLGeocoder alloc] init];

	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

	[self createDateFormatter];
	[self getCurrentLocation];
}

- (void)createDateFormatter 
{
	_dateFormatter = [[NSDateFormatter alloc] init];
	[_dateFormatter setDateFormat:@"dd.MM.yyy HH:mm"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger numberOfRows = 6;

	if (_datePickerIsShown)
		numberOfRows++;

	return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	UITableViewCell *cell;

	if (_datePickerIsShown)
	{
		switch (indexPath.row)
		{
			case 1:
				cell = [self createPickerCell:_date];
				break;
		}
	}
	else
	{
		switch (indexPath.row)
		{
			case 0:
				cell = [self createDataCellWithKey:@"Zeitpunkt" andData:[_dateFormatter stringFromDate:_date]];
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				break;

			case 1:
				cell = [self createDataCellWithKey:@"Problem" andData:_issueData.problem];
				cell.userInteractionEnabled = NO;
				break;

			case 2:
				cell = [self createDataCellWithKey:@"Ort" andData:_issueData.location];
				cell.userInteractionEnabled = NO;
				break;

			case 3:
				cell = [self createDataCellWithKey:@"Häufigkeit" andData:_issueData.frequency];
				cell.userInteractionEnabled = NO;
				break;

			case 4:
				cell = [self createDataCellWithKey:@"Position" andData:@"LOCATION"];
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				break;

			case 5:
				cell = [self createButtonCell];
				cell.accessoryType = UITableViewCellAccessoryNone;
				break;
		}
	}

	return cell;
}

- (UITableViewCell *)createDataCellWithKey:(NSString *)key andData:(NSString *)data
{

	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kDataCellId];
	cell.textLabel.text = key;
	cell.detailTextLabel.text = data;
	return cell;
}

- (UITableViewCell *)createPickerCell:(NSDate *)date 
{
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kDatePickerCellId];
	UIDatePicker *targetedDatePicker = (UIDatePicker *)[cell viewWithTag:kDatePickerTag];
	[targetedDatePicker setDate:date animated:NO];
	return cell;
}

- (UITableViewCell *)createButtonCell
{
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kButtonCellId];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableView beginUpdates];

	if(indexPath.row == 0)
    {
		if (_datePickerIsShown)
        {
            [self hideExistingPicker];
        }
		else
        {
			[self showNewPicker];
        }
    }
    
	if(indexPath.row == 4)
		[self getCurrentLocation];

	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self.tableView endUpdates];
}

- (void)hideExistingPicker
{
	[self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]]
						  withRowAnimation:UITableViewRowAnimationFade];

	_datePickerIsShown = false;
}

- (void)showNewPicker
{
	NSArray *indexPaths = @[[NSIndexPath indexPathForRow:1 inSection:0]];

	[self.tableView insertRowsAtIndexPaths:indexPaths
						  withRowAnimation:UITableViewRowAnimationFade];

	_datePickerIsShown = true;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat rowHeight = self.tableView.rowHeight;

	if (_datePickerIsShown && (1 == indexPath.row))
	{
		rowHeight = 162;
	}

	return rowHeight;
}

- (IBAction)dateChanged:(UIDatePicker *)sender
{
	NSIndexPath *parentCellIndexPath = nil;

	if (_datePickerIsShown)
	{
		parentCellIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	}
	else
	{
		return;
	}

	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:parentCellIndexPath];
	_date = sender.date;
	cell.detailTextLabel.text = [_dateFormatter stringFromDate:_date];
}

- (void)getCurrentLocation
{
	_locationManager.delegate = self;
	_locationManager.desiredAccuracy = kCLLocationAccuracyBest;

	[_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Position nicht erkannt!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	CLLocation *currentLocation = newLocation;

	[_geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
	{
		if (error == nil && [placemarks count] > 0)
		{
			CLPlacemark *placemark = [placemarks lastObject];
			NSString *addressText = [NSString stringWithFormat:@"%@ %@\n%@ %@, %@",
														   placemark.thoroughfare, placemark.subThoroughfare,
														   placemark.postalCode, placemark.locality,
														   placemark.country];


			UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
			cell.detailTextLabel.text = addressText;
		}
		else
		{
			NSLog(@"%@", error.debugDescription);
		}

		[_locationManager stopUpdatingLocation];
	} ];
}

@end