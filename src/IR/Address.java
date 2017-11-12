package IR;

/**
 * Created by zhangjiaheng on 16/4/26.
 */
public abstract class Address {
    abstract public String print();
    public boolean isString = false;
    public boolean isGlobal = false;
    public boolean isParam = false;
}
