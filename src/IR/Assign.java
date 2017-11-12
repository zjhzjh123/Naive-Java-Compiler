package IR;

import org.omg.CORBA.PUBLIC_MEMBER;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/28.
 */
public class Assign extends Quadruple{
    public Address dest;
    public Address src;

    public Assign(){
        dest = null;
        src = null;
    }

    public Assign(Address dest, Address src){
        this.dest = dest;
        this.src = src;
    }

    public String print(){
        return dest.print() + " = " + "move" + " " + src.print();
    }

    public String MIPSprint(){
        String s = "";
        if(src instanceof IntegerConst){
            s = s + "li" +  " " + "$t0" + ", " + ((IntegerConst)src).value + "\n";
            s = s + "sw" + " " + "$t0" + ", " + ((Temp)dest).num * 4 +  "($sp)" + "\n";
        }
        else{
            s = s + "lw" + " " + "$t0" + ", " + ((Temp)src).num * 4 + "($sp)" + "\n";
            s = s + "sw" + " " + "$t0" + ", " + ((Temp)dest).num * 4 + "($sp)" + "\n";
        }
        return s;
    }
    @Override
    public ArrayList<Temp> getdef() {
        ArrayList<Temp> list = new ArrayList<Temp>();
        if(dest != null && dest instanceof Temp)
            list.add((Temp)dest);
        return list;
    }

    @Override
    public ArrayList<Temp> getuse() {
        ArrayList<Temp> list = new ArrayList<Temp>();
        if(src != null && src instanceof Temp)
            list.add((Temp)src);
        return list;
    }
}
