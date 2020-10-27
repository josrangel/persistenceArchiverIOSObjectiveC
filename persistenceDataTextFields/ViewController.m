//
//  ViewController.m
//  persistenceDataTextFields
//
//  Created by KMMX on 26/10/20.
//

#import "ViewController.h"
#import "BIDFourLines.h"

static NSString *const kRootKey = @"kRootKey";

@interface ViewController ()
@property (strong,nonatomic) IBOutletCollection(UITextField) NSArray *linefields;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *filepath = [self dataFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filepath]){
        /*NSArray *array = [[NSArray alloc] initWithContentsOfFile:filepath];
        for (int i = 0; i<4; i++) {
            UITextField *theField = self.linefields[i];
            theField.text = array[i];
        }*/
        //buffer de bytes
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filepath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        BIDFourLines *fourLines = [unarchiver decodeObjectForKey:kRootKey];
        [unarchiver finishDecoding];
        for (int i = 0; i < 4; i++) {
            UITextField *theField = self.linefields[i];
            theField.text = fourLines.lines[i];
        }
    }
    
    UIApplication *app = [UIApplication sharedApplication];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)  name:UIApplicationWillResignActiveNotification object:app];
    
    
}

-(void)applicationWillResignActive:(NSNotification *)notification{
    NSString *filePath = [self dataFilePath];
    //NSArray *array = [self.linefields valueForKey:@"text"];
    //[array writeToFile:filePath atomically:YES];
    BIDFourLines *fourLines = [[BIDFourLines alloc] init];
    fourLines.lines = [self.linefields valueForKey:@"text"];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:fourLines forKey:kRootKey];
    [archiver finishEncoding];
    [data writeToFile:filePath atomically:YES];
}

-(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //return [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    return [documentsDirectory stringByAppendingPathComponent:@"data.archive"];

}


@end
