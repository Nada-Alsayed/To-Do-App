//
//  EditToDoViewController.m
//  ToDo List
//
//  Created by MAC on 26/04/2023.
//

#import "EditToDoViewController.h"

@interface EditToDoViewController ()

@end

@implementation EditToDoViewController
{
    NSMutableArray<Task *> *InProgArray;
    NSMutableArray<Task *> *doneArray;
    NSString *priorityStr;
    NSString *stateStr;
    NSMutableArray<Task *> *arr;
    int position;
}
- (IBAction)edit:(id)sender {
       if([_txtTitle.text isEqual:@""]){
            UIAlertController *alert;
                    alert=[UIAlertController alertControllerWithTitle:@"Alert" message:@"Fill all required data" preferredStyle:UIAlertControllerStyleAlert];
    
                 UIAlertAction * action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL];
    
                 [alert addAction:action];
                 [self presentViewController:alert animated:YES
                                  completion:NULL];
    
        }
       else{
          //  Task* task=[Task new];
            _receivedObject.title=_txtTitle.text;
            _receivedObject.date=_date.date;
            _receivedObject.priority=priorityStr;
            _receivedObject.descriptionTask=_txtDesc.text;
            
            NSLog(@"task id: %d", _receivedObject.taskId);
            
            if([stateStr isEqual:@"Todo"]){
                printf("nnnnnnnnnnnnnnn");

                for(int i =0;i<arr.count;i++){
                    if( arr[i].taskId == _receivedObject.taskId ){
                        position=i;
                        printf("nnnn");
                        [arr removeObjectAtIndex:i];
                        break;
                    }
                }
                [arr addObject:_receivedObject];
                NSError *error;
                NSData *archiveData=[NSKeyedArchiver archivedDataWithRootObject:arr requiringSecureCoding:YES error:&error];
                if(error !=nil){
                    NSLog(@"error reg");
                }
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                [defaults setObject:archiveData forKey:@"Try"];
                [defaults synchronize];
                
                [ self.navigationController popViewControllerAnimated:YES];
                NSLog(@"Todo array count :%lu", (unsigned long)arr.count);
                
            }else if ([stateStr isEqual:@"InProgress"]){
                NSLog(@"welcome in progresss ");
                for(int i =0;i<arr.count;i++){
                    if( arr[i].taskId == _receivedObject.taskId ){
                        position=i;
                        printf("nnnn");
                        [arr removeObjectAtIndex:position];
                        break;
                    }
                }
                NSError *errortodo;
                NSData *archiveDataToDo=[NSKeyedArchiver archivedDataWithRootObject:arr requiringSecureCoding:YES error:&errortodo];
                if(errortodo !=nil){
                    NSLog(@"error reg");
                }
                NSUserDefaults *defaultsToDo=[NSUserDefaults standardUserDefaults];
                [defaultsToDo setObject:archiveDataToDo forKey:@"Try"];
                [defaultsToDo synchronize];
                
                
                [InProgArray addObject:_receivedObject];
                NSError *error;
                NSData *archiveData=[NSKeyedArchiver archivedDataWithRootObject:InProgArray requiringSecureCoding:YES error:&error];
                if(error !=nil){
                    NSLog(@"error reg");
                }else{
                    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                    [defaults setObject:archiveData forKey:@"InProgArr"];
                    
                    [defaults synchronize];
                    
                   // NSLog(@"InProgress Array count : %lu", (unsigned long)InProgArray.count);
                    
                    [ self.navigationController popViewControllerAnimated:YES];
                }
                
            }else{
                NSLog(@"welcome in Done ");
                for(int i =0;i<arr.count;i++){
                    if( arr[i].taskId == _receivedObject.taskId ){
                        position=i;
                        printf("nnnn");
                        [arr removeObjectAtIndex:position];
                        break;
                    }
                }
                NSError *errortodo;
                NSData *archiveDataToDo=[NSKeyedArchiver archivedDataWithRootObject:arr requiringSecureCoding:YES error:&errortodo];
                if(errortodo !=nil){
                    NSLog(@"error reg");
                }
                NSUserDefaults *defaultsToDo=[NSUserDefaults standardUserDefaults];
                [defaultsToDo setObject:archiveDataToDo forKey:@"Try"];
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
                    
                    NSLog(@"done array count:%lu :", (unsigned long)doneArray.count);
                    
                    [ self.navigationController popViewControllerAnimated:YES];
                }
            }
        }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO];
    stateStr=@"Todo";
    priorityStr=_receivedObject.priority;
    NSLog(@"recieved id: %d", _receivedObject.taskId);
    NSError *error;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *saveData=[defaults objectForKey:@"Try"];
    NSMutableArray<Task *> *task1=(NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:saveData];
    if(task1==nil){
        task1=[NSMutableArray new];
        arr=task1;
    }else{
        if(error !=nil){
            NSLog(@"error log");
        }else{
            NSLog( @"%@ task1 date", task1.firstObject.date);
        }
        arr=task1;
        //NSLog(@"%lu count2:", (unsigned long)task1.count);
       // NSLog(@"%lu count:", (unsigned long)arr.count);
    }
    // +++++++++++++inProg+++++++++++++
    NSError *error2;
    NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
    NSData *saved=[defaults2 objectForKey:@"InProgArr"];
    InProgArray=(NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:saved];
    if(InProgArray==nil){
        InProgArray=[NSMutableArray new];
    }else{
        if(error !=nil){
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
    _date.date=_receivedObject.date;
    if([_receivedObject.priority isEqual:@"High"]){
        [_priority setSelectedSegmentIndex:0];
    }else if([_receivedObject.priority isEqual:@"Medium"]){
        [_priority setSelectedSegmentIndex:1];
    }else{
        [_priority setSelectedSegmentIndex:2];
    }
}

-(IBAction)editPriority:(id)sender {
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
- (IBAction)editState:(id)sender {
    
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
        if (segmentedControl.selectedSegmentIndex == 0) {
            stateStr=@"Todo";
        }
        else if(segmentedControl.selectedSegmentIndex == 1){
            stateStr=@"InProgress";
        }
        else{
            stateStr=@"Done";
        }
        
    }
    NSLog(@"%@", stateStr);
   
}


@end
