//
//  AddTaskViewController.m
//  ToDo List
//
//  Created by MAC on 26/04/2023.
//

#import "AddTaskViewController.h"
#import "Task.h"
@interface AddTaskViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *txtFDescription;
@property (weak, nonatomic) IBOutlet UITextField *txtFTitle;
@end

@implementation AddTaskViewController
{
    NSString *priority;
    NSMutableArray<Task *> *arr;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO];
    priority=@"High";
    NSError *error;
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

    NSData *saved=[defaults objectForKey:@"Try"];

    arr=(NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:saved];
    
    if(arr==nil){
        arr=[NSMutableArray new];
    }else{
        if(error !=nil){
            NSLog(@"error log");
        }else{
            NSLog( @"%@  add date", arr.lastObject.date);
        }
    }
}
- (IBAction)setPriority:(id)sender {
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
        if (segmentedControl.selectedSegmentIndex == 0) {
            priority=@"High";
        }
        else if (segmentedControl.selectedSegmentIndex == 1) {
            priority=@"Medium";
        }
        else{
            priority=@"Low";
        }
    }
  //  NSLog(@"%@", priority);
}
- (IBAction)btnSave:(id)sender {
    if([_txtFTitle.text isEqual:@""]){
        UIAlertController *alert;
                alert=[UIAlertController alertControllerWithTitle:@"Alert" message:@"Fill all required data" preferredStyle:UIAlertControllerStyleAlert];
            
             UIAlertAction * action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL];
             
             [alert addAction:action];
             [self presentViewController:alert animated:YES
                              completion:NULL];
       
    }
    else{
        Task *t=[Task new];
        t.title=_txtFTitle.text;
        t.date=_datePicker.date;
        t.priority=priority;
        t.descriptionTask=_txtFDescription.text;
     
        [arr addObject:t];
      //  NSLog(@"%lu c:", (unsigned long)arr.count);
        NSLog(@"%lu c:", (unsigned long)t.taskId);

        NSError *error;
        NSData *archiveData=[NSKeyedArchiver archivedDataWithRootObject:arr requiringSecureCoding:YES error:&error];
        if(error !=nil){
            NSLog(@"error reg");
        }else{
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setObject:archiveData forKey:@"Try"];
            
            [defaults synchronize];
            
           // NSLog(@"%lu m:", (unsigned long)arr.count);
            
            [ self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
