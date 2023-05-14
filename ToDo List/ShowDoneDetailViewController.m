//
//  ShowDoneDetailViewController.m
//  ToDo List
//
//  Created by MAC on 27/04/2023.
//

#import "ShowDoneDetailViewController.h"

@interface ShowDoneDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelState;
@property (weak, nonatomic) IBOutlet UILabel *labelPriority;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelDesc;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@end

@implementation ShowDoneDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _labelTitle.text=_receivedObject.title;
    _labelDesc.text=_receivedObject.descriptionTask;
    NSDate *taskDate = self.receivedObject.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd, yyyy"];
        NSString *formattedDate = [dateFormatter stringFromDate:taskDate];
        _labelDate.text = formattedDate;
    if([_receivedObject.priority isEqual:@"High"]){
        _labelPriority.text=@"High" ;
    }else if([_receivedObject.priority isEqual:@"Medium"]){
        _labelPriority.text=@"Medium" ;
    }else{
        _labelPriority.text=@"Low" ;
    }
    _labelState.text=@"Done";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
