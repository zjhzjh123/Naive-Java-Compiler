package IR;

import cfg.FunctionCFG;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by zhangjiaheng on 16/4/26.
 */
public class Function {
    public String name;
    public ArrayList<Address> args;
    public ArrayList<Quadruple> body;
    public Label begin, end;
    public FunctionCFG cfg;
    public int size;
    public int tempnum;
    public IR ir;
    public boolean isLeaf = true;
    public Function(){
        name = null;
        args = new ArrayList<Address>();
        body = new ArrayList<Quadruple>();
        begin = null;
    }

    public Function(String name, ArrayList<Address>args, ArrayList<Quadruple>body, Label label, int num, IR ir){
        this.name = name;
        this.args = args;
        this.body = body;
        this.begin = label;
        tempnum = num;
        this.ir = ir;
    }
    public String print(){
     //   System.out.println("ddddddddd");
        String string = "func " + name;
        for(Address address : args){
            string = string + " " + address.print();
        }
        string = string + " {\n";
        for(Quadruple quadruple : body){
            if(!(quadruple instanceof Label))
                string = string + "\t";
            string = string + quadruple.print();
            if(quadruple instanceof Label)
                string = string + ":";
            string = string + "\n";
        }
        return string + "}";
    }
    public String MiPSprint(){
        String s = "";
        for(Quadruple quadruple : body)
            s = s + quadruple.MIPSprint();
        return s;
    }
}
