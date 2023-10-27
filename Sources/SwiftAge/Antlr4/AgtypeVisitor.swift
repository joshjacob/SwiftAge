// Generated from Agtype.g4 by ANTLR 4.13.1
import Antlr4

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link AgtypeParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
open class AgtypeVisitor<T>: ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link AgtypeParser#agType}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitAgType(_ ctx: AgtypeParser.AgTypeContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link AgtypeParser#agValue}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitAgValue(_ ctx: AgtypeParser.AgValueContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code StringValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitStringValue(_ ctx: AgtypeParser.StringValueContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code IntegerValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitIntegerValue(_ ctx: AgtypeParser.IntegerValueContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code FloatValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitFloatValue(_ ctx: AgtypeParser.FloatValueContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code TrueBoolean}
	 * labeled alternative in {@link AgtypeParser#value}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitTrueBoolean(_ ctx: AgtypeParser.TrueBooleanContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code FalseBoolean}
	 * labeled alternative in {@link AgtypeParser#value}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitFalseBoolean(_ ctx: AgtypeParser.FalseBooleanContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code NullValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitNullValue(_ ctx: AgtypeParser.NullValueContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code ObjectValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitObjectValue(_ ctx: AgtypeParser.ObjectValueContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code ArrayValue}
	 * labeled alternative in {@link AgtypeParser#value}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitArrayValue(_ ctx: AgtypeParser.ArrayValueContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link AgtypeParser#obj}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitObj(_ ctx: AgtypeParser.ObjContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link AgtypeParser#pair}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitPair(_ ctx: AgtypeParser.PairContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link AgtypeParser#array}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitArray(_ ctx: AgtypeParser.ArrayContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link AgtypeParser#typeAnnotation}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitTypeAnnotation(_ ctx: AgtypeParser.TypeAnnotationContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link AgtypeParser#floatLiteral}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitFloatLiteral(_ ctx: AgtypeParser.FloatLiteralContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

}