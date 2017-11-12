package ast;

import IR.Address;
import IR.Label;
import IR.Quadruple;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public abstract class Stmt extends ast{
    abstract public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end);
}
