//
//  DoraemonBackTraceDecoder.m
//  DoraemonKit
//
//  Created by apple on 2020/8/21.
//

#import "DoraemonBackTraceDecoder.h"

//@interface DoraemonBackTraceDecoder()
//
//@property (nonatomic, assign) NSInteger base;
//@property (nonatomic, assign) NSInteger tMin;
//@property (nonatomic, assign) NSInteger tMax;
//@property (nonatomic, assign) NSInteger skew;
//@property (nonatomic, assign) NSInteger damp;
//@property (nonatomic, assign) NSInteger initialBias;
//@property (nonatomic, assign) NSInteger initialN;
//
//@property (nonatomic, assign) NSString *delimiter;
//@property (nonatomic, assign) NSMutableArray *encodeTable;
//@property (nonatomic, assign) NSMutableArray *decodeTable;
//
//@end

@implementation DoraemonBackTraceDecoder

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        _base = 36;
//        _tMin = 1;
//        _tMax = 26;
//        _skew = 38;
//        _damp = 700;
//        _initialBias = 72;
//        _initialN = 0x80;
//        _delimiter = @"_";
//        _encodeTable = [@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJ" componentsSeparatedByString:@""].mutableCopy;
//        for (int i = 0; i < _encodeTable.count; i++) {
//            _decodeTable[i] = _encodeTable[i];
//        }
//        
//    }
//    return self;
//  
//}
//
//- (NSString *)encode:(NSString *)unicode {
//    
//    NSMutableString *retval = [NSMutableString string];
//    NSMutableArray *extendedChars = [NSMutableArray array];
//    for (NSString *c in [unicode componentsSeparatedByString:@""]) {
//        NSInteger ci = c.integerValue;
//        if (ci < self.initialN) {
//            [retval appendString:c];
//        } else {
//            [extendedChars addObject:@(ci)];
//        }
//            
//    }
//        
//    if (extendedChars.count == 0) {
//        return retval;
//    }
//        
//    [retval appendString:self.delimiter];
//        
////    extendedChars.sortInPlace()
//        
//    NSInteger bias = self.initialBias;
//    NSInteger delta = 0;
//    NSInteger n = self.initialN;
//    NSInteger h = retval.u.count - 1
//    NSInteger b = retval.unicodeScalars.count - 1
//        
//        for var i = 0; h < unicode.unicodeScalars.count; {
//            let char = extendedChars[i++]
//            delta = delta + (char - n) * (h + 1)
//            n = char
//            
//            for c in unicode.unicodeScalars {
//                let ci = Int(c.value)
//                if ci < n || ci < initialN {
//                    delta++
//                }
//                
//                if ci == n {
//                    var q = delta
//                    for var k = self.base; ; k += base {
//                        let t = max(min(k - bias, self.tMax), self.tMin)
//                        if q < t {
//                            break
//                        }
//                        
//                        let code = t + ((q - t) % (self.base - t))
//                        retval.append(self.encodeTable[code])
//                        
//                        q = (q - t) / (self.base - t)
//                    }
//                    
//                    retval.append(self.encodeTable[q])
//                    bias = self.adapt(delta, h + 1, h == b)
//                    delta = 0
//                    h++
//                }
//            }
//            
//            delta++
//            n++
//        }
//        return retval
//    }
//    
//    private func adapt(var delta: Int, _ numPoints: Int, _ firstTime: Bool) -> Int {
//        delta = delta / (firstTime ? self.damp : 2)
//        
//        delta += delta / numPoints
//        var k = 0
//        while (delta > ((self.base - self.tMin) * self.tMax) / 2) {
//            delta = delta / (self.base - self.tMin)
//            k = k + self.base
//        }
//        k += ((self.base - self.tMin + 1) * delta) / (delta + self.skew)
//        return k
//    }
//    
//    //MARK: decode
//    
//    public func decode(punycode: String) -> String {
//        var input = [Character](punycode.characters)
//        var n = self.initialN
//        var i = 0
//        var bias = self.initialBias
//        var output = [Character]()
//        
//        var pos = 0
//        if let ipos = input.indexOf(self.delimiter) {
//            pos = ipos
//            output.appendContentsOf(input[0 ..< pos++])
//        }
//        
//        var outputLength = output.count
//        let inputLength = input.count
//        while pos < inputLength {
//            let oldi = i
//            var w = 1
//            for var k = self.base;; k += self.base {
//                let digit = self.decodeTable[input[pos++]]!
//                i = i + (digit * w)
//                let t = max(min(k - bias, self.tMax), self.tMin)
//                if (digit < t) {
//                    break
//                }
//                w = w * (self.base - t)
//            }
//            bias = self.adapt(i - oldi, ++outputLength, (oldi == 0))
//            n = n + i / outputLength
//            i = i % outputLength
//            output.insert(Character(UnicodeScalar(n)), atIndex: i)
//            i++
//        }
//        return String(output)
//    }
//}

@end
