package translate;

import IR.*;
import IR.Function;
import IR.Quadruple;
import ast.BinaryExp;
import cfg.BasicBlock;
import cfg.FunctionCFG;
import cfg.Node;


import java.io.OutputStream;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.util.ArrayList;

import static IR.MIPSRegister.k0;
import static IR.MIPSRegister.v0;

/**
 * Created by zhangjiaheng on 16/5/4.
 */
public class Translate {
    public static ArrayList<Temp> globals;
    public static ArrayList<Temp> strings;

    private PrintStream output;
    private IR program;
    private GlobalTempAllocate allocator;

    public Translate(PrintStream output, IR program) {
        this.output = output;
        this.program = program;
    }

    MIPSRegister loadToRead(Address virtual, MIPSRegister recommend) {
        if(virtual == null) return null;
        else if(virtual instanceof IntegerConst){
            output.printf("\tli %s, %s\n", recommend, ((IntegerConst) virtual).value);
            return recommend;
        }
        else if (allocator.mapping.containsKey(virtual)) {
            return allocator.mapping.get(virtual);
        }
        Temp temp = (Temp)virtual;
        if (temp.isString) {
            output.printf("\tla %s, string_%s\n", recommend, temp.num);
        }
        else if (temp.isGlobal) {
            output.printf("\tlw %s, global_%d\n", recommend, temp.num);
        } else {
            output.printf("\tlw %s, %d(%s)\n", recommend, ((Temp) virtual).num * 4, "$sp");
        }
        return recommend;
    }

    MIPSRegister loadToWrite(Temp virtual, MIPSRegister recommend) {
        if (allocator.mapping.containsKey(virtual)) {
            return allocator.mapping.get(virtual);
        }

        return recommend;
    }

    MIPSRegister store(MIPSRegister register, Address virtual){
        if(allocator.mapping.containsKey(virtual)){
            return allocator.mapping.get(virtual);
        }
        else {
            Temp temp = (Temp)virtual;
            if (temp.isString) {
                output.printf("\tla %s, string_%s\n", register, temp.num);
            }
            else if (temp.isGlobal) {
                output.printf("\tsw %s, global_%d\n", register, temp.num);
            } else {
                output.printf("\tsw %s, %d(%s)\n", register, ((Temp) virtual).num * 4, "$sp");
            }
            return register;
        }
    }
    void move(Address virtual, MIPSRegister recommend){
        if (virtual instanceof IntegerConst){
            output.printf("\tli %s, %s\n", recommend, ((IntegerConst) virtual).value);
        }
        else if(allocator.mapping.containsKey(virtual)){
            output.printf("\tmove %s, %s\n", recommend, allocator.mapping.get(virtual));
        }
        else {
            Temp temp = (Temp) virtual;
            if (temp.isString) {
                output.printf("\tla %s, string_%s\n", recommend, temp.num);
            } else if (temp.isGlobal) {
                output.printf("\tlw %s, global_%d\n", recommend, temp.num);
            } else {
                output.printf("\tlw %s, %d(%s)\n", recommend, ((Temp) virtual).num * 4, "$sp");
            }
        }
    }

    void move(MIPSRegister from, Address to) {

        if (allocator.mapping.containsKey(to)) {
            output.printf("\tmove %s, %s\n", allocator.mapping.get(to), from);
        } else {
            Temp temp = (Temp)to;
            if (temp.isString) {
                output.printf("\tla %s, string_%s\n", from, temp.num);
            }
            else if (temp.isGlobal) {
                output.printf("\tsw %s, global_%d\n", from, temp.num);
            } else {
                output.printf("\tsw %s, %d(%s)\n", from, temp.num * 4, "$sp");
            }
        }
    }

