//
//  ViewController.m
//  KeyBoardWithToolBar
//
//  Created by apple on 12-8-10.
//  Copyright (c) 2018年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize scrollView = _scrollView;
@synthesize textField = _textField;
@synthesize textView = _textView;

- (void)dealloc {
    [_keyBoardWithToolBar release];
    [_scrollView release];
    [_textField release];
    [_textView release];
    [super dealloc];
}

// 123
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _keyBoardWithToolBar = [[KeyBoardWithToolBar alloc] init];
    _keyBoardWithToolBar.delegate = self;
    [_keyBoardWithToolBar setControlList:[NSArray arrayWithObjects:_textField, _textView, nil]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.scrollView = nil;
    self.textField = nil;
    self.textView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)calcContentOffset:(NSInteger)offset {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    self.scrollView.contentOffset = CGPointMake(0, offset);
    [UIView commitAnimations];
}

- (void)didClickDoneButton {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    self.scrollView.contentOffset = CGPointMake(0, 0);
    [UIView commitAnimations];    
}

@end
