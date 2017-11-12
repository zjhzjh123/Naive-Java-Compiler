package ast;

import IR.*;
import translate.Translate;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class StringConst extends Exp{
    public String string;
    public StringConst (String astring){
        string = astring;
    }

    @Override
    public String toString(int d) {
        return indent(d) + "StringConst\n" + indent(d+ 1) + string + "\n";
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope) {
        Islvalue = false;
        exptype = new StringType();
        return true;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        Temp temp = new Temp(string);
        temp.isString = true;
        Translate.strings.add(temp);
        return temp;
    }
}
