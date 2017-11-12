package ast;

import IR.*;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class UnaryExp extends Exp {
    public Exp num;
    public UnaryOp unaryop;
    public UnaryExp(Exp anum, UnaryOp aunaryop){
        num = anum;
        unaryop = aunaryop;
    }

    @Override
    public String toString(int d) {
        return indent(d) + "UnaryExp\n" + num.toString(d+1) + indent(d+1) + unaryop.toString() + "\n";
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope) {
        if(!num.round_3(table,funcDec,stack,scope)){
            outputerrorinfo();
            return false;
        }
        if (unaryop == UnaryOp.add_add_op ||
                unaryop == UnaryOp.minus_minus_op) {
            if (!num.Islvalue) {
                outputerrorinfo();
                return false;
            }
            if (!(num.exptype instanceof IntType)) {
                outputerrorinfo();
               return false;
            }
            exptype = num.exptype;
            Islvalue = false;
        }

        if (unaryop == UnaryOp.add_op ||
                unaryop == UnaryOp.minus_op ||
                unaryop == UnaryOp.delete_op) {
            if (!(num.exptype instanceof IntType)) {
                outputerrorinfo();
                return false;
            }
            exptype = num.exptype;
            Islvalue = false;
        }

        if (unaryop == UnaryOp.non_op) {
            if (!(num.exptype instanceof BoolType)) {
                outputerrorinfo();
                return false;
            }
            exptype = num.exptype;
            Islvalue = false;
        }

        return true;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        if(unaryop == UnaryOp.add_add_op){
            Address address = num.getAddress(pos, table, list, begin, end);
            if(address instanceof Temp){
                list.add(new ArithmeticExpr(address, address, ArithmeticOp.ADD, new IntegerConst(1)));
                return address;
            }
            else{
                Temp temp = new Temp();
                list.add(new MemoryRead(temp, ((Memory)address).offset, ((Memory)address).temp));
                list.add(new ArithmeticExpr(temp, temp, ArithmeticOp.ADD, new IntegerConst(1)));
                list.add(new MemoryWrite(((Memory)address).temp, ((Memory)address).offset, temp));
                return temp;
            }
        }
        if(unaryop == UnaryOp.minus_minus_op){
            Address address = num.getAddress(pos, table, list, begin, end);
            if (address instanceof Temp){
                list.add(new ArithmeticExpr(address, address, ArithmeticOp.SUB, new IntegerConst(1)));
                return address;
            }
            else {
                Temp temp = new Temp();
                list.add(new MemoryRead(temp, ((Memory)address).offset,((Memory)address).temp));
                list.add(new ArithmeticExpr(temp, temp, ArithmeticOp.SUB, new IntegerConst(1)));
                list.add(new MemoryWrite(((Memory)address).temp, ((Memory)address).offset, temp));
                return temp;
            }
        }
        Address src = num.translate(pos, table, list, begin, end);
        if (unaryop == UnaryOp.add_op) {
            return src;
        }
        Address dest;
        if (unaryop == UnaryOp.minus_op) {
            if(src instanceof IntegerConst)
                return new IntegerConst(-(((IntegerConst) src).value));
            else {
                dest = new Temp();
                list.add(new ArithmeticExpr(dest, ArithmeticOp.MINUS, src));
            }
            return dest;
        }
        if (unaryop == UnaryOp.delete_op) {
            if(src instanceof IntegerConst)
                return new IntegerConst(-(((IntegerConst) src).value));
            else {
                dest = new Temp();
                list.add(new ArithmeticExpr(dest, ArithmeticOp.TILDE, src));
            }
            return dest;
        }
        if (unaryop == UnaryOp.non_op) {
            if(src instanceof IntegerConst){
                if(((IntegerConst)src).value != 0){
                    return new IntegerConst(0);
                }
                else{
                    return new IntegerConst(1);
                }
            }
            else {
                dest = new Temp();
                list.add(new ArithmeticExpr(dest, src, ArithmeticOp.XOR, new IntegerConst(1)));
            }
            return dest;
        }
        return null;
    }
}
