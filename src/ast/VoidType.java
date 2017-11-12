package ast;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class VoidType extends BasicType{
    @Override
    public String toString(int d) {
        return indent(d) + "void\n";
    }
    public boolean round_2(Table table) {
        return true;
    }
}
