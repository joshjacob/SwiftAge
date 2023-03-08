//
//  SwiftAgeVisitor.swift
//  
//
//  Created by Joshua Jacob on 3/7/23.
//

import Foundation
import Antlr4

public class SwiftAgeVisitor : AgtypeVisitor<AGValue?> {
    
    static func cleanString(_ string: String) -> String {
        let quote = "\""
        var returnString = string
        if returnString.hasPrefix(quote) {
            returnString = String(returnString.dropFirst(quote.count))
        }
        if returnString.hasSuffix(quote) {
            returnString = String(returnString.dropLast(quote.count))
        }
        return returnString
    }
    
    /**
     * Visit a parse tree produced by {@link AgtypeParser#agType}.
     - Parameters:
     - ctx: the parse tree
     - returns: the visitor result
     */
    public override func visitAgType(_ ctx: AgtypeParser.AgTypeContext) -> AGValue? {
        if let agVal = ctx.agValue() {
            let ageVisitorAgValue = AgeVisitorAgValue()
            return agVal.accept(ageVisitorAgValue) ?? nil
        }
        return nil
    }
}

class AgeVisitorAgValue : AgtypeVisitor<AGValue?> {
    
    /**
     * Visit a parse tree produced by {@link AgtypeParser#agValue}.
     - Parameters:
     - ctx: the parse tree
     - returns: the visitor result
     */
    override func visitAgValue(_ ctx: AgtypeParser.AgValueContext) -> AGValue? {
        guard let valueCtx = ctx.value() else { return nil }
        if let annoCtx = ctx.typeAnnotation() {
            let anno = annoCtx.accept(AgeVisitorATypeAnnotation())
            let agValue = self.handleAnnotatedValue(anno: anno ?? "", ctx: valueCtx)
            return agValue
        } else {
            if valueCtx is AgtypeParser.StringValueContext {
                let ageVisitor = AgeVisitorStringValue()
                let agValue = valueCtx.accept(ageVisitor) ?? nil
                return agValue
            }
            if valueCtx is AgtypeParser.IntegerValueContext {
                let ageVisitor = AgeVisitorIntegerValue()
                let agValue = valueCtx.accept(ageVisitor) ?? nil
                return agValue
            }
            if valueCtx is AgtypeParser.FloatValueContext {
                let ageVisitor = AgeVisitorFloatValue()
                let agValue = valueCtx.accept(ageVisitor) ?? nil
                return agValue
            }
            if valueCtx is AgtypeParser.TrueBooleanContext {
                let ageVisitor = AgeVisitorBooleanValue()
                let agValue = valueCtx.accept(ageVisitor) ?? nil
                return agValue
            }
            if valueCtx is AgtypeParser.FalseBooleanContext {
                let ageVisitor = AgeVisitorBooleanValue()
                let agValue = valueCtx.accept(ageVisitor) ?? nil
                return agValue
            }
            if valueCtx is AgtypeParser.NullValueContext {
                let ageVisitor = AgeVisitorNullValue()
                let _ = valueCtx.accept(ageVisitor) ?? nil
                // let agValue = AGValue.init(value: nil)
                return nil
            }
            if valueCtx is AgtypeParser.ObjectValueContext {
                let ageVisitor = AgeVisitorObjectValue()
                let agValue = valueCtx.accept(ageVisitor) ?? nil
                return agValue
            }
            else if valueCtx is AgtypeParser.ArrayValueContext {
                let ageVisitor = AgeVisitorArrayValue()
                let agValue = valueCtx.accept(ageVisitor) ?? nil
                return agValue
            }
        }
        return nil
    }
    
