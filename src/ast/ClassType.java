package ast;

import IR.Address;
import IR.Label;
import IR.Quadruple;
import javafx.util.Pair;
import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class ClassType extends BasicType{
    public Symbol symbol;
    public ClassType(Symbol asymbol){
        symbol = asymbol;
    }

    @Override
    public String toString(int d) {
        return indent(d) + "ClassType\n" + symbol.toString(d+1);
    }
    public boolean round_2(Table table) {
       if(table.get(symbol) != null)
           return true;
        outputerrorinfo();
        return false;
    }
    public boolean ClassTypeCompare(ClassType type1, ClassType type2){
        if(type1.symbol.equals(type2.symbol)) return true;
        outputerrorinfo();
        return false;
    }
    public Address getSize(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        return ((ClassDel)((Pair)table.get(symbol)).getKey()).getSize();
    }
}
