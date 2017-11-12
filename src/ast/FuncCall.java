package ast;

import IR.*;
import javafx.util.Pair;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class FuncCall extends Exp{
    public Symbol name;
    public CompoundParam compoundparam;

    public FuncCall(Symbol aname){
        name = aname;
        compoundparam = null;
    }
    public FuncCall(Symbol aname, CompoundParam acompoundparam){
        name = aname;
        compoundparam = acompoundparam;
    }

    @Override
    public String toString(int d) {
        String string = "";
        string = string + name.toString(d + 1);
        if(compoundparam != null) string = string + compoundparam.toString(d + 1);
        return indent(d) + "FuncCall\n" + string;
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope) {
        Object object = table.get(name);
        if (object != null) {
            if (!(((Pair<Object, Integer>)table.get(name)).getKey() instanceof FuncDec)) {
                outputerrorinfo();
                return false;
            }
        }
        FuncDec funcDec1 = null;
        if(table.get(name) != null)
            funcDec1 = (FuncDec)((Pair)table.get(name)).getKey();
        if(funcDec1 == null){
            outputerrorinfo();
            return false;
        }
        if (funcDec1 != null && funcDec1.compoundvardec != null) {
            if (!compoundparam.round_3(table, funcDec1, stack, scope)) {
                outputerrorinfo();
                return false;
            }
        }
        if (funcDec1 != null) {
            String string = name.toString();
            if (string.equals("print")|| string.equals("println")) {
                if (compoundparam.explist.size() != 1) {
                    outputerrorinfo();
                    return false;
                }
                if(!(compoundparam.explist.get(0).exptype instanceof StringType)){
                    outputerrorinfo();
                    return false;
                }
            }

            if (string.equals("getString") || string.equals("getInt")) {
                if (compoundparam.explist.size() != 0) {
                    outputerrorinfo();
                    return false;
                }
            }

            if (string.equals("toString") ) {
                if (compoundparam.explist.size() != 1) {
                    outputerrorinfo();
                    return false;
                }
                if(!(compoundparam.explist.get(0).exptype instanceof IntType)){
                    outputerrorinfo();
                    return false;
                }
            }
        }
        else if(table.get(funcDec1.name) == null) {outputerrorinfo(); return false;}
        exptype = funcDec1.type;
        Islvalue = false;
        return true;
    }

    public Address translate(Table pos, Table table, ArrayList<Quadruple> list, Label begin, Label end) {
        Temp rt = new Temp();
        ArrayList<Address> arg = new ArrayList<Address>();
        Pair<ast, Integer> now = (Pair<ast, Integer>)table.get(name);
        if(compoundparam != null){
            for(Exp exp : compoundparam.explist){
                arg.add(exp.translate(pos, table, list, begin, end));
            }
        }
        if (((FuncDec)((Pair)table.get(name)).getKey()).type instanceof VoidType)
            list.add(new Call(null, ((FuncDec)((Pair)table.get(name)).getKey()).save, ((FuncDec)((Pair)table.get(name)).getKey()).name.toString(), arg));
        else
            list.add(new Call(rt, ((FuncDec)((Pair)table.get(name)).getKey()).save, ((FuncDec)((Pair)table.get(name)).getKey()).name.toString(), arg));
        return rt;
    }
}
