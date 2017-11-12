package ast;

import IR.*;
import cfg.FunctionCFG;
import javafx.util.Pair;
import translate.Translate;

import java.util.ArrayList;
import java.util.Stack;



/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class FuncDec extends Dec{
    public static FuncDec instance;

    public BasicType type;
    public Symbol name;
    public CompoundVarDec compoundvardec;
    public CompoundStmt compoundstmt;
    public Function save;

    public FuncDec() {
        type = null;
        name = null;
        compoundvardec = null;
        compoundstmt = null;
    }
    public FuncDec(BasicType atype, Symbol astring, CompoundVarDec acompoundvardec1, CompoundStmt acompoundstmt) {
        type = atype;
        name = astring;
        compoundvardec = acompoundvardec1;
        compoundstmt = acompoundstmt;
    }

    @Override
    public String toString(int d) {
        String string = "";
        string = string + type.toString(d+1) + name.toString(d+1);
        if(compoundvardec != null) string += compoundvardec.toString(d+1);
        if(compoundstmt != null) string += compoundstmt.toString(d+1);
        return indent(d) + "FuncDec\n" + string;
    }
    public boolean round_2(Table table) {
        if (name.toString().equals("main")) {
            if (!(type instanceof IntType)) {
                outputerrorinfo();
                return false;
            }
            if (compoundvardec != null) {
                outputerrorinfo();
                return false;
            }
        }

        if (type instanceof ClassType){
            if(table.get(((ClassType) type).symbol) == null){
                outputerrorinfo();
                return false;
            }
        }

        if (table.get(name) != null) {
            outputerrorinfo();
            return false;
        }

        table.put(name, new Pair<>(this, scope));
        return true;
    }
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast>stack, int scope){
        table.beginScope();
        scope++;
        if(compoundvardec != null){
            if(!compoundvardec.round_3(table, this, stack, scope)){
                outputerrorinfo();
                return false;
            }
        }
        if(compoundstmt != null){
            if(!compoundstmt.round_3(table, this, stack, scope)){
                outputerrorinfo();
                return false;
            }
        }
        scope--;
        table.endScope();
        return true;
    }

    public Function getvalue(Table pos, Table table){
        FuncDec.instance = this;

        Temp.clear();
        pos.beginScope();
        Function function = new Function();
        save = function;
        function.name = name.toString();
        Label label = new Label();
        function.begin = label;
        Label label1 = new Label();
        function.end = label1;
//        function.body.add(new Goto(label));
        function.body.add(label);

        if (name.toString().equals("main")) {
            for (Dec dec : Prog.program.declist) {
                if (dec instanceof VarDec) {
                    Temp temp = (Temp) pos.get(((VarDec) dec).name);
                    if (((VarDec) dec).exp != null)
                        function.body.add(new Assign(temp, ((VarDec) dec).exp.translate(pos, table, function.body, null, null)));
                }
            }
        }

        if(compoundvardec != null){
            compoundvardec.addto(pos, table, function.args);
        }
        compoundstmt.translate(pos, table, function.body, null, null);
        pos.endScope();
//        function.body.add(new Goto(label1));
        function.body.add(label1);
        function.cfg = new FunctionCFG(function);
        function.tempnum = Temp.tempCount;
        return function;
    }
}
