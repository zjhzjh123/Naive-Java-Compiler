package IR;

import ast.FuncDec;
import ast.Table;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/26.
 */
public class Call extends Quadruple{
    public Temp returnValue;
    public Function callee, caller;
    public ArrayList<Address> arrayList;
    public String name;

    public Call(){
        returnValue = null;
        callee = null;
        arrayList = null;
    }

    public Call(Temp returnValue, Function caller, String name, ArrayList<Address>arrayList){
        this.returnValue = returnValue;
        this.caller = caller;
        this.name = name;
        this.arrayList = arrayList;
    }

    public String print(){
        String s = "";
        for (Address address : arrayList)
            s = s + " " + address.print();
        if (returnValue == null)
            return "call" + " "  + s;
        else
            return returnValue.print() + " = call" + " "  + s;
    }

    @Override
    public String MIPSprint(){
        String s = "";
        int sp = (callee.size + 1) * 4;
        int sp1 = ((caller.size + 1) * 4 + sp);
        int sp2 = (returnValue.num + 1) * 4 + sp;
        s = s + "subu " + "$sp" + "," + "$sp" + sp + "\n";
        for(int i = 0; i < arrayList.size(); i++){
            s = s + "lw " + "$t0, " + (((Temp)arrayList.get(i)).num + sp) + "($sp)" + "\n";
            s = s + "sw" + "$t0, " + callee.args.get(i) + "($sp)" + "\n";
        }
        s = s + "sw " + "$ra, " + sp1 + "($sp)" + "\n";
        s = s + "jal " + callee.begin + "\n";
        s = s + "sw " + "$v0, " + sp2 + "($sp)" + "\n";
        s = s + "lw " + "$ra, " + sp1 + "($sp)" + "\n";
        s = s + "addu " + "$sp, " + "$sp, " + sp + "\n";
        return s;
    }

    @Override
    public ArrayList<Temp> getdef() {
        ArrayList<Temp> list = new ArrayList<Temp>();
        if(returnValue != null)
            list.add(returnValue);
        return list;
    }

    @Override
    public ArrayList<Temp> getuse() {
        ArrayList<Temp> list = new ArrayList<Temp>();
        if(arrayList != null){
            for (int i = 0; i < arrayList.size(); i++){
                if(arrayList.get(i) instanceof Temp){
                    list.add((Temp) arrayList.get(i));
                }
            }
        }
        return list;
    }
}
