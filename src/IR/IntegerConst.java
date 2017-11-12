package IR;

/**
 * Created by zhangjiaheng on 16/4/28.
 */
public class IntegerConst extends Const{
    public int value;

    public IntegerConst() {}

    public IntegerConst(int value) {
        this.value = value;
    }
    public String print() {
        return String.valueOf(value);
    }
}
