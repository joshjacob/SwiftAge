// Generated from Agtype.g4 by ANTLR 4.13.1

import Antlr4


/**
 * This class provides an empty implementation of {@link AgtypeListener},
 * which can be extended to create a listener which only needs to handle a subset
 * of the available methods.
 */
open class AgtypeBaseListener: AgtypeListener {
     public init() { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterAgType(_ ctx: AgtypeParser.AgTypeContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitAgType(_ ctx: AgtypeParser.AgTypeContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterAgValue(_ ctx: AgtypeParser.AgValueContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitAgValue(_ ctx: AgtypeParser.AgValueContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterStringValue(_ ctx: AgtypeParser.StringValueContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitStringValue(_ ctx: AgtypeParser.StringValueContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterIntegerValue(_ ctx: AgtypeParser.IntegerValueContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitIntegerValue(_ ctx: AgtypeParser.IntegerValueContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterFloatValue(_ ctx: AgtypeParser.FloatValueContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitFloatValue(_ ctx: AgtypeParser.FloatValueContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterTrueBoolean(_ ctx: AgtypeParser.TrueBooleanContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitTrueBoolean(_ ctx: AgtypeParser.TrueBooleanContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterFalseBoolean(_ ctx: AgtypeParser.FalseBooleanContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitFalseBoolean(_ ctx: AgtypeParser.FalseBooleanContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterNullValue(_ ctx: AgtypeParser.NullValueContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitNullValue(_ ctx: AgtypeParser.NullValueContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterObjectValue(_ ctx: AgtypeParser.ObjectValueContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitObjectValue(_ ctx: AgtypeParser.ObjectValueContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterArrayValue(_ ctx: AgtypeParser.ArrayValueContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitArrayValue(_ ctx: AgtypeParser.ArrayValueContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterObj(_ ctx: AgtypeParser.ObjContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitObj(_ ctx: AgtypeParser.ObjContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterPair(_ ctx: AgtypeParser.PairContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitPair(_ ctx: AgtypeParser.PairContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterArray(_ ctx: AgtypeParser.ArrayContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitArray(_ ctx: AgtypeParser.ArrayContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterTypeAnnotation(_ ctx: AgtypeParser.TypeAnnotationContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitTypeAnnotation(_ ctx: AgtypeParser.TypeAnnotationContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterFloatLiteral(_ ctx: AgtypeParser.FloatLiteralContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitFloatLiteral(_ ctx: AgtypeParser.FloatLiteralContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterEveryRule(_ ctx: ParserRuleContext) throws { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitEveryRule(_ ctx: ParserRuleContext) throws { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func visitTerminal(_ node: TerminalNode) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func visitErrorNode(_ node: ErrorNode) { }
}