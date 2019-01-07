//
//  PlaceholderTextView.m
//  iShanggang
//
//  Created by 鲍晓飞 on 17/5/17.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import "PlaceholderTextView.h"


@interface PlaceholderTextView ()

@property (nonatomic, strong) UIColor *realTextColor;
@property (nonatomic, readonly) NSString *realText;

- (void)beginEditing:(NSNotification *)notification;
- (void)endEditing:(NSNotification *)notification;

@end


@implementation PlaceholderTextView

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    
    self.realTextColor = [UIColor blackColor];
    
    [super awakeFromNib];
}

#pragma mark -
#pragma mark Setter/Getters

- (void)setPlaceholder:(NSString *)aPlaceholder {
    
    if ([self.realText isEqualToString:_placeholder]) {
        self.text = aPlaceholder;
    }
    
    _placeholder = aPlaceholder;
    
    [self endEditing:nil];
}

- (NSString *)text {
    NSString *text = [super text];
    if ([text isEqualToString:self.placeholder]) return @"";
    return text;
}

- (void)setText:(NSString *)text {
    if ([text isEqualToString:@""] || text == nil) {
        super.text = self.placeholder;
    }
    else {
        super.text = text;
    }
    
    if ([text isEqualToString:self.placeholder]) {
        self.textColor = [UIColor lightGrayColor];
    }
    else {
        self.textColor = self.realTextColor;
    }
}

- (NSString *)realText {
    return [super text];
}

- (void)beginEditing:(NSNotification*)notification {
    if ([self.realText isEqualToString:self.placeholder]) {
        super.text = nil;
        self.textColor = self.realTextColor;
    }
}

- (void)endEditing:(NSNotification*)notification {
    
    if ([self.realText isEqualToString:@""] || self.realText == nil) {
        super.text = self.placeholder;
        self.textColor = [UIColor lightGrayColor];
    }
}

- (void)setTextColor:(UIColor *)textColor {
    if ([self.realText isEqualToString:self.placeholder]) {
        if ([textColor isEqual:[UIColor lightGrayColor]]) [super setTextColor:textColor];
        else self.realTextColor = textColor;
    }
    else {
        self.realTextColor = textColor;
        [super setTextColor:textColor];
    }
}


@end