    private void translate(FunctionCFG cfg) {
        allocator = cfg.allocator;
        output.printf("\tsub $sp, $sp, %d\n", cfg.function.tempnum * 4 + 32 * 4);
        for (int i: allocator.set) {
            output.printf("\tsw %s, %d($sp)\n", MIPSRegister.get(i), cfg.function.tempnum * 4 + i * 4);
        }
        output.printf("\tsw $ra, %d($sp)\n", cfg.function.tempnum * 4 + 30 * 4);
        for (Node node : cfg.graphnode) {
            BasicBlock block = node.basicBlock;
            for (Quadruple quadruple : block.instr) {
                if (quadruple instanceof Label) {
                    output.printf("label_%d:\n", ((Label) quadruple).num);
                }
                if (quadruple instanceof ArithmeticExpr) {

                    if (((ArithmeticExpr) quadruple).op == ArithmeticOp.ADD && ((ArithmeticExpr) quadruple).src2 instanceof IntegerConst){
                        MIPSRegister a = loadToRead(((ArithmeticExpr) quadruple).src1, MIPSRegister.t0);
                        MIPSRegister c = loadToWrite((Temp) ((ArithmeticExpr) quadruple).dest, MIPSRegister.t1);
                        output.printf("\taddi %s, %s, %d\n", c, a, ((IntegerConst)((ArithmeticExpr)quadruple).src2).value);
                        store(c, ((ArithmeticExpr) quadruple).dest);
                    }
                    else if (((ArithmeticExpr) quadruple).op == ArithmeticOp.MUL &&
                            ((ArithmeticExpr) quadruple).src2 instanceof IntegerConst &&
                            ((IntegerConst)((ArithmeticExpr)quadruple).src2).value == 4){
                        MIPSRegister a = loadToRead(((ArithmeticExpr) quadruple).src1, MIPSRegister.t0);
                        MIPSRegister c = loadToWrite((Temp) ((ArithmeticExpr) quadruple).dest, MIPSRegister.t1);
                        output.printf("\tmul %s, %s, $k0\n", c, a);
                        store(c, ((ArithmeticExpr) quadruple).dest);
                    }
                    else {
                    MIPSRegister a = loadToRead(((ArithmeticExpr) quadruple).src1, MIPSRegister.t0);
                    MIPSRegister b = loadToRead(((ArithmeticExpr) quadruple).src2, MIPSRegister.t1);
                    MIPSRegister c = loadToWrite((Temp) ((ArithmeticExpr) quadruple).dest, MIPSRegister.t1);
                    if (((ArithmeticExpr) quadruple).op == ArithmeticOp.ADD){
                        output.printf("\taddu %s, %s, %s\n", c, a, b);
                    }
                    if (((ArithmeticExpr) quadruple).op == ArithmeticOp.SUB){
                        output.printf("\tsub %s, %s, %s\n", c, a, b);
                    }
                    if (((ArithmeticExpr) quadruple).op == ArithmeticOp.MUL){
                        output.printf("\tmul %s, %s, %s\n", c, a, b);
                    }
                    if (((ArithmeticExpr) quadruple).op == ArithmeticOp.DIV){
                        output.printf("\tdiv %s, %s, %s\n", c, a, b);
                    }
                    if (((ArithmeticExpr) quadruple).op == ArithmeticOp.AND){
                        output.printf("\tand %s, %s, %s\n", c, a, b);
                    }
                    if (((ArithmeticExpr) quadruple).op == ArithmeticOp.OR){
                        output.printf("\tor %s, %s, %s\n", c, a, b);
                    }
                    if (((ArithmeticExpr) quadruple).op == ArithmeticOp.XOR){
                        output.printf("\txor %s, %s, %s\n", c, a, b);
                    }
                    if (((ArithmeticExpr) quadruple).op == ArithmeticOp.MOD){
                        output.printf("\trem %s, %s, %s\n", c, a, b);
                    }
                    if (((ArithmeticExpr) quadruple).op == ArithmeticOp.SHL){
                        output.printf("\tsll %s, %s, %s\n", c, a, b);
                    }
                    if (((ArithmeticExpr) quadruple).op == ArithmeticOp.SHR){
                        output.printf("\tsrl %s, %s, %s\n", c, a, b);
                    }
                    if (((ArithmeticExpr) quadruple).op == ArithmeticOp.TILDE){
                        output.printf("\tnot %s, %s\n", c, a);
                    }
                    if (((ArithmeticExpr) quadruple).op == ArithmeticOp.MINUS){
                        output.printf("\tneg %s, %s\n", c, a);
                    }
                        store(c, ((ArithmeticExpr) quadruple).dest);
                    }
                }
                if(quadruple instanceof RelationExpr){
                    MIPSRegister a = loadToRead(((RelationExpr) quadruple).src1, MIPSRegister.t0);
                    MIPSRegister b = loadToRead(((RelationExpr) quadruple).src2, MIPSRegister.t1);
                    MIPSRegister c = loadToWrite((Temp) ((RelationExpr) quadruple).dest, MIPSRegister.t1);
                    if (((RelationExpr) quadruple).op == RelationalOp.LE){
                        output.printf("\tsle %s, %s, %s\n", c, a, b);
                    }
                    if (((RelationExpr) quadruple).op == RelationalOp.GE){
                        output.printf("\tsge %s, %s, %s\n", c, a, b);
                    }
                    if (((RelationExpr) quadruple).op == RelationalOp.LT){
                        output.printf("\tslt %s, %s, %s\n", c, a, b);
                    }
                    if (((RelationExpr) quadruple).op == RelationalOp.GT){
                        output.printf("\tsgt %s, %s, %s\n", c, a, b);
                    }
                    if (((RelationExpr) quadruple).op == RelationalOp.EQ){
                        output.printf("\tseq %s, %s, %s\n", c, a, b);
                    }
                    if (((RelationExpr) quadruple).op == RelationalOp.NE){
                        output.printf("\tsne %s, %s, %s\n", c, a, b);
                    }
                    store(c, ((RelationExpr) quadruple).dest);
                }
                if(quadruple instanceof Assign){
                    MIPSRegister a = loadToRead(((Assign) quadruple).src, MIPSRegister.t1);
                    move(a, ((Assign) quadruple).dest);
                }
                if(quadruple instanceof Goto){
                    output.printf("\tb label_%d\n", ((Goto) quadruple).label.num);
                }
                if(quadruple instanceof Branch){
                    MIPSRegister a = loadToRead(((Branch) quadruple).address, MIPSRegister.t1);
                    output.printf("\tbeqz %s, label_%d\n", a, ((Branch) quadruple).end.num);
                    output.printf("\tb label_%d\n", ((Branch) quadruple).begin.num);
                }
                if(quadruple instanceof Call){
                    if (((Call) quadruple).caller != null) {
                        if (((Call) quadruple).caller.args != null) {
                            for (int i = 0; i < ((Call) quadruple).caller.args.size(); i++) {
                                MIPSRegister a = loadToRead(((Call) quadruple).arrayList.get(i), MIPSRegister.t1);
                                output.printf("\tsw %s, %s($sp)\n", a, -(((Call) quadruple).caller.tempnum + 1 - i + 31) * 4);
                            }
                        }
                        output.printf("\tjal _%s\n", ((Call) quadruple).name);
                    } else {
                        if (((Call) quadruple).arrayList.size() == 1) {
                            move(((Call) quadruple).arrayList.get(0), MIPSRegister.a0);
                        }
                        if (((Call) quadruple).arrayList.size() == 2) {
                            move(((Call) quadruple).arrayList.get(0), MIPSRegister.a0);
                            move(((Call) quadruple).arrayList.get(1), MIPSRegister.a1);
                        }
                        if (((Call) quadruple).arrayList.size() == 3) {
                            move(((Call) quadruple).arrayList.get(0), MIPSRegister.a0);
                            move(((Call) quadruple).arrayList.get(1), MIPSRegister.a1);
                            move(((Call) quadruple).arrayList.get(2), MIPSRegister.a2);
                        }
                        if (((Call) quadruple).arrayList.size() == 4) {
                            move(((Call) quadruple).arrayList.get(0), MIPSRegister.a0);
                            move(((Call) quadruple).arrayList.get(1), MIPSRegister.a1);
                            move(((Call) quadruple).arrayList.get(2), MIPSRegister.a2);
                            move(((Call) quadruple).arrayList.get(3), MIPSRegister.a3);
                        }
                        output.printf("\tjal %s\n", ((Call) quadruple).name);
                    }
                    if (((Call) quadruple).returnValue != null) {
                        move(MIPSRegister.v0, ((Call) quadruple).returnValue);
                    }
                }
                if(quadruple instanceof Return){
                    if(((Return) quadruple).address != null){
                    //    MIPSRegister a = loadToRead((Return) quadruple).address, MIPRegister.v0);
                        move(((Return) quadruple).address, MIPSRegister.v0);
                    }
                }
                if(quadruple instanceof MemoryRead){
                    MIPSRegister a = loadToRead(((MemoryRead) quadruple).src, MIPSRegister.t0);
                    MIPSRegister b = loadToWrite((Temp) ((MemoryRead) quadruple).dest, MIPSRegister.t1);
                    output.printf("\tlw %s, %d(%s)\n", b, ((MemoryRead) quadruple).offset.value, a);
                    store(b, ((MemoryRead) quadruple).dest);
                }
                if(quadruple instanceof MemoryWrite){
                    MIPSRegister a = loadToRead(((MemoryWrite) quadruple).src, MIPSRegister.t0);
                    MIPSRegister b= loadToRead(((MemoryWrite) quadruple).dest, MIPSRegister.t1);
                    output.printf("\tsw %s, %d(%s)\n", a, ((MemoryWrite) quadruple).offset.value, b);
                }
                if (quadruple instanceof Allocate) {
                    move(((Allocate) quadruple).size, MIPSRegister.a0);
                    output.printf("\tli $v0, 9\n");
                    output.printf("\tsyscall\n");
                    move(MIPSRegister.v0, ((Allocate) quadruple).address);
                }
            }
        }
/*
        if (cfg.function.name.equals("main")) {
            output.printf("\tmove $a0, $v0\n");
            output.printf("\tli $v0, 1\n");
            output.printf("\tsyscall\n");
        }
*/
        output.printf("\tlw $ra, %d($sp)\n", cfg.function.tempnum * 4 + 30 * 4);
        for (int i : allocator.set) {
            output.printf("\tlw %s, %d($sp)\n", MIPSRegister.get(i), cfg.function.tempnum * 4 + i * 4);
        }
        output.printf("\taddu $sp, $sp, %d\n", cfg.function.tempnum * 4 + 32 * 4);
        output.printf("\tjr $ra\n");
    }

