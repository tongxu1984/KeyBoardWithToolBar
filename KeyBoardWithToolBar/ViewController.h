//
//  ViewController.h
//  KeyBoardWithToolBar
//
//  Created by apple on 12-8-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardWithToolBar.h"

@interface ViewController : UIViewController <KeyBoardWithToolBarDelegate> {
    KeyBoardWithToolBar *_keyBoardWithToolBar;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end
