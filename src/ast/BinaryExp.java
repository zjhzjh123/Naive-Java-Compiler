package ast;

import IR.*;

import javafx.util.Pair;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class BinaryExp extends Exp{
    public Exp left, right;
    public BinaryOp op;
    public BinaryExp(Exp aleft, BinaryOp aop, Exp aright){
        left = aleft;
        right = aright;
        op = aop;
    }

    @Override
    public String toString(int d) {
        return indent(d) + "BinaryExp\n" + left.toString(d+1)
                + indent(d+1) + op.toString() + "\n" + right.toString(d+1);
    }

    @Override
    public boolean round_3(Table table, FuncDec funcDec, Stack<ast> stack, int scope) {
        if(!left.round_3(table,funcDec,stack, scope) || !right.round_3(table, funcDec, stack, scope)){
            outputerrorinfo();
            return false;
        }

        BasicType tp1 = left.exptype;
        BasicType tp2 = right.exptype;

        if(!typeCompare(tp1,tp2)){

            if (op == BinaryOp.assignment_op && tp2 instanceof NullType &&
                    (tp1 instanceof ArrayType || tp1 instanceof ClassType)) {
                return true;
            }
            outputerrorinfo();
            return false;
        }
        if (op == BinaryOp.assignment_op) {


            if (!left.Islvalue) {
                outputerrorinfo();
                return false;
            }
            exptype = tp1;
            Islvalue = false;
        }
     //   System.out.println(op);
        if ((op == BinaryOp.log_and_op) || (op == BinaryOp.log_or_op)) {

            if (tp1 instanceof BoolType) {
                exptype = tp1;
                Islvalue = false;
            } else {
                outputerrorinfo();
                return false;
            }
        }

        if((op == BinaryOp.and_op || op == BinaryOp.inclusive_or_op || op == BinaryOp.exclusive_or_op)){
            if(tp1 instanceof IntType){
                exptype = tp1;
                Islvalue = false;
                return true;
            }
            outputerrorinfo();
            return false;
        }
        if(op == BinaryOp.equality_op){
            if(tp1 instanceof VoidType || tp1 instanceof NullType){
                outputerrorinfo();
                return false;
            }
            exptype = new BoolType();
            Islvalue = false;
        }

        if(op == BinaryOp.non_equality_op){
            if(tp1 instanceof VoidType || tp1 instanceof NullType || tp1 instanceof StringType){
                outputerrorinfo();
                return false;
            }
            exptype = new BoolType();
            Islvalue = false;
        }
        if(op == BinaryOp.less_op || op == BinaryOp.less_equality_op
                || op == BinaryOp.larger_op || op == BinaryOp.larger_equality_op){

            if(tp1 instanceof VoidType || tp1 instanceof NullType || tp1 instanceof ClassType
                    || tp1 instanceof BoolType || tp1 instanceof ArrayType){
                outputerrorinfo();
                return false;
            }
            exptype = new BoolType();
            Islvalue = false;
        }
        if(op == BinaryOp.add_op){

            if(!(tp1 instanceof IntType) && !(tp1 instanceof StringType)){
                outputerrorinfo();
                return false;
            }
            else if (tp1 instanceof IntType){
                exptype = tp1;
                Islvalue = false;
            } else if (tp1 instanceof StringType) {
                exptype = tp1;
                Islvalue = false;
            }
        }
        if(op == BinaryOp.minus_op || op == BinaryOp.div_op || op == BinaryOp.multi_op
                || op == BinaryOp.mod_op || op == BinaryOp.left_op || op == BinaryOp.right_op){

            if(!(tp1 instanceof IntType)){
                outputerrorinfo();
                return false;
            }
            exptype = tp1;
            Islvalue = false;
        }

    //   System.out.println("zhangjiaheng");
        return true;
    }
    public Address translate(Table pos, Table table, ArrayList<Quadruple>list, Label begin, Label end){
        //短路求值
        if(op == BinaryOp.log_and_op){
            Address address1 = left.translate(pos, table, list, begin, end);
            if(address1 instanceof IntegerConst){
                if(((IntegerConst) address1).value == 0)
                    return new IntegerConst(0);
                else return right.translate(pos, table, list, begin, end);
            }
            else{
                Label label = new Label();
                Label success = new Label();
                Label fail = new Label();
                Label endjudge = new Label();
                Temp temp = new Temp();
                list.add(new Branch(address1, label, fail));
                list.add(label);
                Address address2 = right.translate(pos, table, list, begin, end);
                list.add(new Branch(address2, success, fail));
                list.add(success);
                list.add(new Assign(temp, new IntegerConst(1)));
                list.add(new Goto(endjudge));
                list.add(fail);
                list.add(new Assign(temp, new IntegerConst(0)));
                list.add(new Goto(endjudge));
                list.add(endjudge);
                return temp;
            }
        }
        if(op == BinaryOp.log_or_op){
            Address address1 = left.translate(pos, table, list, begin, end);
            if(address1 instanceof IntegerConst){
                if(((IntegerConst) address1).value == 1)
                    return new IntegerConst(1);
                else return right.translate(pos, table, list, begin, end);
            }
            else{
                Label label = new Label();
                Label success = new Label();
                Label fail = new Label();
                Label endjudge = new Label();
                Temp temp = new Temp();
                list.add(new Branch(address1, success, label));
                list.add(label);
                Address address2 = right.translate(pos, table, list, begin, end);
                list.add(new Branch(address2, success, fail));
                list.add(success);
                list.add(new Assign(temp, new IntegerConst(1)));
                list.add(new Goto(endjudge));
                list.add(fail);
                list.add(new Assign(temp, new IntegerConst(0)));
                list.add(new Goto(endjudge));
                list.add(endjudge);
                return temp;
            }
        }
        Address address2 = right.translate(pos, table, list, begin, end);
        if(op == BinaryOp.assignment_op){
            Address address = left.getAddress(pos, table, list, begin, end);
            if(address instanceof Temp)
                list.add(new Assign(address, address2));
            else{
                list.add(new MemoryWrite(((Memory)address).temp, ((Memory)address).offset, address2));
            }
            return address2;
        }
        Address address1 = left.translate(pos, table, list, begin, end);
        Temp temp = new Temp();
        if(op == BinaryOp.log_and_op){
            if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst(((IntegerConst) address1).value & ((IntegerConst) address2).value);
                return result;
            }
            else if(address1 instanceof IntegerConst){
                list.add(new ArithmeticExpr(temp, address2, ArithmeticOp.AND, address1));
            }
            else list.add(new ArithmeticExpr(temp, address1, ArithmeticOp.AND, address2));
        }
        if(op == BinaryOp.log_or_op){
            if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst(((IntegerConst) address1).value | ((IntegerConst) address2).value);
                return result;
            }
            else if(address1 instanceof IntegerConst){
                list.add(new ArithmeticExpr(temp, address2, ArithmeticOp.OR, address1));
            }
            else list.add(new ArithmeticExpr(temp, address1, ArithmeticOp.OR, address2));
        }
        if(op == BinaryOp.equality_op){
            if (left.exptype instanceof StringType && right.exptype instanceof StringType){
                ArrayList<Address> arg = new ArrayList<Address>();
                arg.add(address1);
                arg.add(address2);
                Temp temp0 = new Temp();
                list.add(new Call(temp0, null, "stringEquals", arg));
                return temp0;
            }
            else if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst(1 - ((IntegerConst) address1).value - ((IntegerConst) address2).value);
                return result;
            }
            else if(address1 instanceof IntegerConst){
                list.add(new RelationExpr(temp, address2, RelationalOp.EQ, address1));
            }
            else list.add(new RelationExpr(temp, address1, RelationalOp.EQ, address2));
        }
        if(op == BinaryOp.non_equality_op){
            if (left.exptype instanceof StringType && right.exptype instanceof StringType){
                ArrayList<Address> arg = new ArrayList<Address>();
                arg.add(address2);
                arg.add(address1);
                Temp temp0 = new Temp();
                list.add(new Call(temp0, null, "stringEquals", arg));
                list.add(new ArithmeticExpr(temp0, temp0, ArithmeticOp.XOR, new IntegerConst(1)));
                return temp0;
            }
            else if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst(((IntegerConst) address1).value - ((IntegerConst) address2).value);
                return result;
            }
            else if(address1 instanceof IntegerConst){
                list.add(new RelationExpr(temp, address2, RelationalOp.NE, address1));
            }
            else list.add(new RelationExpr(temp, address1, RelationalOp.NE,address2));
        }
        if(op == BinaryOp.less_op){
            if (left.exptype instanceof StringType && right.exptype instanceof StringType){
                ArrayList<Address> arg = new ArrayList<Address>();
                arg.add(address1);
                arg.add(address2);
                Temp temp0 = new Temp();
                list.add(new Call(temp0, null, "stringLessThan", arg));
                return temp0;
            }
            else if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst();
                int value = ((IntegerConst) address1).value - ((IntegerConst) address2).value;
                if(value < 0) result.value = 1;
                else result.value = 0;
                return result;
            }
            else if(address1 instanceof IntegerConst){
                list.add(new RelationExpr(temp, address2, RelationalOp.GT, address1));
            }
            else list.add(new RelationExpr(temp,address1, RelationalOp.LT, address2));
        }
        if(op == BinaryOp.larger_op){
            if (left.exptype instanceof StringType && right.exptype instanceof StringType){
                ArrayList<Address> arg = new ArrayList<Address>();
                arg.add(address2);
                arg.add(address1);
                Temp temp0 = new Temp();
                list.add(new Call(temp0, null, "stringLessThan", arg));
                return temp0;
            }
            else if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst();
                int value = ((IntegerConst) address1).value - ((IntegerConst) address2).value;
                if(value > 0) result.value = 1;
                else result.value = 0;
                return result;
            }
            else if(address1 instanceof IntegerConst){
                list.add(new RelationExpr(temp, address2, RelationalOp.LT, address1));
            }
            else list.add(new RelationExpr(temp, address1, RelationalOp.GT, address2));
        }
        if(op == BinaryOp.larger_equality_op){
            if (left.exptype instanceof StringType && right.exptype instanceof StringType){
                ArrayList<Address> arg = new ArrayList<Address>();
                arg.add(address2);
                arg.add(address1);
                Temp temp0 = new Temp();
                list.add(new Call(temp0, null, "stringLessThanOrEquals", arg));
                return temp0;
            }
            else if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst();
                int value = ((IntegerConst) address1).value - ((IntegerConst) address2).value;
                if(value >= 0) result.value = 1;
                else result.value = 0;
                return result;
            }
            else if(address1 instanceof IntegerConst){
                list.add(new RelationExpr(temp, address2, RelationalOp.LE, address1));
            }
            else list.add(new RelationExpr(temp, address1, RelationalOp.GE, address2));
        }
        if(op == BinaryOp.less_equality_op){
            if (left.exptype instanceof StringType && right.exptype instanceof StringType){
                ArrayList<Address> arg = new ArrayList<Address>();
                arg.add(address1);
                arg.add(address2);
                Temp temp0 = new Temp();
                list.add(new Call(temp0, null, "stringLessThanOrEquals", arg));
                return temp0;
            }
            else if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst();
                int value = ((IntegerConst) address1).value - ((IntegerConst) address2).value;
                if(value <= 0) result.value = 1;
                else result.value = 0;
                return result;
            }
            else if(address1 instanceof IntegerConst){
                list.add(new RelationExpr(temp, address2, RelationalOp.GE, address1));
            }
            else list.add(new RelationExpr(temp, address1, RelationalOp.LE, address2));
        }
        if(op == BinaryOp.inclusive_or_op){
            if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst(((IntegerConst) address1).value | ((IntegerConst) address2).value);
                return result;
            }
            else if(address1 instanceof IntegerConst){
                list.add(new ArithmeticExpr(temp, address2, ArithmeticOp.OR, address1));
            }
            else list.add(new ArithmeticExpr(temp, address1, ArithmeticOp.OR, address2));
        }
        if(op == BinaryOp.exclusive_or_op){
            if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst(((IntegerConst) address1).value ^ ((IntegerConst) address2).value);
                return result;
            }
            else if(address1 instanceof IntegerConst){
                list.add(new ArithmeticExpr(temp, address2, ArithmeticOp.XOR, address1));
            }
            else list.add(new ArithmeticExpr(temp, address1, ArithmeticOp.XOR, address2));
        }
        if(op == BinaryOp.add_op){
        //    if(address2.isString) System.out.println("ssssssssssssssssss");
            if (left.exptype instanceof StringType && right.exptype instanceof StringType) {
        //        System.out.println("ssssssssssssssssss");
                ArrayList<Address> arg = new ArrayList<Address>();
                arg.add(address1);
                arg.add(address2);
                Temp temp0 = new Temp();
        //        temp0.isString = true;
                list.add(new Call(temp0, null, "stringAdd", arg));
                return temp0;
            }
            else if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst(((IntegerConst) address1).value + ((IntegerConst) address2).value);
                return result;
            }
            else if(address1 instanceof IntegerConst){
                list.add(new ArithmeticExpr(temp, address2, ArithmeticOp.ADD, address1));
            }
            else list.add(new ArithmeticExpr(temp, address1, ArithmeticOp.ADD, address2));
        }
        if(op == BinaryOp.left_op){
            if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst(((IntegerConst) address1).value << ((IntegerConst) address2).value);
                return result;
            }
            else if(address1 instanceof IntegerConst){
                Temp temp0 = new Temp();
                list.add(new Assign(temp, address1));
                list.add(new ArithmeticExpr(temp, temp0, ArithmeticOp.SHL, address2));
            }
            else list.add(new ArithmeticExpr(temp, address1, ArithmeticOp.SHL, address2));
        }
        if(op == BinaryOp.right_op){
            if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst(((IntegerConst) address1).value >> ((IntegerConst) address2).value);
                return result;
            }
            else if(address1 instanceof IntegerConst){
                Temp temp0 = new Temp();
                list.add(new Assign(temp, address1));
                list.add(new ArithmeticExpr(temp, temp0, ArithmeticOp.SHR, address2));
            }
            else list.add(new ArithmeticExpr(temp, address1, ArithmeticOp.SHR, address2));
        }
        if(op == BinaryOp.multi_op){
            if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst(((IntegerConst) address1).value * ((IntegerConst) address2).value);
                return result;
            }
            else if(address1 instanceof IntegerConst){
                list.add(new ArithmeticExpr(temp, address2, ArithmeticOp.MUL, address1));
            }
            list.add(new ArithmeticExpr(temp, address1, ArithmeticOp.MUL, address2));
        }
        if(op == BinaryOp.minus_op){
            if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst(((IntegerConst) address1).value - ((IntegerConst) address2).value);
                return result;
            }
            else if(address1 instanceof IntegerConst){
                Temp temp0 = new Temp();
                list.add(new Assign(temp0, address1));
                list.add(new ArithmeticExpr(temp, temp0, ArithmeticOp.SUB, address2));
            }
            else list.add(new ArithmeticExpr(temp, address1, ArithmeticOp.SUB, address2));
        }
        if(op == BinaryOp.div_op){
            if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst(((IntegerConst) address1).value / ((IntegerConst) address2).value);
                return result;
            }
            else if(address1 instanceof IntegerConst){
                Temp temp0 = new Temp();
                list.add(new Assign(temp, address1));
                list.add(new ArithmeticExpr(temp, temp0, ArithmeticOp.DIV, address2));
            }
            else list.add(new ArithmeticExpr(temp, address1, ArithmeticOp.DIV, address2));
        }
        if(op == BinaryOp.mod_op){
            if(address1 instanceof IntegerConst && address2 instanceof IntegerConst){
                IntegerConst result = new IntegerConst(((IntegerConst) address1).value % ((IntegerConst) address2).value);
                return result;
            }
            else if(address1 instanceof IntegerConst){
                Temp temp0 = new Temp();
                list.add(new Assign(temp, address1));
                list.add(new ArithmeticExpr(temp, temp0, ArithmeticOp.MOD, address2));
            }
            else list.add(new ArithmeticExpr(temp, address1, ArithmeticOp.MOD, address2));
        }
        return temp;
    }
}