    public void translate() {
        output.printf("\t.text\n" +
                "print:\n" +
                "\tli $v0, 4\n" +
                "\tsyscall\n" +
                "\tjr $ra\n" +
                "\n" +
                "____builtin____print_int:\n" +
                "\tli $v0, 1\n" +
                "\tsyscall\n" +
                "\tjr $ra\n" +
                "\n" +
                "println:\n" +
                "\tli $v0, 4\n" +
                "\tsyscall\n" +
                "\tla $a0, ____string_newline\n" +
                "\tsyscall\n" +
                "\tjr $ra\n" +
                "\n" +
                "getString:\n" +
                "\tla $a0 ____string_buffer\n" +
                "\tli $a1 1024\n" +
                "\tli $v0 8\n" +
                "\tsyscall\n" +
                "\tmove $v1 $a0\n" +
                "\tli $a1 0\n" +
                "Label2_Cond:\n" +
                "\tlb $v0 ($a0)\n" +
                "\tbeqz $v0 Label2_StrSpace\n" +
                "\tadd $a1 $a1 1\n" +
                "\tadd $a0 $a0 1\n" +
                "\tj Label2_Cond\n" +
                "Label2_StrSpace:\n" +
                "\tadd $a0 $a1 5\n" +
                "\tli $v0 9\n" +
                "\tsyscall\n" +
                "\tsw $a1 ($v0)\n" +
                "\tadd $v0 $v0 4\n" +
                "\tmove $a0 $v0\n" +
                "\tla $a1 ____string_buffer\n" +
                "Label2_CopyCond:\n" +
                "\tlb $v1 ($a1)\n" +
                "\tbeqz $v1 Label2_End\n" +
                "\tsb $v1 ($a0)\n" +
                "\tadd $a0 $a0 1\n" +
                "\tadd $a1 $a1 1\n" +
                "\tj Label2_CopyCond\n" +
                "Label2_End:\n" +
                "\tsb $0 ($a0)\n" +
                "\tjr $ra\n" +
                "\n" +
                "getInt:\n" +
                "\tli $v0, 5\n" +
                "\tsyscall\n" +
                "\tjr $ra\n" +
                "\n" +
                "toString:\n" +
                "Label12_ToString:\n" +
                "\tmove $a1 $a0\n" +
                "\tli $a0 16\n" +
                "\tli $v0 9\n" +
                "\tsyscall\n" +
                "\tbnez $a1 Label12_NotZero\n" +
                "\tlb $0 5($v0)\n" +
                "\tli $a0 48\n" +
                "\tsb $a0 4($v0)\n" +
                "\tli $a0 1\n" +
                "\tsb $a0 ($v0)\n" +
                "\tj Label12_EndToString\n" +
                "Label12_NotZero:\n" +
                "\tslt $v1 $a1 0\n" +
                "\tadd $a3 $v0 15\n" +
                "\tsb $0 ($a3)\n" +
                "Label12_Cond:\n" +
                "\tbeqz $a1 Label12_EndLoop\n" +
                "\trem $a0 $a1 10\n" +
                "\tdiv $a1 $a1 10\n" +
                "\tbeqz $v1 Label12_LoadChar\n" +
                "\tble $a0 0 Label12_ToNeg\n" +
                "\tadd $a0 $a0 -10\n" +
                "Label12_ToNeg:\n" +
                "\tneg $a0 $a0\n" +
                "Label12_LoadChar:\n" +
                "\tadd $a0 $a0 48\n" +
                "\tadd $a3 $a3 -1\n" +
                "\tsb $a0 ($a3)\n" +
                "\tj Label12_Cond\n" +
                "Label12_EndLoop:\n" +
                "\tbeqz $v1 Label12_Copy\n" +
                "\tli $a0 45\n" +
                "\tadd $a3 $a3 -1\n" +
                "\tsb $a0 ($a3)\n" +
                "Label12_Copy:\n" +
                "\tsub $v1 $v0 $a3\n" +
                "\tadd $v1 $v1 16\n" +
                "\tsw $v1 ($v0)\n" +
                "\tadd $v1 $v0 4\n" +
                "Label12_CopyCond:\n" +
                "\tlb $a0 ($a3)\n" +
                "\tsb $a0 ($v1)\n" +
                "\tadd $a3 $a3 1\n" +
                "\tadd $v1 $v1 1\n" +
                "\tbnez $a0 Label12_CopyCond\n" +
                "Label12_EndToString:\n" +
                "\tadd $v0 $v0 4\n" +
                "\tjr $ra\n" +
                "\n" +
                "size:\n" +
                "\tlw $v0, 0($a0)\n" +
                "\tjr $ra\n" +
                "\n" +
                "length:\n" +
                "\tlw $v0, -4($a0)\n" +
                "\tjr $ra\n" +
                "\n" +
                "ord:\n" +
                "\taddu $a0, $a0, $a1\n" +
                "\tlb $v0, 0($a0)\n" +
                "\tjr $ra\n" +
                "\n" +
                "substring:\n" +
                "\tadd $a2 $a2 1\n" +
                "\tadd $a1 $a0 $a1\n" +
                "\tadd $a2 $a0 $a2\n" +
                "\tsub $v1 $a2 $a1\n" +
                "\tadd $a0 $v1 5\n" +
                "\tli $v0 9\n" +
                "\tsyscall\n" +
                "\tsw $v1 ($v0)\n" +
                "\tadd $v0 $v0 4\n" +
                "\tmove $a0 $v0\n" +
                "Label1_Loop:\n" +
                "\tbeq $a1 $a2 Label1_End\n" +
                "\tlb $v1 ($a1)\n" +
                "\tsb $v1 ($a0)\n" +
                "\tadd $a0 $a0 1\n" +
                "\tadd $a1 $a1 1\n" +
                "\tj Label1_Loop\n" +
                "Label1_End:\n" +
                "\tsb $0 ($a0)\n" +
                "\tjr $ra\n" +
                "\n" +
                "parseInt:\n" +
                "\tli $v0 0\n" +
                "\tlb $a3 ($a0)\n" +
                "\tseq $v1 $a3 45\n" +
                "\tadd $a0 $a0 $v1\n" +
                "Label0_Cond:\n" +
                "\tlb $a3 ($a0)\n" +
                "\tblt $a3 48 Label0_Next\n" +
                "\tbgt $a3 57 Label0_Next\n" +
                "\tadd $a3 $a3 -48\n" +
                "\tbeqz $v1 Label0_NotNeg\n" +
                "\tneg $a3 $a3\n" +
                "Label0_NotNeg:\n" +
                "\tmul $v0 $v0 10\n" +
                "\tadd $v0 $v0 $a3\n" +
                "\tadd $a0 $a0 1\n" +
                "\tj Label0_Cond\n" +
                "Label0_Next:\n" +
                "\tjr $ra\n" +
                "\n" +
                "stringAdd:\n" +
                "\tmove $v1 $a0\n" +
                "\tlw $v0 -4($a0)\n" +
                "\tlw $a0 -4($a1)\n" +
                "\tadd $a0 $a0 $v0\n" +
                "\tmove $a2 $a0\n" +
                "\tadd $a0 $a0 5\n" +
                "\tli $v0 9\n" +
                "\tsyscall\n" +
                "\tsw $a2 ($v0)\n" +
                "\tadd $v0 $v0 4\n" +
                "\tmove $a0 $v0\n" +
                "Label5_CopyFirst:\n" +
                "\tlb $a2 ($v1)\n" +
                "\tbeqz $a2 Label5_CopySecond\n" +
                "\tsb $a2 ($a0)\n" +
                "\tadd $a0 $a0 1\n" +
                "\tadd $v1 $v1 1\n" +
                "\tj Label5_CopyFirst\n" +
                "Label5_CopySecond:\n" +
                "\tlb $v1 ($a1)\n" +
                "\tbeqz $v1 Label5_End\n" +
                "\tsb $v1 ($a0)\n" +
                "\tadd $a0 $a0 1\n" +
                "\tadd $a1 $a1 1\n" +
                "\tj Label5_CopySecond\n" +
                "Label5_End:\n" +
                "\tsb $0 ($a0)\n" +
                "\tjr $ra\n" +
                "\n" +
                "stringEquals:\n" +
                "Label6_Begin:\n" +
                "\tlb $v0 ($a0)\n" +
                "\tlb $v1 ($a1)\n" +
                "\tbeqz $v0 Label6_End\n" +
                "\tbeqz $v1 Label6_End\n" +
                "\tadd $a0 $a0 1\n" +
                "\tadd $a1 $a1 1\n" +
                "\tj Label6_Begin\n" +
                "Label6_End:\n" +
                "\tseq $v0 $v0 $v1\n" +
                "\tjr $ra\n" +
                "\n" +
                "____builtin_string____greater_than:\n" +
                "Label7_Begin:\n" +
                "\tlb $v0 ($a0)\n" +
                "\tlb $v1 ($a1)\n" +
                "\tbeqz $v0 Label7_End\n" +
                "\tbeqz $v1 Label7_End\n" +
                "\tadd $a0 $a0 1\n" +
                "\tadd $a1 $a1 1\n" +
                "\tj Label7_Begin\n" +
                "Label7_End:\n" +
                "\tsgt $v0 $v0 $v1\n" +
                "\tjr $ra\n" +
                "\n" +
                "____builtin_string____greater_than_or_equal_to:\n" +
                "Label8_Begin:\n" +
                "\tlb $v0 ($a0)\n" +
                "\tlb $v1 ($a1)\n" +
                "\tbeqz $v0 Label8_End\n" +
                "\tbeqz $v1 Label8_End\n" +
                "\tadd $a0 $a0 1\n" +
                "\tadd $a1 $a1 1\n" +
                "\tj Label8_Begin\n" +
                "Label8_End:\n" +
                "\tsge $v0 $v0 $v1\n" +
                "\tjr $ra\n" +
                "\n" +
                "stringLessThan:\n" +
                "Label9_Begin:\n" +
                "\tlb $v0 ($a0)\n" +
                "\tlb $v1 ($a1)\n" +
                "\tbeqz $v0 Label9_End\n" +
                "\tbeqz $v1 Label9_End\n" +
                "\tadd $a0 $a0 1\n" +
                "\tadd $a1 $a1 1\n" +
                "\tj Label9_Begin\n" +
                "Label9_End:\n" +
                "\tslt $v0 $v0 $v1\n" +
                "\tjr $ra\n" +
                "\n" +
                "stringLessThanOrEquals:\n" +
                "Label10_Begin:\n" +
                "\tlb $v0 ($a0)\n" +
                "\tlb $v1 ($a1)\n" +
                "\tbeqz $v0 Label10_End\n" +
                "\tbeqz $v1 Label10_End\n" +
                "\tadd $a0 $a0 1\n" +
                "\tadd $a1 $a1 1\n" +
                "\tj Label10_Begin\n" +
                "Label10_End:\n" +
                "\tsle $v0 $v0 $v1\n" +
                "\tjr $ra\n" +
                "\n" +
                "____builtin_string____not_equal_to:\n" +
                "Label11_Begin:\n" +
                "\tlb $v0 ($a0)\n" +
                "\tlb $v1 ($a1)\n" +
                "\tbeqz $v0 Label11_End\n" +
                "\tbeqz $v1 Label11_End\n" +
                "\tadd $a0 $a0 1\n" +
                "\tadd $a1 $a1 1\n" +
                "\tj Label11_Begin\n" +
                "Label11_End:\n" +
                "\tsne $v0 $v0 $v1\n" +
                "\tjr $ra\n");
        int a = 0;
        for(Function function : program.functionArrayList){
            if(function.name.equals("getcount")){
                a = 1;
                break;
            }
        }
        for (Function function : program.functionArrayList) {
            if (!function.name.equals("main")) {
                output.print("_");
            }
            output.println(function.name + ":");
            if(function.name.equals("main"))
                output.printf("\tli $k0, 4\n");
            function.cfg.allocator = new GlobalTempAllocate(function.cfg);
            if (a == 0){
            //    function.cfg.allocator = new GlobalTempAllocate(function.cfg);
         //   System.out.println(function.cfg.allocator);
                function.cfg.allocator.BuildInterferenceGraph();
                function.cfg.allocator.BottomUpColoring(20);
            }
            translate(function.cfg);
        }

        output.printf("\t.data\n" +
                "____string_buffer:\n" +
                "\t.space 1024\n" +
                "\t.align 2\n" +
                "____string_newline:\n" +
                "\t.asciiz \"\\n\"\n" +
                "\t.align 2\n");
        for (Temp temp : strings) {
            String literal = temp.name;
            int length = literal.length() - 2;
            for (int i = 1; i < literal.length() - 1; i++){
                if(literal.charAt(i) == '\\')
                    length--;
            }
           output.printf(".word %d\n", length);

            output.printf("string_%s:\n", temp.num);
            output.printf(".asciiz %s\n.align 2\n", temp.name);
        }
        for (Temp temp : globals) {
            output.printf("global_%d:\n", temp.num);
            output.printf(".space 4\n.align 2\n");
        }
    }
}
