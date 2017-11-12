package ast;

import IR.Address;
import IR.Label;
import IR.Quadruple;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/3.
 */
public class CompoundVarDecStmt extends Stmt{
    public LinkedList<VarDecStmt> vardeclist;
    public CompoundVarDecStmt(){
        vardeclist = new LinkedList<VarDecStmt>();
    }
    public CompoundVarDecStmt(LinkedList<VarDecStmt> avardeclist){
        vardeclist = avardeclist;
    }

    @Override
    public String toString(int d) {
        String string = "";
        for (VarDecStmt varDec : vardeclist) {
            string = string + varDec.toString(d + 1);
        }
        return indent(d) + "CompoundVarDecStmt\n" + string;
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope) {

        for(VarDecStmt varDec : vardeclist){
            if(!varDec.round_3(table,funcDec,stack,scope)){
                outputerrorinfo();
                return false;
            }
        }
        return true;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple> list, Label begin, Label end){
        for(VarDecStmt varDecStmt : vardeclist){
            varDecStmt.translate(pos, table, list, begin, end);
        }
        return null;
    }
}
