package ast;

import IR.Address;
import IR.IntegerConst;
import IR.Label;
import IR.Quadruple;
import javafx.util.Pair;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */

public class ClassDel extends Dec{
    public Symbol name;
    public CompoundVarDec compoundVarDec;
    public ClassDel(Symbol aname, CompoundVarDec acompoundVarDec){
        name = aname;
        compoundVarDec = acompoundVarDec;
    }

    @Override
    public String toString(int d) {
        String string = "";
        string = string + name.toString(d + 1);
        if(compoundVarDec != null) string = string + compoundVarDec.toString(d + 1);
        return indent(d) + "ClassDec\n" + string;
    }
    public boolean round_1(Table table) {
        if (table.get(name) != null) {
            outputerrorinfo();
            return false;
        }
        table.put(name, new Pair<>(this, scope));
        return true;
    }

    public boolean round_3(Table table, FuncDec funcDec, Stack<ast>stack, int scope) {
        table.beginScope();
        scope++;
        if (compoundVarDec != null){
            if(!compoundVarDec.round_3(table, funcDec, stack, scope)) {
                outputerrorinfo();
                return false;
            }
        };
        scope--;
        table.endScope();
        return true;
    }
    public Address getSize(){
        return new IntegerConst(compoundVarDec.vardeclist.size());
    }
}
