//
//  ViewModel.m
//  Margana
//
//  Created by David Beleza on 13/07/16.
//  Copyright © 2016 David Beleza. All rights reserved.
//

#import "ViewModel.h"

@interface ViewModel()

@end

@implementation ViewModel

- (void)getAnagramList:(NSMutableArray*)array withString:(NSString*)string afterCompletion:(void(^)(NSMutableArray *arrayAnagram))completion {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
        
        for (NSString *tempString in array) {
            
            if ([self checkIfWord:string isEqualToWord:tempString]) {
                
                [mutableArray addObject:tempString];
                
            }
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
          
            completion(mutableArray);
            
        });
        
    });
    
}

- (BOOL)checkIfWord:(NSString*)word isEqualToWord:(NSString*)ListWord {
    
    
    NSString *a = [self convertAndSortString:word];
    NSString *b = [self convertAndSortString:ListWord];
    
    if ([a isEqualToString:b]) {
        
        return true;
        
    }
    
    return false;
}

- (NSString*)convertAndSortString:(NSString *)string {
 
    
    NSString *stringLowerCase = [string lowercaseString];
    
    NSMutableArray *charArray = [NSMutableArray arrayWithCapacity:stringLowerCase.length];
    
    for (int i=0; i<stringLowerCase.length; ++i) {
        NSString *charStr = [stringLowerCase substringWithRange:NSMakeRange(i, 1)];
        [charArray addObject:charStr];
    }
    
    [charArray sortUsingComparator:^(NSString *a, NSString *b){
        return [a compare:b];
    }];
    
    return [NSString stringWithFormat:@"%@", charArray];;
    
}

@end
