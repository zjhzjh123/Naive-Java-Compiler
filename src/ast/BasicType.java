package ast;

import IR.Address;
import IR.Label;
import IR.Quadruple;
import IR.Temp;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public abstract class BasicType extends ast{
    public boolean round_2(Table table){return true;}
    public Address getSize(Table pos, Table table, ArrayList<Quadruple> list, Label begin, Label end){
        return new Temp();
    }
}
