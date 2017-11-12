package IR;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/30.
 */
public class MemoryWrite extends Quadruple{
    public Address dest;
    public Address src;
    public IntegerConst offset;
    public int size = 4;

    public MemoryWrite(Address dest, IntegerConst offset, Address src) {
        this.dest = dest;
        this.offset = offset;
        this.src = src;
    }

    public void read(ArrayList<Temp> list) {
        if (src instanceof Temp)
            list.add((Temp) src);
    }

    public void write(ArrayList<Temp> list) {
        if (dest instanceof Temp)
            list.add((Temp) dest);
    }
    public String print() {
        return "store " + size + " " + dest.print() + " " + src.print() + " " + offset.print();
    }

    @Override
    public String MIPSprint() {
        String s = "";
        s = s + "lw " + "$t0, " + ((Temp)src).num * 4 + "($sp)\n";
        s = s + "sw " + "$t0, " + ((Temp)dest).num * 4 + offset + "($sp)\n";
        return s;
    }

    @Override
    public ArrayList<Temp> getdef() {
        return null;
    }

    @Override
    public ArrayList<Temp> getuse() {
        ArrayList<Temp>list = new ArrayList<Temp>();
        if(dest != null && dest instanceof Temp){
            list.add((Temp)dest);
        }
        if(src != null && src instanceof Temp){
            list.add((Temp)src);
        }
        if(list.size() != 0) return list;
        else return null;
    }
}
