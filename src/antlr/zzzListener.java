// Generated from /Users/zhangjiaheng/IdeaProjects/compiler/src/zzz.g4 by ANTLR 4.5.1
package antlr;
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link zzzParser}.
 */
public interface zzzListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by the {@code block}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void enterBlock(zzzParser.BlockContext ctx);
	/**
	 * Exit a parse tree produced by the {@code block}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void exitBlock(zzzParser.BlockContext ctx);
	/**
	 * Enter a parse tree produced by the {@code val_decl}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void enterVal_decl(zzzParser.Val_declContext ctx);
	/**
	 * Exit a parse tree produced by the {@code val_decl}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void exitVal_decl(zzzParser.Val_declContext ctx);
	/**
	 * Enter a parse tree produced by the {@code expresion}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void enterExpresion(zzzParser.ExpresionContext ctx);
	/**
	 * Exit a parse tree produced by the {@code expresion}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void exitExpresion(zzzParser.ExpresionContext ctx);
	/**
	 * Enter a parse tree produced by the {@code if_else}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void enterIf_else(zzzParser.If_elseContext ctx);
	/**
	 * Exit a parse tree produced by the {@code if_else}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void exitIf_else(zzzParser.If_elseContext ctx);
	/**
	 * Enter a parse tree produced by the {@code if}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void enterIf(zzzParser.IfContext ctx);
	/**
	 * Exit a parse tree produced by the {@code if}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void exitIf(zzzParser.IfContext ctx);
	/**
	 * Enter a parse tree produced by the {@code return}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void enterReturn(zzzParser.ReturnContext ctx);
	/**
	 * Exit a parse tree produced by the {@code return}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void exitReturn(zzzParser.ReturnContext ctx);
	/**
	 * Enter a parse tree produced by the {@code break}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void enterBreak(zzzParser.BreakContext ctx);
	/**
	 * Exit a parse tree produced by the {@code break}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void exitBreak(zzzParser.BreakContext ctx);
	/**
	 * Enter a parse tree produced by the {@code continue}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void enterContinue(zzzParser.ContinueContext ctx);
	/**
	 * Exit a parse tree produced by the {@code continue}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void exitContinue(zzzParser.ContinueContext ctx);
	/**
	 * Enter a parse tree produced by the {@code while}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void enterWhile(zzzParser.WhileContext ctx);
	/**
	 * Exit a parse tree produced by the {@code while}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void exitWhile(zzzParser.WhileContext ctx);
	/**
	 * Enter a parse tree produced by the {@code for}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void enterFor(zzzParser.ForContext ctx);
	/**
	 * Exit a parse tree produced by the {@code for}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 */
	void exitFor(zzzParser.ForContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#expr_stmt}.
	 * @param ctx the parse tree
	 */
	void enterExpr_stmt(zzzParser.Expr_stmtContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#expr_stmt}.
	 * @param ctx the parse tree
	 */
	void exitExpr_stmt(zzzParser.Expr_stmtContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(zzzParser.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(zzzParser.ExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#assignment_expr}.
	 * @param ctx the parse tree
	 */
	void enterAssignment_expr(zzzParser.Assignment_exprContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#assignment_expr}.
	 * @param ctx the parse tree
	 */
	void exitAssignment_expr(zzzParser.Assignment_exprContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#logic_or_expr}.
	 * @param ctx the parse tree
	 */
	void enterLogic_or_expr(zzzParser.Logic_or_exprContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#logic_or_expr}.
	 * @param ctx the parse tree
	 */
	void exitLogic_or_expr(zzzParser.Logic_or_exprContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#logic_and_expr}.
	 * @param ctx the parse tree
	 */
	void enterLogic_and_expr(zzzParser.Logic_and_exprContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#logic_and_expr}.
	 * @param ctx the parse tree
	 */
	void exitLogic_and_expr(zzzParser.Logic_and_exprContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#inclusive_or_expr}.
	 * @param ctx the parse tree
	 */
	void enterInclusive_or_expr(zzzParser.Inclusive_or_exprContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#inclusive_or_expr}.
	 * @param ctx the parse tree
	 */
	void exitInclusive_or_expr(zzzParser.Inclusive_or_exprContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#exclusive_or_expr}.
	 * @param ctx the parse tree
	 */
	void enterExclusive_or_expr(zzzParser.Exclusive_or_exprContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#exclusive_or_expr}.
	 * @param ctx the parse tree
	 */
	void exitExclusive_or_expr(zzzParser.Exclusive_or_exprContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#and_expr}.
	 * @param ctx the parse tree
	 */
	void enterAnd_expr(zzzParser.And_exprContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#and_expr}.
	 * @param ctx the parse tree
	 */
	void exitAnd_expr(zzzParser.And_exprContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#equality_expr}.
	 * @param ctx the parse tree
	 */
	void enterEquality_expr(zzzParser.Equality_exprContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#equality_expr}.
	 * @param ctx the parse tree
	 */
	void exitEquality_expr(zzzParser.Equality_exprContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#relational_expr}.
	 * @param ctx the parse tree
	 */
	void enterRelational_expr(zzzParser.Relational_exprContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#relational_expr}.
	 * @param ctx the parse tree
	 */
	void exitRelational_expr(zzzParser.Relational_exprContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#shift_expr}.
	 * @param ctx the parse tree
	 */
	void enterShift_expr(zzzParser.Shift_exprContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#shift_expr}.
	 * @param ctx the parse tree
	 */
	void exitShift_expr(zzzParser.Shift_exprContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#additive_expr}.
	 * @param ctx the parse tree
	 */
	void enterAdditive_expr(zzzParser.Additive_exprContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#additive_expr}.
	 * @param ctx the parse tree
	 */
	void exitAdditive_expr(zzzParser.Additive_exprContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#multiplication_expr}.
	 * @param ctx the parse tree
	 */
	void enterMultiplication_expr(zzzParser.Multiplication_exprContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#multiplication_expr}.
	 * @param ctx the parse tree
	 */
	void exitMultiplication_expr(zzzParser.Multiplication_exprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code new}
	 * labeled alternative in {@link zzzParser#creation_expr}.
	 * @param ctx the parse tree
	 */
	void enterNew(zzzParser.NewContext ctx);
	/**
	 * Exit a parse tree produced by the {@code new}
	 * labeled alternative in {@link zzzParser#creation_expr}.
	 * @param ctx the parse tree
	 */
	void exitNew(zzzParser.NewContext ctx);
	/**
	 * Enter a parse tree produced by the {@code unary_expresion}
	 * labeled alternative in {@link zzzParser#creation_expr}.
	 * @param ctx the parse tree
	 */
	void enterUnary_expresion(zzzParser.Unary_expresionContext ctx);
	/**
	 * Exit a parse tree produced by the {@code unary_expresion}
	 * labeled alternative in {@link zzzParser#creation_expr}.
	 * @param ctx the parse tree
	 */
	void exitUnary_expresion(zzzParser.Unary_expresionContext ctx);
	/**
	 * Enter a parse tree produced by the {@code onedim}
	 * labeled alternative in {@link zzzParser#dim_expr}.
	 * @param ctx the parse tree
	 */
	void enterOnedim(zzzParser.OnedimContext ctx);
	/**
	 * Exit a parse tree produced by the {@code onedim}
	 * labeled alternative in {@link zzzParser#dim_expr}.
	 * @param ctx the parse tree
	 */
	void exitOnedim(zzzParser.OnedimContext ctx);
	/**
	 * Enter a parse tree produced by the {@code multidim}
	 * labeled alternative in {@link zzzParser#dim_expr}.
	 * @param ctx the parse tree
	 */
	void enterMultidim(zzzParser.MultidimContext ctx);
	/**
	 * Exit a parse tree produced by the {@code multidim}
	 * labeled alternative in {@link zzzParser#dim_expr}.
	 * @param ctx the parse tree
	 */
	void exitMultidim(zzzParser.MultidimContext ctx);
	/**
	 * Enter a parse tree produced by the {@code postfixexpr}
	 * labeled alternative in {@link zzzParser#unary_expr}.
	 * @param ctx the parse tree
	 */
	void enterPostfixexpr(zzzParser.PostfixexprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code postfixexpr}
	 * labeled alternative in {@link zzzParser#unary_expr}.
	 * @param ctx the parse tree
	 */
	void exitPostfixexpr(zzzParser.PostfixexprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code add_addexpr}
	 * labeled alternative in {@link zzzParser#unary_expr}.
	 * @param ctx the parse tree
	 */
	void enterAdd_addexpr(zzzParser.Add_addexprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code add_addexpr}
	 * labeled alternative in {@link zzzParser#unary_expr}.
	 * @param ctx the parse tree
	 */
	void exitAdd_addexpr(zzzParser.Add_addexprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code minus_minusexpr}
	 * labeled alternative in {@link zzzParser#unary_expr}.
	 * @param ctx the parse tree
	 */
	void enterMinus_minusexpr(zzzParser.Minus_minusexprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code minus_minusexpr}
	 * labeled alternative in {@link zzzParser#unary_expr}.
	 * @param ctx the parse tree
	 */
	void exitMinus_minusexpr(zzzParser.Minus_minusexprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code operatorexpr}
	 * labeled alternative in {@link zzzParser#unary_expr}.
	 * @param ctx the parse tree
	 */
	void enterOperatorexpr(zzzParser.OperatorexprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code operatorexpr}
	 * labeled alternative in {@link zzzParser#unary_expr}.
	 * @param ctx the parse tree
	 */
	void exitOperatorexpr(zzzParser.OperatorexprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code next}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 */
	void enterNext(zzzParser.NextContext ctx);
	/**
	 * Exit a parse tree produced by the {@code next}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 */
	void exitNext(zzzParser.NextContext ctx);
	/**
	 * Enter a parse tree produced by the {@code call_mem_func}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 */
	void enterCall_mem_func(zzzParser.Call_mem_funcContext ctx);
	/**
	 * Exit a parse tree produced by the {@code call_mem_func}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 */
	void exitCall_mem_func(zzzParser.Call_mem_funcContext ctx);
	/**
	 * Enter a parse tree produced by the {@code postfix_call_mem}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 */
	void enterPostfix_call_mem(zzzParser.Postfix_call_memContext ctx);
	/**
	 * Exit a parse tree produced by the {@code postfix_call_mem}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 */
	void exitPostfix_call_mem(zzzParser.Postfix_call_memContext ctx);
	/**
	 * Enter a parse tree produced by the {@code minus_minus}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 */
	void enterMinus_minus(zzzParser.Minus_minusContext ctx);
	/**
	 * Exit a parse tree produced by the {@code minus_minus}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 */
	void exitMinus_minus(zzzParser.Minus_minusContext ctx);
	/**
	 * Enter a parse tree produced by the {@code add_add}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 */
	void enterAdd_add(zzzParser.Add_addContext ctx);
	/**
	 * Exit a parse tree produced by the {@code add_add}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 */
	void exitAdd_add(zzzParser.Add_addContext ctx);
	/**
	 * Enter a parse tree produced by the {@code postfix_call_func}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 */
	void enterPostfix_call_func(zzzParser.Postfix_call_funcContext ctx);
	/**
	 * Exit a parse tree produced by the {@code postfix_call_func}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 */
	void exitPostfix_call_func(zzzParser.Postfix_call_funcContext ctx);
	/**
	 * Enter a parse tree produced by the {@code postfix_exp}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 */
	void enterPostfix_exp(zzzParser.Postfix_expContext ctx);
	/**
	 * Exit a parse tree produced by the {@code postfix_exp}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 */
	void exitPostfix_exp(zzzParser.Postfix_expContext ctx);
	/**
	 * Enter a parse tree produced by the {@code multiexpr}
	 * labeled alternative in {@link zzzParser#param_list}.
	 * @param ctx the parse tree
	 */
	void enterMultiexpr(zzzParser.MultiexprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code multiexpr}
	 * labeled alternative in {@link zzzParser#param_list}.
	 * @param ctx the parse tree
	 */
	void exitMultiexpr(zzzParser.MultiexprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code oneexpr}
	 * labeled alternative in {@link zzzParser#param_list}.
	 * @param ctx the parse tree
	 */
	void enterOneexpr(zzzParser.OneexprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code oneexpr}
	 * labeled alternative in {@link zzzParser#param_list}.
	 * @param ctx the parse tree
	 */
	void exitOneexpr(zzzParser.OneexprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code pre_expr_bool}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 */
	void enterPre_expr_bool(zzzParser.Pre_expr_boolContext ctx);
	/**
	 * Exit a parse tree produced by the {@code pre_expr_bool}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 */
	void exitPre_expr_bool(zzzParser.Pre_expr_boolContext ctx);
	/**
	 * Enter a parse tree produced by the {@code pre_expr_id}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 */
	void enterPre_expr_id(zzzParser.Pre_expr_idContext ctx);
	/**
	 * Exit a parse tree produced by the {@code pre_expr_id}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 */
	void exitPre_expr_id(zzzParser.Pre_expr_idContext ctx);
	/**
	 * Enter a parse tree produced by the {@code pre_expr_int}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 */
	void enterPre_expr_int(zzzParser.Pre_expr_intContext ctx);
	/**
	 * Exit a parse tree produced by the {@code pre_expr_int}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 */
	void exitPre_expr_int(zzzParser.Pre_expr_intContext ctx);
	/**
	 * Enter a parse tree produced by the {@code pre_expr_string}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 */
	void enterPre_expr_string(zzzParser.Pre_expr_stringContext ctx);
	/**
	 * Exit a parse tree produced by the {@code pre_expr_string}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 */
	void exitPre_expr_string(zzzParser.Pre_expr_stringContext ctx);
	/**
	 * Enter a parse tree produced by the {@code pre_expr_expr}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 */
	void enterPre_expr_expr(zzzParser.Pre_expr_exprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code pre_expr_expr}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 */
	void exitPre_expr_expr(zzzParser.Pre_expr_exprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code pre_expr_null}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 */
	void enterPre_expr_null(zzzParser.Pre_expr_nullContext ctx);
	/**
	 * Exit a parse tree produced by the {@code pre_expr_null}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 */
	void exitPre_expr_null(zzzParser.Pre_expr_nullContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#class_decl}.
	 * @param ctx the parse tree
	 */
	void enterClass_decl(zzzParser.Class_declContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#class_decl}.
	 * @param ctx the parse tree
	 */
	void exitClass_decl(zzzParser.Class_declContext ctx);
	/**
	 * Enter a parse tree produced by the {@code onetypeid}
	 * labeled alternative in {@link zzzParser#member_decl_list}.
	 * @param ctx the parse tree
	 */
	void enterOnetypeid(zzzParser.OnetypeidContext ctx);
	/**
	 * Exit a parse tree produced by the {@code onetypeid}
	 * labeled alternative in {@link zzzParser#member_decl_list}.
	 * @param ctx the parse tree
	 */
	void exitOnetypeid(zzzParser.OnetypeidContext ctx);
	/**
	 * Enter a parse tree produced by the {@code multitypeid}
	 * labeled alternative in {@link zzzParser#member_decl_list}.
	 * @param ctx the parse tree
	 */
	void enterMultitypeid(zzzParser.MultitypeidContext ctx);
	/**
	 * Exit a parse tree produced by the {@code multitypeid}
	 * labeled alternative in {@link zzzParser#member_decl_list}.
	 * @param ctx the parse tree
	 */
	void exitMultitypeid(zzzParser.MultitypeidContext ctx);
	/**
	 * Enter a parse tree produced by the {@code typeid}
	 * labeled alternative in {@link zzzParser#var_decl_stmt}.
	 * @param ctx the parse tree
	 */
	void enterTypeid(zzzParser.TypeidContext ctx);
	/**
	 * Exit a parse tree produced by the {@code typeid}
	 * labeled alternative in {@link zzzParser#var_decl_stmt}.
	 * @param ctx the parse tree
	 */
	void exitTypeid(zzzParser.TypeidContext ctx);
	/**
	 * Enter a parse tree produced by the {@code typeidequality}
	 * labeled alternative in {@link zzzParser#var_decl_stmt}.
	 * @param ctx the parse tree
	 */
	void enterTypeidequality(zzzParser.TypeidequalityContext ctx);
	/**
	 * Exit a parse tree produced by the {@code typeidequality}
	 * labeled alternative in {@link zzzParser#var_decl_stmt}.
	 * @param ctx the parse tree
	 */
	void exitTypeidequality(zzzParser.TypeidequalityContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#func_decl}.
	 * @param ctx the parse tree
	 */
	void enterFunc_decl(zzzParser.Func_declContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#func_decl}.
	 * @param ctx the parse tree
	 */
	void exitFunc_decl(zzzParser.Func_declContext ctx);
	/**
	 * Enter a parse tree produced by the {@code multitype}
	 * labeled alternative in {@link zzzParser#param_decl_list}.
	 * @param ctx the parse tree
	 */
	void enterMultitype(zzzParser.MultitypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code multitype}
	 * labeled alternative in {@link zzzParser#param_decl_list}.
	 * @param ctx the parse tree
	 */
	void exitMultitype(zzzParser.MultitypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code onetype}
	 * labeled alternative in {@link zzzParser#param_decl_list}.
	 * @param ctx the parse tree
	 */
	void enterOnetype(zzzParser.OnetypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code onetype}
	 * labeled alternative in {@link zzzParser#param_decl_list}.
	 * @param ctx the parse tree
	 */
	void exitOnetype(zzzParser.OnetypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#block_stmt}.
	 * @param ctx the parse tree
	 */
	void enterBlock_stmt(zzzParser.Block_stmtContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#block_stmt}.
	 * @param ctx the parse tree
	 */
	void exitBlock_stmt(zzzParser.Block_stmtContext ctx);
	/**
	 * Enter a parse tree produced by the {@code onestmt}
	 * labeled alternative in {@link zzzParser#stmt_list}.
	 * @param ctx the parse tree
	 */
	void enterOnestmt(zzzParser.OnestmtContext ctx);
	/**
	 * Exit a parse tree produced by the {@code onestmt}
	 * labeled alternative in {@link zzzParser#stmt_list}.
	 * @param ctx the parse tree
	 */
	void exitOnestmt(zzzParser.OnestmtContext ctx);
	/**
	 * Enter a parse tree produced by the {@code multiplystmt}
	 * labeled alternative in {@link zzzParser#stmt_list}.
	 * @param ctx the parse tree
	 */
	void enterMultiplystmt(zzzParser.MultiplystmtContext ctx);
	/**
	 * Exit a parse tree produced by the {@code multiplystmt}
	 * labeled alternative in {@link zzzParser#stmt_list}.
	 * @param ctx the parse tree
	 */
	void exitMultiplystmt(zzzParser.MultiplystmtContext ctx);
	/**
	 * Enter a parse tree produced by {@link zzzParser#program}.
	 * @param ctx the parse tree
	 */
	void enterProgram(zzzParser.ProgramContext ctx);
	/**
	 * Exit a parse tree produced by {@link zzzParser#program}.
	 * @param ctx the parse tree
	 */
	void exitProgram(zzzParser.ProgramContext ctx);
	/**
	 * Enter a parse tree produced by the {@code arraytype}
	 * labeled alternative in {@link zzzParser#type}.
	 * @param ctx the parse tree
	 */
	void enterArraytype(zzzParser.ArraytypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code arraytype}
	 * labeled alternative in {@link zzzParser#type}.
	 * @param ctx the parse tree
	 */
	void exitArraytype(zzzParser.ArraytypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code onlyonetype}
	 * labeled alternative in {@link zzzParser#type}.
	 * @param ctx the parse tree
	 */
	void enterOnlyonetype(zzzParser.OnlyonetypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code onlyonetype}
	 * labeled alternative in {@link zzzParser#type}.
	 * @param ctx the parse tree
	 */
	void exitOnlyonetype(zzzParser.OnlyonetypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code int}
	 * labeled alternative in {@link zzzParser#basictype}.
	 * @param ctx the parse tree
	 */
	void enterInt(zzzParser.IntContext ctx);
	/**
	 * Exit a parse tree produced by the {@code int}
	 * labeled alternative in {@link zzzParser#basictype}.
	 * @param ctx the parse tree
	 */
	void exitInt(zzzParser.IntContext ctx);
	/**
	 * Enter a parse tree produced by the {@code string}
	 * labeled alternative in {@link zzzParser#basictype}.
	 * @param ctx the parse tree
	 */
	void enterString(zzzParser.StringContext ctx);
	/**
	 * Exit a parse tree produced by the {@code string}
	 * labeled alternative in {@link zzzParser#basictype}.
	 * @param ctx the parse tree
	 */
	void exitString(zzzParser.StringContext ctx);
	/**
	 * Enter a parse tree produced by the {@code bool}
	 * labeled alternative in {@link zzzParser#basictype}.
	 * @param ctx the parse tree
	 */
	void enterBool(zzzParser.BoolContext ctx);
	/**
	 * Exit a parse tree produced by the {@code bool}
	 * labeled alternative in {@link zzzParser#basictype}.
	 * @param ctx the parse tree
	 */
	void exitBool(zzzParser.BoolContext ctx);
	/**
	 * Enter a parse tree produced by the {@code id}
	 * labeled alternative in {@link zzzParser#basictype}.
	 * @param ctx the parse tree
	 */
	void enterId(zzzParser.IdContext ctx);
	/**
	 * Exit a parse tree produced by the {@code id}
	 * labeled alternative in {@link zzzParser#basictype}.
	 * @param ctx the parse tree
	 */
	void exitId(zzzParser.IdContext ctx);
}