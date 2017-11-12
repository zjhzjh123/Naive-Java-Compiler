package cfg;

import IR.*;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/5/3.
 */
public class BasicBlock {
    public ArrayList<Quadruple>instr;
    public Node node;
    public BasicBlock(){
        instr = new ArrayList<Quadruple>();
    }
    public BasicBlock(ArrayList<Quadruple>quadruples){
        instr = quadruples;
    }

    public ArrayList<Temp> def(){
        ArrayList<Temp>list = new ArrayList<Temp>();
        for(Quadruple quadruple : instr){
            if(quadruple.getdef() != null)
                list.addAll(quadruple.getdef());
        }
        return list;
    }

    public ArrayList<Temp> use(){
        ArrayList<Temp>list = new ArrayList<Temp>();
        for(Quadruple quadruple : instr)
            list.addAll(quadruple.getuse());
        return list;
    }
}
