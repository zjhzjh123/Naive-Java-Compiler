package ast;

import IR.Address;
import IR.Quadruple;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public abstract class Dec extends ast{
    @Override
    public String toString(int d) {
        return indent(d) + "Dec\n";
    }
    public Address getvalue(Table table, ArrayList<Quadruple>list){
        return null;
    }
}
