package IR;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/26.
 */
public abstract class Quadruple {
    abstract public String print();
    abstract public String MIPSprint();
    abstract public ArrayList<Temp> getdef();
    abstract public ArrayList<Temp> getuse();
}
