package IR;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/28.
 */
public class Branch extends Quadruple{
    public Address address;
    public Label begin;
    public Label end;

    public Branch(){
        address = null;
        begin = null;
        end = null;
    }

    public Branch(Address address, Label begin, Label end) {
        this.address = address;
        this.begin = begin;
        this.end = end;
    }

    public String print() {
        return "br " + address.print() + " " + begin.print() + " " + end.print();
    }
    public String MIPSprint(){
        String s = "";
        if(address instanceof IntegerConst){
         //   s = s + "beq " + 1 + ", " + ((IntegerConst)address).value + ", %" + begin.num + "\n";
            s = s + "beq " + 0 + ", " + ((IntegerConst)address).value + "," + end.num + "\n";
        }
        if(address instanceof Temp){
            s = s + "beq " + 0 + ", " + ((Temp)address).num * 4 + "($sp)" + ", %" + end.num + "\n";
            s = s + "beq " + 0 + ", " + ((Temp)address).num * 4 + "($sp)" + ", %" + end.num + "\n";
        }
        return s;
    }

    @Override
    public ArrayList<Temp> getdef() {
        return null;
    }

    @Override
    public ArrayList<Temp> getuse() {
        ArrayList<Temp> list = new ArrayList<Temp>();
        if(address != null && address instanceof Temp)
            list.add((Temp)address);
        return list;
    }

}
