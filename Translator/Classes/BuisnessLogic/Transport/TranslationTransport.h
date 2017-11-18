//
//  TranslationTransport.h
//  Translator
//
//  Created by MS on 17.11.2017.
//  Copyright © 2017 Personal Project. All rights reserved.
//

#import "BaseDataLoader.h"

@interface TranslationTransport : BaseDataLoader

- (void)translateText:(NSString *)text
              success:(void (^)(NSDictionary *translationJSON))success
              failure:(void (^)(NSString *errorMessage))failure;

@end
