//
//  JSONParser.h
//  ProgrammingAssessmentiOS
//
//  Created by Diego Eduardo on 11/13/15.
//  Copyright © 2015 Diego Eduardo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JSONParser : NSObject

@property(strong,nonatomic) NSArray* finalDictionaryWord;
@property(strong,nonatomic) NSMutableDictionary* finalDictionaryDetail;



-(NSArray*)parserJSON:(NSString*)data;
@end
