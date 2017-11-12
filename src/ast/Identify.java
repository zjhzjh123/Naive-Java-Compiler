package ast;

import IR.Address;
import IR.Label;
import IR.Quadruple;
import IR.Temp;
import javafx.util.Pair;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/3.
 */
public class Identify extends Exp{
    public Symbol symbol;
    public Identify(Symbol asymbol){
        symbol = asymbol;
    }

    @Override
    public String toString(int d) {
        return indent(d) + "Identify\n" + symbol.toString(d + 1);
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope) {
        if(table.get(symbol) == null){
            outputerrorinfo();
            return false;
        }
        ast tmp = (ast) ((Pair)table.get(symbol)).getKey();
        if(tmp instanceof VarDecStmt){
            exptype = ((VarDecStmt) tmp).vardec.type;
            Islvalue = true;
        }

        if(tmp instanceof ClassDel){
            exptype = new ClassType(symbol);
            Islvalue = true;
        }
        if(tmp instanceof FuncDec){
            exptype = ((FuncDec) tmp).type;
            Islvalue = false;
        }
        if(tmp instanceof VarDec){
            exptype = ((VarDec) tmp).type;
            Islvalue = true;
        }
        return true;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        return (Address) pos.get(symbol);
    }

    @Override
    public Address getAddress(Table pos, Table table, ArrayList<Quadruple> list, Label begin, Label end) {
        return (Address) pos.get(symbol);
    }
}
