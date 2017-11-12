package ast;

import IR.*;
import javafx.util.Pair;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class CreationExp extends Exp{
    public BasicType type;
    public CreationExp(BasicType atype) {
        type = atype;
    }

    @Override
    public String toString(int d) {
        return indent(d) + "CreationExp\n" + type.toString(d+1);
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope) {

        if(type instanceof ArrayType){
            BasicType type1 = type;
            while(type1 instanceof ArrayType){

                if(!(((ArrayType) type1).baseType instanceof ArrayType)){
                    if(((ArrayType) type1).arraySize == null){
                        outputerrorinfo();
                        return false;
                    }
                }
                type1 = ((ArrayType) type1).baseType;
            }
            if(type1 instanceof ClassType){
                if (((Pair)table.get(((ClassType) type1).symbol)).getKey() == null){

                    outputerrorinfo();
                    return false;
                }
            }
        }
        if(type instanceof ClassType){
            if(table.get(((ClassType) type).symbol) == null){
                outputerrorinfo();
                return false;
            }
        }
        exptype = type;
        Islvalue = false;
        return true;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        if(type instanceof ClassType){
            Address address = ((ClassType) type).getSize(pos, table, list, begin, end);
            Address temp = new Temp();
            list.add(new ArithmeticExpr(temp, address, ArithmeticOp.MUL, new IntegerConst(4)));
            Address dest = new Temp();
            list.add(new Allocate(dest, temp));
            return dest;
        }
        else{
            Address address = ((ArrayType)type).getSize(pos, table, list, begin, end);
            Address temp = new Temp();
            list.add(new ArithmeticExpr(temp, address, ArithmeticOp.ADD, new IntegerConst(1)));
            Address temp1 = new Temp();
            list.add(new ArithmeticExpr(temp1, temp, ArithmeticOp.MUL, new IntegerConst(4)));
            Address temp2 = new Temp();
            list.add(new Allocate(temp2, temp1));
            //list.add(new MemoryWrite())
            list.add(new MemoryWrite(temp2, new IntegerConst(0), address));
            return temp2;
        }
    }
}
