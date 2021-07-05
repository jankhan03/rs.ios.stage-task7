//
//  RSViewController.m
//  RS7_task
//
//  Created by Yan Khanetski on 4.07.21.
//

#import "RSViewController.h"
#import "RSKeyboard.h"
#import "Data.h"

@interface RSViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UITextField *login;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *authorize;
@property (weak, nonatomic) IBOutlet UIView *secureContainerView;
@property (weak, nonatomic) IBOutlet UILabel *view1;
@property (weak, nonatomic) IBOutlet UILabel *view2;
@property (weak, nonatomic) IBOutlet UILabel *view3;
@property (weak, nonatomic) IBOutlet UILabel *result_view;
@end

@implementation RSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defaultState];
}

- (void)defaultState {
    self.view2.backgroundColor = [UIColor whiteColor];
    [self textConfiguration];
    [self loginConfiguration];
    [self passwordConfiguration];
    [self authorizeComfigurationNormal];
    for (id i in self.view2.subviews)
    {
        if ([i isMemberOfClass: [UITextField class]])
        {
            [self addDelegates:i];
            [i addTarget:self
                  action:@selector(tappingBegin:)
        forControlEvents: UIControlEventEditingDidBegin];
        }
    }
    self.secureContainerView.hidden = YES;
    [self subscribeOnKeyboardEvents];
}

#pragma mark UI

- (void)textConfiguration {
    self.text.text = @"RSSchool";
    self.text.textAlignment = NSTextAlignmentCenter;
    [self.text setFont:[UIFont boldSystemFontOfSize:36]];
    [self.text setTextColor:[UIColor blackColor]];
    [self.text setBackgroundColor:[UIColor whiteColor]];
}

- (void)loginConfiguration {
    self.login.placeholder = @"Login";
    self.login.text = @"";
    self.login.alpha = 1;
    UIColor *color = [UIColor colorWithRed:0.3 green:0.36 blue:0.41 alpha:1.0];
    self.login.layer.borderColor = color.CGColor;
    self.login.layer.borderWidth = 1.5;
    self.login.layer.cornerRadius = 5;
    self.login.userInteractionEnabled = YES;
}

- (void)passwordConfiguration {
    self.password.placeholder = @"Password";
    self.password.text = @"";
    self.password.alpha = 1;
    self.password.secureTextEntry = YES;
    UIColor *color = [UIColor colorWithRed:0.3 green:0.36 blue:0.41 alpha:1.0];
    self.password.layer.borderColor = color.CGColor;
    self.password.layer.borderWidth = 1.5;
    self.password.layer.cornerRadius = 5;
    self.password.userInteractionEnabled = YES;
}