    private func handleAnnotatedValue(anno:String, ctx:ParserRuleContext) -> AGValue {
        
        if anno == "numeric" {
            // TODO: consider failed parsing return
            return Decimal.init(string: ctx.getText()) ?? Decimal(0.0)
        }
        else if anno == "vertex" {
            let dict = ctx.accept(AgeVisitorObjectValue())
            //var vid = dict. // dict["id"]
            // var vertex = None
            // if self.vertexCache != None and vid in self.vertexCache {
            //     vertex = self.vertexCache[vid]
            // } else {
            let id = dict?["id"] as? Int64 ?? 0
            let label = dict?["label"] as? String ?? ""
            let properties = dict?["properties"] as? Dictionary<String,AGValue> ?? Dictionary<String,AGValue>()
            let vertex = Vertex.init(
                id: id,
                label: label,
                properties: properties)
            // }
            
            // TODO: review vertex cache
            /* if self.vertexCache != None {
                self.vertexCache[vid] = vertex
            } */
            
            return vertex
        }
        else if anno == "edge" {
            if ctx is AgtypeParser.ObjectValueContext {
                let dict = ctx.accept(AgeVisitorObjectValue())
                let id = dict?["id"] as? Int64 ?? 0
                let label = dict?["label"] as? String ?? ""
                let properties = dict?["properties"] as? Dictionary<String,AGValue> ?? Dictionary<String,AGValue>()
                var edge = Edge(
                    id: id,
                    label: label,
                    properties: properties)
                edge.endId = dict?["end_id"] as? Int64 ?? 0
                edge.startId = dict?["start_id"] as? Int64 ?? 0
                return edge
            }
        }
        else if anno == "path" {
            let arr = ctx.accept(AgeVisitorArrayValue())
            let path = Path.init(entities: arr ?? [])
            return path
        }
        // return ctx.accept(self)
        else {
            return Decimal.init(string: ctx.getText()) ?? Decimal(0.0)
        }
        return Decimal.init(string: ctx.getText()) ?? Decimal(0.0)
    }
}

class AgeVisitorStringValue : AgtypeVisitor<String> {
    
    /**
     * Visit a parse tree produced by the {@code StringValue}
     * labeled alternative in {@link AgtypeParser#value}.
     - Parameters:
     - ctx: the parse tree
     - returns: the visitor result
     */
    override func visitStringValue(_ ctx: AgtypeParser.StringValueContext) -> String {
        // TODO: reconsider if string is null
        let string = ctx.STRING()?.getText() ?? ""
        return SwiftAgeVisitor.cleanString(string)
    }
}

class AgeVisitorIntegerValue : AgtypeVisitor<Int64> {
    
    /**
     * Visit a parse tree produced by the {@code IntegerValue}
     * labeled alternative in {@link AgtypeParser#value}.
     - Parameters:
     - ctx: the parse tree
     - returns: the visitor result
     */
    override func visitIntegerValue(_ ctx: AgtypeParser.IntegerValueContext) -> Int64 {
        // TODO: reconsider if int is null
        return Int64.init(ctx.INTEGER()?.getText() ?? "0") ?? 0
    }
}

class AgeVisitorFloatValue : AgtypeVisitor<Double> {
    /**
     * Visit a parse tree produced by the {@code FloatValue}
     * labeled alternative in {@link AgtypeParser#value}.
     - Parameters:
     - ctx: the parse tree
     - returns: the visitor result
     */
    override func visitFloatValue(_ ctx: AgtypeParser.FloatValueContext) -> Double {
        if let floatLiteral =  ctx.floatLiteral() {
            return floatLiteral.accept(AgeVisitorFloatLiteral()) ?? 0.0
        } else {
            // TODO: review return
            return 0.0
        }
    }
}
 
class AgeVisitorBooleanValue : AgtypeVisitor<Bool> {
    /**
     * Visit a parse tree produced by the {@code TrueBoolean}
     * labeled alternative in {@link AgtypeParser#value}.
     - Parameters:
     - ctx: the parse tree
     - returns: the visitor result
     */
    override func visitTrueBoolean(_ ctx: AgtypeParser.TrueBooleanContext) -> Bool {
        return true
    }
    
    /**
     * Visit a parse tree produced by the {@code FalseBoolean}
     * labeled alternative in {@link AgtypeParser#value}.
     - Parameters:
     - ctx: the parse tree
     - returns: the visitor result
     */
    override func visitFalseBoolean(_ ctx: AgtypeParser.FalseBooleanContext) -> Bool {
        return false
    }
}

class AgeVisitorNullValue : AgtypeVisitor<NSNull> {
    /**
     * Visit a parse tree produced by the {@code NullValue}
     * labeled alternative in {@link AgtypeParser#value}.
     - Parameters:
     - ctx: the parse tree
     - returns: the visitor result
     */
    override func visitNullValue(_ ctx: AgtypeParser.NullValueContext) -> NSNull {
        return NSNull.init()
    }
}
    
