// Generated from Agtype.g4 by ANTLR 4.13.1
import Antlr4

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link AgtypeParser}.
 */
public protocol AgtypeListener: ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link AgtypeParser#agType}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterAgType(_ ctx: AgtypeParser.AgTypeContext)
	/**
	 * Exit a parse tree produced by {@link AgtypeParser#agType}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitAgType(_ ctx: AgtypeParser.AgTypeContext)
	/**
	 * Enter a parse tree produced by {@link AgtypeParser#agValue}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterAgValue(_ ctx: AgtypeParser.AgValueContext)
	/**
	 * Exit a parse tree produced by {@link AgtypeParser#agValue}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitAgValue(_ ctx: AgtypeParser.AgValueContext)
	/**
	 * Enter a parse tree produced by the {@code StringValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterStringValue(_ ctx: AgtypeParser.StringValueContext)
	/**
	 * Exit a parse tree produced by the {@code StringValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitStringValue(_ ctx: AgtypeParser.StringValueContext)
	/**
	 * Enter a parse tree produced by the {@code IntegerValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterIntegerValue(_ ctx: AgtypeParser.IntegerValueContext)
	/**
	 * Exit a parse tree produced by the {@code IntegerValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitIntegerValue(_ ctx: AgtypeParser.IntegerValueContext)
	/**
	 * Enter a parse tree produced by the {@code FloatValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterFloatValue(_ ctx: AgtypeParser.FloatValueContext)
	/**
	 * Exit a parse tree produced by the {@code FloatValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitFloatValue(_ ctx: AgtypeParser.FloatValueContext)
	/**
	 * Enter a parse tree produced by the {@code TrueBoolean}
	 * labeled alternative in {@link AgtypeParser#value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterTrueBoolean(_ ctx: AgtypeParser.TrueBooleanContext)
	/**
	 * Exit a parse tree produced by the {@code TrueBoolean}
	 * labeled alternative in {@link AgtypeParser#value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitTrueBoolean(_ ctx: AgtypeParser.TrueBooleanContext)
	/**
	 * Enter a parse tree produced by the {@code FalseBoolean}
	 * labeled alternative in {@link AgtypeParser#value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterFalseBoolean(_ ctx: AgtypeParser.FalseBooleanContext)
	/**
	 * Exit a parse tree produced by the {@code FalseBoolean}
	 * labeled alternative in {@link AgtypeParser#value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitFalseBoolean(_ ctx: AgtypeParser.FalseBooleanContext)
	/**
	 * Enter a parse tree produced by the {@code NullValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterNullValue(_ ctx: AgtypeParser.NullValueContext)
	/**
	 * Exit a parse tree produced by the {@code NullValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitNullValue(_ ctx: AgtypeParser.NullValueContext)
	/**
	 * Enter a parse tree produced by the {@code ObjectValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterObjectValue(_ ctx: AgtypeParser.ObjectValueContext)
	/**
	 * Exit a parse tree produced by the {@code ObjectValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitObjectValue(_ ctx: AgtypeParser.ObjectValueContext)
	/**
	 * Enter a parse tree produced by the {@code ArrayValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterArrayValue(_ ctx: AgtypeParser.ArrayValueContext)
	/**
	 * Exit a parse tree produced by the {@code ArrayValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitArrayValue(_ ctx: AgtypeParser.ArrayValueContext)
	/**
	 * Enter a parse tree produced by {@link AgtypeParser#obj}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterObj(_ ctx: AgtypeParser.ObjContext)
	/**
	 * Exit a parse tree produced by {@link AgtypeParser#obj}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitObj(_ ctx: AgtypeParser.ObjContext)
	/**
	 * Enter a parse tree produced by {@link AgtypeParser#pair}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterPair(_ ctx: AgtypeParser.PairContext)
	/**
	 * Exit a parse tree produced by {@link AgtypeParser#pair}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitPair(_ ctx: AgtypeParser.PairContext)
	/**
	 * Enter a parse tree produced by {@link AgtypeParser#array}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterArray(_ ctx: AgtypeParser.ArrayContext)
	/**
	 * Exit a parse tree produced by {@link AgtypeParser#array}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitArray(_ ctx: AgtypeParser.ArrayContext)
	/**
	 * Enter a parse tree produced by {@link AgtypeParser#typeAnnotation}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterTypeAnnotation(_ ctx: AgtypeParser.TypeAnnotationContext)
	/**
	 * Exit a parse tree produced by {@link AgtypeParser#typeAnnotation}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitTypeAnnotation(_ ctx: AgtypeParser.TypeAnnotationContext)
	/**
	 * Enter a parse tree produced by {@link AgtypeParser#floatLiteral}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterFloatLiteral(_ ctx: AgtypeParser.FloatLiteralContext)
	/**
	 * Exit a parse tree produced by {@link AgtypeParser#floatLiteral}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitFloatLiteral(_ ctx: AgtypeParser.FloatLiteralContext)
}