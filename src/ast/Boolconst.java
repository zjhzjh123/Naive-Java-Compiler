package ast;

import IR.*;
import javafx.scene.control.Tab;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class Boolconst extends Exp{
    public boolean bool;
    public Boolconst(boolean abool){
        bool = abool;
    }

    @Override
    public String toString(int d) {
        return indent(d) + "Boolconst\n" + indent(d+1) + bool + "\n";
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope) {
        Islvalue = false;
        exptype = new BoolType();
        return true;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        if(bool)
            return new IntegerConst(1);
        else return new IntegerConst(0);
    }
}
