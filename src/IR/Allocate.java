package IR;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/30.
 */
public class Allocate extends Quadruple{
    public Address address;
    public Address size;

    public Allocate(Address address, Address size){
        this.address = address;
        this.size = size;
    }
    public void read(ArrayList<Temp>list){
        if(size instanceof Temp)
            list.add((Temp) size);
    }
    public void write(ArrayList<Temp>list){
        if(address instanceof Temp){
            list.add((Temp) address);
        }
    }

    public String print(){
        return address.print() + " = alloc " + size.print();
    }

    @Override
    public String MIPSprint() {
        String s = "";
        s = s + "sw " + "$t0, " + ((IntegerConst)size).value * 4 + "($sp)\n";
        return s;
    }

    @Override
    public ArrayList<Temp> getdef() {
        if(address instanceof Temp) {
            ArrayList<Temp>list = new ArrayList<Temp>();
            list.add((Temp) address);
            return list;
        }
        else return null;
    }

    @Override
    public ArrayList<Temp> getuse() {
        if(size instanceof Temp) {
            ArrayList<Temp>list = new ArrayList<Temp>();
            list.add((Temp) size);
            return list;
        }
        else return null;
    }

}
