//
//  ViewController.m
//  persistenceDataTextFields
//
//  Created by KMMX on 26/10/20.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong,nonatomic) IBOutletCollection(UITextField) NSArray *linefields;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *filepath = [self dataFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filepath]){
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filepath];
        for (int i = 0; i<4; i++) {
            UITextField *theField = self.linefields[i];
            theField.text = array[i];
        }
    }
    
    UIApplication *app = [UIApplication sharedApplication];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)  name:UIApplicationWillResignActiveNotification object:app];
    
    
}

-(void)applicationWillResignActive:(NSNotification *)notification{
    NSString *filePath = [self dataFilePath];
    NSArray *array = [self.linefields valueForKey:@"text"];
    [array writeToFile:filePath atomically:YES];
}

-(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
}


@end
