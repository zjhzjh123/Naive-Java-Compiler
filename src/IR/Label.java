package IR;

import cfg.BasicBlock;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/26.
 */
public class Label extends Quadruple{
    private static int labelCount = 0;
    public BasicBlock basicBlock;
    public int num;
    public Label(){
        num = labelCount++;
    }
    public String print(){
        return "%" + num;
    }

    @Override
    public String MIPSprint() {
        return "%" + num + "\n";
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
