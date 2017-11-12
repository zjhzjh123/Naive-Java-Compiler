package ast;

import IR.Address;
import IR.IR;
import IR.*;
import IR.Function;
import javafx.scene.control.Tab;
import translate.Translate;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class Prog extends ast {
    public static Prog program;

    public LinkedList<Dec> declist;
    public Prog() {declist = new LinkedList<Dec>();}
    public Prog(LinkedList<Dec> adeclist) {declist = adeclist;}
    public String toString(int d) {
        String string = "";
        for (Dec dec : declist) {
            string = string + dec.toString(d + 1);
        }
        return indent(d) + "CompoundVarDecStmt\n" + string;
    }
    public boolean round_1(Table table){
        for(Dec dec : declist){
            if(!dec.round_1(table)){
                outputerrorinfo();
                return false;
            }
        }
        return true;
    }
    public boolean round_2(Table table){
        for(Dec dec : declist){
            if(!dec.round_2(table)){
                outputerrorinfo();
                return false;
            }
        }
        return true;
    }
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast>stack, int scope){
        for(Dec dec : declist){
            if(!dec.round_3(table, funcDec, stack, scope)){
                outputerrorinfo();
                return false;
            }
        }
        return true;
    }

    public IR translate(Table pos, Table table){
        IR ret = new IR();
        Temp.GlobalTemp = 0;

        Translate.globals = new ArrayList<>();
        for (Dec dec : Prog.program.declist) {
            if (dec instanceof VarDec) {
                Temp temp = new Temp(((VarDec) dec).name.toString());
                temp.isGlobal = true;
                Translate.globals.add(temp);
                pos.put(((VarDec) dec).name, temp);
            }
        }
        for(Dec dec : declist){
            if(dec instanceof FuncDec){
                ret.functionArrayList.add((Function)((FuncDec) dec).getvalue(pos, table));
            }
        }
        return ret;
    }
}
