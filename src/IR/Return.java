package IR;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/30.
 */
public class  Return extends Quadruple{
    public Address address;
    public Return(){
        address = null;
    }
    public Return(Address address){
        this.address = address;
    }
    public String print() {
        if (address != null)
            return "ret " + address.print();
        else
            return "ret";
    }

    @Override
    public String MIPSprint() {
        String s = "";
        if(address instanceof IntegerConst){
            s = s + "li " + "$t0, " + ((IntegerConst)address).value + "\n";
        }
        else s = s + "lw " + "$t0, " + ((Temp)address).num * 4 + "($sp)\n";
        s = s +  "jr $ra\n";
        return s;
    }

    @Override
    public ArrayList<Temp> getdef() {
        return null;
    }

    @Override
    public ArrayList<Temp> getuse() {
        ArrayList<Temp> list = new ArrayList<Temp>();
        if(address != null && address instanceof Temp){
            list.add((Temp)address);
        }
        return list;
    }
}
