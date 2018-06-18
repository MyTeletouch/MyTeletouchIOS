//
//  AnsiiToScanCodeConverter.swift
//  MyTeletouch
//
//  Created by julian on 7/13/15.
//  Copyright (c) 2015 MyTeletouch. All rights reserved.
//

import Foundation

struct ScanCodeInfo{
    var ScanCode  = UInt8()
    var SpecialKeys = UInt8()
}

/// Class to exctract scan code from ANSII char
internal class AnsiiToScanCodeConverter {

    /// Pressed shift key bit set
    private static var ShiftKey: UInt8 = 0b00000010
    
    /**
    Scan code information from character
    
    :param: char Character value
    
    :returns: Scan code and shift state
    */
    static func scanCodeFromChar(char: Character) -> ScanCodeInfo {
        let characterString = String(char)
        let scalars = characterString.unicodeScalars
        return scanCode(scalars[scalars.startIndex].value)
    }
    
    /**
    Scan code information from ANSII code
    
    :param: charCode ANSII char code
    
    :returns: Scan code and shift state
    */
    static func scanCode(charCode: UInt32) -> ScanCodeInfo {
        switch(charCode){
        case 8: return ScanCodeInfo(ScanCode: 0x2A, SpecialKeys: 0)//BS
        case 9: return ScanCodeInfo(ScanCode: 0x2B, SpecialKeys: 0)//TAB
        case 10: return ScanCodeInfo(ScanCode: 0x28, SpecialKeys: 0)//New line
        case 32: return ScanCodeInfo(ScanCode: 0x2C, SpecialKeys: 0)//spaece
        case 33: return ScanCodeInfo(ScanCode: 0x1E, SpecialKeys: ShiftKey)//!
        case 34: return ScanCodeInfo(ScanCode: 0x34, SpecialKeys: ShiftKey)//"
        case 35: return ScanCodeInfo(ScanCode: 0x20, SpecialKeys: ShiftKey)//#
        case 36: return ScanCodeInfo(ScanCode: 0x21, SpecialKeys: ShiftKey)//$
        case 37: return ScanCodeInfo(ScanCode: 0x22, SpecialKeys: ShiftKey)//%
        case 38: return ScanCodeInfo(ScanCode: 0x24, SpecialKeys: ShiftKey)//&
        case 39: return ScanCodeInfo(ScanCode: 0x34, SpecialKeys: 0)//'
        case 40: return ScanCodeInfo(ScanCode: 0x26, SpecialKeys: ShiftKey)//(
        case 41: return ScanCodeInfo(ScanCode: 0x27, SpecialKeys: ShiftKey)//)
        case 42: return ScanCodeInfo(ScanCode: 0x25, SpecialKeys: ShiftKey)//*
        case 43: return ScanCodeInfo(ScanCode: 0x2E, SpecialKeys: ShiftKey)//+
        case 44: return ScanCodeInfo(ScanCode: 0x36, SpecialKeys: 0)//,
        case 45: return ScanCodeInfo(ScanCode: 0x2D, SpecialKeys: 0)//-
        case 46: return ScanCodeInfo(ScanCode: 0x37, SpecialKeys: 0)//.
        case 47: return ScanCodeInfo(ScanCode: 0x38, SpecialKeys: 0)///
        case 48: return ScanCodeInfo(ScanCode: 0x27, SpecialKeys: 0)//0
        case 49: return ScanCodeInfo(ScanCode: 0x1E, SpecialKeys: 0)//1
        case 50: return ScanCodeInfo(ScanCode: 0x1F, SpecialKeys: 0)//2
        case 51: return ScanCodeInfo(ScanCode: 0x20, SpecialKeys: 0)//3
        case 52: return ScanCodeInfo(ScanCode: 0x21, SpecialKeys: 0)//4
        case 53: return ScanCodeInfo(ScanCode: 0x22, SpecialKeys: 0)//5
        case 54: return ScanCodeInfo(ScanCode: 0x23, SpecialKeys: 0)//6
        case 55: return ScanCodeInfo(ScanCode: 0x24, SpecialKeys: 0)//7
        case 56: return ScanCodeInfo(ScanCode: 0x25, SpecialKeys: 0)//8
        case 57: return ScanCodeInfo(ScanCode: 0x26, SpecialKeys: 0)//9
        case 58: return ScanCodeInfo(ScanCode: 0x33, SpecialKeys: ShiftKey)//:
        case 59: return ScanCodeInfo(ScanCode: 0x33, SpecialKeys: 0)//;
        case 60: return ScanCodeInfo(ScanCode: 0x36, SpecialKeys: ShiftKey)//<
        case 61: return ScanCodeInfo(ScanCode: 0x2E, SpecialKeys: 0)//=
        case 62: return ScanCodeInfo(ScanCode: 0x37, SpecialKeys: ShiftKey)//>
        case 63: return ScanCodeInfo(ScanCode: 0x38, SpecialKeys: ShiftKey)//?
        case 64: return ScanCodeInfo(ScanCode: 0x1F, SpecialKeys: ShiftKey)//@
        case 65: return ScanCodeInfo(ScanCode: 0x04, SpecialKeys: ShiftKey)//A
        case 66: return ScanCodeInfo(ScanCode: 0x05, SpecialKeys: ShiftKey)//B
        case 67: return ScanCodeInfo(ScanCode: 0x06, SpecialKeys: ShiftKey)//C
        case 68: return ScanCodeInfo(ScanCode: 0x07, SpecialKeys: ShiftKey)//D
        case 69: return ScanCodeInfo(ScanCode: 0x08, SpecialKeys: ShiftKey)//E
        case 70: return ScanCodeInfo(ScanCode: 0x09, SpecialKeys: ShiftKey)//F
        case 71: return ScanCodeInfo(ScanCode: 0x0A, SpecialKeys: ShiftKey)//G
        case 72: return ScanCodeInfo(ScanCode: 0x0B, SpecialKeys: ShiftKey)//H
        case 73: return ScanCodeInfo(ScanCode: 0x0C, SpecialKeys: ShiftKey)//I
        case 74: return ScanCodeInfo(ScanCode: 0x0D, SpecialKeys: ShiftKey)//J
        case 75: return ScanCodeInfo(ScanCode: 0x0E, SpecialKeys: ShiftKey)//K
        case 76: return ScanCodeInfo(ScanCode: 0x0F, SpecialKeys: ShiftKey)//L
        case 77: return ScanCodeInfo(ScanCode: 0x10, SpecialKeys: ShiftKey)//M
        case 78: return ScanCodeInfo(ScanCode: 0x11, SpecialKeys: ShiftKey)//N
        case 79: return ScanCodeInfo(ScanCode: 0x12, SpecialKeys: ShiftKey)//O
        case 80: return ScanCodeInfo(ScanCode: 0x13, SpecialKeys: ShiftKey)//P
        case 81: return ScanCodeInfo(ScanCode: 0x14, SpecialKeys: ShiftKey)//Q
        case 82: return ScanCodeInfo(ScanCode: 0x15, SpecialKeys: ShiftKey)//R
        case 83: return ScanCodeInfo(ScanCode: 0x16, SpecialKeys: ShiftKey)//S
        case 84: return ScanCodeInfo(ScanCode: 0x17, SpecialKeys: ShiftKey)//T
        case 85: return ScanCodeInfo(ScanCode: 0x18, SpecialKeys: ShiftKey)//U
        case 86: return ScanCodeInfo(ScanCode: 0x19, SpecialKeys: ShiftKey)//V
        case 87: return ScanCodeInfo(ScanCode: 0x1A, SpecialKeys: ShiftKey)//W
        case 88: return ScanCodeInfo(ScanCode: 0x1B, SpecialKeys: ShiftKey)//X
        case 89: return ScanCodeInfo(ScanCode: 0x1C, SpecialKeys: ShiftKey)//Y
        case 90: return ScanCodeInfo(ScanCode: 0x1D, SpecialKeys: ShiftKey)//Z
        case 91: return ScanCodeInfo(ScanCode: 0x2F, SpecialKeys: 0)//[
        case 92: return ScanCodeInfo(ScanCode: 0x31, SpecialKeys: 0)//\
        case 93: return ScanCodeInfo(ScanCode: 0x30, SpecialKeys: 0)//]
        case 94: return ScanCodeInfo(ScanCode: 0x23, SpecialKeys: ShiftKey)//^
        case 95: return ScanCodeInfo(ScanCode: 0x2D, SpecialKeys: ShiftKey)//_
        case 96: return ScanCodeInfo(ScanCode: 0x32, SpecialKeys: 0)//`
        case 97: return ScanCodeInfo (ScanCode: 0x04, SpecialKeys: 0)//a
        case 98: return ScanCodeInfo (ScanCode: 0x05, SpecialKeys: 0)//b
        case 99: return ScanCodeInfo (ScanCode: 0x06, SpecialKeys: 0)//c
        case 100: return ScanCodeInfo(ScanCode: 0x07, SpecialKeys: 0)//d
        case 101: return ScanCodeInfo(ScanCode: 0x08, SpecialKeys: 0)//e
        case 102: return ScanCodeInfo(ScanCode: 0x09, SpecialKeys: 0)//f
        case 103: return ScanCodeInfo(ScanCode: 0x0A, SpecialKeys: 0)//g
        case 104: return ScanCodeInfo(ScanCode: 0x0B, SpecialKeys: 0)//h
        case 105: return ScanCodeInfo(ScanCode: 0x0C, SpecialKeys: 0)//i
        case 106: return ScanCodeInfo(ScanCode: 0x0D, SpecialKeys: 0)//j
        case 107: return ScanCodeInfo(ScanCode: 0x0E, SpecialKeys: 0)//k
        case 108: return ScanCodeInfo(ScanCode: 0x0F, SpecialKeys: 0)//l
        case 109: return ScanCodeInfo(ScanCode: 0x10, SpecialKeys: 0)//m
        case 110: return ScanCodeInfo(ScanCode: 0x11, SpecialKeys: 0)//n
        case 111: return ScanCodeInfo(ScanCode: 0x12, SpecialKeys: 0)//o
        case 112: return ScanCodeInfo(ScanCode: 0x13, SpecialKeys: 0)//p
        case 113: return ScanCodeInfo(ScanCode: 0x14, SpecialKeys: 0)//q
        case 114: return ScanCodeInfo(ScanCode: 0x15, SpecialKeys: 0)//r
        case 115: return ScanCodeInfo(ScanCode: 0x16, SpecialKeys: 0)//s
        case 116: return ScanCodeInfo(ScanCode: 0x17, SpecialKeys: 0)//t
        case 117: return ScanCodeInfo(ScanCode: 0x18, SpecialKeys: 0)//u
        case 118: return ScanCodeInfo(ScanCode: 0x19, SpecialKeys: 0)//v
        case 119: return ScanCodeInfo(ScanCode: 0x1A, SpecialKeys: 0)//w
        case 120: return ScanCodeInfo(ScanCode: 0x1B, SpecialKeys: 0)//x
        case 121: return ScanCodeInfo(ScanCode: 0x1C, SpecialKeys: 0)//y
        case 122: return ScanCodeInfo(ScanCode: 0x1D, SpecialKeys: 0)//z
        case 123: return ScanCodeInfo(ScanCode: 0x2F, SpecialKeys: ShiftKey)//{
        case 124: return ScanCodeInfo(ScanCode: 0x31, SpecialKeys: ShiftKey)//|
        case 125: return ScanCodeInfo(ScanCode: 0x30, SpecialKeys: ShiftKey)//}
        case 126: return ScanCodeInfo(ScanCode: 0x32, SpecialKeys: ShiftKey)//~
        default: return ScanCodeInfo()
        }
    }
}