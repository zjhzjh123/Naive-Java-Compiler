package IR;

import ast.FuncDec;
import jdk.nashorn.internal.ir.FunctionNode;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/28.
 */
public class IR{
    public ArrayList<Function> functionArrayList;
    public ArrayList<Temp> globaldeclist;
    public ArrayList<Quadruple> init;
    public IR(){
        functionArrayList = new ArrayList<Function>();
    }

    public IR(ArrayList<Function> functionArrayList1, ArrayList<Temp>list, ArrayList<Quadruple>list1){
        functionArrayList = functionArrayList1;
        globaldeclist = list;
        init = list1;
    }
    public String print(){
        String string = "";

        for(Function function : functionArrayList){

            string = string + function.print() + "\n";
        }
        return string;
    }
    public String MIPSprint(){
        return null;
    }
}
