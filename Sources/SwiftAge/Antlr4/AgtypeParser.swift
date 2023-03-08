// Generated from Agtype.g4 by ANTLR 4.12.0
import Antlr4

open class AgtypeParser: Parser {

	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = AgtypeParser._ATN.getNumberOfDecisions()
          for i in 0..<length {
            decisionToDFA.append(DFA(AgtypeParser._ATN.getDecisionState(i)!, i))
           }
           return decisionToDFA
     }()

	internal static let _sharedContextCache = PredictionContextCache()

	public
	enum Tokens: Int {
		case EOF = -1, T__0 = 1, T__1 = 2, T__2 = 3, T__3 = 4, T__4 = 5, T__5 = 6, 
                 T__6 = 7, T__7 = 8, T__8 = 9, T__9 = 10, T__10 = 11, T__11 = 12, 
                 T__12 = 13, IDENT = 14, STRING = 15, INTEGER = 16, RegularFloat = 17, 
                 ExponentFloat = 18, WS = 19
	}

	public
	static let RULE_agType = 0, RULE_agValue = 1, RULE_value = 2, RULE_obj = 3, 
            RULE_pair = 4, RULE_array = 5, RULE_typeAnnotation = 6, RULE_floatLiteral = 7

	public
	static let ruleNames: [String] = [
		"agType", "agValue", "value", "obj", "pair", "array", "typeAnnotation", 
		"floatLiteral"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, "'true'", "'false'", "'null'", "'{'", "','", "'}'", "':'", "'['", 
		"']'", "'::'", "'-'", "'Infinity'", "'NaN'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 
		"IDENT", "STRING", "INTEGER", "RegularFloat", "ExponentFloat", "WS"
	]
	public
	static let VOCABULARY = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)

	override open
	func getGrammarFileName() -> String { return "Agtype.g4" }

	override open
	func getRuleNames() -> [String] { return AgtypeParser.ruleNames }

	override open
	func getSerializedATN() -> [Int] { return AgtypeParser._serializedATN }

	override open
	func getATN() -> ATN { return AgtypeParser._ATN }


	override open
	func getVocabulary() -> Vocabulary {
	    return AgtypeParser.VOCABULARY
	}

	override public
	init(_ input:TokenStream) throws {
	    RuntimeMetaData.checkVersion("4.12.0", RuntimeMetaData.VERSION)
		try super.init(input)
		_interp = ParserATNSimulator(self,AgtypeParser._ATN,AgtypeParser._decisionToDFA, AgtypeParser._sharedContextCache)
	}


	public class AgTypeContext: ParserRuleContext {
			open
			func agValue() -> AgValueContext? {
				return getRuleContext(AgValueContext.self, 0)
			}
			open
			func EOF() -> TerminalNode? {
				return getToken(AgtypeParser.Tokens.EOF.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return AgtypeParser.RULE_agType
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.enterAgType(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.exitAgType(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? AgtypeVisitor {
			    return visitor.visitAgType(self)
			}
			else if let visitor = visitor as? AgtypeBaseVisitor {
			    return visitor.visitAgType(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func agType() throws -> AgTypeContext {
		var _localctx: AgTypeContext
		_localctx = AgTypeContext(_ctx, getState())
		try enterRule(_localctx, 0, AgtypeParser.RULE_agType)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(16)
		 	try agValue()
		 	setState(17)
		 	try match(AgtypeParser.Tokens.EOF.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class AgValueContext: ParserRuleContext {
			open
			func value() -> ValueContext? {
				return getRuleContext(ValueContext.self, 0)
			}
			open
			func typeAnnotation() -> TypeAnnotationContext? {
				return getRuleContext(TypeAnnotationContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return AgtypeParser.RULE_agValue
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.enterAgValue(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.exitAgValue(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? AgtypeVisitor {
			    return visitor.visitAgValue(self)
			}
			else if let visitor = visitor as? AgtypeBaseVisitor {
			    return visitor.visitAgValue(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func agValue() throws -> AgValueContext {
		var _localctx: AgValueContext
		_localctx = AgValueContext(_ctx, getState())
		try enterRule(_localctx, 2, AgtypeParser.RULE_agValue)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(19)
		 	try value()
		 	setState(21)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (_la == AgtypeParser.Tokens.T__9.rawValue) {
		 		setState(20)
		 		try typeAnnotation()

		 	}


		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class ValueContext: ParserRuleContext {
		override open
		func getRuleIndex() -> Int {
			return AgtypeParser.RULE_value
		}
	}
	public class NullValueContext: ValueContext {

		public
		init(_ ctx: ValueContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.enterNullValue(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.exitNullValue(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? AgtypeVisitor {
			    return visitor.visitNullValue(self)
			}
			else if let visitor = visitor as? AgtypeBaseVisitor {
			    return visitor.visitNullValue(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public class ObjectValueContext: ValueContext {
			open
			func obj() -> ObjContext? {
				return getRuleContext(ObjContext.self, 0)
			}

		public
		init(_ ctx: ValueContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.enterObjectValue(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.exitObjectValue(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? AgtypeVisitor {
			    return visitor.visitObjectValue(self)
			}
			else if let visitor = visitor as? AgtypeBaseVisitor {
			    return visitor.visitObjectValue(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public class IntegerValueContext: ValueContext {
			open
			func INTEGER() -> TerminalNode? {
				return getToken(AgtypeParser.Tokens.INTEGER.rawValue, 0)
			}

		public
		init(_ ctx: ValueContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.enterIntegerValue(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.exitIntegerValue(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? AgtypeVisitor {
			    return visitor.visitIntegerValue(self)
			}
			else if let visitor = visitor as? AgtypeBaseVisitor {
			    return visitor.visitIntegerValue(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public class TrueBooleanContext: ValueContext {

		public
		init(_ ctx: ValueContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.enterTrueBoolean(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.exitTrueBoolean(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? AgtypeVisitor {
			    return visitor.visitTrueBoolean(self)
			}
			else if let visitor = visitor as? AgtypeBaseVisitor {
			    return visitor.visitTrueBoolean(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public class FalseBooleanContext: ValueContext {

		public
		init(_ ctx: ValueContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.enterFalseBoolean(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.exitFalseBoolean(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? AgtypeVisitor {
			    return visitor.visitFalseBoolean(self)
			}
			else if let visitor = visitor as? AgtypeBaseVisitor {
			    return visitor.visitFalseBoolean(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public class FloatValueContext: ValueContext {
			open
			func floatLiteral() -> FloatLiteralContext? {
				return getRuleContext(FloatLiteralContext.self, 0)
			}

		public
		init(_ ctx: ValueContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.enterFloatValue(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.exitFloatValue(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? AgtypeVisitor {
			    return visitor.visitFloatValue(self)
			}
			else if let visitor = visitor as? AgtypeBaseVisitor {
			    return visitor.visitFloatValue(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public class StringValueContext: ValueContext {
			open
			func STRING() -> TerminalNode? {
				return getToken(AgtypeParser.Tokens.STRING.rawValue, 0)
			}

		public
		init(_ ctx: ValueContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.enterStringValue(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.exitStringValue(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? AgtypeVisitor {
			    return visitor.visitStringValue(self)
			}
			else if let visitor = visitor as? AgtypeBaseVisitor {
			    return visitor.visitStringValue(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public class ArrayValueContext: ValueContext {
			open
			func array() -> ArrayContext? {
				return getRuleContext(ArrayContext.self, 0)
			}

		public
		init(_ ctx: ValueContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.enterArrayValue(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.exitArrayValue(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? AgtypeVisitor {
			    return visitor.visitArrayValue(self)
			}
			else if let visitor = visitor as? AgtypeBaseVisitor {
			    return visitor.visitArrayValue(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func value() throws -> ValueContext {
		var _localctx: ValueContext
		_localctx = ValueContext(_ctx, getState())
		try enterRule(_localctx, 4, AgtypeParser.RULE_value)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(31)
		 	try _errHandler.sync(self)
		 	switch (AgtypeParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .STRING:
		 		_localctx =  StringValueContext(_localctx);
		 		try enterOuterAlt(_localctx, 1)
		 		setState(23)
		 		try match(AgtypeParser.Tokens.STRING.rawValue)

		 		break

		 	case .INTEGER:
		 		_localctx =  IntegerValueContext(_localctx);
		 		try enterOuterAlt(_localctx, 2)
		 		setState(24)
		 		try match(AgtypeParser.Tokens.INTEGER.rawValue)

		 		break
		 	case .T__10:fallthrough
		 	case .T__11:fallthrough
		 	case .T__12:fallthrough
		 	case .RegularFloat:fallthrough
		 	case .ExponentFloat:
		 		_localctx =  FloatValueContext(_localctx);
		 		try enterOuterAlt(_localctx, 3)
		 		setState(25)
		 		try floatLiteral()

		 		break

		 	case .T__0:
		 		_localctx =  TrueBooleanContext(_localctx);
		 		try enterOuterAlt(_localctx, 4)
		 		setState(26)
		 		try match(AgtypeParser.Tokens.T__0.rawValue)

		 		break

		 	case .T__1:
		 		_localctx =  FalseBooleanContext(_localctx);
		 		try enterOuterAlt(_localctx, 5)
		 		setState(27)
		 		try match(AgtypeParser.Tokens.T__1.rawValue)

		 		break

		 	case .T__2:
		 		_localctx =  NullValueContext(_localctx);
		 		try enterOuterAlt(_localctx, 6)
		 		setState(28)
		 		try match(AgtypeParser.Tokens.T__2.rawValue)

		 		break

		 	case .T__3:
		 		_localctx =  ObjectValueContext(_localctx);
		 		try enterOuterAlt(_localctx, 7)
		 		setState(29)
		 		try obj()

		 		break

		 	case .T__7:
		 		_localctx =  ArrayValueContext(_localctx);
		 		try enterOuterAlt(_localctx, 8)
		 		setState(30)
		 		try array()

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class ObjContext: ParserRuleContext {
			open
			func pair() -> [PairContext] {
				return getRuleContexts(PairContext.self)
			}
			open
			func pair(_ i: Int) -> PairContext? {
				return getRuleContext(PairContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return AgtypeParser.RULE_obj
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.enterObj(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.exitObj(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? AgtypeVisitor {
			    return visitor.visitObj(self)
			}
			else if let visitor = visitor as? AgtypeBaseVisitor {
			    return visitor.visitObj(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func obj() throws -> ObjContext {
		var _localctx: ObjContext
		_localctx = ObjContext(_ctx, getState())
		try enterRule(_localctx, 6, AgtypeParser.RULE_obj)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(46)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,3, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(33)
		 		try match(AgtypeParser.Tokens.T__3.rawValue)
		 		setState(34)
		 		try pair()
		 		setState(39)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (_la == AgtypeParser.Tokens.T__4.rawValue) {
		 			setState(35)
		 			try match(AgtypeParser.Tokens.T__4.rawValue)
		 			setState(36)
		 			try pair()


		 			setState(41)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}
		 		setState(42)
		 		try match(AgtypeParser.Tokens.T__5.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(44)
		 		try match(AgtypeParser.Tokens.T__3.rawValue)
		 		setState(45)
		 		try match(AgtypeParser.Tokens.T__5.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class PairContext: ParserRuleContext {
			open
			func STRING() -> TerminalNode? {
				return getToken(AgtypeParser.Tokens.STRING.rawValue, 0)
			}
			open
			func agValue() -> AgValueContext? {
				return getRuleContext(AgValueContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return AgtypeParser.RULE_pair
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.enterPair(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.exitPair(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? AgtypeVisitor {
			    return visitor.visitPair(self)
			}
			else if let visitor = visitor as? AgtypeBaseVisitor {
			    return visitor.visitPair(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func pair() throws -> PairContext {
		var _localctx: PairContext
		_localctx = PairContext(_ctx, getState())
		try enterRule(_localctx, 8, AgtypeParser.RULE_pair)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(48)
		 	try match(AgtypeParser.Tokens.STRING.rawValue)
		 	setState(49)
		 	try match(AgtypeParser.Tokens.T__6.rawValue)
		 	setState(50)
		 	try agValue()

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class ArrayContext: ParserRuleContext {
			open
			func agValue() -> [AgValueContext] {
				return getRuleContexts(AgValueContext.self)
			}
			open
			func agValue(_ i: Int) -> AgValueContext? {
				return getRuleContext(AgValueContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return AgtypeParser.RULE_array
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.enterArray(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.exitArray(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? AgtypeVisitor {
			    return visitor.visitArray(self)
			}
			else if let visitor = visitor as? AgtypeBaseVisitor {
			    return visitor.visitArray(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func array() throws -> ArrayContext {
		var _localctx: ArrayContext
		_localctx = ArrayContext(_ctx, getState())
		try enterRule(_localctx, 10, AgtypeParser.RULE_array)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(65)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,5, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(52)
		 		try match(AgtypeParser.Tokens.T__7.rawValue)
		 		setState(53)
		 		try agValue()
		 		setState(58)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (_la == AgtypeParser.Tokens.T__4.rawValue) {
		 			setState(54)
		 			try match(AgtypeParser.Tokens.T__4.rawValue)
		 			setState(55)
		 			try agValue()


		 			setState(60)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}
		 		setState(61)
		 		try match(AgtypeParser.Tokens.T__8.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(63)
		 		try match(AgtypeParser.Tokens.T__7.rawValue)
		 		setState(64)
		 		try match(AgtypeParser.Tokens.T__8.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class TypeAnnotationContext: ParserRuleContext {
			open
			func IDENT() -> TerminalNode? {
				return getToken(AgtypeParser.Tokens.IDENT.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return AgtypeParser.RULE_typeAnnotation
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.enterTypeAnnotation(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.exitTypeAnnotation(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? AgtypeVisitor {
			    return visitor.visitTypeAnnotation(self)
			}
			else if let visitor = visitor as? AgtypeBaseVisitor {
			    return visitor.visitTypeAnnotation(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func typeAnnotation() throws -> TypeAnnotationContext {
		var _localctx: TypeAnnotationContext
		_localctx = TypeAnnotationContext(_ctx, getState())
		try enterRule(_localctx, 12, AgtypeParser.RULE_typeAnnotation)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(67)
		 	try match(AgtypeParser.Tokens.T__9.rawValue)
		 	setState(68)
		 	try match(AgtypeParser.Tokens.IDENT.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class FloatLiteralContext: ParserRuleContext {
			open
			func RegularFloat() -> TerminalNode? {
				return getToken(AgtypeParser.Tokens.RegularFloat.rawValue, 0)
			}
			open
			func ExponentFloat() -> TerminalNode? {
				return getToken(AgtypeParser.Tokens.ExponentFloat.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return AgtypeParser.RULE_floatLiteral
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.enterFloatLiteral(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? AgtypeListener {
				listener.exitFloatLiteral(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? AgtypeVisitor {
			    return visitor.visitFloatLiteral(self)
			}
			else if let visitor = visitor as? AgtypeBaseVisitor {
			    return visitor.visitFloatLiteral(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func floatLiteral() throws -> FloatLiteralContext {
		var _localctx: FloatLiteralContext
		_localctx = FloatLiteralContext(_ctx, getState())
		try enterRule(_localctx, 14, AgtypeParser.RULE_floatLiteral)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(77)
		 	try _errHandler.sync(self)
		 	switch (AgtypeParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .RegularFloat:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(70)
		 		try match(AgtypeParser.Tokens.RegularFloat.rawValue)

		 		break

		 	case .ExponentFloat:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(71)
		 		try match(AgtypeParser.Tokens.ExponentFloat.rawValue)

		 		break
		 	case .T__10:fallthrough
		 	case .T__11:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(73)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (_la == AgtypeParser.Tokens.T__10.rawValue) {
		 			setState(72)
		 			try match(AgtypeParser.Tokens.T__10.rawValue)

		 		}

		 		setState(75)
		 		try match(AgtypeParser.Tokens.T__11.rawValue)

		 		break

		 	case .T__12:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(76)
		 		try match(AgtypeParser.Tokens.T__12.rawValue)

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	static let _serializedATN:[Int] = [
		4,1,19,80,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,2,7,
		7,7,1,0,1,0,1,0,1,1,1,1,3,1,22,8,1,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,3,2,
		32,8,2,1,3,1,3,1,3,1,3,5,3,38,8,3,10,3,12,3,41,9,3,1,3,1,3,1,3,1,3,3,3,
		47,8,3,1,4,1,4,1,4,1,4,1,5,1,5,1,5,1,5,5,5,57,8,5,10,5,12,5,60,9,5,1,5,
		1,5,1,5,1,5,3,5,66,8,5,1,6,1,6,1,6,1,7,1,7,1,7,3,7,74,8,7,1,7,1,7,3,7,
		78,8,7,1,7,0,0,8,0,2,4,6,8,10,12,14,0,0,87,0,16,1,0,0,0,2,19,1,0,0,0,4,
		31,1,0,0,0,6,46,1,0,0,0,8,48,1,0,0,0,10,65,1,0,0,0,12,67,1,0,0,0,14,77,
		1,0,0,0,16,17,3,2,1,0,17,18,5,0,0,1,18,1,1,0,0,0,19,21,3,4,2,0,20,22,3,
		12,6,0,21,20,1,0,0,0,21,22,1,0,0,0,22,3,1,0,0,0,23,32,5,15,0,0,24,32,5,
		16,0,0,25,32,3,14,7,0,26,32,5,1,0,0,27,32,5,2,0,0,28,32,5,3,0,0,29,32,
		3,6,3,0,30,32,3,10,5,0,31,23,1,0,0,0,31,24,1,0,0,0,31,25,1,0,0,0,31,26,
		1,0,0,0,31,27,1,0,0,0,31,28,1,0,0,0,31,29,1,0,0,0,31,30,1,0,0,0,32,5,1,
		0,0,0,33,34,5,4,0,0,34,39,3,8,4,0,35,36,5,5,0,0,36,38,3,8,4,0,37,35,1,
		0,0,0,38,41,1,0,0,0,39,37,1,0,0,0,39,40,1,0,0,0,40,42,1,0,0,0,41,39,1,
		0,0,0,42,43,5,6,0,0,43,47,1,0,0,0,44,45,5,4,0,0,45,47,5,6,0,0,46,33,1,
		0,0,0,46,44,1,0,0,0,47,7,1,0,0,0,48,49,5,15,0,0,49,50,5,7,0,0,50,51,3,
		2,1,0,51,9,1,0,0,0,52,53,5,8,0,0,53,58,3,2,1,0,54,55,5,5,0,0,55,57,3,2,
		1,0,56,54,1,0,0,0,57,60,1,0,0,0,58,56,1,0,0,0,58,59,1,0,0,0,59,61,1,0,
		0,0,60,58,1,0,0,0,61,62,5,9,0,0,62,66,1,0,0,0,63,64,5,8,0,0,64,66,5,9,
		0,0,65,52,1,0,0,0,65,63,1,0,0,0,66,11,1,0,0,0,67,68,5,10,0,0,68,69,5,14,
		0,0,69,13,1,0,0,0,70,78,5,17,0,0,71,78,5,18,0,0,72,74,5,11,0,0,73,72,1,
		0,0,0,73,74,1,0,0,0,74,75,1,0,0,0,75,78,5,12,0,0,76,78,5,13,0,0,77,70,
		1,0,0,0,77,71,1,0,0,0,77,73,1,0,0,0,77,76,1,0,0,0,78,15,1,0,0,0,8,21,31,
		39,46,58,65,73,77
	]

	public
	static let _ATN = try! ATNDeserializer().deserialize(_serializedATN)
}