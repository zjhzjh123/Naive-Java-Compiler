package ast;

import IR.Address;
import IR.IntegerConst;
import IR.Label;
import IR.Quadruple;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/3.
 */
public class NullConst extends Exp{
    @Override
    public String toString(int d) {
        return indent(d) + "NullConst\n";
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope) {
        exptype = new NullType();
        Islvalue = false;
        return true;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        return new IntegerConst(0);
    }
}
