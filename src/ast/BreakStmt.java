package ast;

import IR.Address;
import IR.Goto;
import IR.Label;
import IR.Quadruple;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class BreakStmt extends Stmt{
    @Override
    public String toString(int d) {
        return indent(d) + "break\n";
    }

    public boolean round_3(Table table, FuncDec funcDec, Stack<ast>stack, int scope){
        if(stack.isEmpty()){
            outputerrorinfo();
            return false;
        }
        return true;
    }

    public Address translate(Table pos, Table tabel, ArrayList<Quadruple> list, Label begin, Label end){
        list.add(new Goto(end));
        return null;
    }
}
