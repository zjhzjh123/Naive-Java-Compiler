package ast;

import IR.*;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class VarDecStmt extends Stmt {
    public VarDec vardec;
    public VarDecStmt(VarDec avardec){
        vardec = avardec;
    }

    @Override
    public String toString(int d) {
        return indent(d) + "VarDecStmt\n" + vardec.toString(d+1);
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope) {
        if(!vardec.round_3(table, funcDec, stack, scope)){
            return false;
        }
        return true;
    }

    public Address translate(Table pos, Table table, ArrayList<Quadruple> list, Label begin, Label end){
        return vardec.translate(pos,table,list, begin, end);
    }
}
