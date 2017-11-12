package ast;

import IR.*;
import javafx.scene.control.CheckBoxTreeItem;
import javafx.scene.control.Tab;

import java.lang.reflect.AccessibleObject;
import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */

public class ArrayAccess extends Exp{
    public Exp body;
    public Exp subscript;
    public ArrayAccess(){
        body = null;
        subscript = null;
    }
    public ArrayAccess(Exp abody, Exp asubscript){
        body = abody;
        subscript = asubscript;
    }

    @Override
    public String toString(int d) {
        return indent(d) + "ArrayAccess\n" + body.toString(d+1) + subscript.toString(d+1);
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope) {
        if(!(body.round_3(table,funcDec,stack,scope))){

            outputerrorinfo();
            return false;
        }
        if(!(subscript.round_3(table,funcDec,stack, scope))){

            outputerrorinfo();
            return false;
        }

        if(!(subscript.exptype instanceof IntType)){

            outputerrorinfo();
            return false;
        }
        if (body.exptype instanceof ArrayType) {
            if (subscript.exptype instanceof IntType) {
                exptype = ((ArrayType) body.exptype).baseType;
                Islvalue = true;
            } else {
                outputerrorinfo();
                return false;
            }
        } else {
            outputerrorinfo();
            return false;
        }
        return true;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        Address address1 = body.translate(pos, table, list, begin, end);
        Address address2 = subscript.translate(pos, table, list, begin, end);
        Temp temp1 = new Temp();
        Temp temp2 = new Temp();
        Temp temp = new Temp();
        list.add(new ArithmeticExpr(temp1, address2, ArithmeticOp.MUL, new IntegerConst(4)));
        list.add(new ArithmeticExpr(temp2, address1, ArithmeticOp.ADD, temp1));
        list.add(new MemoryRead(temp, new IntegerConst(4), temp2));
        return temp;
    }
    public Address getAddress(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        Address address1 = body.translate(pos, table, list, begin, end);
        Address address2 = subscript.translate(pos, table, list, begin, end);
        Temp temp1 = new Temp();
        Temp temp2 = new Temp();
        list.add(new ArithmeticExpr(temp1, address2, ArithmeticOp.MUL, new IntegerConst(4)));
        list.add(new ArithmeticExpr(temp2, address1, ArithmeticOp.ADD, temp1));
        return new Memory(temp2, new IntegerConst(4));
    }
}
