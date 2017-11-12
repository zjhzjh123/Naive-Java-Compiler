package ast;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class StringType extends BasicType {
    @Override
    public String toString(int d) {
        return indent(d) + "StringType\n";
    }
    public boolean round_2(Table table) {
        return true;
    }
}
