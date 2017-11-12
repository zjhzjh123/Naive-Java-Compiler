package antlr;

import ast.*;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.tree.ParseTree;

import java.math.BigInteger;
import java.util.LinkedList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */

public class BuildListener extends zzzBaseListener{
    public static int row, column;

    public Stack<ast> stack = new Stack<ast>();

    @Override
    public void enterEveryRule(ParserRuleContext ctx) {
        row = ctx.getStart().getLine();
        column = ctx.getStart().getCharPositionInLine();
    }

    @Override public void exitBlock(zzzParser.BlockContext ctx) {
        if(ctx.block_stmt().stmt_list() == null){
            stack.push(null);
        }
    }

    @Override public void exitVal_decl(zzzParser.Val_declContext ctx) {
        VarDecStmt vardecstmt = new VarDecStmt((VarDec)stack.pop());
        stack.push(vardecstmt);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }
    @Override public void exitExpresion(zzzParser.ExpresionContext ctx) {
    }

    @Override public void exitIf(zzzParser.IfContext ctx) {
        Stmt stmt = null;
        if(stack.peek() != null){
            stmt = (Stmt)stack.peek();
        }
        stack.pop();
        IfStmt ifstmt = new IfStmt((Exp)stack.pop(), stmt);
        stack.push(ifstmt);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitIf_else(zzzParser.If_elseContext ctx) {
        Stmt stmt = null;
        if(stack.peek() != null){
            stmt = (Stmt)stack.peek();
        }
        stack.pop();
        Stmt stmt1 = null;
        if(stack.peek() != null){
            stmt1 = (Stmt)stack.peek();
        }
        stack.pop();

        IfStmt ifstmt = new IfStmt((Exp)stack.pop(),stmt1,stmt);
        stack.push(ifstmt);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitReturn(zzzParser.ReturnContext ctx) {
        ReturnStmt returnStmt = new ReturnStmt(null);
        if(ctx.expr() != null) returnStmt.result = (Exp)stack.pop();
        stack.push(returnStmt);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitBreak(zzzParser.BreakContext ctx) {
        stack.push(new BreakStmt());
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitContinue(zzzParser.ContinueContext ctx) {
        stack.push(new ContinueStmt());
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitWhile(zzzParser.WhileContext ctx) {
        Stmt stmt = null;
        if(stack.peek() != null) {
            stmt = (Stmt) stack.peek();
        }
        stack.pop();
        stack.push(new WhileStmt((Exp)stack.pop(),stmt));
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitFor(zzzParser.ForContext ctx) {
        Stmt stmt = null;
        if (stack.peek() != null) {
            stmt = (Stmt)stack.peek();
        }
        stack.pop();

        zzzParser.ExprContext[] exprContexts = new zzzParser.ExprContext[3];

        int counter = 0;
        for (ParseTree parseTree : ctx.children) {
            if (parseTree instanceof zzzParser.ExprContext) {
                exprContexts[counter] = (zzzParser.ExprContext)parseTree;
            }
            if (parseTree.getText().equals(";")) {
                counter++;
            }
        }

        Exp exp3 = null;
        if (exprContexts[2] != null) {
            exp3 = (Exp) stack.pop();
        }
        Exp exp2 = null;
        if (exprContexts[1] != null) {
            exp2 = (Exp) stack.pop();
        }
        Exp exp1 = null;
        if (exprContexts[0] != null) {
            exp1 = (Exp) stack.pop();
        }
//        System.out.println(exp2.getClass());
        stack.push(new ForStmt(exp1, exp2, exp3, stmt));
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitExpr_stmt(zzzParser.Expr_stmtContext ctx) {
        if (ctx.expr() == null) {
            stack.push(null);
        //    stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
        }
    }

    @Override public void exitExpr(zzzParser.ExprContext ctx) { }

    @Override public void exitAssignment_expr(zzzParser.Assignment_exprContext ctx) {
        if(ctx.logic_or_expr() == null){
            Exp exp = (Exp) stack.pop();
            stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.assignment_op, exp));
            stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
        }
    }

    @Override public void exitLogic_or_expr(zzzParser.Logic_or_exprContext ctx) {
        if(ctx.logic_and_expr() == null){
            Exp exp = (Exp) stack.pop();
            stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.log_or_op, exp));
            stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
        }
    }

    @Override public void exitLogic_and_expr(zzzParser.Logic_and_exprContext ctx) {
        if(ctx.inclusive_or_expr() == null){
            Exp exp = (Exp) stack.pop();
            stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.log_and_op, exp));
            stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
        }
    }

    @Override public void exitInclusive_or_expr(zzzParser.Inclusive_or_exprContext ctx) {
        if(ctx.exclusive_or_expr() == null){
            Exp exp = (Exp) stack.pop();
            stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.inclusive_or_op, exp));
            stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
        }
    }

    @Override public void exitExclusive_or_expr(zzzParser.Exclusive_or_exprContext ctx) {
        if(ctx.and_expr() == null){
            Exp exp = (Exp) stack.pop();
            stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.and_op, exp));
            stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
        }
    }

    @Override public void exitAnd_expr(zzzParser.And_exprContext ctx) {
        if(ctx.equality_expr() == null){
            Exp exp = (Exp) stack.pop();
            stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.equality_op, exp));
            stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
        }
    }

    @Override public void exitEquality_expr(zzzParser.Equality_exprContext ctx) {
       // if (ctx.op != null) {
       //     System.out.println(ctx.op.getText());
//     //       System.out.println(ctx.)A
      //  }
      //  if (ctx.relational_expr() != null)
        //    System.out.println("IN EQUALITY" + " " + ctx.relational_expr().getText());
    //    Exp exp = (Exp) stack.pop();
        if(ctx.relational_expr() == null){
            Exp exp = (Exp) stack.pop();
        //    System.out.println("YES");
        //    System.out.println(ctx.op.getText());
            //Exp exp = (Exp) stack.pop();
          //  Exp exp = (Exp) stack.pop();
            if(ctx.op.getText().equals("==")){
           //     Exp exp = (Exp) stack.pop();
            stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.equality_op, exp));
            stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
            }
            if(ctx.op.getText().equals("!=")){
         //       Exp exp = (Exp) stack.pop();
                stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.non_equality_op, exp));
                stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
            }
        }
    }

    @Override public void exitRelational_expr(zzzParser.Relational_exprContext ctx) {
        if(ctx.shift_expr() == null){
            Exp exp = (Exp) stack.pop();
            if(ctx.op.getText().equals("<")){
            //    System.out.println("ffffffffff");
                stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.less_op, exp));
                stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
            }
            if(ctx.op.getText().equals(">")){
                stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.larger_op, exp));
                stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
            }
            if(ctx.op.getText().equals(">=")){
                stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.larger_equality_op, exp));
                stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
            }
            if(ctx.op.getText().equals("<=")){
                stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.less_equality_op, exp));
                stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
            }
        }
    }

    @Override public void exitShift_expr(zzzParser.Shift_exprContext ctx) {
        if(ctx.additive_expr() == null){
            Exp exp = (Exp) stack.pop();
            if(ctx.op.getText().equals("<<")){
                stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.left_op, exp));
                stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
            }
            if(ctx.op.getText().equals(">>")){
                stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.right_op, exp));
                stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
            }
        }
    }

    @Override public void exitAdditive_expr(zzzParser.Additive_exprContext ctx) {
        if(ctx.multiplication_expr() == null){
            Exp exp = (Exp) stack.pop();
            if(ctx.op.getText().equals("+")){
                stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.add_op, exp));
                stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
            }
            if(ctx.op.getText().equals("-")){
                stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.minus_op, exp));
                stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
            }
        }
    }

    @Override public void exitMultiplication_expr(zzzParser.Multiplication_exprContext ctx) {
        if(ctx.creation_expr() == null){
            Exp exp = (Exp) stack.pop();
            if(ctx.op.getText().equals("*")){
                stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.multi_op, exp));
                stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
            }
            if(ctx.op.getText().equals("/")){
                stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.div_op, exp));
                stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
            }
            if(ctx.op.getText().equals("%")){
                stack.push(new BinaryExp((Exp)stack.pop(),BinaryOp.mod_op, exp));
                stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
            }
        }
    }

    @Override public void exitNew(zzzParser.NewContext ctx) {
        if(ctx.dim_expr()!= null){
            Stack<Exp> stack1 = new Stack<Exp>();
            while(stack.peek() instanceof Exp || stack.peek() == null){
                stack1.push((Exp) stack.pop());
            }
            while(!stack1.isEmpty()){
                ArrayType arrayType = new ArrayType((BasicType) stack.pop(),(Exp) stack1.pop());
                stack.push(arrayType);
                stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
            }
        }
        stack.push(new CreationExp((BasicType)stack.pop()));
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitUnary_expresion(zzzParser.Unary_expresionContext ctx) { }

    @Override public void exitOnedim(zzzParser.OnedimContext ctx) {
        if(ctx.expr() == null){
            stack.push(null);
 //           stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
        }
    }
    @Override public void exitMultidim(zzzParser.MultidimContext ctx) {
        if(ctx.expr() == null){
            stack.push(null);
//            stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
        }
    }
//
  // @Override public void exitCreation_expr(zzzParser.Creation_exprContext ctx) {
  //      if(ctx.unary_expr() == null){
  //          BasicType basicType = (BasicType)stack.pop();
  //          stack.push(new CreationExp(basicType));
  //          stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
  //      }
  //  }

  /*  @Override public void exitDim_expr(zzzParser.Dim_exprContext ctx) {
        Stack<Exp> stack1 = new Stack<Exp>();
        while(stack.peek() instanceof Exp){
            stack1.push((Exp) stack.pop());
        }
        BasicType basicType = (BasicType)stack.pop();
        ArrayType arraytype = new ArrayType(basicType, stack1.pop());
        while(!stack1.isEmpty()){
            arraytype = new ArrayType(arraytype, stack1.pop());
        }
        stack.push(arraytype);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }
*/
    @Override public void exitPostfixexpr(zzzParser.PostfixexprContext ctx) { }

    //@Override public void exitCallexpr(zzzParser.CallexprContext ctx) {
    //}

    @Override public void exitAdd_addexpr(zzzParser.Add_addexprContext ctx) {
        stack.push(new UnaryExp((Exp)stack.pop(), UnaryOp.add_add_op));
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitMinus_minusexpr(zzzParser.Minus_minusexprContext ctx) {
        stack.push(new UnaryExp((Exp)stack.pop(), UnaryOp.minus_minus_op));
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitOperatorexpr(zzzParser.OperatorexprContext ctx) {
     //   System.out.println(ctx.op);
        if(ctx.op.getText().equals("+")){
            stack.push(new UnaryExp((Exp)stack.pop(), UnaryOp.add_op));
            stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
        }
        if(ctx.op.getText().equals("-")){

            stack.push(new UnaryExp((Exp)stack.pop(), UnaryOp.minus_op));
            stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
        }
        if(ctx.op.getText().equals("!")){
            stack.push(new UnaryExp((Exp)stack.pop(), UnaryOp.non_op));
            stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
        }
        if(ctx.op.getText().equals("~")){
            stack.push(new UnaryExp((Exp)stack.pop(), UnaryOp.delete_op));
            stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
        }
    }

//    @Override public void exitCall_expr(zzzParser.Call_exprContext ctx) {
 //       Symbol symbol = new Symbol(ctx.ID().getText());
   //     CompoundParam compoundparam = new CompoundParam();
     //   if(ctx.param_list() != null)
       //     compoundparam = (CompoundParam)stack.pop();
       // FuncCall funccall = new FuncCall(symbol,compoundparam);
       // stack.push(funccall);
      //  stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
   // }

    @Override public void exitNext(zzzParser.NextContext ctx) { }

    @Override public void exitAdd_add(zzzParser.Add_addContext ctx) {
        stack.push(new PostAdd((Exp)stack.pop()));
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitMinus_minus(zzzParser.Minus_minusContext ctx) {
        stack.push(new PostMinus((Exp)stack.pop()));
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitPostfix_exp(zzzParser.Postfix_expContext ctx) {
        Exp exp = (Exp)stack.pop();
        ArrayAccess arrayaccess = new ArrayAccess((Exp)stack.pop(), exp);
        stack.push(arrayaccess);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitPostfix_call_mem(zzzParser.Postfix_call_memContext ctx) {
    //    System.out.println(ctx.ID().getText());
        Exp exp = (Exp)stack.pop();
        Symbol symbol = Symbol.symbol(ctx.ID().getText());
        ClassAccess classaccess = new ClassAccess(exp, symbol);
        stack.push(classaccess);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitPostfix_call_func(zzzParser.Postfix_call_funcContext ctx) {
     //   Symbol symbol = ((Identify)stack.pop()).symbol;
        CompoundParam compoundparam = new CompoundParam();
        if(ctx.param_list() != null)
            compoundparam = (CompoundParam)stack.pop();
        Symbol symbol = ((Identify)stack.pop()).symbol;
        FuncCall funccall = new FuncCall(symbol,compoundparam);
        stack.push(funccall);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitCall_mem_func(zzzParser.Call_mem_funcContext ctx) {
    //    System.out.println(ctx.ID().getText());
        Symbol symbol1 = Symbol.symbol(ctx.ID().getText());
        CompoundParam compoundparam = new CompoundParam();
        if(ctx.param_list() != null)
            compoundparam = (CompoundParam)stack.pop();
        Exp exp = (Exp)stack.pop();
        ClassAccess funccall = new ClassAccess(exp, symbol1, compoundparam);
        stack.push(funccall);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitMultiexpr(zzzParser.MultiexprContext ctx) {
        Exp exp = (Exp)stack.pop();
        CompoundParam compoundparam = new CompoundParam();
        compoundparam.explist.add(exp);
        stack.push(compoundparam);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitOneexpr(zzzParser.OneexprContext ctx) {
        Exp exp = (Exp)stack.pop();
        CompoundParam compoundparam1 = (CompoundParam)stack.pop();
    //    while(compoundparam.explist.size() != 0){
     //       compoundparam1.explist.add(compoundparam.explist.getFirst());
      //      compoundparam1.explist.pop();
       // }
        compoundparam1.explist.add(exp);
        stack.push(compoundparam1);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }



    @Override public void exitPre_expr_id(zzzParser.Pre_expr_idContext ctx) {
        Symbol symbol = Symbol.symbol(ctx.getText());
        Identify identify = new Identify(symbol);
        stack.push(identify);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitPre_expr_int(zzzParser.Pre_expr_intContext ctx) {
    //    int a = Integer.parseInt(ctx.getText());
        IntConst intconst = new IntConst(new BigInteger(ctx.getText()));
        stack.push(intconst);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitPre_expr_string(zzzParser.Pre_expr_stringContext ctx) {
        StringConst stringconst = new StringConst(ctx.getText());
        stack.push(stringconst);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitPre_expr_bool(zzzParser.Pre_expr_boolContext ctx) {

        Boolconst boolconst = new Boolconst(true);
        if(ctx.getText().equals("false"))
            boolconst.bool = false;
        stack.push(boolconst);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitPre_expr_expr(zzzParser.Pre_expr_exprContext ctx) {

    }

    @Override public void exitPre_expr_null(zzzParser.Pre_expr_nullContext ctx) {
        stack.push(new NullConst());
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitClass_decl(zzzParser.Class_declContext ctx) {
        Symbol symbol = Symbol.symbol(ctx.ID().getText());
    //    System.out.println(symbol.toString());
        CompoundVarDec compoundVarDec = (CompoundVarDec)stack.pop();
        ClassDel classDel = new ClassDel(symbol, compoundVarDec);
        stack.push(classDel);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitOnetypeid(zzzParser.OnetypeidContext ctx) {
        BasicType type = (BasicType) stack.pop();
        Symbol symbol = Symbol.symbol(ctx.ID().getText());
        VarDec vardec = new VarDec(type, symbol);
        CompoundVarDec compoundVarDec = new CompoundVarDec();
        compoundVarDec.vardeclist.add(vardec);
        stack.push(compoundVarDec);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitMultitypeid(zzzParser.MultitypeidContext ctx) {
        //    System.out.println(ctx.ID().getText());
        BasicType type = (BasicType) stack.pop();
        Symbol symbol = Symbol.symbol(ctx.ID().getText());
        VarDec varDec = new VarDec(type, symbol);
        CompoundVarDec compoundVarDec = (CompoundVarDec)stack.pop();
        //    while(compoundVarDec.vardeclist.size()!=0){
        //        compoundVarDec1.vardeclist.add(compoundVarDec.vardeclist.getFirst());
        //        compoundVarDec.vardeclist.pop();
        //    }
        compoundVarDec.vardeclist.add(varDec);
        stack.push(compoundVarDec);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitTypeid(zzzParser.TypeidContext ctx) {
        Symbol symbol = Symbol.symbol(ctx.ID().getText());
        VarDec vardec = new VarDec((BasicType)(stack.pop()),symbol);
        stack.push(vardec);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitTypeidequality(zzzParser.TypeidequalityContext ctx) {
        Exp exp = (Exp)stack.pop();
        Symbol symbol = Symbol.symbol(ctx.ID().getText());
        BasicType type = (BasicType)stack.pop();
        VarDec vardec = new VarDec(type, symbol, exp);
        stack.push(vardec);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitFunc_decl(zzzParser.Func_declContext ctx) {
    //    System.out.print("Func_decl");
        CompoundVarDec compoundVarDec = new CompoundVarDec();
        CompoundStmt compoundStmt = new CompoundStmt(null);
        if(ctx.block_stmt() != null && ctx.block_stmt().stmt_list() != null) compoundStmt = (CompoundStmt) stack.pop();
        else compoundStmt =  null;
        if(ctx.param_decl_list() != null) compoundVarDec = (CompoundVarDec) stack.pop();
        else compoundVarDec = null;
        BasicType type = new VoidType();
        if(!stack.isEmpty() && stack.peek() instanceof BasicType) type = (BasicType)stack.pop();

        Symbol symbol = Symbol.symbol(ctx.ID().getText());
    //    System.out.println(symbol.toString());
        FuncDec funcdec = new FuncDec(type, symbol, compoundVarDec, compoundStmt);
        stack.push(funcdec);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitOnetype(zzzParser.OnetypeContext ctx) {
    //    System.out.println(ctx.ID().toString());
        Symbol symbol = Symbol.symbol(ctx.ID().getText());
        BasicType type = (BasicType)stack.pop();
        VarDec vardec = new VarDec(type, symbol);
        CompoundVarDec compoundVarDec = new CompoundVarDec();
        compoundVarDec.vardeclist.add(vardec);
        stack.push(compoundVarDec);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitMultitype(zzzParser.MultitypeContext ctx) {
    //    System.out.println(ctx.ID().toString());
        BasicType type = (BasicType)stack.pop();
        Symbol symbol = Symbol.symbol(ctx.ID().getText());
        VarDec varDec = new VarDec(type, symbol);
        CompoundVarDec compoundVarDec = (CompoundVarDec)stack.pop();
     //   while(compoundVarDec.vardeclist.size()!=0){
      //      compoundVarDec1.vardeclist.add(compoundVarDec.vardeclist.getFirst());
        //    compoundVarDec.vardeclist.pop();
        //}
        compoundVarDec.vardeclist.add(varDec);
        stack.push(compoundVarDec);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitBlock_stmt(zzzParser.Block_stmtContext ctx) { }

    @Override public void exitOnestmt(zzzParser.OnestmtContext ctx) {
        Stmt stmt = (Stmt)stack.pop();
        CompoundStmt compoundStmt = new CompoundStmt();
        compoundStmt.stmtlist.add(stmt);
        stack.push(compoundStmt);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitMultiplystmt(zzzParser.MultiplystmtContext ctx) {
        Stmt stmt = (Stmt)stack.pop();
        CompoundStmt compoundStmt = (CompoundStmt)stack.pop();
        compoundStmt.stmtlist.add(stmt);
        stack.push(compoundStmt);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitProgram(zzzParser.ProgramContext ctx) {
     //   System.out.print("Prog");
        Prog prog = new Prog();
        LinkedList<Dec> dec = new LinkedList<Dec>();
        while(!stack.empty()){
            prog.declist.addFirst((Dec)stack.peek());
        //    System.out.println(stack.peek().toString(0));
            stack.pop();
        }
        stack.push(prog);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitArraytype(zzzParser.ArraytypeContext ctx) {
        stack.push(new ArrayType((BasicType)stack.pop()));
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitOnlyonetype(zzzParser.OnlyonetypeContext ctx) { }

    @Override public void exitInt(zzzParser.IntContext ctx) {
        IntType inttype = new IntType();
        stack.push(inttype);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitString(zzzParser.StringContext ctx) {
        StringType stringtype = new StringType();
        stack.push(stringtype);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitBool(zzzParser.BoolContext ctx) {
        BoolType booltype = new BoolType();
        stack.push(booltype);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }

    @Override public void exitId(zzzParser.IdContext ctx) {
        Symbol symbol = Symbol.symbol(ctx.getText());
        ClassType classtype = new ClassType(symbol);
        stack.push(classtype);
        stack.peek().info = new ErrorInfo(ctx.getStart().getLine(),ctx.getStart().getCharPositionInLine());
    }
}
