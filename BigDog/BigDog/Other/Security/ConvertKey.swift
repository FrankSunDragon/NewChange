//
//  ConvertKey.swift
//  BigDog
//
//  Created by Jacky Sun on 2016/11/9.
//  Copyright © 2016年 syf. All rights reserved.
//

import UIKit

public class ConvertKey: NSObject {
    
    
   class func additiveHash(key:String, prime:Int)->Int
    {
        var hash:Int=0;
        for item in key.characters{
            
            hash += item.toInt();
        }
        return (hash % prime);
    }
    
//    var hash:Int = additiveHash(key: "abcabcabcabcabcabcabcabcabcabcabc",prime: 1000003);
//    
    
    class func getKey(key:String)->String{
        if(key.characters.count>16){
            let key1:String = key.substring(with: key.startIndex..<key.index(key.startIndex, offsetBy: 12));
            let key2 = key.substring(from: key.index(key.startIndex, offsetBy: 12));
            var hash = String(additiveHash(key: key2,prime: 1000003));
            let length = hash.characters.count;
            if(length<4){
                let newValue  = key2.substring(with:key.startIndex..<key.index(key.startIndex,offsetBy:4-length))
                hash += newValue;
            }
            
            return key1+hash;
        }else if(key.characters.count<16){
            var key1:String = key+key;
            repeat{
                key1+=key1;
                
            }while(key1.characters.count<16);
            return key1.substring(with: key1.startIndex..<key1.index(key1.startIndex, offsetBy: 16));
        }
        return key;
    }
}


extension Character
{
    func toInt() -> Int
    {
        var intFromCharacter:Int = 0
        for scalar in String(self).unicodeScalars
        {
            intFromCharacter = Int(scalar.value)
        }
        return intFromCharacter
    }
}

