package ast;

import IR.Address;
import IR.Function;
import IR.Label;
import IR.Quadruple;


import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class CompoundVarDec extends VarDec{
    public LinkedList<VarDec> vardeclist;
    public CompoundVarDec(){
        vardeclist = new LinkedList<VarDec>();
    }
    public CompoundVarDec(LinkedList<VarDec> avardeclist){
        vardeclist = avardeclist;
    }

    @Override
    public String toString(int d) {
        String string = "";
        for (VarDec vardec : vardeclist) {
            string = string + vardec.toString(d + 1);
        }
        return indent(d) + "CompoundVarDecStmt\n" + string;
    }

    @Override

    public boolean round_3(Table table, FuncDec funcDec, Stack<ast>stack, int scope) {
        for(VarDec varDec : vardeclist){
            if(!varDec.round_3(table, funcDec, stack, scope)){
                outputerrorinfo();
                return false;
            }
        };
        return true;
    }

    public void addto(Table pos, Table table, ArrayList<Address>args){
        for(int i = 0; i < vardeclist.size(); i++){
            vardeclist.get(i).addto(pos, table, args);
        }
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        for(VarDec varDec : vardeclist){
            varDec.translate(pos, table, list, begin, end);
        }
        return null;
    }
}
