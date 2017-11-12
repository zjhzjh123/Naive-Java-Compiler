package ast;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
import IR.*;

import java.util.ArrayList;
import java.util.Stack;
public class WhileStmt extends Stmt{
    public Exp condition;
    public Stmt stmt;
    public WhileStmt(Exp acondition, Stmt astmt){
        condition = acondition;
        stmt = astmt;
    }

    @Override
    public String toString(int d) {
        String string = "";
        string = string + condition.toString(d+1);
        if(stmt != null) string += stmt.toString(d+1);
        return indent(d) + "WhileStmt\n" + string;
    }

    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope){
        stack.push(this);
        table.beginScope();
        scope++;
        if(condition == null){
            outputerrorinfo();
            return false;
        }
        if(!condition.round_3(table,funcDec,stack, scope)){
            outputerrorinfo();
            return false;
        }
        if(!(condition.exptype instanceof BoolType)){
            outputerrorinfo();
            return false;
        }
        else if(stmt != null){
            if(!stmt.round_3(table, funcDec, stack, scope)){
                outputerrorinfo();
                return false;
            }
        }
        scope--;
        table.endScope();
        stack.pop();
        return true;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end) {
        Label label1 = new Label();
        Label label2 = new Label();
        Label label3 = new Label();
        list.add(new Goto(label1));
        list.add(label1);
        if (condition != null) {
            list.add(new Branch(condition.translate(pos, table, list, begin, end), label2, label3));
        }
        list.add(label2);
        pos.beginScope();
        stmt.translate(pos, table, list, label1, label3);
        pos.endScope();
        list.add(new Goto(label1));
        list.add(label3);
        return null;
    }
}
