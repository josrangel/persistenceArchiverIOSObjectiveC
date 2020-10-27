//
//  BIDFourLines.m
//  persistenceDataTextFields
//
//  Created by KMMX on 26/10/20.
//

#import "BIDFourLines.h"

static NSString *const KLinesKey = @"KLinesKey";

@implementation BIDFourLines



- (id)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
    if(self){
        self.lines = [coder decodeObjectForKey:KLinesKey];
    }
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.lines forKey:KLinesKey];
}



- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    BIDFourLines *copy = [[[self class] allocWithZone:zone] init];
    NSMutableArray *linesCopy = [NSMutableArray array];
    for (id line in self.lines) {
        [linesCopy addObject:[line copyWithZone:zone]];
    }
    copy.lines = linesCopy;
    return copy;
}

@end
