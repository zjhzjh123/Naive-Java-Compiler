package ast;

import IR.Address;
import IR.Label;
import IR.Quadruple;
import IR.Temp;
import javafx.scene.control.Tab;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */

public class CompoundParam extends Exp{
    public LinkedList<Exp> explist;
    public CompoundParam(){
        explist = new LinkedList<Exp>();
    }
    public CompoundParam(LinkedList<Exp> aexplist){
        explist = aexplist;
    }

    @Override
    public String toString(int d) {
        String string = "";
        for (Exp exp : explist) {
            string = string + exp.toString(d + 1);
        }
        return indent(d) + "CompoundParam\n" + string;
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope) {
        if(explist != null && explist.size() != funcDec.compoundvardec.vardeclist.size()) {
            outputerrorinfo();
            return false;
        }

        for(int i = 0; i < explist.size(); ++i) {
            Exp exp = explist.get(i);
            if (!exp.round_3(table, funcDec, stack, scope)) {
                outputerrorinfo();
                return false;
            }
            if(!typeCompare(exp.exptype, funcDec.compoundvardec.vardeclist.get(i).type)){
                outputerrorinfo();
                return false;
            }

        }

        return true;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        for(Exp exp : explist){
            exp.translate(pos, table, list, begin, end);
        }
        return null;
    }
}
