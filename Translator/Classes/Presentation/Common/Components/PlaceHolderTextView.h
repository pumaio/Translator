//
//  PlaceHolderTextView.h
//  Translator
//
//  Created by MS on 13.11.2017.
//  Copyright © 2017 Personal Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceHolderTextView : UITextView

@property (nonatomic, retain) IBInspectable NSString *placeholder;
@property (nonatomic, retain) IBInspectable UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
