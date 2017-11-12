package ast;

import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public abstract class ast {
    public ErrorInfo info;
    public int scope;
    public ast(ErrorInfo ainfo) {info.col = ainfo.col; info.col = ainfo.row;}
    public ast(){info = null;}
    public String indent(int d){
        String string = "";
        while(d >= 0){
            string = string + "\t";
            --d;
        }
        return string;
    }

    public void outputerrorinfo(){
//        System.out.println("************ERROR MESSAGE************");
//        System.out.println(this.toString(0));
    }

    public abstract String toString(int d);
    public boolean round_1(Table table){return true;}
    public boolean round_2(Table table){return true;}
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast>stack, int scope){return true;}
    public boolean typeCompare(BasicType type1, BasicType type2) {
        if (type1 instanceof BoolType && type2 instanceof BoolType) return true;
        if (type1 instanceof IntType && type2 instanceof IntType) return true;
        if (type1 instanceof StringType && type2 instanceof StringType) return true;
        if (type1 instanceof ClassType && type2 instanceof ClassType) {
            return ((ClassType) type1).symbol.equals(((ClassType) type2).symbol);
        }
        if (type1 instanceof ArrayType && type2 instanceof ArrayType) {
            return typeCompare(((ArrayType) type1).baseType, ((ArrayType) type2).baseType);
        }
        if (type1 instanceof NullType) {
            return type2 instanceof NullType || type2 instanceof ArrayType || type2 instanceof ClassType;
        }
        if (type2 instanceof NullType) {
            return type1 instanceof NullType || type1 instanceof ArrayType || type1 instanceof ClassType;
        }
        return false;
    }
}
