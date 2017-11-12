package ast;

import IR.Address;
import IR.Label;
import IR.Quadruple;
import javafx.util.Pair;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class ArrayType extends BasicType{
    public BasicType baseType;
    public Exp arraySize;
    public ArrayType() {
        baseType = null;
        arraySize = null;
    }
    public ArrayType(BasicType abaseType) {
        baseType = abaseType;
        arraySize = null;
    }
    public ArrayType(BasicType abaseType, Exp aarraySize) {
        baseType = abaseType;
        arraySize = aarraySize;
    }

    @Override
    public String toString(int d) {
        String string = "";
        string = string + baseType.toString(d + 1);
        if(arraySize != null) string = string + arraySize.toString(d + 1);
        return indent(d) + "ArrayType\n" + string;
    }
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast>stack, int scope){
        if(arraySize.round_3(table,funcDec,stack, scope)){
            outputerrorinfo();
            return false;
        }
        if(!(arraySize.exptype instanceof IntType)){
        //    System.out.println("arraySize is not Int!\n" + this.info.toString() + this.toString(0));
            outputerrorinfo();
            return false;
        }
        if(!baseType.round_3(table, funcDec, stack, scope)){
            outputerrorinfo();
            return false;
        }
        if(baseType instanceof ClassType){
            if(((Pair)table.get(((ClassType) baseType).symbol)).getKey() == null){
                outputerrorinfo();
                return false;
            }
        }
        return true;
    }
    public Address getSize(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        if(arraySize != null)
            return arraySize.translate(pos, table, list, begin, end);
        return baseType.getSize(pos, table, list, begin, end);
    }
}
