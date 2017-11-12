package ast;

import IR.*;
import javafx.util.Pair;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/3.
 */
public class ClassAccess extends Exp{
    public Exp exp;
    public Symbol symbol;
    public CompoundParam compoundParam;
    public ClassAccess(Exp aexp, Symbol asymbol){
        exp = aexp;
        symbol = asymbol;
        compoundParam = null;
    }
    public ClassAccess(Exp aexp, Symbol asymbol, CompoundParam acompoundParam){
        exp = aexp;
        symbol = asymbol;
        compoundParam = acompoundParam;
    }

    @Override
    public String toString(int d) {
        String string = "";
        string = string + exp.toString(d+1) + symbol.toString(d+1);
        if(compoundParam != null) string = string + compoundParam.toString(d+1);
        return indent(d) + "ClassAccess\n" + string;
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope) {

        if(!exp.round_3(table, funcDec, stack, scope)){

            outputerrorinfo();
            return false;
        }

        if(exp.exptype instanceof StringType){

            if(symbol.toString().equals("length")){
                if(compoundParam.explist.size() != 0){
                    outputerrorinfo();
                    return false;
                }
                exptype = new IntType();
                return true;
            }
            if(symbol.toString().equals("substring")){

                if(compoundParam.explist.size() != 2){
                    outputerrorinfo();
                    return false;
                }

                if(!compoundParam.explist.get(0).round_3(table,funcDec,stack, scope) ||
                        !compoundParam.explist.get(1).round_3(table, funcDec, stack, scope)){
                    outputerrorinfo();
                    return false;
                }
                if(!(compoundParam.explist.get(0).exptype instanceof IntType) ||
                        !(compoundParam.explist.get(1).exptype instanceof IntType)){
                    outputerrorinfo();
                    return false;
                }
            //    System.out.println("wocwocwoc");
                exptype = new StringType();
                return true;
            }
            if(symbol.toString().equals("parseInt")){
                if(compoundParam.explist.size() != 0){
                    outputerrorinfo();
                    return false;
                }
                exptype = new IntType();
                return true;
            }
            if(symbol.toString().equals("ord")){
                if(compoundParam.explist.size() != 1){
                    outputerrorinfo();
                    return false;
                }
                if(!compoundParam.explist.get(0).round_3(table,funcDec,stack,scope)){
                    outputerrorinfo();
                    return false;
                }
                if(!(compoundParam.explist.get(0).exptype instanceof IntType)){
                    outputerrorinfo();
                    return false;
                }
                exptype = new IntType();
                return true;
            }
        }
        if(exp.exptype instanceof ArrayType){
            if(symbol.toString().equals("size")){
                if(compoundParam.explist.size() != 0){
                    outputerrorinfo();
                    return false;
                }
                exptype = new IntType();
                Islvalue = false;
                return true;
            }
        }

        if(exp.exptype instanceof ClassType){
            ClassDel classDel = (ClassDel) ((Pair)table.get(((ClassType) exp.exptype).symbol)).getKey();
            boolean bool = false;
            for(VarDec varDec : classDel.compoundVarDec.vardeclist){
                if(varDec.name.equals(symbol)){
                    bool = true;
                    exptype = varDec.type;
                    Islvalue = true;
                    break;
                }
            }
            if(!bool){
                outputerrorinfo();
                return false;
            }
        }
        else{
            outputerrorinfo();
            return false;
        }
        return true;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        if(symbol.toString().equals("length")){
            Temp temp = new Temp();
            ArrayList<Address> list1 = new ArrayList<Address>();
            list1.add(exp.translate(pos, table, list, begin, end));
            list.add(new Call(temp, null, "length", list1));
            return temp;
        }
        if(symbol.toString().equals("substring")){
            Temp temp = new Temp();
            ArrayList<Address> list1 = new ArrayList<Address>();
            list1.add(exp.translate(pos, table, list, begin, end));
            for(int i = 0; i < compoundParam.explist.size(); i++){
                list1.add(compoundParam.explist.get(i).translate(pos, table, list, begin, end));
            };
            list.add(new Call(temp, null, "substring", list1));
            return temp;
        }
        if(symbol.toString().equals("parseInt")){
            Temp temp = new Temp();
            ArrayList<Address> list1 = new ArrayList<Address>();
            Address address00 = exp.translate(pos, table, list, begin, end);
            list1.add(address00);
            for(int i = 0; i < compoundParam.explist.size(); i++){
                list1.add(compoundParam.explist.get(i).translate(pos, table, list, begin, end));
            };
            list.add(new Call(temp, null, "parseInt", list1));
            return temp;
        }
        if(symbol.toString().equals("size")){
            Temp temp = new Temp();
            ArrayList<Address> list1 = new ArrayList<Address>();
            list1.add(exp.translate(pos, table, list, begin, end));
            for(int i = 0; i < compoundParam.explist.size(); i++){
                list1.add(compoundParam.explist.get(i).translate(pos, table, list, begin, end));
            };
            list.add(new Call(temp, null, "size", list1));
            return temp;
        }
        if(symbol.toString().equals("ord")){
            Temp temp = new Temp();
            ArrayList<Address> list1 = new ArrayList<Address>();
            list1.add(exp.translate(pos, table, list, begin, end));
            for(int i = 0; i < compoundParam.explist.size(); i++){
                list1.add(compoundParam.explist.get(i).translate(pos, table, list, begin, end));
            };
            list.add(new Call(temp, null, "ord", list1));
            return temp;
        }
        Address address = exp.translate(pos,table,list,begin, end);
        Temp temp = new Temp();
        ClassType type = (ClassType) exp.exptype;
        ClassDel classDel = (ClassDel) ((Pair)table.get(type.symbol)).getKey();
        int size = 0;
        for(VarDec varDec : classDel.compoundVarDec.vardeclist){
            if(varDec.name.toString() == symbol.toString())
                break;
            else size++;
        }
        list.add(new MemoryRead(temp, new IntegerConst(size * 4), address));
        return temp;
    }
    public Address getAddress(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        if(symbol.toString().equals("length")){
            Temp temp = new Temp();
            ArrayList<Address> list1 = new ArrayList<Address>();
            list1.add(exp.translate(pos, table, list, begin, end));
            list.add(new Call(temp, null, "length", list1));
            return temp;
        }
        if(symbol.toString().equals("substring")){
            Temp temp = new Temp();
            ArrayList<Address> list1 = new ArrayList<Address>();
            list1.add(exp.translate(pos, table, list, begin, end));
            for(int i = 0; i < compoundParam.explist.size(); i++){
                list1.add(compoundParam.explist.get(i).translate(pos, table, list, begin, end));
            };
            list.add(new Call(temp, null, "substring", list1));
            return temp;
        }
        if(symbol.toString().equals("parseInt")){
            Temp temp = new Temp();
            ArrayList<Address> list1 = new ArrayList<Address>();
            list1.add(exp.translate(pos, table, list, begin, end));
            for(int i = 0; i < compoundParam.explist.size(); i++){
                list1.add(compoundParam.explist.get(i).translate(pos, table, list, begin, end));
            };
            list.add(new Call(temp, null, "parseInt", list1));
            return temp;
        }
        if(symbol.toString().equals("size")){
            Temp temp = new Temp();
            ArrayList<Address> list1 = new ArrayList<Address>();
            list1.add(exp.translate(pos, table, list, begin, end));
            for(int i = 0; i < compoundParam.explist.size(); i++){
                list1.add(compoundParam.explist.get(i).translate(pos, table, list, begin, end));
            };
            list.add(new Call(temp, null, "size", list1));
            return temp;
        }
        if(symbol.toString().equals("ord")){
            Temp temp = new Temp();
            ArrayList<Address> list1 = new ArrayList<Address>();
            list1.add(exp.translate(pos, table, list, begin, end));
            for(int i = 0; i < compoundParam.explist.size(); i++){
                list1.add(compoundParam.explist.get(i).translate(pos, table, list, begin, end));
            };
            list.add(new Call(temp, null, "ord", list1));
            return temp;
        }
        Address address = exp.translate(pos,table,list,begin, end);
        ClassType type = (ClassType) exp.exptype;
        ClassDel classDel = (ClassDel) ((Pair)table.get(type.symbol)).getKey();
        int size = 0;
        for(VarDec varDec : classDel.compoundVarDec.vardeclist){
            if(varDec.name.toString() == symbol.toString())
                break;
            else size++;
        }
        return new Memory(address, new IntegerConst(size * 4));
    }
}
