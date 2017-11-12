// Generated from /Users/zhangjiaheng/IdeaProjects/compiler/src/zzz.g4 by ANTLR 4.5.1
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
	 * Visit a parse tree produced by {@link zzzParser#stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStmt(zzzParser.StmtContext ctx);
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
	 * Visit a parse tree produced by {@link zzzParser#creation_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCreation_expr(zzzParser.Creation_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#dim_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDim_expr(zzzParser.Dim_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#unary_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUnary_expr(zzzParser.Unary_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#call_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCall_expr(zzzParser.Call_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#unary_operator_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUnary_operator_expr(zzzParser.Unary_operator_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#postfix_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPostfix_expr(zzzParser.Postfix_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#postfix}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPostfix(zzzParser.PostfixContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#param_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParam_list(zzzParser.Param_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#pre_expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPre_expr(zzzParser.Pre_exprContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#class_decl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitClass_decl(zzzParser.Class_declContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#member_decl_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMember_decl_list(zzzParser.Member_decl_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#var_decl_stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVar_decl_stmt(zzzParser.Var_decl_stmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#func_decl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunc_decl(zzzParser.Func_declContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#param_decl_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParam_decl_list(zzzParser.Param_decl_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#block_stmt}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBlock_stmt(zzzParser.Block_stmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#stmt_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStmt_list(zzzParser.Stmt_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#program}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProgram(zzzParser.ProgramContext ctx);
	/**
	 * Visit a parse tree produced by {@link zzzParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitType(zzzParser.TypeContext ctx);
}