package ast;

import IR.*;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class ReturnStmt extends Stmt{
    public Exp result;
    public ReturnStmt() {
        result = null;
    }
    public ReturnStmt(Exp aresult) {
        result = aresult;
    }

    @Override
    public String toString(int d) {
        String string = "";
        if(result != null) string = string + result.toString(d+1);
        return indent(d) + "ReturnStmt\n" + string;
    }
    public boolean round_3(Table table,FuncDec funcDec, Stack<ast>stack, int scope){

        if(funcDec == null){
            outputerrorinfo();
            return false;
        }

        if(result != null){

            if(!result.round_3(table,funcDec,stack,scope)){return false;}
            if(!typeCompare(funcDec.type, result.exptype)){
                outputerrorinfo();
                return false;
            }
        }
        if(result == null){
            if(!(funcDec.type instanceof VoidType)){
                outputerrorinfo();
                return false;
            }
        }
        return true;
    }

    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        if(result != null) list.add(new Return(result.translate(pos, table, list, begin, end)));
        else list.add(new Return());
        list.add(new Goto(FuncDec.instance.save.end));
        return null;
    }
}