class AgeVisitorObjectValue : AgtypeVisitor<Dictionary<String,AGValue>> {
    /**
     * Visit a parse tree produced by the {@code ObjectValue}
     * labeled alternative in {@link AgtypeParser#value}.
    - Parameters:
      - ctx: the parse tree
    - returns: the visitor result
     */
    override func visitObjectValue(_ ctx: AgtypeParser.ObjectValueContext) -> Dictionary<String,AGValue> {
        var objValue = Dictionary<String,AGValue>()
        for child in ctx.children ?? [] {
            if let obj = child.accept(AgeVisitorObject()) {
                objValue = obj
            }
        }
        return objValue
    }
    
}

class AgeVisitorArrayValue : AgtypeVisitor<[AGValue]> {
    /**
     * Visit a parse tree produced by the {@code ArrayValue}
     * labeled alternative in {@link AgtypeParser#value}.
     - Parameters:
     - ctx: the parse tree
     - returns: the visitor result
     */
    override func visitArrayValue(_ ctx: AgtypeParser.ArrayValueContext) -> [AGValue] {
        var arrayValue = [AGValue]()
        for child in ctx.children ?? [] {
            if let agArray = child.accept(AgeVisitorArray()) {
                arrayValue.append(contentsOf: agArray)
            }
        }
        return arrayValue
    }
}

class AgeVisitorObject : AgtypeVisitor<Dictionary<String,AGValue>> {
    /**
     * Visit a parse tree produced by {@link AgtypeParser#obj}.
     - Parameters:
     - ctx: the parse tree
     - returns: the visitor result
     */
    override func visitObj(_ ctx: AgtypeParser.ObjContext) -> Dictionary<String,AGValue>  {
        var dict = Dictionary<String, AGValue>()
        for child in ctx.children ?? [] {
            if !(child is TerminalNode) {
                let (pairString, pairValue) = child.accept(AgeVisitorPair()) ?? ("", nil)
                dict[SwiftAgeVisitor.cleanString(pairString)] = pairValue
            }
        }
        return dict
    }
}
    
class AgeVisitorPair : AgtypeVisitor<(String,AGValue?)> {
    /**
     * Visit a parse tree produced by {@link AgtypeParser#pair}.
     - Parameters:
     - ctx: the parse tree
     - returns: the visitor result
     */
    override func visitPair(_ ctx: AgtypeParser.PairContext) -> (String,AGValue?) {
        // TODO: review use of !
        let value = ctx.agValue()?.accept(AgeVisitorAgValue())! as AGValue?
        // TODO: consider empty string
        return (ctx.STRING()?.getText() ?? "", value)
    }
}

class AgeVisitorArray : AgtypeVisitor<[AGValue]> {
    
    /**
     * Visit a parse tree produced by {@link AgtypeParser#array}.
     - Parameters:
     - ctx: the parse tree
     - returns: the visitor result
     */
    override func visitArray(_ ctx: AgtypeParser.ArrayContext) -> [AGValue] {
        var array = [AGValue]()
        if let children = ctx.children {
            for child in children {
                if !(child is TerminalNode) {
                    if let agValue = child.accept(AgeVisitorAgValue()) as? AGValue {
                        array.append(agValue)
                    }
                }
            }
        }
        return array
    }
}

class AgeVisitorATypeAnnotation : AgtypeVisitor<String> {
    /**
     * Visit a parse tree produced by {@link AgtypeParser#typeAnnotation}.
     - Parameters:
     - ctx: the parse tree
     - returns: the visitor result
     */
    override func visitTypeAnnotation(_ ctx: AgtypeParser.TypeAnnotationContext) -> String {
        return ctx.IDENT()?.getText() ?? ""
    }
}

class AgeVisitorFloatLiteral : AgtypeVisitor<Double> {
    /**
     * Visit a parse tree produced by {@link AgtypeParser#floatLiteral}.
    - Parameters:
      - ctx: the parse tree
    - returns: the visitor result
     */
    override func visitFloatLiteral(_ ctx: AgtypeParser.FloatLiteralContext) -> Double {
        if let float = ctx.RegularFloat() {
            return Double(float.getText()) ?? 0.0
        }
        else if let float = ctx.ExponentFloat() {
            return Double(float.getText()) ?? 0.0
        }
        else {
            let text = ctx.getText()
            if text == "NaN" {
                return Double.nan
            }
            else if text == "-Infinity" {
                return Double.infinity
            }
            else if text == "Infinity" {
                return -Double.infinity
            }
            else {
                // TODO: Review options for throwing errors
                return Double.nan
            }
        }
    }
}

