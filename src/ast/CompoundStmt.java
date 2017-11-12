package ast;

import IR.Address;
import IR.Label;
import IR.Quadruple;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class CompoundStmt extends Stmt{
    public LinkedList<Stmt> stmtlist;
    public CompoundStmt(){
        stmtlist = new LinkedList<Stmt>();
    }
    public CompoundStmt(LinkedList<Stmt> astmtlist){stmtlist = astmtlist;
    }

    @Override
    public String toString(int d) {
        String string = "";
        for (Stmt stmt : stmtlist) {
            if(stmt != null)string = string + stmt.toString(d + 1);
        }
        return indent(d) + "CompoundStmt\n" + string;
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope){
        table.beginScope();
        for(Stmt stmt : stmtlist){
            if(!stmt.round_3(table,funcDec,stack, scope)){
                outputerrorinfo();
                return false;
            }
        }
        table.endScope();
        return true;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        pos.beginScope();
        for(Stmt stmt : stmtlist){
            stmt.translate(pos, table, list, begin, end);
        }
        pos.endScope();
        return null;
    }
}
