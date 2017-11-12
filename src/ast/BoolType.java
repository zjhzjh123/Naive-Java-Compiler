package ast;

import IR.Address;
import IR.Label;
import IR.Quadruple;
import IR.Temp;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class BoolType extends BasicType{
    @Override
    public String toString(int d) {
        return indent(d) + "BoolType\n";
    }
    public boolean round_2(Table table) {
        return true;
    }
}