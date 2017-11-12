package ast;

import IR.*;
import javafx.util.Pair;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class VarDec extends Dec{
    public BasicType type;
    public Symbol name;
    public Exp exp;
    public VarDec(){
        type = null;
        name = null;
        exp = null;
    }
    public VarDec(BasicType atype, Symbol aname){
        type = atype;
        name = aname;
        exp = null;
    }
    public VarDec(BasicType atype, Symbol aname, Exp aexp){
        type = atype;
        name = aname;
        exp = aexp;
    }

    @Override
    public String toString(int d) {
        String string = "";
        if(type != null) string += type.toString(d+1);
        if(name != null) string += name.toString(d+1);
        if(exp != null) string += exp.toString(d+1);
        return indent(d) + "VarDec\n" + string;
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope) {
        if(exp != null && !exp.round_3(table,funcDec,stack, scope)){
            outputerrorinfo();
            return false;
        }
        if(type instanceof VoidType){
            outputerrorinfo();
            return false;
        }
        if(type instanceof StringType){
            if(exp != null && !exp.round_3(table, funcDec, stack, scope)){
                outputerrorinfo();
                return false;
            }
            if(exp != null && exp instanceof NullConst){
                outputerrorinfo();
                return false;
            }
        }
        if (type instanceof ClassType) {
            if (table.get(((ClassType) type).symbol) == null) {
                outputerrorinfo();
                return false;
            }
        }
        else if (type instanceof ArrayType) {

            BasicType type1 = type;
            if (type1 instanceof ClassType) {
                if (table.get(((ClassType) type1).symbol) == null) {
                    outputerrorinfo();
                    return false;
                }
            }
            int num = 0;
            while (type1 instanceof ArrayType) {
                type1 = ((ArrayType) type1).baseType;
                if(type1 instanceof ClassType){
                    if(table.get(((ClassType) type1).symbol)== null){
                        outputerrorinfo();
                        return false;
                    }
                }
            }
        }
        if(table.get(name) != null && ((Pair)table.get(name)).getValue().equals(scope)) {
            outputerrorinfo();
            return false;
        }
        table.put(name, new Pair<>(this, scope));
        return true;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        Address rt = new Temp();
        pos.put(name, rt);
        if(exp != null) list.add(new Assign(rt, exp.translate(pos, table, list, begin, end)));
        return rt;
    }

    public void addto(Table pos, Table table, ArrayList<Address> args) {
        Temp temp = new Temp();
        args.add(temp);
        temp.isParam = true;
        pos.put(name, temp);
    }
}
