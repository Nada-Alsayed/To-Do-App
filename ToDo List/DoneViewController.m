//
//  DoneViewController.m
//  ToDo List
//
//  Created by MAC on 26/04/2023.
//

#import "DoneViewController.h"
#import "Task.h"
#import "TableViewCell.h"
#import "ShowDoneDetailViewController.h"

@interface DoneViewController ()
{
    NSMutableArray<Task *>  *easy;
    NSMutableArray<Task *>  *medium;
    NSMutableArray<Task *>  *hard;
    
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property NSMutableArray<Task *> *arr;
@property Boolean isFiltered;

@end

@implementation DoneViewController
- (IBAction)filterData:(id)sender {
    
    NSLog(@"Filter222222222 Clicked\n");
    _isFiltered=!_isFiltered;
    [easy removeAllObjects];
    [medium removeAllObjects];
    [hard removeAllObjects];
    for(Task *task in _arr)
    {
        if([task.priority isEqual:@"High"])
        {
            [easy addObject:task];
        }
        else if([task.priority isEqual:@"Medium"])
        {
            [medium addObject:task];
        }
        else if([task.priority isEqual:@"Low"])
        {
            [hard addObject:task];
        }
    }
    [self.table reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arr=[NSMutableArray new];
    _isFiltered=false;
    easy=[NSMutableArray new];
    medium=[NSMutableArray new];
    hard=[NSMutableArray new];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
    
    _isFiltered=false;
    NSError *error;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

    NSData *saveData=[defaults objectForKey:@"Done"];

    _arr=(NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:saveData];
    if(_arr==nil){
        _arr=[NSMutableArray new];
        printf("nnnnnnniiiiillll");
        
    }
    printf("arr///////////count %lu",(unsigned long)_arr.count);
    [_table reloadData];
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger index;
        if(self->_isFiltered)
        {
           
            if(indexPath.section==0)
            {
                index =[self->_arr indexOfObject:self->easy[indexPath.row]];
                [self->easy removeObjectAtIndex:indexPath.row];
            }
               
            else if(indexPath.section==1)
            {
                index =[self->_arr indexOfObject:self->medium[indexPath.row]];
                [self->medium removeObjectAtIndex:indexPath.row];
            }
                
            else {
                index =[self->_arr indexOfObject:self->hard[indexPath.row]];
                [self->hard removeObjectAtIndex:indexPath.row];
            }
            [self.arr removeObjectAtIndex:indexPath.row];
        }
        else{
            [self.arr removeObjectAtIndex:indexPath.row];

        }
            NSData *newArchiveData = [NSKeyedArchiver archivedDataWithRootObject:self.arr];
            NSUserDefaults *defaultData = [NSUserDefaults standardUserDefaults];
            [defaultData setObject:newArchiveData forKey:@"Done"];
            [defaultData synchronize];
        // Delete the row from the table view
        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationFade];
    }

}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(_isFiltered)
    {
        switch(section)
        {
            case 0:
                return @"High Level Tasks";
                break;
            case 1:
                return @"Medium Level Tasks";
                break;
            case 2:
                return @"Low level Tasks";
                break;
            default:
                return @"";
        }}
    else
        return @"";
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellc" forIndexPath:indexPath];
    
    cell.imgView.layer.cornerRadius = cell.imgView.frame.size.width / 2;
    cell.imgView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imgView.clipsToBounds = YES;
    
    if(_isFiltered)
    {
        
        if(indexPath.section==0)
        {
            cell.labelTitle.text=easy[indexPath.row].title;
            
            if([easy[indexPath.row].priority isEqual:@"High"])
            {
                cell.imgView.image=[UIImage imageNamed:@"red"] ;
            }
            else if ([easy[indexPath.row].priority isEqual:@"Medium"])
            {
                cell.imgView.image=[UIImage imageNamed:@"orange"] ;
            }
            else
            {
                cell.imgView.image=[UIImage imageNamed:@"green"] ;
            }
            
        }
        else if (indexPath.section==1){
    
            cell.labelTitle.text=medium[indexPath.row].title;
            
            if([medium[indexPath.row].priority isEqual:@"High"])
            {
                cell.imgView.image=[UIImage imageNamed:@"red"] ;
            }
            else if ([medium[indexPath.row].priority isEqual:@"Medium"])
            {
                cell.imgView.image=[UIImage imageNamed:@"orange"] ;
            }
            else
            {
                cell.imgView.image=[UIImage imageNamed:@"green"] ;
            }
        }
        else{
         
         cell.labelTitle.text=hard[indexPath.row].title;
         
         if([hard[indexPath.row].priority isEqual:@"High"])
         {
             cell.imgView.image=[UIImage imageNamed:@"red"] ;
         }
         else if ([hard[indexPath.row].priority isEqual:@"Medium"])
         {
             cell.imgView.image=[UIImage imageNamed:@"orange"] ;
         }
         else
         {
             cell.imgView.image=[UIImage imageNamed:@"green"] ;
         }
        }
    }else{
     cell.labelTitle.text=_arr[indexPath.row].title;
     
     if([_arr[indexPath.row].priority isEqual:@"High"])
     {
         cell.imgView.image=[UIImage imageNamed:@"red"] ;
     }
     else if ([_arr[indexPath.row].priority isEqual:@"Medium"])
     {
         cell.imgView.image=[UIImage imageNamed:@"orange"] ;
     }
     else
     {
         cell.imgView.image=[UIImage imageNamed:@"green"] ;
     }
    }
   
    cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_isFiltered)
    {
        if(section==0)
            return easy.count;
        else if(section==1)
            return medium.count;
        else if(section==2)
        {
            return hard.count;
        }
        else
            return  0;
    }
    else
    {
        return _arr.count;

    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _isFiltered ?3:1;
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
  
    Task *task ;
    NSInteger index;
    if(self->_isFiltered)
     {
         
       if(indexPath.section==0)
    {
        task = [easy objectAtIndex:indexPath.row];
        index=[self->_arr indexOfObject:self->easy[indexPath.row]];
        
    }
       
    else if(indexPath.section==1)
    {
        index =[self->_arr indexOfObject:self->medium[indexPath.row]];
        
        task = [medium objectAtIndex:indexPath.row];
        
    }
        
    else {
        task = [hard objectAtIndex:indexPath.row];
        index =[self->_arr indexOfObject:self->hard[indexPath.row]];
        
    }
    }
    else{
    task = [_arr objectAtIndex:indexPath.row];
        index=indexPath.row;
    }


    ShowDoneDetailViewController *addScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"donedetail"];
    [ self.navigationController pushViewController:addScreen animated:YES];
    
    addScreen.index=indexPath.row;
    addScreen.receivedObject=task;
    NSLog(@"add id8888 :%d",task.taskId);
    NSLog(@"title id8888 :%@",task.title);
    
}

@end
