package IR;

import javax.management.relation.Relation;
import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/30.
 */
public class RelationExpr extends Quadruple{
    public RelationalOp op;
    public Address dest;
    public Address src1;
    public Address src2;

    public RelationExpr(){
        op = null;
        dest = null;
        src1 = null;
        src2 = null;
    }

    public RelationExpr(Address dest, Address src1, RelationalOp op, Address src2){
        this.dest = dest;
        this.src1 = src1;
        this.op = op;
        this.src2 = src2;
    }

    public RelationExpr(Address dest, RelationalOp op, Address src1){
        this.dest = dest;
        this.src1 = src1;
        this.op = op;
        this.src2 = null;
    }
    public String print(){
        String opr = "";
        switch (op) {
            case EQ: opr = "seq"; break;
            case NE: opr = "sne"; break;
            case GT: opr = "sgt"; break;
            case GE: opr = "sge"; break;
            case LT: opr = "slt"; break;
            case LE: opr = "sle"; break;
        }
        return dest.print() + " = " + opr + " " + src1.print() + " " + src2.print();
    }
    public String MIPSprint(){
        String s = "";
        if(op == RelationalOp.EQ) {
            s = s + "lw " + "$t0" + ", " + ((Temp) src1).num * 4 + "($sp)" + "\n";
            if (src2 instanceof Temp) {
                s = s + "lw " + "$t1" + ", " + ((Temp) src2).num * 4 + "($sp)" + "\n";
            }
            if (src2 instanceof IntegerConst) {
                s = s + "li " + "$t1" + ", " + ((IntegerConst) src2).value + "\n";
            }
            s = s + "seq " + "$t2" + ", " + "$t0" + ", " + "$t1" + "\n";
            s = s + "sw " + "$t2" + ", " + ((Temp) dest).num * 4 + "($sp)" + "\n";
        }
        if(op == RelationalOp.GE) {
            s = s + "lw " + "$t0" + ", " + ((Temp) src1).num * 4 + "($sp)" + "\n";
            if (src2 instanceof Temp) {
                s = s + "lw " + "$t1" + ", " + ((Temp) src2).num * 4 + "($sp)" + "\n";
            }
            if (src2 instanceof IntegerConst) {
                s = s + "li " + "$t1" + ", " + ((IntegerConst) src2).value + "\n";
            }
            s = s + "sge " + "$t2" + ", " + "$t0" + ", " + "$t1" + "\n";
            s = s + "sw " + "$t2" + ", " + ((Temp) dest).num * 4 + "($sp)" + "\n";
        }
        if(op == RelationalOp.GT) {
            s = s + "lw " + "$t0" + ", " + ((Temp) src1).num * 4 + "($sp)" + "\n";
            if (src2 instanceof Temp) {
                s = s + "lw " + "$t1" + ", " + ((Temp) src2).num * 4 + "($sp)" + "\n";
            }
            if (src2 instanceof IntegerConst) {
                s = s + "li " + "$t1" + ", " + ((IntegerConst) src2).value + "\n";
            }
            s = s + "sgt " + "$t2" + ", " + "$t0" + ", " + "$t1" + "\n";
            s = s + "sw " + "$t2" + ", " + ((Temp) dest).num * 4 + "($sp)" + "\n";
        }
        if(op == RelationalOp.LT) {
            s = s + "lw " + "$t0" + ", " + ((Temp) src1).num * 4 + "($sp)" + "\n";
            if (src2 instanceof Temp) {
                s = s + "lw " + "$t1" + ", " + ((Temp) src2).num * 4 + "($sp)" + "\n";
            }
            if (src2 instanceof IntegerConst) {
                s = s + "li " + "$t1" + ", " + ((IntegerConst) src2).value + "\n";
            }
            s = s + "slt " + "$t2" + ", " + "$t0" + ", " + "$t1" + "\n";
            s = s + "sw " + "$t2" + ", " + ((Temp) dest).num * 4 + "($sp)" + "\n";
        }
        if(op == RelationalOp.LE) {
            s = s + "lw " + "$t0" + ", " + ((Temp) src1).num * 4 + "($sp)" + "\n";
            if (src2 instanceof Temp) {
                s = s + "lw " + "$t1" + ", " + ((Temp) src2).num * 4 + "($sp)" + "\n";
            }
            if (src2 instanceof IntegerConst) {
                s = s + "li " + "$t1" + ", " + ((IntegerConst) src2).value + "\n";
            }
            s = s + "sle " + "$t2" + ", " + "$t0" + ", " + "$t1" + "\n";
            s = s + "sw " + "$t2" + ", " + ((Temp) dest).num * 4 + "($sp)" + "\n";
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
        if(src1 != null && src1 instanceof Temp)
            list.add((Temp)src1);
        if(src2 != null && src2 instanceof Temp)
            list.add((Temp)src2);
        return list;
    }
}
