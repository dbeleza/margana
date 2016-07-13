//
//  ViewModel.h
//  Margana
//
//  Created by David Beleza on 13/07/16.
//  Copyright © 2016 David Beleza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModel : NSObject

- (void)getAnagramList:(NSMutableArray*)array withString:(NSString*)string afterCompletion:(void(^)(NSMutableArray *arrayAnagram))completion;

@end
