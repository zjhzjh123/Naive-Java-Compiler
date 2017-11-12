// Generated from /Users/zhangjiaheng/IdeaProjects/compiler/src/zzz.g4 by ANTLR 4.5.1
package antlr;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class zzzParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.5.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, T__8=9, 
		T__9=10, T__10=11, T__11=12, T__12=13, T__13=14, T__14=15, T__15=16, T__16=17, 
		T__17=18, T__18=19, T__19=20, T__20=21, T__21=22, T__22=23, T__23=24, 
		T__24=25, T__25=26, T__26=27, T__27=28, T__28=29, T__29=30, T__30=31, 
		T__31=32, WS=33, COMMENT=34, LineComment=35, IF=36, ELSE=37, RETURN=38, 
		BREAK=39, CONTINUE=40, WHILE=41, FOR=42, VIOD=43, CLASS=44, NEW=45, INT=46, 
		STRING=47, BOOL=48, NULL=49, BoolLiteral=50, IntLiteral=51, StringLiteral=52, 
		ID=53;
	public static final int
		RULE_stmt = 0, RULE_expr_stmt = 1, RULE_expr = 2, RULE_assignment_expr = 3, 
		RULE_logic_or_expr = 4, RULE_logic_and_expr = 5, RULE_inclusive_or_expr = 6, 
		RULE_exclusive_or_expr = 7, RULE_and_expr = 8, RULE_equality_expr = 9, 
		RULE_relational_expr = 10, RULE_shift_expr = 11, RULE_additive_expr = 12, 
		RULE_multiplication_expr = 13, RULE_creation_expr = 14, RULE_dim_expr = 15, 
		RULE_unary_expr = 16, RULE_postfix_expr = 17, RULE_param_list = 18, RULE_pre_expr = 19, 
		RULE_class_decl = 20, RULE_member_decl_list = 21, RULE_var_decl_stmt = 22, 
		RULE_func_decl = 23, RULE_param_decl_list = 24, RULE_block_stmt = 25, 
		RULE_stmt_list = 26, RULE_program = 27, RULE_type = 28, RULE_basictype = 29;
	public static final String[] ruleNames = {
		"stmt", "expr_stmt", "expr", "assignment_expr", "logic_or_expr", "logic_and_expr", 
		"inclusive_or_expr", "exclusive_or_expr", "and_expr", "equality_expr", 
		"relational_expr", "shift_expr", "additive_expr", "multiplication_expr", 
		"creation_expr", "dim_expr", "unary_expr", "postfix_expr", "param_list", 
		"pre_expr", "class_decl", "member_decl_list", "var_decl_stmt", "func_decl", 
		"param_decl_list", "block_stmt", "stmt_list", "program", "type", "basictype"
	};

	private static final String[] _LITERAL_NAMES = {
		null, "'('", "')'", "';'", "'='", "'||'", "'&&'", "'|'", "'^'", "'&'", 
		"'!='", "'=='", "'<'", "'>'", "'<='", "'>='", "'<<'", "'>>'", "'+'", "'-'", 
		"'/'", "'*'", "'%'", "'['", "']'", "'++'", "'--'", "'!'", "'~'", "'.'", 
		"','", "'{'", "'}'", null, null, null, "'if'", "'else'", "'return'", "'break'", 
		"'continue'", "'while'", "'for'", "'void'", "'class'", "'new'", "'int'", 
		"'string'", "'bool'", "'null'"
	};
	private static final String[] _SYMBOLIC_NAMES = {
		null, null, null, null, null, null, null, null, null, null, null, null, 
		null, null, null, null, null, null, null, null, null, null, null, null, 
		null, null, null, null, null, null, null, null, null, "WS", "COMMENT", 
		"LineComment", "IF", "ELSE", "RETURN", "BREAK", "CONTINUE", "WHILE", "FOR", 
		"VIOD", "CLASS", "NEW", "INT", "STRING", "BOOL", "NULL", "BoolLiteral", 
		"IntLiteral", "StringLiteral", "ID"
	};
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "zzz.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public zzzParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}
	public static class StmtContext extends ParserRuleContext {
		public StmtContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_stmt; }
	 
		public StmtContext() { }
		public void copyFrom(StmtContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class ExpresionContext extends StmtContext {
		public Expr_stmtContext expr_stmt() {
			return getRuleContext(Expr_stmtContext.class,0);
		}
		public ExpresionContext(StmtContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterExpresion(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitExpresion(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitExpresion(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class Val_declContext extends StmtContext {
		public Var_decl_stmtContext var_decl_stmt() {
			return getRuleContext(Var_decl_stmtContext.class,0);
		}
		public Val_declContext(StmtContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterVal_decl(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitVal_decl(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitVal_decl(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class BreakContext extends StmtContext {
		public TerminalNode BREAK() { return getToken(zzzParser.BREAK, 0); }
		public BreakContext(StmtContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterBreak(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitBreak(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitBreak(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class ContinueContext extends StmtContext {
		public TerminalNode CONTINUE() { return getToken(zzzParser.CONTINUE, 0); }
		public ContinueContext(StmtContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterContinue(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitContinue(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitContinue(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class ForContext extends StmtContext {
		public TerminalNode FOR() { return getToken(zzzParser.FOR, 0); }
		public StmtContext stmt() {
			return getRuleContext(StmtContext.class,0);
		}
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public ForContext(StmtContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterFor(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitFor(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitFor(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class BlockContext extends StmtContext {
		public Block_stmtContext block_stmt() {
			return getRuleContext(Block_stmtContext.class,0);
		}
		public BlockContext(StmtContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterBlock(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitBlock(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitBlock(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class WhileContext extends StmtContext {
		public TerminalNode WHILE() { return getToken(zzzParser.WHILE, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public StmtContext stmt() {
			return getRuleContext(StmtContext.class,0);
		}
		public WhileContext(StmtContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterWhile(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitWhile(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitWhile(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class If_elseContext extends StmtContext {
		public TerminalNode IF() { return getToken(zzzParser.IF, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public List<StmtContext> stmt() {
			return getRuleContexts(StmtContext.class);
		}
		public StmtContext stmt(int i) {
			return getRuleContext(StmtContext.class,i);
		}
		public TerminalNode ELSE() { return getToken(zzzParser.ELSE, 0); }
		public If_elseContext(StmtContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterIf_else(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitIf_else(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitIf_else(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class IfContext extends StmtContext {
		public TerminalNode IF() { return getToken(zzzParser.IF, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public StmtContext stmt() {
			return getRuleContext(StmtContext.class,0);
		}
		public IfContext(StmtContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterIf(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitIf(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitIf(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class ReturnContext extends StmtContext {
		public TerminalNode RETURN() { return getToken(zzzParser.RETURN, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public ReturnContext(StmtContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterReturn(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitReturn(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitReturn(this);
			else return visitor.visitChildren(this);
		}
	}

	public final StmtContext stmt() throws RecognitionException {
		StmtContext _localctx = new StmtContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_stmt);
		int _la;
		try {
			setState(107);
			switch ( getInterpreter().adaptivePredict(_input,4,_ctx) ) {
			case 1:
				_localctx = new BlockContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(60);
				block_stmt();
				}
				break;
			case 2:
				_localctx = new Val_declContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(61);
				var_decl_stmt();
				}
				break;
			case 3:
				_localctx = new ExpresionContext(_localctx);
				enterOuterAlt(_localctx, 3);
				{
				setState(62);
				expr_stmt();
				}
				break;
			case 4:
				_localctx = new If_elseContext(_localctx);
				enterOuterAlt(_localctx, 4);
				{
				setState(63);
				match(IF);
				setState(64);
				match(T__0);
				setState(65);
				expr();
				setState(66);
				match(T__1);
				setState(67);
				stmt();
				setState(68);
				match(ELSE);
				setState(69);
				stmt();
				}
				break;
			case 5:
				_localctx = new IfContext(_localctx);
				enterOuterAlt(_localctx, 5);
				{
				setState(71);
				match(IF);
				setState(72);
				match(T__0);
				setState(73);
				expr();
				setState(74);
				match(T__1);
				setState(75);
				stmt();
				}
				break;
			case 6:
				_localctx = new ReturnContext(_localctx);
				enterOuterAlt(_localctx, 6);
				{
				setState(77);
				match(RETURN);
				setState(79);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__17) | (1L << T__18) | (1L << T__24) | (1L << T__25) | (1L << T__26) | (1L << T__27) | (1L << NEW) | (1L << NULL) | (1L << BoolLiteral) | (1L << IntLiteral) | (1L << StringLiteral) | (1L << ID))) != 0)) {
					{
					setState(78);
					expr();
					}
				}

				setState(81);
				match(T__2);
				}
				break;
			case 7:
				_localctx = new BreakContext(_localctx);
				enterOuterAlt(_localctx, 7);
				{
				setState(82);
				match(BREAK);
				setState(83);
				match(T__2);
				}
				break;
			case 8:
				_localctx = new ContinueContext(_localctx);
				enterOuterAlt(_localctx, 8);
				{
				setState(84);
				match(CONTINUE);
				setState(85);
				match(T__2);
				}
				break;
			case 9:
				_localctx = new WhileContext(_localctx);
				enterOuterAlt(_localctx, 9);
				{
				setState(86);
				match(WHILE);
				setState(87);
				match(T__0);
				setState(88);
				expr();
				setState(89);
				match(T__1);
				setState(90);
				stmt();
				}
				break;
			case 10:
				_localctx = new ForContext(_localctx);
				enterOuterAlt(_localctx, 10);
				{
				setState(92);
				match(FOR);
				setState(93);
				match(T__0);
				setState(95);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__17) | (1L << T__18) | (1L << T__24) | (1L << T__25) | (1L << T__26) | (1L << T__27) | (1L << NEW) | (1L << NULL) | (1L << BoolLiteral) | (1L << IntLiteral) | (1L << StringLiteral) | (1L << ID))) != 0)) {
					{
					setState(94);
					expr();
					}
				}

				setState(97);
				match(T__2);
				setState(99);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__17) | (1L << T__18) | (1L << T__24) | (1L << T__25) | (1L << T__26) | (1L << T__27) | (1L << NEW) | (1L << NULL) | (1L << BoolLiteral) | (1L << IntLiteral) | (1L << StringLiteral) | (1L << ID))) != 0)) {
					{
					setState(98);
					expr();
					}
				}

				setState(101);
				match(T__2);
				setState(103);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__17) | (1L << T__18) | (1L << T__24) | (1L << T__25) | (1L << T__26) | (1L << T__27) | (1L << NEW) | (1L << NULL) | (1L << BoolLiteral) | (1L << IntLiteral) | (1L << StringLiteral) | (1L << ID))) != 0)) {
					{
					setState(102);
					expr();
					}
				}

				setState(105);
				match(T__1);
				setState(106);
				stmt();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Expr_stmtContext extends ParserRuleContext {
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public Expr_stmtContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expr_stmt; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterExpr_stmt(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitExpr_stmt(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitExpr_stmt(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Expr_stmtContext expr_stmt() throws RecognitionException {
		Expr_stmtContext _localctx = new Expr_stmtContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_expr_stmt);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(110);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__17) | (1L << T__18) | (1L << T__24) | (1L << T__25) | (1L << T__26) | (1L << T__27) | (1L << NEW) | (1L << NULL) | (1L << BoolLiteral) | (1L << IntLiteral) | (1L << StringLiteral) | (1L << ID))) != 0)) {
				{
				setState(109);
				expr();
				}
			}

			setState(112);
			match(T__2);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExprContext extends ParserRuleContext {
		public Assignment_exprContext assignment_expr() {
			return getRuleContext(Assignment_exprContext.class,0);
		}
		public ExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitExpr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ExprContext expr() throws RecognitionException {
		ExprContext _localctx = new ExprContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_expr);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(114);
			assignment_expr(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Assignment_exprContext extends ParserRuleContext {
		public Logic_or_exprContext logic_or_expr() {
			return getRuleContext(Logic_or_exprContext.class,0);
		}
		public List<Assignment_exprContext> assignment_expr() {
			return getRuleContexts(Assignment_exprContext.class);
		}
		public Assignment_exprContext assignment_expr(int i) {
			return getRuleContext(Assignment_exprContext.class,i);
		}
		public Assignment_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assignment_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterAssignment_expr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitAssignment_expr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitAssignment_expr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Assignment_exprContext assignment_expr() throws RecognitionException {
		return assignment_expr(0);
	}

	private Assignment_exprContext assignment_expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Assignment_exprContext _localctx = new Assignment_exprContext(_ctx, _parentState);
		Assignment_exprContext _prevctx = _localctx;
		int _startState = 6;
		enterRecursionRule(_localctx, 6, RULE_assignment_expr, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(117);
			logic_or_expr(0);
			}
			_ctx.stop = _input.LT(-1);
			setState(124);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,6,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new Assignment_exprContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_assignment_expr);
					setState(119);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(120);
					match(T__3);
					setState(121);
					assignment_expr(2);
					}
					} 
				}
				setState(126);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,6,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Logic_or_exprContext extends ParserRuleContext {
		public Logic_and_exprContext logic_and_expr() {
			return getRuleContext(Logic_and_exprContext.class,0);
		}
		public List<Logic_or_exprContext> logic_or_expr() {
			return getRuleContexts(Logic_or_exprContext.class);
		}
		public Logic_or_exprContext logic_or_expr(int i) {
			return getRuleContext(Logic_or_exprContext.class,i);
		}
		public Logic_or_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_logic_or_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterLogic_or_expr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitLogic_or_expr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitLogic_or_expr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Logic_or_exprContext logic_or_expr() throws RecognitionException {
		return logic_or_expr(0);
	}

	private Logic_or_exprContext logic_or_expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Logic_or_exprContext _localctx = new Logic_or_exprContext(_ctx, _parentState);
		Logic_or_exprContext _prevctx = _localctx;
		int _startState = 8;
		enterRecursionRule(_localctx, 8, RULE_logic_or_expr, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(128);
			logic_and_expr(0);
			}
			_ctx.stop = _input.LT(-1);
			setState(135);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,7,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new Logic_or_exprContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_logic_or_expr);
					setState(130);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(131);
					match(T__4);
					setState(132);
					logic_or_expr(3);
					}
					} 
				}
				setState(137);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,7,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Logic_and_exprContext extends ParserRuleContext {
		public Inclusive_or_exprContext inclusive_or_expr() {
			return getRuleContext(Inclusive_or_exprContext.class,0);
		}
		public List<Logic_and_exprContext> logic_and_expr() {
			return getRuleContexts(Logic_and_exprContext.class);
		}
		public Logic_and_exprContext logic_and_expr(int i) {
			return getRuleContext(Logic_and_exprContext.class,i);
		}
		public Logic_and_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_logic_and_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterLogic_and_expr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitLogic_and_expr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitLogic_and_expr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Logic_and_exprContext logic_and_expr() throws RecognitionException {
		return logic_and_expr(0);
	}

	private Logic_and_exprContext logic_and_expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Logic_and_exprContext _localctx = new Logic_and_exprContext(_ctx, _parentState);
		Logic_and_exprContext _prevctx = _localctx;
		int _startState = 10;
		enterRecursionRule(_localctx, 10, RULE_logic_and_expr, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(139);
			inclusive_or_expr(0);
			}
			_ctx.stop = _input.LT(-1);
			setState(146);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,8,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new Logic_and_exprContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_logic_and_expr);
					setState(141);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(142);
					match(T__5);
					setState(143);
					logic_and_expr(2);
					}
					} 
				}
				setState(148);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,8,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Inclusive_or_exprContext extends ParserRuleContext {
		public Exclusive_or_exprContext exclusive_or_expr() {
			return getRuleContext(Exclusive_or_exprContext.class,0);
		}
		public List<Inclusive_or_exprContext> inclusive_or_expr() {
			return getRuleContexts(Inclusive_or_exprContext.class);
		}
		public Inclusive_or_exprContext inclusive_or_expr(int i) {
			return getRuleContext(Inclusive_or_exprContext.class,i);
		}
		public Inclusive_or_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_inclusive_or_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterInclusive_or_expr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitInclusive_or_expr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitInclusive_or_expr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Inclusive_or_exprContext inclusive_or_expr() throws RecognitionException {
		return inclusive_or_expr(0);
	}

	private Inclusive_or_exprContext inclusive_or_expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Inclusive_or_exprContext _localctx = new Inclusive_or_exprContext(_ctx, _parentState);
		Inclusive_or_exprContext _prevctx = _localctx;
		int _startState = 12;
		enterRecursionRule(_localctx, 12, RULE_inclusive_or_expr, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(150);
			exclusive_or_expr(0);
			}
			_ctx.stop = _input.LT(-1);
			setState(157);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,9,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new Inclusive_or_exprContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_inclusive_or_expr);
					setState(152);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(153);
					match(T__6);
					setState(154);
					inclusive_or_expr(3);
					}
					} 
				}
				setState(159);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,9,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Exclusive_or_exprContext extends ParserRuleContext {
		public And_exprContext and_expr() {
			return getRuleContext(And_exprContext.class,0);
		}
		public List<Exclusive_or_exprContext> exclusive_or_expr() {
			return getRuleContexts(Exclusive_or_exprContext.class);
		}
		public Exclusive_or_exprContext exclusive_or_expr(int i) {
			return getRuleContext(Exclusive_or_exprContext.class,i);
		}
		public Exclusive_or_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_exclusive_or_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterExclusive_or_expr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitExclusive_or_expr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitExclusive_or_expr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Exclusive_or_exprContext exclusive_or_expr() throws RecognitionException {
		return exclusive_or_expr(0);
	}

	private Exclusive_or_exprContext exclusive_or_expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Exclusive_or_exprContext _localctx = new Exclusive_or_exprContext(_ctx, _parentState);
		Exclusive_or_exprContext _prevctx = _localctx;
		int _startState = 14;
		enterRecursionRule(_localctx, 14, RULE_exclusive_or_expr, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(161);
			and_expr(0);
			}
			_ctx.stop = _input.LT(-1);
			setState(168);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,10,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new Exclusive_or_exprContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_exclusive_or_expr);
					setState(163);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(164);
					match(T__7);
					setState(165);
					exclusive_or_expr(3);
					}
					} 
				}
				setState(170);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,10,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class And_exprContext extends ParserRuleContext {
		public Equality_exprContext equality_expr() {
			return getRuleContext(Equality_exprContext.class,0);
		}
		public List<And_exprContext> and_expr() {
			return getRuleContexts(And_exprContext.class);
		}
		public And_exprContext and_expr(int i) {
			return getRuleContext(And_exprContext.class,i);
		}
		public And_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_and_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterAnd_expr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitAnd_expr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitAnd_expr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final And_exprContext and_expr() throws RecognitionException {
		return and_expr(0);
	}

	private And_exprContext and_expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		And_exprContext _localctx = new And_exprContext(_ctx, _parentState);
		And_exprContext _prevctx = _localctx;
		int _startState = 16;
		enterRecursionRule(_localctx, 16, RULE_and_expr, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(172);
			equality_expr(0);
			}
			_ctx.stop = _input.LT(-1);
			setState(179);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,11,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new And_exprContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_and_expr);
					setState(174);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(175);
					match(T__8);
					setState(176);
					and_expr(3);
					}
					} 
				}
				setState(181);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,11,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Equality_exprContext extends ParserRuleContext {
		public Token op;
		public Relational_exprContext relational_expr() {
			return getRuleContext(Relational_exprContext.class,0);
		}
		public List<Equality_exprContext> equality_expr() {
			return getRuleContexts(Equality_exprContext.class);
		}
		public Equality_exprContext equality_expr(int i) {
			return getRuleContext(Equality_exprContext.class,i);
		}
		public Equality_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_equality_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterEquality_expr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitEquality_expr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitEquality_expr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Equality_exprContext equality_expr() throws RecognitionException {
		return equality_expr(0);
	}

	private Equality_exprContext equality_expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Equality_exprContext _localctx = new Equality_exprContext(_ctx, _parentState);
		Equality_exprContext _prevctx = _localctx;
		int _startState = 18;
		enterRecursionRule(_localctx, 18, RULE_equality_expr, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(183);
			relational_expr(0);
			}
			_ctx.stop = _input.LT(-1);
			setState(190);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,12,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new Equality_exprContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_equality_expr);
					setState(185);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(186);
					((Equality_exprContext)_localctx).op = _input.LT(1);
					_la = _input.LA(1);
					if ( !(_la==T__9 || _la==T__10) ) {
						((Equality_exprContext)_localctx).op = (Token)_errHandler.recoverInline(this);
					} else {
						consume();
					}
					setState(187);
					equality_expr(3);
					}
					} 
				}
				setState(192);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,12,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Relational_exprContext extends ParserRuleContext {
		public Token op;
		public Shift_exprContext shift_expr() {
			return getRuleContext(Shift_exprContext.class,0);
		}
		public List<Relational_exprContext> relational_expr() {
			return getRuleContexts(Relational_exprContext.class);
		}
		public Relational_exprContext relational_expr(int i) {
			return getRuleContext(Relational_exprContext.class,i);
		}
		public Relational_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_relational_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterRelational_expr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitRelational_expr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitRelational_expr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Relational_exprContext relational_expr() throws RecognitionException {
		return relational_expr(0);
	}

	private Relational_exprContext relational_expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Relational_exprContext _localctx = new Relational_exprContext(_ctx, _parentState);
		Relational_exprContext _prevctx = _localctx;
		int _startState = 20;
		enterRecursionRule(_localctx, 20, RULE_relational_expr, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(194);
			shift_expr(0);
			}
			_ctx.stop = _input.LT(-1);
			setState(201);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,13,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new Relational_exprContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_relational_expr);
					setState(196);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(197);
					((Relational_exprContext)_localctx).op = _input.LT(1);
					_la = _input.LA(1);
					if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__11) | (1L << T__12) | (1L << T__13) | (1L << T__14))) != 0)) ) {
						((Relational_exprContext)_localctx).op = (Token)_errHandler.recoverInline(this);
					} else {
						consume();
					}
					setState(198);
					relational_expr(3);
					}
					} 
				}
				setState(203);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,13,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Shift_exprContext extends ParserRuleContext {
		public Token op;
		public Additive_exprContext additive_expr() {
			return getRuleContext(Additive_exprContext.class,0);
		}
		public List<Shift_exprContext> shift_expr() {
			return getRuleContexts(Shift_exprContext.class);
		}
		public Shift_exprContext shift_expr(int i) {
			return getRuleContext(Shift_exprContext.class,i);
		}
		public Shift_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_shift_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterShift_expr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitShift_expr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitShift_expr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Shift_exprContext shift_expr() throws RecognitionException {
		return shift_expr(0);
	}

	private Shift_exprContext shift_expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Shift_exprContext _localctx = new Shift_exprContext(_ctx, _parentState);
		Shift_exprContext _prevctx = _localctx;
		int _startState = 22;
		enterRecursionRule(_localctx, 22, RULE_shift_expr, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(205);
			additive_expr(0);
			}
			_ctx.stop = _input.LT(-1);
			setState(212);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,14,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new Shift_exprContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_shift_expr);
					setState(207);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(208);
					((Shift_exprContext)_localctx).op = _input.LT(1);
					_la = _input.LA(1);
					if ( !(_la==T__15 || _la==T__16) ) {
						((Shift_exprContext)_localctx).op = (Token)_errHandler.recoverInline(this);
					} else {
						consume();
					}
					setState(209);
					shift_expr(3);
					}
					} 
				}
				setState(214);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,14,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Additive_exprContext extends ParserRuleContext {
		public Token op;
		public Multiplication_exprContext multiplication_expr() {
			return getRuleContext(Multiplication_exprContext.class,0);
		}
		public List<Additive_exprContext> additive_expr() {
			return getRuleContexts(Additive_exprContext.class);
		}
		public Additive_exprContext additive_expr(int i) {
			return getRuleContext(Additive_exprContext.class,i);
		}
		public Additive_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_additive_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterAdditive_expr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitAdditive_expr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitAdditive_expr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Additive_exprContext additive_expr() throws RecognitionException {
		return additive_expr(0);
	}

	private Additive_exprContext additive_expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Additive_exprContext _localctx = new Additive_exprContext(_ctx, _parentState);
		Additive_exprContext _prevctx = _localctx;
		int _startState = 24;
		enterRecursionRule(_localctx, 24, RULE_additive_expr, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(216);
			multiplication_expr(0);
			}
			_ctx.stop = _input.LT(-1);
			setState(223);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,15,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new Additive_exprContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_additive_expr);
					setState(218);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(219);
					((Additive_exprContext)_localctx).op = _input.LT(1);
					_la = _input.LA(1);
					if ( !(_la==T__17 || _la==T__18) ) {
						((Additive_exprContext)_localctx).op = (Token)_errHandler.recoverInline(this);
					} else {
						consume();
					}
					setState(220);
					additive_expr(3);
					}
					} 
				}
				setState(225);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,15,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Multiplication_exprContext extends ParserRuleContext {
		public Token op;
		public Creation_exprContext creation_expr() {
			return getRuleContext(Creation_exprContext.class,0);
		}
		public List<Multiplication_exprContext> multiplication_expr() {
			return getRuleContexts(Multiplication_exprContext.class);
		}
		public Multiplication_exprContext multiplication_expr(int i) {
			return getRuleContext(Multiplication_exprContext.class,i);
		}
		public Multiplication_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_multiplication_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterMultiplication_expr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitMultiplication_expr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitMultiplication_expr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Multiplication_exprContext multiplication_expr() throws RecognitionException {
		return multiplication_expr(0);
	}

	private Multiplication_exprContext multiplication_expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Multiplication_exprContext _localctx = new Multiplication_exprContext(_ctx, _parentState);
		Multiplication_exprContext _prevctx = _localctx;
		int _startState = 26;
		enterRecursionRule(_localctx, 26, RULE_multiplication_expr, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(227);
			creation_expr();
			}
			_ctx.stop = _input.LT(-1);
			setState(234);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,16,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new Multiplication_exprContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_multiplication_expr);
					setState(229);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(230);
					((Multiplication_exprContext)_localctx).op = _input.LT(1);
					_la = _input.LA(1);
					if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__19) | (1L << T__20) | (1L << T__21))) != 0)) ) {
						((Multiplication_exprContext)_localctx).op = (Token)_errHandler.recoverInline(this);
					} else {
						consume();
					}
					setState(231);
					multiplication_expr(3);
					}
					} 
				}
				setState(236);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,16,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Creation_exprContext extends ParserRuleContext {
		public Creation_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_creation_expr; }
	 
		public Creation_exprContext() { }
		public void copyFrom(Creation_exprContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class NewContext extends Creation_exprContext {
		public TerminalNode NEW() { return getToken(zzzParser.NEW, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public Dim_exprContext dim_expr() {
			return getRuleContext(Dim_exprContext.class,0);
		}
		public NewContext(Creation_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterNew(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitNew(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitNew(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class Unary_expresionContext extends Creation_exprContext {
		public Unary_exprContext unary_expr() {
			return getRuleContext(Unary_exprContext.class,0);
		}
		public Unary_expresionContext(Creation_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterUnary_expresion(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitUnary_expresion(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitUnary_expresion(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Creation_exprContext creation_expr() throws RecognitionException {
		Creation_exprContext _localctx = new Creation_exprContext(_ctx, getState());
		enterRule(_localctx, 28, RULE_creation_expr);
		try {
			setState(243);
			switch (_input.LA(1)) {
			case NEW:
				_localctx = new NewContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(237);
				match(NEW);
				setState(238);
				type(0);
				setState(240);
				switch ( getInterpreter().adaptivePredict(_input,17,_ctx) ) {
				case 1:
					{
					setState(239);
					dim_expr(0);
					}
					break;
				}
				}
				break;
			case T__0:
			case T__17:
			case T__18:
			case T__24:
			case T__25:
			case T__26:
			case T__27:
			case NULL:
			case BoolLiteral:
			case IntLiteral:
			case StringLiteral:
			case ID:
				_localctx = new Unary_expresionContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(242);
				unary_expr();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Dim_exprContext extends ParserRuleContext {
		public Dim_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_dim_expr; }
	 
		public Dim_exprContext() { }
		public void copyFrom(Dim_exprContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class OnedimContext extends Dim_exprContext {
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public OnedimContext(Dim_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterOnedim(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitOnedim(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitOnedim(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class MultidimContext extends Dim_exprContext {
		public Dim_exprContext dim_expr() {
			return getRuleContext(Dim_exprContext.class,0);
		}
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public MultidimContext(Dim_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterMultidim(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitMultidim(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitMultidim(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Dim_exprContext dim_expr() throws RecognitionException {
		return dim_expr(0);
	}

	private Dim_exprContext dim_expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Dim_exprContext _localctx = new Dim_exprContext(_ctx, _parentState);
		Dim_exprContext _prevctx = _localctx;
		int _startState = 30;
		enterRecursionRule(_localctx, 30, RULE_dim_expr, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			_localctx = new OnedimContext(_localctx);
			_ctx = _localctx;
			_prevctx = _localctx;

			setState(246);
			match(T__22);
			setState(248);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__17) | (1L << T__18) | (1L << T__24) | (1L << T__25) | (1L << T__26) | (1L << T__27) | (1L << NEW) | (1L << NULL) | (1L << BoolLiteral) | (1L << IntLiteral) | (1L << StringLiteral) | (1L << ID))) != 0)) {
				{
				setState(247);
				expr();
				}
			}

			setState(250);
			match(T__23);
			}
			_ctx.stop = _input.LT(-1);
			setState(260);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,21,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new MultidimContext(new Dim_exprContext(_parentctx, _parentState));
					pushNewRecursionContext(_localctx, _startState, RULE_dim_expr);
					setState(252);
					if (!(precpred(_ctx, 1))) throw new FailedPredicateException(this, "precpred(_ctx, 1)");
					setState(253);
					match(T__22);
					setState(255);
					_la = _input.LA(1);
					if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__17) | (1L << T__18) | (1L << T__24) | (1L << T__25) | (1L << T__26) | (1L << T__27) | (1L << NEW) | (1L << NULL) | (1L << BoolLiteral) | (1L << IntLiteral) | (1L << StringLiteral) | (1L << ID))) != 0)) {
						{
						setState(254);
						expr();
						}
					}

					setState(257);
					match(T__23);
					}
					} 
				}
				setState(262);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,21,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Unary_exprContext extends ParserRuleContext {
		public Unary_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_unary_expr; }
	 
		public Unary_exprContext() { }
		public void copyFrom(Unary_exprContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class Minus_minusexprContext extends Unary_exprContext {
		public Unary_exprContext unary_expr() {
			return getRuleContext(Unary_exprContext.class,0);
		}
		public Minus_minusexprContext(Unary_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterMinus_minusexpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitMinus_minusexpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitMinus_minusexpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class PostfixexprContext extends Unary_exprContext {
		public Postfix_exprContext postfix_expr() {
			return getRuleContext(Postfix_exprContext.class,0);
		}
		public PostfixexprContext(Unary_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterPostfixexpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitPostfixexpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitPostfixexpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class OperatorexprContext extends Unary_exprContext {
		public Token op;
		public Unary_exprContext unary_expr() {
			return getRuleContext(Unary_exprContext.class,0);
		}
		public OperatorexprContext(Unary_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterOperatorexpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitOperatorexpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitOperatorexpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class Add_addexprContext extends Unary_exprContext {
		public Unary_exprContext unary_expr() {
			return getRuleContext(Unary_exprContext.class,0);
		}
		public Add_addexprContext(Unary_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterAdd_addexpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitAdd_addexpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitAdd_addexpr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Unary_exprContext unary_expr() throws RecognitionException {
		Unary_exprContext _localctx = new Unary_exprContext(_ctx, getState());
		enterRule(_localctx, 32, RULE_unary_expr);
		int _la;
		try {
			setState(270);
			switch (_input.LA(1)) {
			case T__0:
			case NULL:
			case BoolLiteral:
			case IntLiteral:
			case StringLiteral:
			case ID:
				_localctx = new PostfixexprContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(263);
				postfix_expr(0);
				}
				break;
			case T__24:
				_localctx = new Add_addexprContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(264);
				match(T__24);
				setState(265);
				unary_expr();
				}
				break;
			case T__25:
				_localctx = new Minus_minusexprContext(_localctx);
				enterOuterAlt(_localctx, 3);
				{
				setState(266);
				match(T__25);
				setState(267);
				unary_expr();
				}
				break;
			case T__17:
			case T__18:
			case T__26:
			case T__27:
				_localctx = new OperatorexprContext(_localctx);
				enterOuterAlt(_localctx, 4);
				{
				setState(268);
				((OperatorexprContext)_localctx).op = _input.LT(1);
				_la = _input.LA(1);
				if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__17) | (1L << T__18) | (1L << T__26) | (1L << T__27))) != 0)) ) {
					((OperatorexprContext)_localctx).op = (Token)_errHandler.recoverInline(this);
				} else {
					consume();
				}
				setState(269);
				unary_expr();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Postfix_exprContext extends ParserRuleContext {
		public Postfix_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_postfix_expr; }
	 
		public Postfix_exprContext() { }
		public void copyFrom(Postfix_exprContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class NextContext extends Postfix_exprContext {
		public Pre_exprContext pre_expr() {
			return getRuleContext(Pre_exprContext.class,0);
		}
		public NextContext(Postfix_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterNext(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitNext(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitNext(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class Call_mem_funcContext extends Postfix_exprContext {
		public Postfix_exprContext postfix_expr() {
			return getRuleContext(Postfix_exprContext.class,0);
		}
		public TerminalNode ID() { return getToken(zzzParser.ID, 0); }
		public Param_listContext param_list() {
			return getRuleContext(Param_listContext.class,0);
		}
		public Call_mem_funcContext(Postfix_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterCall_mem_func(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitCall_mem_func(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitCall_mem_func(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class Postfix_call_memContext extends Postfix_exprContext {
		public Postfix_exprContext postfix_expr() {
			return getRuleContext(Postfix_exprContext.class,0);
		}
		public TerminalNode ID() { return getToken(zzzParser.ID, 0); }
		public Postfix_call_memContext(Postfix_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterPostfix_call_mem(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitPostfix_call_mem(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitPostfix_call_mem(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class Minus_minusContext extends Postfix_exprContext {
		public Postfix_exprContext postfix_expr() {
			return getRuleContext(Postfix_exprContext.class,0);
		}
		public Minus_minusContext(Postfix_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterMinus_minus(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitMinus_minus(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitMinus_minus(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class Add_addContext extends Postfix_exprContext {
		public Postfix_exprContext postfix_expr() {
			return getRuleContext(Postfix_exprContext.class,0);
		}
		public Add_addContext(Postfix_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterAdd_add(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitAdd_add(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitAdd_add(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class Postfix_call_funcContext extends Postfix_exprContext {
		public Postfix_exprContext postfix_expr() {
			return getRuleContext(Postfix_exprContext.class,0);
		}
		public Param_listContext param_list() {
			return getRuleContext(Param_listContext.class,0);
		}
		public Postfix_call_funcContext(Postfix_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterPostfix_call_func(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitPostfix_call_func(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitPostfix_call_func(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class Postfix_expContext extends Postfix_exprContext {
		public Postfix_exprContext postfix_expr() {
			return getRuleContext(Postfix_exprContext.class,0);
		}
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public Postfix_expContext(Postfix_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterPostfix_exp(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitPostfix_exp(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitPostfix_exp(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Postfix_exprContext postfix_expr() throws RecognitionException {
		return postfix_expr(0);
	}

	private Postfix_exprContext postfix_expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Postfix_exprContext _localctx = new Postfix_exprContext(_ctx, _parentState);
		Postfix_exprContext _prevctx = _localctx;
		int _startState = 34;
		enterRecursionRule(_localctx, 34, RULE_postfix_expr, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			_localctx = new NextContext(_localctx);
			_ctx = _localctx;
			_prevctx = _localctx;

			setState(273);
			pre_expr();
			}
			_ctx.stop = _input.LT(-1);
			setState(303);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,26,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(301);
					switch ( getInterpreter().adaptivePredict(_input,25,_ctx) ) {
					case 1:
						{
						_localctx = new Add_addContext(new Postfix_exprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_postfix_expr);
						setState(275);
						if (!(precpred(_ctx, 7))) throw new FailedPredicateException(this, "precpred(_ctx, 7)");
						setState(276);
						match(T__24);
						}
						break;
					case 2:
						{
						_localctx = new Minus_minusContext(new Postfix_exprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_postfix_expr);
						setState(277);
						if (!(precpred(_ctx, 6))) throw new FailedPredicateException(this, "precpred(_ctx, 6)");
						setState(278);
						match(T__25);
						}
						break;
					case 3:
						{
						_localctx = new Postfix_expContext(new Postfix_exprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_postfix_expr);
						setState(279);
						if (!(precpred(_ctx, 5))) throw new FailedPredicateException(this, "precpred(_ctx, 5)");
						setState(280);
						match(T__22);
						setState(281);
						expr();
						setState(282);
						match(T__23);
						}
						break;
					case 4:
						{
						_localctx = new Call_mem_funcContext(new Postfix_exprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_postfix_expr);
						setState(284);
						if (!(precpred(_ctx, 4))) throw new FailedPredicateException(this, "precpred(_ctx, 4)");
						setState(285);
						match(T__28);
						setState(286);
						match(ID);
						setState(287);
						match(T__0);
						setState(289);
						_la = _input.LA(1);
						if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__17) | (1L << T__18) | (1L << T__24) | (1L << T__25) | (1L << T__26) | (1L << T__27) | (1L << NEW) | (1L << NULL) | (1L << BoolLiteral) | (1L << IntLiteral) | (1L << StringLiteral) | (1L << ID))) != 0)) {
							{
							setState(288);
							param_list(0);
							}
						}

						setState(291);
						match(T__1);
						}
						break;
					case 5:
						{
						_localctx = new Postfix_call_memContext(new Postfix_exprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_postfix_expr);
						setState(292);
						if (!(precpred(_ctx, 3))) throw new FailedPredicateException(this, "precpred(_ctx, 3)");
						setState(293);
						match(T__28);
						setState(294);
						match(ID);
						}
						break;
					case 6:
						{
						_localctx = new Postfix_call_funcContext(new Postfix_exprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_postfix_expr);
						setState(295);
						if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
						setState(296);
						match(T__0);
						setState(298);
						_la = _input.LA(1);
						if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__17) | (1L << T__18) | (1L << T__24) | (1L << T__25) | (1L << T__26) | (1L << T__27) | (1L << NEW) | (1L << NULL) | (1L << BoolLiteral) | (1L << IntLiteral) | (1L << StringLiteral) | (1L << ID))) != 0)) {
							{
							setState(297);
							param_list(0);
							}
						}

						setState(300);
						match(T__1);
						}
						break;
					}
					} 
				}
				setState(305);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,26,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Param_listContext extends ParserRuleContext {
		public Param_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_param_list; }
	 
		public Param_listContext() { }
		public void copyFrom(Param_listContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class MultiexprContext extends Param_listContext {
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public MultiexprContext(Param_listContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterMultiexpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitMultiexpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitMultiexpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class OneexprContext extends Param_listContext {
		public Param_listContext param_list() {
			return getRuleContext(Param_listContext.class,0);
		}
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public OneexprContext(Param_listContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterOneexpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitOneexpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitOneexpr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Param_listContext param_list() throws RecognitionException {
		return param_list(0);
	}

	private Param_listContext param_list(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Param_listContext _localctx = new Param_listContext(_ctx, _parentState);
		Param_listContext _prevctx = _localctx;
		int _startState = 36;
		enterRecursionRule(_localctx, 36, RULE_param_list, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			_localctx = new MultiexprContext(_localctx);
			_ctx = _localctx;
			_prevctx = _localctx;

			setState(307);
			expr();
			}
			_ctx.stop = _input.LT(-1);
			setState(314);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,27,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new OneexprContext(new Param_listContext(_parentctx, _parentState));
					pushNewRecursionContext(_localctx, _startState, RULE_param_list);
					setState(309);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(310);
					match(T__29);
					setState(311);
					expr();
					}
					} 
				}
				setState(316);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,27,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Pre_exprContext extends ParserRuleContext {
		public Pre_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pre_expr; }
	 
		public Pre_exprContext() { }
		public void copyFrom(Pre_exprContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class Pre_expr_exprContext extends Pre_exprContext {
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public Pre_expr_exprContext(Pre_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterPre_expr_expr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitPre_expr_expr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitPre_expr_expr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class Pre_expr_intContext extends Pre_exprContext {
		public TerminalNode IntLiteral() { return getToken(zzzParser.IntLiteral, 0); }
		public Pre_expr_intContext(Pre_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterPre_expr_int(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitPre_expr_int(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitPre_expr_int(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class Pre_expr_nullContext extends Pre_exprContext {
		public TerminalNode NULL() { return getToken(zzzParser.NULL, 0); }
		public Pre_expr_nullContext(Pre_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterPre_expr_null(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitPre_expr_null(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitPre_expr_null(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class Pre_expr_idContext extends Pre_exprContext {
		public TerminalNode ID() { return getToken(zzzParser.ID, 0); }
		public Pre_expr_idContext(Pre_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterPre_expr_id(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitPre_expr_id(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitPre_expr_id(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class Pre_expr_boolContext extends Pre_exprContext {
		public TerminalNode BoolLiteral() { return getToken(zzzParser.BoolLiteral, 0); }
		public Pre_expr_boolContext(Pre_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterPre_expr_bool(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitPre_expr_bool(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitPre_expr_bool(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class Pre_expr_stringContext extends Pre_exprContext {
		public TerminalNode StringLiteral() { return getToken(zzzParser.StringLiteral, 0); }
		public Pre_expr_stringContext(Pre_exprContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterPre_expr_string(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitPre_expr_string(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitPre_expr_string(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Pre_exprContext pre_expr() throws RecognitionException {
		Pre_exprContext _localctx = new Pre_exprContext(_ctx, getState());
		enterRule(_localctx, 38, RULE_pre_expr);
		try {
			setState(326);
			switch (_input.LA(1)) {
			case BoolLiteral:
				_localctx = new Pre_expr_boolContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(317);
				match(BoolLiteral);
				}
				break;
			case ID:
				_localctx = new Pre_expr_idContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(318);
				match(ID);
				}
				break;
			case IntLiteral:
				_localctx = new Pre_expr_intContext(_localctx);
				enterOuterAlt(_localctx, 3);
				{
				setState(319);
				match(IntLiteral);
				}
				break;
			case StringLiteral:
				_localctx = new Pre_expr_stringContext(_localctx);
				enterOuterAlt(_localctx, 4);
				{
				setState(320);
				match(StringLiteral);
				}
				break;
			case T__0:
				_localctx = new Pre_expr_exprContext(_localctx);
				enterOuterAlt(_localctx, 5);
				{
				setState(321);
				match(T__0);
				setState(322);
				expr();
				setState(323);
				match(T__1);
				}
				break;
			case NULL:
				_localctx = new Pre_expr_nullContext(_localctx);
				enterOuterAlt(_localctx, 6);
				{
				setState(325);
				match(NULL);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Class_declContext extends ParserRuleContext {
		public TerminalNode CLASS() { return getToken(zzzParser.CLASS, 0); }
		public TerminalNode ID() { return getToken(zzzParser.ID, 0); }
		public Member_decl_listContext member_decl_list() {
			return getRuleContext(Member_decl_listContext.class,0);
		}
		public Class_declContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_class_decl; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterClass_decl(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitClass_decl(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitClass_decl(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Class_declContext class_decl() throws RecognitionException {
		Class_declContext _localctx = new Class_declContext(_ctx, getState());
		enterRule(_localctx, 40, RULE_class_decl);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(328);
			match(CLASS);
			setState(329);
			match(ID);
			setState(330);
			match(T__30);
			setState(332);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << INT) | (1L << STRING) | (1L << BOOL) | (1L << ID))) != 0)) {
				{
				setState(331);
				member_decl_list(0);
				}
			}

			setState(334);
			match(T__31);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Member_decl_listContext extends ParserRuleContext {
		public Member_decl_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_member_decl_list; }
	 
		public Member_decl_listContext() { }
		public void copyFrom(Member_decl_listContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class OnetypeidContext extends Member_decl_listContext {
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode ID() { return getToken(zzzParser.ID, 0); }
		public OnetypeidContext(Member_decl_listContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterOnetypeid(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitOnetypeid(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitOnetypeid(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class MultitypeidContext extends Member_decl_listContext {
		public Member_decl_listContext member_decl_list() {
			return getRuleContext(Member_decl_listContext.class,0);
		}
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode ID() { return getToken(zzzParser.ID, 0); }
		public MultitypeidContext(Member_decl_listContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterMultitypeid(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitMultitypeid(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitMultitypeid(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Member_decl_listContext member_decl_list() throws RecognitionException {
		return member_decl_list(0);
	}

	private Member_decl_listContext member_decl_list(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Member_decl_listContext _localctx = new Member_decl_listContext(_ctx, _parentState);
		Member_decl_listContext _prevctx = _localctx;
		int _startState = 42;
		enterRecursionRule(_localctx, 42, RULE_member_decl_list, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			_localctx = new OnetypeidContext(_localctx);
			_ctx = _localctx;
			_prevctx = _localctx;

			setState(337);
			type(0);
			setState(338);
			match(ID);
			setState(339);
			match(T__2);
			}
			_ctx.stop = _input.LT(-1);
			setState(348);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,30,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new MultitypeidContext(new Member_decl_listContext(_parentctx, _parentState));
					pushNewRecursionContext(_localctx, _startState, RULE_member_decl_list);
					setState(341);
					if (!(precpred(_ctx, 1))) throw new FailedPredicateException(this, "precpred(_ctx, 1)");
					setState(342);
					type(0);
					setState(343);
					match(ID);
					setState(344);
					match(T__2);
					}
					} 
				}
				setState(350);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,30,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Var_decl_stmtContext extends ParserRuleContext {
		public Var_decl_stmtContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_var_decl_stmt; }
	 
		public Var_decl_stmtContext() { }
		public void copyFrom(Var_decl_stmtContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class TypeidContext extends Var_decl_stmtContext {
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode ID() { return getToken(zzzParser.ID, 0); }
		public TypeidContext(Var_decl_stmtContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterTypeid(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitTypeid(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitTypeid(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class TypeidequalityContext extends Var_decl_stmtContext {
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode ID() { return getToken(zzzParser.ID, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public TypeidequalityContext(Var_decl_stmtContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterTypeidequality(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitTypeidequality(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitTypeidequality(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Var_decl_stmtContext var_decl_stmt() throws RecognitionException {
		Var_decl_stmtContext _localctx = new Var_decl_stmtContext(_ctx, getState());
		enterRule(_localctx, 44, RULE_var_decl_stmt);
		try {
			setState(361);
			switch ( getInterpreter().adaptivePredict(_input,31,_ctx) ) {
			case 1:
				_localctx = new TypeidContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(351);
				type(0);
				setState(352);
				match(ID);
				setState(353);
				match(T__2);
				}
				break;
			case 2:
				_localctx = new TypeidequalityContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(355);
				type(0);
				setState(356);
				match(ID);
				setState(357);
				match(T__3);
				setState(358);
				expr();
				setState(359);
				match(T__2);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Func_declContext extends ParserRuleContext {
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode ID() { return getToken(zzzParser.ID, 0); }
		public Block_stmtContext block_stmt() {
			return getRuleContext(Block_stmtContext.class,0);
		}
		public Param_decl_listContext param_decl_list() {
			return getRuleContext(Param_decl_listContext.class,0);
		}
		public Func_declContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_func_decl; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterFunc_decl(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitFunc_decl(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitFunc_decl(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Func_declContext func_decl() throws RecognitionException {
		Func_declContext _localctx = new Func_declContext(_ctx, getState());
		enterRule(_localctx, 46, RULE_func_decl);
		int _la;
		try {
			setState(380);
			switch (_input.LA(1)) {
			case INT:
			case STRING:
			case BOOL:
			case ID:
				enterOuterAlt(_localctx, 1);
				{
				setState(363);
				type(0);
				setState(364);
				match(ID);
				setState(365);
				match(T__0);
				setState(367);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << INT) | (1L << STRING) | (1L << BOOL) | (1L << ID))) != 0)) {
					{
					setState(366);
					param_decl_list(0);
					}
				}

				setState(369);
				match(T__1);
				setState(370);
				block_stmt();
				}
				break;
			case VIOD:
				enterOuterAlt(_localctx, 2);
				{
				setState(372);
				match(VIOD);
				setState(373);
				match(ID);
				setState(374);
				match(T__0);
				setState(376);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << INT) | (1L << STRING) | (1L << BOOL) | (1L << ID))) != 0)) {
					{
					setState(375);
					param_decl_list(0);
					}
				}

				setState(378);
				match(T__1);
				setState(379);
				block_stmt();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Param_decl_listContext extends ParserRuleContext {
		public Param_decl_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_param_decl_list; }
	 
		public Param_decl_listContext() { }
		public void copyFrom(Param_decl_listContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class MultitypeContext extends Param_decl_listContext {
		public Param_decl_listContext param_decl_list() {
			return getRuleContext(Param_decl_listContext.class,0);
		}
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode ID() { return getToken(zzzParser.ID, 0); }
		public MultitypeContext(Param_decl_listContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterMultitype(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitMultitype(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitMultitype(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class OnetypeContext extends Param_decl_listContext {
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode ID() { return getToken(zzzParser.ID, 0); }
		public OnetypeContext(Param_decl_listContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterOnetype(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitOnetype(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitOnetype(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Param_decl_listContext param_decl_list() throws RecognitionException {
		return param_decl_list(0);
	}

	private Param_decl_listContext param_decl_list(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Param_decl_listContext _localctx = new Param_decl_listContext(_ctx, _parentState);
		Param_decl_listContext _prevctx = _localctx;
		int _startState = 48;
		enterRecursionRule(_localctx, 48, RULE_param_decl_list, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			_localctx = new OnetypeContext(_localctx);
			_ctx = _localctx;
			_prevctx = _localctx;

			setState(383);
			type(0);
			setState(384);
			match(ID);
			}
			_ctx.stop = _input.LT(-1);
			setState(393);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,35,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new MultitypeContext(new Param_decl_listContext(_parentctx, _parentState));
					pushNewRecursionContext(_localctx, _startState, RULE_param_decl_list);
					setState(386);
					if (!(precpred(_ctx, 1))) throw new FailedPredicateException(this, "precpred(_ctx, 1)");
					setState(387);
					match(T__29);
					setState(388);
					type(0);
					setState(389);
					match(ID);
					}
					} 
				}
				setState(395);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,35,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Block_stmtContext extends ParserRuleContext {
		public Stmt_listContext stmt_list() {
			return getRuleContext(Stmt_listContext.class,0);
		}
		public Block_stmtContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_block_stmt; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterBlock_stmt(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitBlock_stmt(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitBlock_stmt(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Block_stmtContext block_stmt() throws RecognitionException {
		Block_stmtContext _localctx = new Block_stmtContext(_ctx, getState());
		enterRule(_localctx, 50, RULE_block_stmt);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(396);
			match(T__30);
			setState(398);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__2) | (1L << T__17) | (1L << T__18) | (1L << T__24) | (1L << T__25) | (1L << T__26) | (1L << T__27) | (1L << T__30) | (1L << IF) | (1L << RETURN) | (1L << BREAK) | (1L << CONTINUE) | (1L << WHILE) | (1L << FOR) | (1L << NEW) | (1L << INT) | (1L << STRING) | (1L << BOOL) | (1L << NULL) | (1L << BoolLiteral) | (1L << IntLiteral) | (1L << StringLiteral) | (1L << ID))) != 0)) {
				{
				setState(397);
				stmt_list(0);
				}
			}

			setState(400);
			match(T__31);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Stmt_listContext extends ParserRuleContext {
		public Stmt_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_stmt_list; }
	 
		public Stmt_listContext() { }
		public void copyFrom(Stmt_listContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class OnestmtContext extends Stmt_listContext {
		public StmtContext stmt() {
			return getRuleContext(StmtContext.class,0);
		}
		public OnestmtContext(Stmt_listContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterOnestmt(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitOnestmt(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitOnestmt(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class MultiplystmtContext extends Stmt_listContext {
		public Stmt_listContext stmt_list() {
			return getRuleContext(Stmt_listContext.class,0);
		}
		public StmtContext stmt() {
			return getRuleContext(StmtContext.class,0);
		}
		public MultiplystmtContext(Stmt_listContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterMultiplystmt(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitMultiplystmt(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitMultiplystmt(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Stmt_listContext stmt_list() throws RecognitionException {
		return stmt_list(0);
	}

	private Stmt_listContext stmt_list(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Stmt_listContext _localctx = new Stmt_listContext(_ctx, _parentState);
		Stmt_listContext _prevctx = _localctx;
		int _startState = 52;
		enterRecursionRule(_localctx, 52, RULE_stmt_list, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			_localctx = new OnestmtContext(_localctx);
			_ctx = _localctx;
			_prevctx = _localctx;

			setState(403);
			stmt();
			}
			_ctx.stop = _input.LT(-1);
			setState(409);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,37,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new MultiplystmtContext(new Stmt_listContext(_parentctx, _parentState));
					pushNewRecursionContext(_localctx, _startState, RULE_stmt_list);
					setState(405);
					if (!(precpred(_ctx, 1))) throw new FailedPredicateException(this, "precpred(_ctx, 1)");
					setState(406);
					stmt();
					}
					} 
				}
				setState(411);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,37,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class ProgramContext extends ParserRuleContext {
		public List<Class_declContext> class_decl() {
			return getRuleContexts(Class_declContext.class);
		}
		public Class_declContext class_decl(int i) {
			return getRuleContext(Class_declContext.class,i);
		}
		public List<Func_declContext> func_decl() {
			return getRuleContexts(Func_declContext.class);
		}
		public Func_declContext func_decl(int i) {
			return getRuleContext(Func_declContext.class,i);
		}
		public List<Var_decl_stmtContext> var_decl_stmt() {
			return getRuleContexts(Var_decl_stmtContext.class);
		}
		public Var_decl_stmtContext var_decl_stmt(int i) {
			return getRuleContext(Var_decl_stmtContext.class,i);
		}
		public ProgramContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_program; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterProgram(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitProgram(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitProgram(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ProgramContext program() throws RecognitionException {
		ProgramContext _localctx = new ProgramContext(_ctx, getState());
		enterRule(_localctx, 54, RULE_program);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(417);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << VIOD) | (1L << CLASS) | (1L << INT) | (1L << STRING) | (1L << BOOL) | (1L << ID))) != 0)) {
				{
				setState(415);
				switch ( getInterpreter().adaptivePredict(_input,38,_ctx) ) {
				case 1:
					{
					setState(412);
					class_decl();
					}
					break;
				case 2:
					{
					setState(413);
					func_decl();
					}
					break;
				case 3:
					{
					setState(414);
					var_decl_stmt();
					}
					break;
				}
				}
				setState(419);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TypeContext extends ParserRuleContext {
		public TypeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type; }
	 
		public TypeContext() { }
		public void copyFrom(TypeContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class ArraytypeContext extends TypeContext {
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public ArraytypeContext(TypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterArraytype(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitArraytype(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitArraytype(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class OnlyonetypeContext extends TypeContext {
		public BasictypeContext basictype() {
			return getRuleContext(BasictypeContext.class,0);
		}
		public OnlyonetypeContext(TypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterOnlyonetype(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitOnlyonetype(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitOnlyonetype(this);
			else return visitor.visitChildren(this);
		}
	}

	public final TypeContext type() throws RecognitionException {
		return type(0);
	}

	private TypeContext type(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		TypeContext _localctx = new TypeContext(_ctx, _parentState);
		TypeContext _prevctx = _localctx;
		int _startState = 56;
		enterRecursionRule(_localctx, 56, RULE_type, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			_localctx = new OnlyonetypeContext(_localctx);
			_ctx = _localctx;
			_prevctx = _localctx;

			setState(421);
			basictype();
			}
			_ctx.stop = _input.LT(-1);
			setState(428);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,40,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new ArraytypeContext(new TypeContext(_parentctx, _parentState));
					pushNewRecursionContext(_localctx, _startState, RULE_type);
					setState(423);
					if (!(precpred(_ctx, 1))) throw new FailedPredicateException(this, "precpred(_ctx, 1)");
					setState(424);
					match(T__22);
					setState(425);
					match(T__23);
					}
					} 
				}
				setState(430);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,40,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class BasictypeContext extends ParserRuleContext {
		public BasictypeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_basictype; }
	 
		public BasictypeContext() { }
		public void copyFrom(BasictypeContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class StringContext extends BasictypeContext {
		public TerminalNode STRING() { return getToken(zzzParser.STRING, 0); }
		public StringContext(BasictypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterString(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitString(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitString(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class BoolContext extends BasictypeContext {
		public TerminalNode BOOL() { return getToken(zzzParser.BOOL, 0); }
		public BoolContext(BasictypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterBool(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitBool(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitBool(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class IdContext extends BasictypeContext {
		public TerminalNode ID() { return getToken(zzzParser.ID, 0); }
		public IdContext(BasictypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterId(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitId(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitId(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class IntContext extends BasictypeContext {
		public TerminalNode INT() { return getToken(zzzParser.INT, 0); }
		public IntContext(BasictypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).enterInt(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof zzzListener ) ((zzzListener)listener).exitInt(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof zzzVisitor ) return ((zzzVisitor<? extends T>)visitor).visitInt(this);
			else return visitor.visitChildren(this);
		}
	}

	public final BasictypeContext basictype() throws RecognitionException {
		BasictypeContext _localctx = new BasictypeContext(_ctx, getState());
		enterRule(_localctx, 58, RULE_basictype);
		try {
			setState(435);
			switch (_input.LA(1)) {
			case INT:
				_localctx = new IntContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(431);
				match(INT);
				}
				break;
			case STRING:
				_localctx = new StringContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(432);
				match(STRING);
				}
				break;
			case BOOL:
				_localctx = new BoolContext(_localctx);
				enterOuterAlt(_localctx, 3);
				{
				setState(433);
				match(BOOL);
				}
				break;
			case ID:
				_localctx = new IdContext(_localctx);
				enterOuterAlt(_localctx, 4);
				{
				setState(434);
				match(ID);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 3:
			return assignment_expr_sempred((Assignment_exprContext)_localctx, predIndex);
		case 4:
			return logic_or_expr_sempred((Logic_or_exprContext)_localctx, predIndex);
		case 5:
			return logic_and_expr_sempred((Logic_and_exprContext)_localctx, predIndex);
		case 6:
			return inclusive_or_expr_sempred((Inclusive_or_exprContext)_localctx, predIndex);
		case 7:
			return exclusive_or_expr_sempred((Exclusive_or_exprContext)_localctx, predIndex);
		case 8:
			return and_expr_sempred((And_exprContext)_localctx, predIndex);
		case 9:
			return equality_expr_sempred((Equality_exprContext)_localctx, predIndex);
		case 10:
			return relational_expr_sempred((Relational_exprContext)_localctx, predIndex);
		case 11:
			return shift_expr_sempred((Shift_exprContext)_localctx, predIndex);
		case 12:
			return additive_expr_sempred((Additive_exprContext)_localctx, predIndex);
		case 13:
			return multiplication_expr_sempred((Multiplication_exprContext)_localctx, predIndex);
		case 15:
			return dim_expr_sempred((Dim_exprContext)_localctx, predIndex);
		case 17:
			return postfix_expr_sempred((Postfix_exprContext)_localctx, predIndex);
		case 18:
			return param_list_sempred((Param_listContext)_localctx, predIndex);
		case 21:
			return member_decl_list_sempred((Member_decl_listContext)_localctx, predIndex);
		case 24:
			return param_decl_list_sempred((Param_decl_listContext)_localctx, predIndex);
		case 26:
			return stmt_list_sempred((Stmt_listContext)_localctx, predIndex);
		case 28:
			return type_sempred((TypeContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean assignment_expr_sempred(Assignment_exprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 2);
		}
		return true;
	}
	private boolean logic_or_expr_sempred(Logic_or_exprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 1:
			return precpred(_ctx, 2);
		}
		return true;
	}
	private boolean logic_and_expr_sempred(Logic_and_exprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 2:
			return precpred(_ctx, 2);
		}
		return true;
	}
	private boolean inclusive_or_expr_sempred(Inclusive_or_exprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 3:
			return precpred(_ctx, 2);
		}
		return true;
	}
	private boolean exclusive_or_expr_sempred(Exclusive_or_exprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 4:
			return precpred(_ctx, 2);
		}
		return true;
	}
	private boolean and_expr_sempred(And_exprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 5:
			return precpred(_ctx, 2);
		}
		return true;
	}
	private boolean equality_expr_sempred(Equality_exprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 6:
			return precpred(_ctx, 2);
		}
		return true;
	}
	private boolean relational_expr_sempred(Relational_exprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 7:
			return precpred(_ctx, 2);
		}
		return true;
	}
	private boolean shift_expr_sempred(Shift_exprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 8:
			return precpred(_ctx, 2);
		}
		return true;
	}
	private boolean additive_expr_sempred(Additive_exprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 9:
			return precpred(_ctx, 2);
		}
		return true;
	}
	private boolean multiplication_expr_sempred(Multiplication_exprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 10:
			return precpred(_ctx, 2);
		}
		return true;
	}
	private boolean dim_expr_sempred(Dim_exprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 11:
			return precpred(_ctx, 1);
		}
		return true;
	}
	private boolean postfix_expr_sempred(Postfix_exprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 12:
			return precpred(_ctx, 7);
		case 13:
			return precpred(_ctx, 6);
		case 14:
			return precpred(_ctx, 5);
		case 15:
			return precpred(_ctx, 4);
		case 16:
			return precpred(_ctx, 3);
		case 17:
			return precpred(_ctx, 2);
		}
		return true;
	}
	private boolean param_list_sempred(Param_listContext _localctx, int predIndex) {
		switch (predIndex) {
		case 18:
			return precpred(_ctx, 2);
		}
		return true;
	}
	private boolean member_decl_list_sempred(Member_decl_listContext _localctx, int predIndex) {
		switch (predIndex) {
		case 19:
			return precpred(_ctx, 1);
		}
		return true;
	}
	private boolean param_decl_list_sempred(Param_decl_listContext _localctx, int predIndex) {
		switch (predIndex) {
		case 20:
			return precpred(_ctx, 1);
		}
		return true;
	}
	private boolean stmt_list_sempred(Stmt_listContext _localctx, int predIndex) {
		switch (predIndex) {
		case 21:
			return precpred(_ctx, 1);
		}
		return true;
	}
	private boolean type_sempred(TypeContext _localctx, int predIndex) {
		switch (predIndex) {
		case 22:
			return precpred(_ctx, 1);
		}
		return true;
	}

	public static final String _serializedATN =
		"\3\u0430\ud6d1\u8206\uad2d\u4417\uaef1\u8d80\uaadd\3\67\u01b8\4\2\t\2"+
		"\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13"+
		"\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31\t\31"+
		"\4\32\t\32\4\33\t\33\4\34\t\34\4\35\t\35\4\36\t\36\4\37\t\37\3\2\3\2\3"+
		"\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\5\2"+
		"R\n\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\5\2b\n\2"+
		"\3\2\3\2\5\2f\n\2\3\2\3\2\5\2j\n\2\3\2\3\2\5\2n\n\2\3\3\5\3q\n\3\3\3\3"+
		"\3\3\4\3\4\3\5\3\5\3\5\3\5\3\5\3\5\7\5}\n\5\f\5\16\5\u0080\13\5\3\6\3"+
		"\6\3\6\3\6\3\6\3\6\7\6\u0088\n\6\f\6\16\6\u008b\13\6\3\7\3\7\3\7\3\7\3"+
		"\7\3\7\7\7\u0093\n\7\f\7\16\7\u0096\13\7\3\b\3\b\3\b\3\b\3\b\3\b\7\b\u009e"+
		"\n\b\f\b\16\b\u00a1\13\b\3\t\3\t\3\t\3\t\3\t\3\t\7\t\u00a9\n\t\f\t\16"+
		"\t\u00ac\13\t\3\n\3\n\3\n\3\n\3\n\3\n\7\n\u00b4\n\n\f\n\16\n\u00b7\13"+
		"\n\3\13\3\13\3\13\3\13\3\13\3\13\7\13\u00bf\n\13\f\13\16\13\u00c2\13\13"+
		"\3\f\3\f\3\f\3\f\3\f\3\f\7\f\u00ca\n\f\f\f\16\f\u00cd\13\f\3\r\3\r\3\r"+
		"\3\r\3\r\3\r\7\r\u00d5\n\r\f\r\16\r\u00d8\13\r\3\16\3\16\3\16\3\16\3\16"+
		"\3\16\7\16\u00e0\n\16\f\16\16\16\u00e3\13\16\3\17\3\17\3\17\3\17\3\17"+
		"\3\17\7\17\u00eb\n\17\f\17\16\17\u00ee\13\17\3\20\3\20\3\20\5\20\u00f3"+
		"\n\20\3\20\5\20\u00f6\n\20\3\21\3\21\3\21\5\21\u00fb\n\21\3\21\3\21\3"+
		"\21\3\21\3\21\5\21\u0102\n\21\3\21\7\21\u0105\n\21\f\21\16\21\u0108\13"+
		"\21\3\22\3\22\3\22\3\22\3\22\3\22\3\22\5\22\u0111\n\22\3\23\3\23\3\23"+
		"\3\23\3\23\3\23\3\23\3\23\3\23\3\23\3\23\3\23\3\23\3\23\3\23\3\23\3\23"+
		"\5\23\u0124\n\23\3\23\3\23\3\23\3\23\3\23\3\23\3\23\5\23\u012d\n\23\3"+
		"\23\7\23\u0130\n\23\f\23\16\23\u0133\13\23\3\24\3\24\3\24\3\24\3\24\3"+
		"\24\7\24\u013b\n\24\f\24\16\24\u013e\13\24\3\25\3\25\3\25\3\25\3\25\3"+
		"\25\3\25\3\25\3\25\5\25\u0149\n\25\3\26\3\26\3\26\3\26\5\26\u014f\n\26"+
		"\3\26\3\26\3\27\3\27\3\27\3\27\3\27\3\27\3\27\3\27\3\27\3\27\7\27\u015d"+
		"\n\27\f\27\16\27\u0160\13\27\3\30\3\30\3\30\3\30\3\30\3\30\3\30\3\30\3"+
		"\30\3\30\5\30\u016c\n\30\3\31\3\31\3\31\3\31\5\31\u0172\n\31\3\31\3\31"+
		"\3\31\3\31\3\31\3\31\3\31\5\31\u017b\n\31\3\31\3\31\5\31\u017f\n\31\3"+
		"\32\3\32\3\32\3\32\3\32\3\32\3\32\3\32\3\32\7\32\u018a\n\32\f\32\16\32"+
		"\u018d\13\32\3\33\3\33\5\33\u0191\n\33\3\33\3\33\3\34\3\34\3\34\3\34\3"+
		"\34\7\34\u019a\n\34\f\34\16\34\u019d\13\34\3\35\3\35\3\35\7\35\u01a2\n"+
		"\35\f\35\16\35\u01a5\13\35\3\36\3\36\3\36\3\36\3\36\3\36\7\36\u01ad\n"+
		"\36\f\36\16\36\u01b0\13\36\3\37\3\37\3\37\3\37\5\37\u01b6\n\37\3\37\2"+
		"\24\b\n\f\16\20\22\24\26\30\32\34 $&,\62\66: \2\4\6\b\n\f\16\20\22\24"+
		"\26\30\32\34\36 \"$&(*,.\60\62\64\668:<\2\b\3\2\f\r\3\2\16\21\3\2\22\23"+
		"\3\2\24\25\3\2\26\30\4\2\24\25\35\36\u01d8\2m\3\2\2\2\4p\3\2\2\2\6t\3"+
		"\2\2\2\bv\3\2\2\2\n\u0081\3\2\2\2\f\u008c\3\2\2\2\16\u0097\3\2\2\2\20"+
		"\u00a2\3\2\2\2\22\u00ad\3\2\2\2\24\u00b8\3\2\2\2\26\u00c3\3\2\2\2\30\u00ce"+
		"\3\2\2\2\32\u00d9\3\2\2\2\34\u00e4\3\2\2\2\36\u00f5\3\2\2\2 \u00f7\3\2"+
		"\2\2\"\u0110\3\2\2\2$\u0112\3\2\2\2&\u0134\3\2\2\2(\u0148\3\2\2\2*\u014a"+
		"\3\2\2\2,\u0152\3\2\2\2.\u016b\3\2\2\2\60\u017e\3\2\2\2\62\u0180\3\2\2"+
		"\2\64\u018e\3\2\2\2\66\u0194\3\2\2\28\u01a3\3\2\2\2:\u01a6\3\2\2\2<\u01b5"+
		"\3\2\2\2>n\5\64\33\2?n\5.\30\2@n\5\4\3\2AB\7&\2\2BC\7\3\2\2CD\5\6\4\2"+
		"DE\7\4\2\2EF\5\2\2\2FG\7\'\2\2GH\5\2\2\2Hn\3\2\2\2IJ\7&\2\2JK\7\3\2\2"+
		"KL\5\6\4\2LM\7\4\2\2MN\5\2\2\2Nn\3\2\2\2OQ\7(\2\2PR\5\6\4\2QP\3\2\2\2"+
		"QR\3\2\2\2RS\3\2\2\2Sn\7\5\2\2TU\7)\2\2Un\7\5\2\2VW\7*\2\2Wn\7\5\2\2X"+
		"Y\7+\2\2YZ\7\3\2\2Z[\5\6\4\2[\\\7\4\2\2\\]\5\2\2\2]n\3\2\2\2^_\7,\2\2"+
		"_a\7\3\2\2`b\5\6\4\2a`\3\2\2\2ab\3\2\2\2bc\3\2\2\2ce\7\5\2\2df\5\6\4\2"+
		"ed\3\2\2\2ef\3\2\2\2fg\3\2\2\2gi\7\5\2\2hj\5\6\4\2ih\3\2\2\2ij\3\2\2\2"+
		"jk\3\2\2\2kl\7\4\2\2ln\5\2\2\2m>\3\2\2\2m?\3\2\2\2m@\3\2\2\2mA\3\2\2\2"+
		"mI\3\2\2\2mO\3\2\2\2mT\3\2\2\2mV\3\2\2\2mX\3\2\2\2m^\3\2\2\2n\3\3\2\2"+
		"\2oq\5\6\4\2po\3\2\2\2pq\3\2\2\2qr\3\2\2\2rs\7\5\2\2s\5\3\2\2\2tu\5\b"+
		"\5\2u\7\3\2\2\2vw\b\5\1\2wx\5\n\6\2x~\3\2\2\2yz\f\4\2\2z{\7\6\2\2{}\5"+
		"\b\5\4|y\3\2\2\2}\u0080\3\2\2\2~|\3\2\2\2~\177\3\2\2\2\177\t\3\2\2\2\u0080"+
		"~\3\2\2\2\u0081\u0082\b\6\1\2\u0082\u0083\5\f\7\2\u0083\u0089\3\2\2\2"+
		"\u0084\u0085\f\4\2\2\u0085\u0086\7\7\2\2\u0086\u0088\5\n\6\5\u0087\u0084"+
		"\3\2\2\2\u0088\u008b\3\2\2\2\u0089\u0087\3\2\2\2\u0089\u008a\3\2\2\2\u008a"+
		"\13\3\2\2\2\u008b\u0089\3\2\2\2\u008c\u008d\b\7\1\2\u008d\u008e\5\16\b"+
		"\2\u008e\u0094\3\2\2\2\u008f\u0090\f\4\2\2\u0090\u0091\7\b\2\2\u0091\u0093"+
		"\5\f\7\4\u0092\u008f\3\2\2\2\u0093\u0096\3\2\2\2\u0094\u0092\3\2\2\2\u0094"+
		"\u0095\3\2\2\2\u0095\r\3\2\2\2\u0096\u0094\3\2\2\2\u0097\u0098\b\b\1\2"+
		"\u0098\u0099\5\20\t\2\u0099\u009f\3\2\2\2\u009a\u009b\f\4\2\2\u009b\u009c"+
		"\7\t\2\2\u009c\u009e\5\16\b\5\u009d\u009a\3\2\2\2\u009e\u00a1\3\2\2\2"+
		"\u009f\u009d\3\2\2\2\u009f\u00a0\3\2\2\2\u00a0\17\3\2\2\2\u00a1\u009f"+
		"\3\2\2\2\u00a2\u00a3\b\t\1\2\u00a3\u00a4\5\22\n\2\u00a4\u00aa\3\2\2\2"+
		"\u00a5\u00a6\f\4\2\2\u00a6\u00a7\7\n\2\2\u00a7\u00a9\5\20\t\5\u00a8\u00a5"+
		"\3\2\2\2\u00a9\u00ac\3\2\2\2\u00aa\u00a8\3\2\2\2\u00aa\u00ab\3\2\2\2\u00ab"+
		"\21\3\2\2\2\u00ac\u00aa\3\2\2\2\u00ad\u00ae\b\n\1\2\u00ae\u00af\5\24\13"+
		"\2\u00af\u00b5\3\2\2\2\u00b0\u00b1\f\4\2\2\u00b1\u00b2\7\13\2\2\u00b2"+
		"\u00b4\5\22\n\5\u00b3\u00b0\3\2\2\2\u00b4\u00b7\3\2\2\2\u00b5\u00b3\3"+
		"\2\2\2\u00b5\u00b6\3\2\2\2\u00b6\23\3\2\2\2\u00b7\u00b5\3\2\2\2\u00b8"+
		"\u00b9\b\13\1\2\u00b9\u00ba\5\26\f\2\u00ba\u00c0\3\2\2\2\u00bb\u00bc\f"+
		"\4\2\2\u00bc\u00bd\t\2\2\2\u00bd\u00bf\5\24\13\5\u00be\u00bb\3\2\2\2\u00bf"+
		"\u00c2\3\2\2\2\u00c0\u00be\3\2\2\2\u00c0\u00c1\3\2\2\2\u00c1\25\3\2\2"+
		"\2\u00c2\u00c0\3\2\2\2\u00c3\u00c4\b\f\1\2\u00c4\u00c5\5\30\r\2\u00c5"+
		"\u00cb\3\2\2\2\u00c6\u00c7\f\4\2\2\u00c7\u00c8\t\3\2\2\u00c8\u00ca\5\26"+
		"\f\5\u00c9\u00c6\3\2\2\2\u00ca\u00cd\3\2\2\2\u00cb\u00c9\3\2\2\2\u00cb"+
		"\u00cc\3\2\2\2\u00cc\27\3\2\2\2\u00cd\u00cb\3\2\2\2\u00ce\u00cf\b\r\1"+
		"\2\u00cf\u00d0\5\32\16\2\u00d0\u00d6\3\2\2\2\u00d1\u00d2\f\4\2\2\u00d2"+
		"\u00d3\t\4\2\2\u00d3\u00d5\5\30\r\5\u00d4\u00d1\3\2\2\2\u00d5\u00d8\3"+
		"\2\2\2\u00d6\u00d4\3\2\2\2\u00d6\u00d7\3\2\2\2\u00d7\31\3\2\2\2\u00d8"+
		"\u00d6\3\2\2\2\u00d9\u00da\b\16\1\2\u00da\u00db\5\34\17\2\u00db\u00e1"+
		"\3\2\2\2\u00dc\u00dd\f\4\2\2\u00dd\u00de\t\5\2\2\u00de\u00e0\5\32\16\5"+
		"\u00df\u00dc\3\2\2\2\u00e0\u00e3\3\2\2\2\u00e1\u00df\3\2\2\2\u00e1\u00e2"+
		"\3\2\2\2\u00e2\33\3\2\2\2\u00e3\u00e1\3\2\2\2\u00e4\u00e5\b\17\1\2\u00e5"+
		"\u00e6\5\36\20\2\u00e6\u00ec\3\2\2\2\u00e7\u00e8\f\4\2\2\u00e8\u00e9\t"+
		"\6\2\2\u00e9\u00eb\5\34\17\5\u00ea\u00e7\3\2\2\2\u00eb\u00ee\3\2\2\2\u00ec"+
		"\u00ea\3\2\2\2\u00ec\u00ed\3\2\2\2\u00ed\35\3\2\2\2\u00ee\u00ec\3\2\2"+
		"\2\u00ef\u00f0\7/\2\2\u00f0\u00f2\5:\36\2\u00f1\u00f3\5 \21\2\u00f2\u00f1"+
		"\3\2\2\2\u00f2\u00f3\3\2\2\2\u00f3\u00f6\3\2\2\2\u00f4\u00f6\5\"\22\2"+
		"\u00f5\u00ef\3\2\2\2\u00f5\u00f4\3\2\2\2\u00f6\37\3\2\2\2\u00f7\u00f8"+
		"\b\21\1\2\u00f8\u00fa\7\31\2\2\u00f9\u00fb\5\6\4\2\u00fa\u00f9\3\2\2\2"+
		"\u00fa\u00fb\3\2\2\2\u00fb\u00fc\3\2\2\2\u00fc\u00fd\7\32\2\2\u00fd\u0106"+
		"\3\2\2\2\u00fe\u00ff\f\3\2\2\u00ff\u0101\7\31\2\2\u0100\u0102\5\6\4\2"+
		"\u0101\u0100\3\2\2\2\u0101\u0102\3\2\2\2\u0102\u0103\3\2\2\2\u0103\u0105"+
		"\7\32\2\2\u0104\u00fe\3\2\2\2\u0105\u0108\3\2\2\2\u0106\u0104\3\2\2\2"+
		"\u0106\u0107\3\2\2\2\u0107!\3\2\2\2\u0108\u0106\3\2\2\2\u0109\u0111\5"+
		"$\23\2\u010a\u010b\7\33\2\2\u010b\u0111\5\"\22\2\u010c\u010d\7\34\2\2"+
		"\u010d\u0111\5\"\22\2\u010e\u010f\t\7\2\2\u010f\u0111\5\"\22\2\u0110\u0109"+
		"\3\2\2\2\u0110\u010a\3\2\2\2\u0110\u010c\3\2\2\2\u0110\u010e\3\2\2\2\u0111"+
		"#\3\2\2\2\u0112\u0113\b\23\1\2\u0113\u0114\5(\25\2\u0114\u0131\3\2\2\2"+
		"\u0115\u0116\f\t\2\2\u0116\u0130\7\33\2\2\u0117\u0118\f\b\2\2\u0118\u0130"+
		"\7\34\2\2\u0119\u011a\f\7\2\2\u011a\u011b\7\31\2\2\u011b\u011c\5\6\4\2"+
		"\u011c\u011d\7\32\2\2\u011d\u0130\3\2\2\2\u011e\u011f\f\6\2\2\u011f\u0120"+
		"\7\37\2\2\u0120\u0121\7\67\2\2\u0121\u0123\7\3\2\2\u0122\u0124\5&\24\2"+
		"\u0123\u0122\3\2\2\2\u0123\u0124\3\2\2\2\u0124\u0125\3\2\2\2\u0125\u0130"+
		"\7\4\2\2\u0126\u0127\f\5\2\2\u0127\u0128\7\37\2\2\u0128\u0130\7\67\2\2"+
		"\u0129\u012a\f\4\2\2\u012a\u012c\7\3\2\2\u012b\u012d\5&\24\2\u012c\u012b"+
		"\3\2\2\2\u012c\u012d\3\2\2\2\u012d\u012e\3\2\2\2\u012e\u0130\7\4\2\2\u012f"+
		"\u0115\3\2\2\2\u012f\u0117\3\2\2\2\u012f\u0119\3\2\2\2\u012f\u011e\3\2"+
		"\2\2\u012f\u0126\3\2\2\2\u012f\u0129\3\2\2\2\u0130\u0133\3\2\2\2\u0131"+
		"\u012f\3\2\2\2\u0131\u0132\3\2\2\2\u0132%\3\2\2\2\u0133\u0131\3\2\2\2"+
		"\u0134\u0135\b\24\1\2\u0135\u0136\5\6\4\2\u0136\u013c\3\2\2\2\u0137\u0138"+
		"\f\4\2\2\u0138\u0139\7 \2\2\u0139\u013b\5\6\4\2\u013a\u0137\3\2\2\2\u013b"+
		"\u013e\3\2\2\2\u013c\u013a\3\2\2\2\u013c\u013d\3\2\2\2\u013d\'\3\2\2\2"+
		"\u013e\u013c\3\2\2\2\u013f\u0149\7\64\2\2\u0140\u0149\7\67\2\2\u0141\u0149"+
		"\7\65\2\2\u0142\u0149\7\66\2\2\u0143\u0144\7\3\2\2\u0144\u0145\5\6\4\2"+
		"\u0145\u0146\7\4\2\2\u0146\u0149\3\2\2\2\u0147\u0149\7\63\2\2\u0148\u013f"+
		"\3\2\2\2\u0148\u0140\3\2\2\2\u0148\u0141\3\2\2\2\u0148\u0142\3\2\2\2\u0148"+
		"\u0143\3\2\2\2\u0148\u0147\3\2\2\2\u0149)\3\2\2\2\u014a\u014b\7.\2\2\u014b"+
		"\u014c\7\67\2\2\u014c\u014e\7!\2\2\u014d\u014f\5,\27\2\u014e\u014d\3\2"+
		"\2\2\u014e\u014f\3\2\2\2\u014f\u0150\3\2\2\2\u0150\u0151\7\"\2\2\u0151"+
		"+\3\2\2\2\u0152\u0153\b\27\1\2\u0153\u0154\5:\36\2\u0154\u0155\7\67\2"+
		"\2\u0155\u0156\7\5\2\2\u0156\u015e\3\2\2\2\u0157\u0158\f\3\2\2\u0158\u0159"+
		"\5:\36\2\u0159\u015a\7\67\2\2\u015a\u015b\7\5\2\2\u015b\u015d\3\2\2\2"+
		"\u015c\u0157\3\2\2\2\u015d\u0160\3\2\2\2\u015e\u015c\3\2\2\2\u015e\u015f"+
		"\3\2\2\2\u015f-\3\2\2\2\u0160\u015e\3\2\2\2\u0161\u0162\5:\36\2\u0162"+
		"\u0163\7\67\2\2\u0163\u0164\7\5\2\2\u0164\u016c\3\2\2\2\u0165\u0166\5"+
		":\36\2\u0166\u0167\7\67\2\2\u0167\u0168\7\6\2\2\u0168\u0169\5\6\4\2\u0169"+
		"\u016a\7\5\2\2\u016a\u016c\3\2\2\2\u016b\u0161\3\2\2\2\u016b\u0165\3\2"+
		"\2\2\u016c/\3\2\2\2\u016d\u016e\5:\36\2\u016e\u016f\7\67\2\2\u016f\u0171"+
		"\7\3\2\2\u0170\u0172\5\62\32\2\u0171\u0170\3\2\2\2\u0171\u0172\3\2\2\2"+
		"\u0172\u0173\3\2\2\2\u0173\u0174\7\4\2\2\u0174\u0175\5\64\33\2\u0175\u017f"+
		"\3\2\2\2\u0176\u0177\7-\2\2\u0177\u0178\7\67\2\2\u0178\u017a\7\3\2\2\u0179"+
		"\u017b\5\62\32\2\u017a\u0179\3\2\2\2\u017a\u017b\3\2\2\2\u017b\u017c\3"+
		"\2\2\2\u017c\u017d\7\4\2\2\u017d\u017f\5\64\33\2\u017e\u016d\3\2\2\2\u017e"+
		"\u0176\3\2\2\2\u017f\61\3\2\2\2\u0180\u0181\b\32\1\2\u0181\u0182\5:\36"+
		"\2\u0182\u0183\7\67\2\2\u0183\u018b\3\2\2\2\u0184\u0185\f\3\2\2\u0185"+
		"\u0186\7 \2\2\u0186\u0187\5:\36\2\u0187\u0188\7\67\2\2\u0188\u018a\3\2"+
		"\2\2\u0189\u0184\3\2\2\2\u018a\u018d\3\2\2\2\u018b\u0189\3\2\2\2\u018b"+
		"\u018c\3\2\2\2\u018c\63\3\2\2\2\u018d\u018b\3\2\2\2\u018e\u0190\7!\2\2"+
		"\u018f\u0191\5\66\34\2\u0190\u018f\3\2\2\2\u0190\u0191\3\2\2\2\u0191\u0192"+
		"\3\2\2\2\u0192\u0193\7\"\2\2\u0193\65\3\2\2\2\u0194\u0195\b\34\1\2\u0195"+
		"\u0196\5\2\2\2\u0196\u019b\3\2\2\2\u0197\u0198\f\3\2\2\u0198\u019a\5\2"+
		"\2\2\u0199\u0197\3\2\2\2\u019a\u019d\3\2\2\2\u019b\u0199\3\2\2\2\u019b"+
		"\u019c\3\2\2\2\u019c\67\3\2\2\2\u019d\u019b\3\2\2\2\u019e\u01a2\5*\26"+
		"\2\u019f\u01a2\5\60\31\2\u01a0\u01a2\5.\30\2\u01a1\u019e\3\2\2\2\u01a1"+
		"\u019f\3\2\2\2\u01a1\u01a0\3\2\2\2\u01a2\u01a5\3\2\2\2\u01a3\u01a1\3\2"+
		"\2\2\u01a3\u01a4\3\2\2\2\u01a49\3\2\2\2\u01a5\u01a3\3\2\2\2\u01a6\u01a7"+
		"\b\36\1\2\u01a7\u01a8\5<\37\2\u01a8\u01ae\3\2\2\2\u01a9\u01aa\f\3\2\2"+
		"\u01aa\u01ab\7\31\2\2\u01ab\u01ad\7\32\2\2\u01ac\u01a9\3\2\2\2\u01ad\u01b0"+
		"\3\2\2\2\u01ae\u01ac\3\2\2\2\u01ae\u01af\3\2\2\2\u01af;\3\2\2\2\u01b0"+
		"\u01ae\3\2\2\2\u01b1\u01b6\7\60\2\2\u01b2\u01b6\7\61\2\2\u01b3\u01b6\7"+
		"\62\2\2\u01b4\u01b6\7\67\2\2\u01b5\u01b1\3\2\2\2\u01b5\u01b2\3\2\2\2\u01b5"+
		"\u01b3\3\2\2\2\u01b5\u01b4\3\2\2\2\u01b6=\3\2\2\2,Qaeimp~\u0089\u0094"+
		"\u009f\u00aa\u00b5\u00c0\u00cb\u00d6\u00e1\u00ec\u00f2\u00f5\u00fa\u0101"+
		"\u0106\u0110\u0123\u012c\u012f\u0131\u013c\u0148\u014e\u015e\u016b\u0171"+
		"\u017a\u017e\u018b\u0190\u019b\u01a1\u01a3\u01ae\u01b5";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}