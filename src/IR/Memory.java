package IR;

/**
 * Created by zhangjiaheng on 16/4/30.
 */
public class Memory extends Address{
    public Address temp;
    public IntegerConst offset;

    public Memory(Address temp, IntegerConst offset) {
        this.temp = temp;
        this.offset = offset;
    }
    public String print() {
        return "";
    }
}
