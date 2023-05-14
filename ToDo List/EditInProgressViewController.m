//
//  EditInProgressViewController.m
//  ToDo List
//
//  Created by MAC on 27/04/2023.
//

#import "EditInProgressViewController.h"

@interface EditInProgressViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segState;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segPriority;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *txtDesc;
@property (weak, nonatomic) IBOutlet UITextField *txtTitle;

@end

@implementation EditInProgressViewController{
        NSMutableArray<Task *> *InProgArray;
        NSMutableArray<Task *> *doneArray;
        NSString *priorityStr;
        NSString *stateStr;
        int position;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO];
    stateStr=@"InProgress";
    priorityStr=_receivedObject.priority;
    NSLog(@"recieved id: %d", _receivedObject.taskId);
    // +++++++++++++inProg+++++++++++++
    NSError *error2;
    NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
    NSData *saved=[defaults2 objectForKey:@"InProgArr"];
    InProgArray=(NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:saved];
    if(InProgArray==nil){
        InProgArray=[NSMutableArray new];
    }else{
        if(error2 !=nil){
            NSLog(@"error log");
        }else{
            NSLog( @"%@  add date", InProgArray.lastObject.date);
        }
    }
    // +++++++++++++Done+++++++++++++++++
    
    NSError *error3;
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    NSData *saved2=[defaults3 objectForKey:@"Done"];
    doneArray=(NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:saved2];
    if(doneArray==nil){
        doneArray=[NSMutableArray new];
    }else{
        if(error3 !=nil){
            NSLog(@"error log");
        }else{
            NSLog( @"%@  add date", doneArray.lastObject.date);
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _txtTitle.text=_receivedObject.title;
    _txtDesc.text=_receivedObject.descriptionTask;
    _datePicker.date=_receivedObject.date;
    if([_receivedObject.priority isEqual:@"High"]){
        [_segPriority setSelectedSegmentIndex:0];
    }else if([_receivedObject.priority isEqual:@"Medium"]){
        [_segPriority setSelectedSegmentIndex:1];
    }else{
        [_segPriority setSelectedSegmentIndex:2];
    }
}

- (IBAction)doEdit:(id)sender {
    if([_txtTitle.text isEqual:@""]){
        UIAlertController *alert;
        alert=[UIAlertController alertControllerWithTitle:@"Alert" message:@"Fill all required data" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL];
        
        [alert addAction:action];
        [self presentViewController:alert animated:YES
                         completion:NULL];
        
    }else{
        //  Task* task=[Task new];
        _receivedObject.title=_txtTitle.text;
        _receivedObject.date=_datePicker.date;
        _receivedObject.priority=priorityStr;
        _receivedObject.descriptionTask=_txtDesc.text;
        
        NSLog(@"task id: %d", _receivedObject.taskId);
        
        if([stateStr isEqual:@"InProgress"]){
            printf("nnnnnnnnnnnnnnn");
            
            for(int i =0;i<InProgArray.count;i++){
                if( InProgArray[i].taskId == _receivedObject.taskId ){
                    position=i;
                    printf("nnnn");
                    [InProgArray removeObjectAtIndex:i];
                    break;
                }
            }
            [InProgArray addObject:_receivedObject];
            NSError *error;
            NSData *archiveData=[NSKeyedArchiver archivedDataWithRootObject:InProgArray requiringSecureCoding:YES error:&error];
            if(error !=nil){
                NSLog(@"error reg");
            }
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setObject:archiveData forKey:@"InProgArr"];
            [defaults synchronize];
            
            [ self.navigationController popViewControllerAnimated:YES];
            NSLog(@"Todo array count :%lu", (unsigned long)InProgArray.count);
            
        }else {
            NSLog(@"welcome in Done ");
            for(int i =0;i<InProgArray.count;i++){
                if( InProgArray[i].taskId == _receivedObject.taskId ){
                    position=i;
                    printf("nnnn");
                    [InProgArray removeObjectAtIndex:position];
                    break;
                }
            }
            NSError *errortodo;
            NSData *archiveDataToDo=[NSKeyedArchiver archivedDataWithRootObject:InProgArray requiringSecureCoding:YES error:&errortodo];
            if(errortodo !=nil){
                NSLog(@"error reg");
            }
            NSUserDefaults *defaultsToDo=[NSUserDefaults standardUserDefaults];
            [defaultsToDo setObject:archiveDataToDo forKey:@"InProgArr"];
            [defaultsToDo synchronize];
            
            
            [doneArray addObject:_receivedObject];
            NSError *error;
            NSData *archiveData=[NSKeyedArchiver archivedDataWithRootObject:doneArray requiringSecureCoding:YES error:&error];
            if(error !=nil){
                NSLog(@"error reg");
            }else{
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                [defaults setObject:archiveData forKey:@"Done"];
                
                [defaults synchronize];
                
                // NSLog(@"InProgress Array count : %lu", (unsigned long)InProgArray.count);
                
                [ self.navigationController popViewControllerAnimated:YES];
            }
            
        }
    }
}
- (IBAction)setState:(id)sender {
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
        if(segmentedControl.selectedSegmentIndex == 0){
            stateStr=@"InProgress";
        }
        else{
            stateStr=@"Done";
        }
        
    }
    NSLog(@"%@", stateStr);
}
    
- (IBAction)setPriority:(id)sender {
    
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
            UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
            if (segmentedControl.selectedSegmentIndex == 0) {
                priorityStr=@"High";
            }
            else if (segmentedControl.selectedSegmentIndex == 1) {
                priorityStr=@"Medium";
            }
            else{
                priorityStr=@"Low";
            }
        }
        NSLog(@"%@", priorityStr);
}
@end
    
