package ast;

import IR.Address;
import IR.Label;
import IR.Quadruple;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class Exp extends Stmt{
    BasicType exptype;
    boolean Islvalue = true;
    @Override
    public String toString(int d) {
        return indent(d) + "Exp\n";
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        return null;
    }
    public Address getAddress(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        return null;
    }
}
