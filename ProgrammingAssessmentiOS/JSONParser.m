//
//  JSONParser.m
//  ProgrammingAssessmentiOS
//
//  Created by Diego Eduardo on 11/13/15.
//  Copyright © 2015 Diego Eduardo. All rights reserved.
//

#import "JSONParser.h"
#import <AFNetworking.h>
#import "ViewController.h"

@implementation JSONParser
@synthesize finalDictionaryWord;
@synthesize finalDictionaryDetail;
NSArray* myArray;
-(NSArray*)parserJSON:(NSString*)data{
    finalDictionaryWord = [[NSArray alloc]init];
    finalDictionaryDetail = [[NSMutableDictionary alloc]init];
    myArray = [[NSArray alloc]init];
    
    NSString *URLString =[NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@",data];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    dispatch_group_t group = dispatch_group_create();
    
    
    dispatch_group_enter(group);
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        myArray = [NSJSONSerialization JSONObjectWithData:responseObject
                                                          options:kNilOptions
                                                            error:&error];
        dispatch_group_leave(group);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        dispatch_group_leave(group);
  
    }];
    [op start];
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    if(myArray.count > 0){
    ViewController* vc = [[ViewController alloc]init];
    
    NSDictionary *tempDict = [myArray objectAtIndex:0];
    
    finalDictionaryWord = [tempDict objectForKey:@"lfs"];
    
    vc.resultsDictionary = [finalDictionaryWord copy];

    return finalDictionaryWord;
    }
    else{
        return nil;
    }
}



@end
