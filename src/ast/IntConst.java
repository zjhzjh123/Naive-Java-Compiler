package ast;

import IR.Address;
import IR.IntegerConst;
import IR.Label;
import IR.Quadruple;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class IntConst extends Exp{
    public BigInteger value;
    public IntConst(BigInteger avalue){
        value = avalue;
    }

    @Override
    public String toString(int d) {
        return indent(d) + "IntConst\n" + indent(d+1) + value + "\n";
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope) {
        exptype = new IntType();
        Islvalue = false;
        return true;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        return new IntegerConst(value.intValue());
    }
}
