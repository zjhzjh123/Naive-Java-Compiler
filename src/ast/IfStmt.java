package ast;

import IR.*;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class IfStmt extends Stmt{
    public Exp condition;
    public Stmt result;
    public Stmt alternative;
    public IfStmt(Exp acondition, Stmt aresult){
        condition = acondition;
        result = aresult;
        alternative = null;
    }
    public IfStmt(Exp acondition, Stmt aresult, Stmt aalternative){
        condition = acondition;
        result = aresult;
        alternative = aalternative;
    }
    public String toString(int d) {
        String string = indent(d) + "IfStmt\n" + condition.toString(d + 1);
        if (result != null) {
            string += result.toString(d + 1);
        }
        if (alternative != null)
            string += alternative.toString(d + 1);
        return string;
    }
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast>stack, int scope){
        if(condition == null){
            outputerrorinfo();
            return false;
        }

        if(!condition.round_3(table, funcDec, stack, scope)){
        //    System.out.println("fuccccc");
            outputerrorinfo();
            return false;
        }
        else if(!(condition.exptype instanceof BoolType)){
        //    System.out.println("zzzzzzzz");
            outputerrorinfo();
            return false;
        }
    //    System.out.println("zhangjiaheng");
        if(result != null){
            table.beginScope();
            scope++;
            if(!result.round_3(table,funcDec,stack, scope)){
                outputerrorinfo();
                return false;
            }
            scope--;
            table.endScope();
        }
    //    System.out.println("zhangjiaheng");
        if(alternative != null){
            table.beginScope();
            scope++;
            if(!alternative.round_3(table, funcDec, stack, scope)){
                outputerrorinfo();
                return false;
            }
            scope--;
            table.endScope();
        }
        return true;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple> list, Label begin, Label end) {
        if(alternative == null){
            Label label1 = new Label();
            Label label2 = new Label();
            if (condition != null) {
                list.add(new Branch(condition.translate(pos, table, list, begin, end), label1, label2));
            }
            list.add(label1);
            pos.beginScope();
            result.translate(pos, table, list, begin, end);
            pos.endScope();
            list.add(new Goto(label2));
            list.add(label2);
            return null;
        }
        else{
            Label label1 = new Label();
            Label label2 = new Label();
            Label label3 = new Label();
            if (condition != null) {
                list.add(new Branch(condition.translate(pos, table, list, begin, end), label1, label2));
            }
            list.add(label1);
            pos.beginScope();
            result.translate(pos, table, list, begin, end);
            pos.endScope();
            list.add(new Goto(label3));
            list.add(label2);
            pos.beginScope();
            alternative.translate(pos, table, list, begin, end);
            pos.endScope();
            list.add(new Goto(label3));
            list.add(label3);
            return null;
        }
    }
}
