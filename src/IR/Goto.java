package IR;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/26.
 */
public class Goto extends Quadruple{
    public Label label;

    private Goto(){
        label = null;
    }

    public Goto(Label label){
        this.label = label;
    }
    public String print(){
        return "jump " + label.print();
    }
    public String MIPSprint(){
        return "b " + label.num + "\n";
    }

    @Override
    public ArrayList<Temp> getdef() {
        return null;
    }

    @Override
    public ArrayList<Temp> getuse() {
        return null;
    }

}