- (void)authorizeComfigurationNormal {
    UIColor *color = [UIColor colorWithRed:0.50 green:0.64 blue:0.93 alpha:1.00];
    [self.authorize setTitle: @"Authorize" forState:UIControlStateNormal];
    self.authorize.alpha = 1;
    self.authorize.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    [self.authorize setTitleColor:color forState:UIControlStateNormal];
    self.authorize.backgroundColor = [UIColor clearColor];
    self.authorize.layer.borderColor = color.CGColor;
    self.authorize.layer.borderWidth = 2;
    self.authorize.layer.cornerRadius = 10;
    self.authorize.userInteractionEnabled = YES;
    UIImage *image = [UIImage new];
    if (@available(iOS 13.0, *))
        image = [UIImage systemImageNamed:@"person" withConfiguration:[UIImageSymbolConfiguration configurationWithFont:[UIFont systemFontOfSize:14 weight:UIFontWeightSemibold]]];
    else
        image = [UIImage imageNamed:@"user.png"];
    self.authorize.tintColor = color;
    [self.authorize setImage:image forState:UIControlStateNormal];
    [self.authorize setImage:image forState:UIControlStateDisabled];
    self.authorize.imageEdgeInsets = UIEdgeInsetsMake(10, -10, 10, -5);
    self.authorize.titleEdgeInsets = UIEdgeInsetsMake(10, -5, 10, -10);
    [self.authorize addTarget:self action: @selector(didTapOnButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.authorize addTarget:self action: @selector(didHighlight) forControlEvents:UIControlEventTouchDown];
}

- (void)resultViewConfiguration {
    self.result_view.text = @"_";
    self.result_view.tag = 1;
    self.result_view.textAlignment = NSTextAlignmentCenter;
    self.result_view.backgroundColor = [UIColor clearColor];
    self.result_view.textColor = [UIColor blackColor];
    self.result_view.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
}

- (void)roundViewConfiguration {
    NSInteger j = 1;
    UIColor *color = [UIColor colorWithRed:0.50 green:0.64 blue:0.93 alpha:1.00];
    UIFont *font = [UIFont systemFontOfSize:24 weight:UIFontWeightSemibold];
    for (UILabel *label in self.secureContainerView.subviews)
    {
        NSNumber *i = @(j);
        if (label.tag != 1)
        {
            label.text = i.stringValue;
            label.textColor = color;
            label.font = font;
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            label.layer.cornerRadius = label.frame.size.height / 2;
            label.layer.borderColor = color.CGColor;
            label.layer.borderWidth = 1.5;
            j++;
        }
    }
}

- (void)doubleCheckConfiguration {
    [self resultViewConfiguration];
    self.secureContainerView.backgroundColor = [UIColor clearColor];
    self.secureContainerView.hidden = NO;
    [self roundViewConfiguration];
    [self makeOneTwoThreeInteractive];
}

#pragma mark functionality

- (void)presentRefresh {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Welcome"
                                message:@"You are successfuly authorized!"
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *refresh = [UIAlertAction actionWithTitle:@"Refresh"
                                                       style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Refreshed");
        [self defaultState];
    }];
    alert.view.tintColor = [UIColor redColor];
    [alert addAction:refresh];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)checkProcess {
    for (UILabel *label in self.secureContainerView.subviews)
    {
        if (label.tag != 1)
        {
            Data *date = [Data new];
            if ([date.code isEqualToString:self.result_view.text])
            {
                label.userInteractionEnabled = NO;
                self.secureContainerView.layer.borderWidth = 2;
                self.secureContainerView.layer.borderColor = [UIColor colorWithRed: 0.57 green: 0.78 blue: 0.69 alpha: 1.00].CGColor;
                self.secureContainerView.layer.cornerRadius = 10;
                [self presentRefresh];
                return ;
            }
            else
            {
                self.result_view.text = @"_";
                self.secureContainerView.layer.borderWidth = 2;
                self.secureContainerView.layer.borderColor = [UIColor colorWithRed:0.76 green:0.00 blue:0.08 alpha:1.00].CGColor;
                self.secureContainerView.layer.cornerRadius = 10;
                return ;
            }
        }
    }
}

- (void)manageResultText:(UILabel *)label {
    if ([self.result_view.text isEqualToString:@"_"])
        self.result_view.text = @"";
    NSMutableString *res = self.result_view.text.mutableCopy;
    if (res.length > 0 && res.length < 4)
    {
        [res appendString:@" "];
    }
    [res appendString: label.text];
    self.result_view.text = res;
    if (self.result_view.text.length == 5)
    {
        [self checkProcess];
    }
}

- (void)tapOnRound:(UIGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        self.secureContainerView.layer.borderColor = [UIColor clearColor].CGColor;
        for (UILabel *label in self.secureContainerView.subviews)
        {
            if (label.tag != 1)
            {
                CGPoint location = [sender locationInView:self.secureContainerView];
                BOOL isPointInsideCircle = CGRectContainsPoint(label.frame, location);
                if (isPointInsideCircle)
                {
                    UIColor *color = [UIColor colorWithRed:0.50 green:0.64 blue:0.93 alpha:0.2];
                    [label setBackgroundColor:color];
                    label.clipsToBounds = YES;
                    [self manageResultText:label];
                }
            }
        }
    }
    if (sender.state == UIGestureRecognizerStateEnded ||
        sender.state == UIGestureRecognizerStateCancelled)
    {
        for (UILabel *label in self.secureContainerView.subviews)
        {
            if (label.tag != 1)
            {
                CGPoint location = [sender locationInView:self.secureContainerView];
                BOOL isPointInsideCircle = CGRectContainsPoint(label.frame, location);
                if (isPointInsideCircle)
                {
                    UIColor *color = [UIColor clearColor];
                    [label setBackgroundColor:color];
                }
            }
        }
    }
}

