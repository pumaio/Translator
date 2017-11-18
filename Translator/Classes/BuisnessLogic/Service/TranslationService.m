//
//  TranslationService.m
//  Translator
//
//  Created by MS on 17.11.2017.
//  Copyright © 2017 Personal Project. All rights reserved.
//

#import "TranslationService.h"
#import "TranslationTransport.h"

@implementation TranslationService

- (void)translateText:(NSString *)text
              success:(void (^)(NSString *translation))success
              failure:(void (^)(NSString *errorMessage))failure {
    TranslationTransport *transport = [[TranslationTransport alloc] init];
    [transport translateText:text success:^(NSDictionary *translationJSON) {
        
    } failure:^(NSString *errorMessage) {
        if (failure) {
            failure (errorMessage);
        }
    }];
}
@end
