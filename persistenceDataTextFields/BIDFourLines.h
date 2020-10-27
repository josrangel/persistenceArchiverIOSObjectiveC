//
//  BIDFourLines.h
//  persistenceDataTextFields
//
//  Created by KMMX on 26/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BIDFourLines : NSObject <NSCoding,NSCopying>
@property (copy,nonatomic) NSArray *lines;
@end

NS_ASSUME_NONNULL_END
