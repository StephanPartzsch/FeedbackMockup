#import <Foundation/Foundation.h>
#import "Objection.h"

@class PFIssueData;

@interface PFFeedbackViewController : UITableViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) PFIssueData *issueData;

@end