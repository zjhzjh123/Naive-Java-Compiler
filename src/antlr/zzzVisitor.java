// Generated from /Users/zhangjiaheng/IdeaProjects/compiler/src/zzz.g4 by ANTLR 4.5.1
package antlr;
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link zzzParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface zzzVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by the {@code block}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBlock(zzzParser.BlockContext ctx);
	/**
	 * Visit a parse tree produced by the {@code val_decl}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVal_decl(zzzParser.Val_declContext ctx);
	/**
	 * Visit a parse tree produced by the {@code expresion}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpresion(zzzParser.ExpresionContext ctx);
	/**
	 * Visit a parse tree produced by the {@code if_else}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIf_else(zzzParser.If_elseContext ctx);
	/**
	 * Visit a parse tree produced by the {@code if}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIf(zzzParser.IfContext ctx);
	/**
	 * Visit a parse tree produced by the {@code return}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitReturn(zzzParser.ReturnContext ctx);
	/**
	 * Visit a parse tree produced by the {@code break}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBreak(zzzParser.BreakContext ctx);
	/**
	 * Visit a parse tree produced by the {@code continue}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitContinue(zzzParser.ContinueContext ctx);
	/**
	 * Visit a parse tree produced by the {@code while}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitWhile(zzzParser.WhileContext ctx);
	/**
	 * Visit a parse tree produced by the {@code for}
	 * labeled alternative in {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFor(zzzParser.ForContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#expr_stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpr_stmt(zzzParser.Expr_stmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpr(zzzParser.ExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#assignment_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAssignment_expr(zzzParser.Assignment_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#logic_or_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLogic_or_expr(zzzParser.Logic_or_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#logic_and_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLogic_and_expr(zzzParser.Logic_and_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#inclusive_or_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInclusive_or_expr(zzzParser.Inclusive_or_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#exclusive_or_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExclusive_or_expr(zzzParser.Exclusive_or_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#and_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAnd_expr(zzzParser.And_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#equality_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEquality_expr(zzzParser.Equality_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#relational_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRelational_expr(zzzParser.Relational_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#shift_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitShift_expr(zzzParser.Shift_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#additive_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAdditive_expr(zzzParser.Additive_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#multiplication_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMultiplication_expr(zzzParser.Multiplication_exprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code new}
	 * labeled alternative in {@link zzzParser#creation_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNew(zzzParser.NewContext ctx);
	/**
	 * Visit a parse tree produced by the {@code unary_expresion}
	 * labeled alternative in {@link zzzParser#creation_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUnary_expresion(zzzParser.Unary_expresionContext ctx);
	/**
	 * Visit a parse tree produced by the {@code onedim}
	 * labeled alternative in {@link zzzParser#dim_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOnedim(zzzParser.OnedimContext ctx);
	/**
	 * Visit a parse tree produced by the {@code multidim}
	 * labeled alternative in {@link zzzParser#dim_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMultidim(zzzParser.MultidimContext ctx);
	/**
	 * Visit a parse tree produced by the {@code postfixexpr}
	 * labeled alternative in {@link zzzParser#unary_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPostfixexpr(zzzParser.PostfixexprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code add_addexpr}
	 * labeled alternative in {@link zzzParser#unary_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAdd_addexpr(zzzParser.Add_addexprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code minus_minusexpr}
	 * labeled alternative in {@link zzzParser#unary_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMinus_minusexpr(zzzParser.Minus_minusexprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code operatorexpr}
	 * labeled alternative in {@link zzzParser#unary_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOperatorexpr(zzzParser.OperatorexprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code next}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNext(zzzParser.NextContext ctx);
	/**
	 * Visit a parse tree produced by the {@code call_mem_func}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCall_mem_func(zzzParser.Call_mem_funcContext ctx);
	/**
	 * Visit a parse tree produced by the {@code postfix_call_mem}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPostfix_call_mem(zzzParser.Postfix_call_memContext ctx);
	/**
	 * Visit a parse tree produced by the {@code minus_minus}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMinus_minus(zzzParser.Minus_minusContext ctx);
	/**
	 * Visit a parse tree produced by the {@code add_add}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAdd_add(zzzParser.Add_addContext ctx);
	/**
	 * Visit a parse tree produced by the {@code postfix_call_func}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPostfix_call_func(zzzParser.Postfix_call_funcContext ctx);
	/**
	 * Visit a parse tree produced by the {@code postfix_exp}
	 * labeled alternative in {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPostfix_exp(zzzParser.Postfix_expContext ctx);
	/**
	 * Visit a parse tree produced by the {@code multiexpr}
	 * labeled alternative in {@link zzzParser#param_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMultiexpr(zzzParser.MultiexprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code oneexpr}
	 * labeled alternative in {@link zzzParser#param_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOneexpr(zzzParser.OneexprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code pre_expr_bool}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPre_expr_bool(zzzParser.Pre_expr_boolContext ctx);
	/**
	 * Visit a parse tree produced by the {@code pre_expr_id}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPre_expr_id(zzzParser.Pre_expr_idContext ctx);
	/**
	 * Visit a parse tree produced by the {@code pre_expr_int}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPre_expr_int(zzzParser.Pre_expr_intContext ctx);
	/**
	 * Visit a parse tree produced by the {@code pre_expr_string}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPre_expr_string(zzzParser.Pre_expr_stringContext ctx);
	/**
	 * Visit a parse tree produced by the {@code pre_expr_expr}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPre_expr_expr(zzzParser.Pre_expr_exprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code pre_expr_null}
	 * labeled alternative in {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPre_expr_null(zzzParser.Pre_expr_nullContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#class_decl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitClass_decl(zzzParser.Class_declContext ctx);
	/**
	 * Visit a parse tree produced by the {@code onetypeid}
	 * labeled alternative in {@link zzzParser#member_decl_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOnetypeid(zzzParser.OnetypeidContext ctx);
	/**
	 * Visit a parse tree produced by the {@code multitypeid}
	 * labeled alternative in {@link zzzParser#member_decl_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMultitypeid(zzzParser.MultitypeidContext ctx);
	/**
	 * Visit a parse tree produced by the {@code typeid}
	 * labeled alternative in {@link zzzParser#var_decl_stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTypeid(zzzParser.TypeidContext ctx);
	/**
	 * Visit a parse tree produced by the {@code typeidequality}
	 * labeled alternative in {@link zzzParser#var_decl_stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTypeidequality(zzzParser.TypeidequalityContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#func_decl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunc_decl(zzzParser.Func_declContext ctx);
	/**
	 * Visit a parse tree produced by the {@code multitype}
	 * labeled alternative in {@link zzzParser#param_decl_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMultitype(zzzParser.MultitypeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code onetype}
	 * labeled alternative in {@link zzzParser#param_decl_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOnetype(zzzParser.OnetypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#block_stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBlock_stmt(zzzParser.Block_stmtContext ctx);
	/**
	 * Visit a parse tree produced by the {@code onestmt}
	 * labeled alternative in {@link zzzParser#stmt_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOnestmt(zzzParser.OnestmtContext ctx);
	/**
	 * Visit a parse tree produced by the {@code multiplystmt}
	 * labeled alternative in {@link zzzParser#stmt_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMultiplystmt(zzzParser.MultiplystmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#program}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProgram(zzzParser.ProgramContext ctx);
	/**
	 * Visit a parse tree produced by the {@code arraytype}
	 * labeled alternative in {@link zzzParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitArraytype(zzzParser.ArraytypeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code onlyonetype}
	 * labeled alternative in {@link zzzParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOnlyonetype(zzzParser.OnlyonetypeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code int}
	 * labeled alternative in {@link zzzParser#basictype}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInt(zzzParser.IntContext ctx);
	/**
	 * Visit a parse tree produced by the {@code string}
	 * labeled alternative in {@link zzzParser#basictype}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitString(zzzParser.StringContext ctx);
	/**
	 * Visit a parse tree produced by the {@code bool}
	 * labeled alternative in {@link zzzParser#basictype}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBool(zzzParser.BoolContext ctx);
	/**
	 * Visit a parse tree produced by the {@code id}
	 * labeled alternative in {@link zzzParser#basictype}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitId(zzzParser.IdContext ctx);
}