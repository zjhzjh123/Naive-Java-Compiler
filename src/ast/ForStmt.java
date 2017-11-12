package ast;

import IR.*;
import javafx.geometry.Pos;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class ForStmt extends Stmt{
    public Exp initcondition;
    public Exp endcondition;
    public Exp itecondition;
    public Stmt stmt;
    public ForStmt(Exp ainitcondition, Exp aendcondition, Exp aitecondition, Stmt astmt){
        initcondition = ainitcondition;
        endcondition = aendcondition;
        itecondition = aitecondition;
        stmt = astmt;
    }

    @Override
    public String toString(int d) {
        String string = "";
        if(initcondition != null) string += initcondition.toString(d+1);
        if(endcondition != null) string += endcondition.toString(d+1);
        if(itecondition != null) string += itecondition.toString(d+1);
        return indent(d) + "ForStmt\n" + string;
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast>stack, int scope) {
        table.beginScope();
        scope++;
        stack.push(this);
        if(initcondition != null){

            if(!initcondition.round_3(table,funcDec,stack, scope)){

                outputerrorinfo();
                return false;
            }
        }
        if(endcondition != null){

            if(!endcondition.round_3(table,funcDec,stack, scope)){
                outputerrorinfo();
                return false;
            }
            if(!(endcondition.exptype instanceof BoolType)){
                outputerrorinfo();
                return false;
            }
        }
        if(itecondition != null){
        //    System.out.print("cccccccc\n");
            if(!itecondition.round_3(table,funcDec,stack, scope)){
          //      System.out.print("cccccccc");
                outputerrorinfo();
                return false;
            }
        }

        if(stmt != null){
        //    System.out.print("vvvsvsvsvsvsvsv\n");
            if(!stmt.round_3(table, funcDec, stack, scope)){
        //        System.out.print("cccccccc\n");
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
        Label label4 = new Label();
        if (initcondition != null) {
            initcondition.translate(pos, table, list, begin, end);
        }
        list.add(new Goto(label1));
        list.add(label1);
        if (endcondition != null) {
            list.add(new Branch(endcondition.translate(pos, table, list, begin, end), label2, label4));
        }
        else list.add(new Branch(new IntegerConst(1), label2, label4));
        list.add(label2);
        pos.beginScope();
        stmt.translate(pos, table, list, label3, label4);
        pos.endScope();
        list.add(label3);
        if (itecondition != null) {
            itecondition.translate(pos, table, list, begin, end);
        }
        list.add(new Goto(label1));
        list.add(label4);
        return null;
    }
}
