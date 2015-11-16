//
//  ViewController.m
//  ProgrammingAssessmentiOS
//
//  Created by Diego Eduardo on 11/13/15.
//  Copyright © 2015 Diego Eduardo. All rights reserved.
//

#import "ViewController.h"
#import "JSONParser.h"
#import "TablePersonalCellTableViewCell.h"
#import <MBProgressHUD.h>

@interface ViewController ()

@end
@implementation ViewController
@synthesize tableViewResults;
- (void)viewDidLoad {
    [super viewDidLoad];
    _resultsDictionary= [[NSArray alloc]init];
    
}

-(void)reloadtableview {
    
    [self.tableViewResults reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_resultsDictionary.count > 0){
        return _resultsDictionary.count;
    }else{
        return 1;
    }
}
-(TablePersonalCellTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    TablePersonalCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(_resultsDictionary.count > 0){
        NSDictionary* tempDict = [_resultsDictionary objectAtIndex:indexPath.row];
        
        cell.labelFreq.text =[NSString stringWithFormat:@"Freq: %@",[tempDict objectForKey:@"freq"]];
        cell.labelLf.text=[NSString stringWithFormat:@"Mean: %@",[tempDict objectForKey:@"lf"]];
        cell.labelSince.text=[NSString stringWithFormat:@"Since: %@",[tempDict objectForKey:@"since"]];
        NSArray* tempArray = [tempDict objectForKey:@"vars"];
        cell.labelVars.text= [NSString stringWithFormat:@"History: %lu",(unsigned long)tempArray.count];
        NSLog(@"%@",tempDict);
    }
    else{
        cell.labelLf.text= @"Empty";
    }
    
    
    return cell;
}
- (IBAction)nyButtonAction:(UIButton *)sender {
    JSONParser* jsonClass = [[JSONParser alloc]init];
    __block NSArray* newDict = [[NSArray alloc]init];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        newDict = [jsonClass parserJSON:_texFieldInput.text];
        if(newDict != nil){
            _resultsDictionary =[newDict copy];
            
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableViewResults reloadData];
            
        });
    });
    
    _resultsDictionary =[jsonClass.finalDictionaryWord copy];
    [self.tableViewResults reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
