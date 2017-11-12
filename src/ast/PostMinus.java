package ast;

import IR.*;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/3.
 */
public class PostMinus extends Exp {
    public Exp exp;
    public PostMinus(Exp aexp){
        exp = aexp;
    }

    @Override
    public String toString(int d) {
        return indent(d) + "PostMinus\n" + exp.toString(d+1);
    }
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope) {
        if(!exp.round_3(table,funcDec,stack,scope)){
            outputerrorinfo();
            return false;
        }
        if(!(exp.exptype instanceof IntType)){
            outputerrorinfo();
            return false;
        }
        exptype = exp.exptype;
        Islvalue = false;
        return true;
    }

    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        Address address = exp.getAddress(pos, table, list, begin, end);
        Temp temp = new Temp();
        if(address instanceof Temp){
            list.add(new Assign(temp, address));
        }
        else{
            list.add(new MemoryRead(temp,((Memory)address).offset, ((Memory)address).temp));
        }
        if(address instanceof Temp){
            list.add(new ArithmeticExpr(address, temp, ArithmeticOp.SUB, new IntegerConst(1)));
        }
        else{
            Temp temp0 = new Temp();
            list.add(new ArithmeticExpr(temp0, temp, ArithmeticOp.SUB, new IntegerConst(1)));
            list.add(new MemoryWrite(((Memory)address).temp, ((Memory)address).offset, temp0));
        }
        return temp;
    }
}
