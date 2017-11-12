package IR;



import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/26.
 */
public class ArithmeticExpr extends Quadruple{
    public ArithmeticOp op;
    public Address dest;
    public Address src1;
    public Address src2;

    public ArithmeticExpr(){
        op = null;
        dest = null;
        src1 = null;
        src2 = null;
    }

    public ArithmeticExpr(Address dest, Address src1, ArithmeticOp op, Address src2){
        this.dest = dest;
        this.src1 = src1;
        this.op = op;
        this.src2 = src2;
    }

    public ArithmeticExpr(Address dest, ArithmeticOp op, Address src1){
        this.dest = dest;
        this.src1 = src1;
        this.op = op;
        this.src2 = null;
    }
    public String print() {
        String opr = "";
        switch (op) {
            case ADD: opr = "add"; break;
            case SUB: opr = "sub"; break;
            case MUL: opr = "mul"; break;
            case DIV: opr = "div"; break;
            case MOD: opr = "rem"; break;
            case SHL: opr = "shl"; break;
            case SHR: opr = "shr"; break;
            case AND: opr = "and"; break;
            case OR: opr = "or"; break;
            case XOR: opr = "xor"; break;
            case MINUS: opr = "neg"; break;
            case TILDE: opr = "not"; break;
            case NOT: return dest.print() + " = " + "sub" + " " + (new IntegerConst(1)).print() + " " + src1.print();
        }
        if (src2 == null)
            return dest.print() + " = " + opr + " " + src1.print();
        else
            return dest.print() + " = " + opr + " " + src1.print() + " " + src2.print();
    }
    public String MIPSprint(){
        String s = "";
        if(op == ArithmeticOp.ADD){
            s = s + "lw " + "$t0" + ", " + ((Temp)src1).num * 4 + "($sp)" + "\n";
            if(src2 instanceof Temp){
                s = s + "lw " + "$t1" + ", " + ((Temp)src2).num * 4 + "($sp)" + "\n";
                s = s + "add " + "$t2" + ", " + "$t0" + ", " + "$t1" + "\n";
            }
            if(src2 instanceof IntegerConst){
                s = s + "add " + "$t2" + ", " + "$t0" + ", " + ((IntegerConst)src2).value + "\n";
            }
            s = s + "sw " + "$t2" + ", " + ((Temp)dest).num * 4 + "($sp)" + "\n";
        }
        if(op == ArithmeticOp.SUB){
            s = s + "lw " + "$t0" + ", " + ((Temp)src1).num * 4 + "($sp)" + "\n";
            if(src2 instanceof Temp){
                s = s + "lw " + "$t1" + ", " + ((Temp)src2).num * 4 + "($sp)" + "\n";
                s = s + "sub " + "$t2" + ", " + "$t0" + ", " + "$t1" + "\n";
            }
            if(src2 instanceof IntegerConst){
                s = s + "sub " + "$t2" + ", " + "$t0" + ", " + ((IntegerConst)src2).value + "\n";
            }
            s = s + "sw " + "$t2" + ", " + ((Temp)dest).num * 4 + "($sp)" + "\n";
        }
        if(op == ArithmeticOp.MUL){
            s = s + "lw " + "$t0" + ", " + ((Temp)src1).num * 4 + "($sp)" + "\n";
            if(src2 instanceof Temp){
                s = s + "lw " + "$t1" + ", " + ((Temp)src2).num * 4 + "($sp)" + "\n";
                s = s + "mul " + "$t2" + ", " + "$t0" + ", " + "$t1" + "\n";
            }
            if(src2 instanceof IntegerConst){
                s = s + "mul " + "$t2" + ", " + "$t0" + ", " + ((IntegerConst)src2).value + "\n";
            }
            s = s + "sw " + "$t2" + "," + ((Temp)dest).num * 4 + "($sp)" + "\n";
        }
        if(op == ArithmeticOp.DIV){
            s = s + "lw " + "$t0" + ", " + ((Temp)src1).num * 4 + "($sp)" + "\n";
            if(src2 instanceof Temp){
                s = s + "lw " + "$t1" + ", " + ((Temp)src2).num * 4 + "($sp)" + "\n";
                s = s + "div " + "$t2" + ", " + "$t0" + ", " + "$t1" + "\n";
            }
            if(src2 instanceof IntegerConst){
                s = s + "div " + "$t2" + ", " + "$t0" + ", " + ((IntegerConst)src2).value + "\n";
            }
            s = s + "sw " + "$t2" + ", " + ((Temp)dest).num * 4 + "($sp)" + "\n";
        }
        if(op == ArithmeticOp.AND){
            s = s + "lw " + "$t0" + ", " + ((Temp)src1).num * 4 + "($sp)" + "\n";
            if(src2 instanceof Temp){
                s = s + "lw " + "$t1" + ", " + ((Temp)src2).num * 4 + "($sp)" + "\n";
                s = s + "and " + "$t2" + ", " + "$t0" + ", " + "$t1" + "\n";
            }
            if(src2 instanceof IntegerConst){
                s = s + "and " + "$t2" + ", " + "$t0" + ", " + ((IntegerConst)src2).value + "\n";
            }
            s = s + "sw " + "$t2" + ", " + ((Temp)dest).num * 4 + "($sp)" + "\n";
        }
        if(op == ArithmeticOp.OR){
            s = s + "lw " + "$t0" + ", " + ((Temp)src1).num * 4 + "($sp)" + "\n";
            if(src2 instanceof Temp){
                s = s + "lw " + "$t1" + ", " + ((Temp)src2).num * 4 + "($sp)" + "\n";
                s = s + "or " + "$t2" + ", " + "$t0" + ", " + "$t1" + "\n";
            }
            if(src2 instanceof IntegerConst){
                s = s + "or " + "$t2" + ", " + "$t0" + ", " + ((IntegerConst)src2).value + "\n";
            }
            s = s + "sw " + "$t2" + ", " + ((Temp)dest).num * 4 + "($sp)" + "\n";
        }
        if(op == ArithmeticOp.MOD){
            s = s + "lw " + "$t0" + ", " + ((Temp)src1).num * 4 + "($sp)" + "\n";
            if(src2 instanceof Temp){
                s = s + "lw " + "$t1" + ", " + ((Temp)src2).num * 4 + "($sp)" + "\n";
                s = s + "rem " + "$t2" + ", " + "$t0" + ", " + "$t1" + "\n";
            }
            if(src2 instanceof IntegerConst){
                s = s + "mod " + "$t2" + ", " + "$t0" + ", " + ((IntegerConst)src2).value + "\n";
            }
            s = s + "sw " + "$t2" + ", " + ((Temp)dest).num * 4 + "($sp)" + "\n";
        }
        if(op == ArithmeticOp.SHR){
            s = s + "lw " + "$t0" + ", " + ((Temp)src1).num * 4 + "($sp)" + "\n";
            if(src2 instanceof Temp){
                s = s + "lw " + "$t1" + ", " + ((Temp)src2).num * 4 + "($sp)" + "\n";
                s = s + "srl " + "$t2" + ", " + "$t0" + ", " + "$t1" + "\n";
            }
            if(src2 instanceof IntegerConst){
                s = s + "srl " + "$t2" + ", " + "$t0" + ", " + ((IntegerConst)src2).value + "\n";
            }
            s = s + "sw " + "$t2" + ", " + ((Temp)dest).num * 4 + "($sp)" + "\n";
        }
        if(op == ArithmeticOp.SHL){
            s = s + "lw " + "$t0" + ", " + ((Temp)src1).num * 4 + "($sp)" + "\n";
            if(src2 instanceof Temp){
                s = s + "lw " + "$t1" + ", " + ((Temp)src2).num * 4 + "($sp)" + "\n";
                s = s + "sll " + "$t2" + ", " + "$t0" + ", " + "$t1" + "\n";
            }
            if(src2 instanceof IntegerConst){
                s = s + "sll " + "$t2" + ", " + "$t0" + ", " + ((IntegerConst)src2).value + "\n";
            }
            s = s + "sw " + "$t2" + ", " + ((Temp)dest).num * 4 + "($sp)" + "\n";
        }
        if(op == ArithmeticOp.XOR){
            s = s + "lw " + "$t0" + ", " + ((Temp)src1).num * 4 + "($sp)" + "\n";
            if(src2 instanceof Temp){
                s = s + "lw " + "$t1" + ", " + ((Temp)src2).num * 4 + "($sp)" + "\n";
                s = s + "xor " + "$t2" + ", " + "$t0" + ", " + "$t1" + "\n";
            }
            if(src2 instanceof IntegerConst){
                s = s + "xor " + "$t2" + ", " + "$t0" + ", " + ((IntegerConst)src2).value + "\n";
            }
            s = s + "sw " + "$t2" + ", " + ((Temp)dest).num * 4 + "($sp)" + "\n";
        }
        if(op == ArithmeticOp.TILDE){
            if(src1 instanceof Temp){
                s = s + "lw " + "$t0" + ", " + ((Temp)src2).num * 4 + "($sp)" + "\n";
            }
            if(src1 instanceof IntegerConst){
                s = s + "li " + "$t0" + ", " + ((IntegerConst)src2).value + "\n";
            }
            s = s + "not " + "$t1" + ", " + "$t0" + "\n";
            s = s + "sw " + "$t1" + ", " + ((Temp)dest).num * 4 + "($sp)" + "\n";
        }
        if(op == ArithmeticOp.NOT){
            if(src1 instanceof Temp){
                s = s + "lw " + "$t0" + ", " + ((Temp)src2).num * 4 + "($sp)" + "\n";
            }
            if(src1 instanceof IntegerConst){
                s = s + "li " + "$t0" + ", " + ((IntegerConst)src2).value + "\n";
            }
            s = s + "not " + "$t1" + ", " + "$t0" + "\n";
            s = s + "sw " + "$t1" + ", " + ((Temp)dest).num * 4 + "($sp)" + "\n";
        }
        if(op == ArithmeticOp.MINUS){
            if(src1 instanceof Temp){
                s = s + "lw " + "$t0" + ", " + ((Temp)src2).num * 4 + "($sp)" + "\n";
            }
            if(src1 instanceof IntegerConst){
                s = s + "li " + "$t0" + ", " + ((IntegerConst)src2).value + "\n";
            }
            s = s + "neg " + "$t1" + ", " + "$t0" + "\n";
            s = s + "sw " + "$t1" + ", " + ((Temp)dest).num * 4 + "($sp)" + "\n";
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
