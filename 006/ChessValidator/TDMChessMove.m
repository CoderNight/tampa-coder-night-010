//
//  TDMChessMove.m
//  ChessValidator
//
//  Created by Craig Clayton on 10/29/13.
//  Copyright (c) 2013 Craig Clayton. All rights reserved.
//

#import "TDMChessMove.h"

@implementation TDMChessMove

- (id)initWithMoves:(NSString *)move
{
    if ((self = [super init]))
    {
        self.moves = move;
        [self createMoves];
        [self createPositions];
    }
    
    return self;
}

- (void)createMoves
{
    NSArray* arrMoves = [self.moves componentsSeparatedByString:@" "];
    
    [arrMoves enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        if (idx == 0) self.startMove    = [arrMoves objectAtIndex:idx];
        if (idx == 1) self.endingMove   = [arrMoves objectAtIndex:idx];
    }];
    
    
    NSLog(@"create move %@ start %@ end %@", self.moves, self.startMove, self.endingMove);
    
    
}

- (int) convertPosition:(NSString *)letter
{
    if ([letter isEqualToString:@"a"]) return 1;
    if ([letter isEqualToString:@"b"]) return 2;
    if ([letter isEqualToString:@"c"]) return 3;
    if ([letter isEqualToString:@"d"]) return 4;
    if ([letter isEqualToString:@"e"]) return 5;
    if ([letter isEqualToString:@"f"]) return 6;
    if ([letter isEqualToString:@"g"]) return 7;
    if ([letter isEqualToString:@"h"]) return 8;
    else return 0;
}

- (void) createPositions
{
    self.startXPos  = [self convertPosition:[self.startMove substringToIndex:1]];
    self.endingXPos = [self convertPosition:[self.endingMove substringToIndex:1]];
    self.startYPos  = [[self.startMove substringFromIndex:1] intValue];
    self.endingYPos = [[self.endingMove substringFromIndex:1] intValue];
    
    NSLog(@"startx %i endx %i starty %i endy %i", self.startXPos, self.endingXPos, self.startYPos, self.endingYPos);
}




@end
