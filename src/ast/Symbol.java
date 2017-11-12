package ast;

import IR.Address;
import IR.Quadruple;
import IR.Temp;

import java.util.ArrayList;

public class Symbol extends ast{
    private String name;
    private Symbol(String n) {
        name=n;
    }
    private static java.util.Dictionary dict = new java.util.Hashtable();

    public String toString() {
        return name;
    }
    public String toString(int d){
        return indent(d) + "Symbol\n" + indent(d + 1) + name.toString() + "\n";
    }

    public static Symbol symbol(String n) {
        String u = n.intern();
        Symbol s = (Symbol)dict.get(u);
        if (s==null) {
            s = new Symbol(u);
            dict.put(u,s);
        }
        return s;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list){
        Temp rt = new Temp();
        return rt;
    }
}