- (void)makeOneTwoThreeInteractive {
    for (UILabel *label in self.secureContainerView.subviews)
    {
        if (label.tag != 1)
        {
            UILongPressGestureRecognizer *tap = [UILongPressGestureRecognizer new];
            tap.minimumPressDuration = 0;
            [tap addTarget:self action:@selector(tapOnRound:)];
            [label setUserInteractionEnabled:YES];
            [label addGestureRecognizer:tap];
        }
    }
}

- (void)authorizeComfigurationDisable {
    [self.authorize setAlpha:0.5];
    [self.login setAlpha:0.5];
    [self.password setAlpha:0.5];
    self.login.layer.borderColor = [UIColor colorWithRed: 0.57 green: 0.78 blue: 0.69 alpha: 1.00].CGColor;
    self.password.layer.borderColor = [UIColor colorWithRed: 0.57 green: 0.78 blue: 0.69 alpha: 1.00].CGColor;
    self.login.layer.borderWidth = 1.5;
    self.password.layer.borderWidth = 1.5;
    self.authorize.userInteractionEnabled = NO;
    self.login.userInteractionEnabled = NO;
    self.password.userInteractionEnabled = NO;
    self.authorize.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
}

- (BOOL)authorizeComfigurationCheck:(UITextField *)text withData:(NSString *)dataText{
    BOOL check = NO;
    UIColor *colorWrong = [UIColor colorWithRed:0.76 green:0.00 blue:0.08 alpha:1.00];
    UIColor *colorRight = [UIColor colorWithRed:0.3 green:0.36 blue:0.41 alpha:1.0];
    if (![text.text isEqualToString: dataText])
    {
        text.layer.borderColor = colorWrong.CGColor;
    }
    else
    {
        text.layer.borderColor = colorRight.CGColor;
        check = YES;
    }
    return check;
}

- (void)tappingBegin:(UITextField *)sender {
    [sender becomeFirstResponder];
    sender.text = @"";
    UIColor *colorRight = [UIColor colorWithRed:0.3 green:0.36 blue:0.41 alpha:1.0];
    sender.layer.borderColor = colorRight.CGColor;
}

- (void)keyboardWillHide:(id)sender {
    NSLog(@"KeyBoard Close");
}

- (void)addDelegates:(UITextField *)sender {
    sender.delegate = self;
}

- (void)didTapAnywhere:(UITapGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.view2];
    BOOL isPointInsideButton = CGRectContainsPoint(self.authorize.frame, location);
    if (isPointInsideButton)
        [self.authorize endEditing:NO];
    else
        [self.view2 endEditing:YES];
}

- (void)didTapOnButton:(UITapGestureRecognizer *)sender {
    Data *data = [Data new];
    [self.authorize setBackgroundColor:[UIColor clearColor]];
    [self.authorize.titleLabel setAlpha:1.0];
    [self.authorize.imageView setAlpha:1.0];
    BOOL loginCheck = [self authorizeComfigurationCheck:self.login withData:data.login];
    BOOL passwordCheck = [self authorizeComfigurationCheck:self.password withData:data.password];
    if (loginCheck && passwordCheck)
    {
        [self.view2 endEditing:YES];
        [self authorizeComfigurationDisable];
        [self doubleCheckConfiguration];
    }
    else
    {
        [self.authorize endEditing:NO];
    }
}

- (void)didHighlight {
    if (self.authorize.isHighlighted && self.authorize.isEnabled)
    {
        [self.authorize setBackgroundColor:[UIColor colorWithRed:0.50 green:0.64 blue:0.93 alpha:0.2]];
        [self.authorize.imageView setAlpha:1.0];
        [self.authorize.titleLabel setAlpha:0.4];
        UIImage *imageFill = [UIImage new];
        if (@available(iOS 13.0, *))
            imageFill = [UIImage systemImageNamed:@"person.fill" withConfiguration:[UIImageSymbolConfiguration configurationWithFont:[UIFont systemFontOfSize:13 weight:UIFontWeightBold]]];
        else
            imageFill = [UIImage imageNamed:@"user-filled.png"];
        [self.authorize setImage:imageFill forState:UIControlStateHighlighted];
    }
    else
    {
        [self.authorize.titleLabel setAlpha:1.0];
        [self.authorize.imageView setAlpha:1.0];
        [self.authorize setBackgroundColor:[UIColor clearColor]];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
