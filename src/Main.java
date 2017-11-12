/**
 * Created by zhangjiaheng on 16/4/3.
 */

import antlr.BuildListener;
import antlr.zzzLexer;
import antlr.zzzParser;
import ast.*;
import IR.*;
import javafx.util.Pair;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import translate.Translate;

import java.io.*;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Stack;

public class Main {

    public void compile(InputStream source, OutputStream output) throws IOException {
        //   InputStream is = System.in;
        ANTLRInputStream input = new ANTLRInputStream(source);
        zzzLexer lexer = new zzzLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        zzzParser parser = new zzzParser(tokens);
        ParseTree tree = parser.program(); // calc is the starting rule

        ParseTreeWalker walker = new ParseTreeWalker();
        BuildListener evalByListener = new BuildListener();
        walker.walk(evalByListener, tree);

        Table table = new Table();
        evalByListener.stack.peek().round_1(table);


        CompoundVarDec compoundVarDec = new CompoundVarDec();
        compoundVarDec.vardeclist.add(new VarDec(new StringType(), Symbol.symbol("str")));
        FuncDec funcDec = new FuncDec(new VoidType(), Symbol.symbol("print"), compoundVarDec, null);
        table.put(Symbol.symbol("print"), new Pair<>(funcDec, 0));

        CompoundVarDec compoundVarDec1 = new CompoundVarDec();
        compoundVarDec1.vardeclist = new LinkedList<>();
        StringType stp = new StringType();
        VarDec varDec = new VarDec(stp, Symbol.symbol("str"));
        compoundVarDec1.vardeclist.add(varDec);

        FuncDec funcDec1 = new FuncDec(new VoidType(), Symbol.symbol("println"), compoundVarDec1, null);
        table.put(Symbol.symbol("println"), new Pair<>(funcDec1, 0));
        FuncDec funcDec2 = new FuncDec(new StringType(), Symbol.symbol("getString"), null, null);
        table.put(Symbol.symbol("getString"), new Pair<>(funcDec2,0));
        FuncDec funcDec3 = new FuncDec(new IntType(), Symbol.symbol("getInt"), null, null);
        table.put(Symbol.symbol("getInt"), new Pair<>(funcDec3, 0));

        CompoundVarDec compoundVarDec2 = new CompoundVarDec();
        compoundVarDec2.vardeclist.add(new VarDec(new IntType(), Symbol.symbol("i")));
        FuncDec funcDec4 = new FuncDec(new StringType(), Symbol.symbol("toString"), compoundVarDec2, null);
        table.put(Symbol.symbol("toString"), new Pair<>(funcDec4,0));

        CompoundVarDec compoundVarDec3 = new CompoundVarDec();
        compoundVarDec3.vardeclist.add(new VarDec(new StringType(), Symbol.symbol("str1")));
        compoundVarDec3.vardeclist.add(new VarDec(new StringType(), Symbol.symbol("str2")));
        FuncDec funcDec5 = new FuncDec(new StringType(), Symbol.symbol("stringAdd"), compoundVarDec3, null);
        table.put(Symbol.symbol("stringAdd"), new Pair<>(funcDec5,0));

        CompoundVarDec compoundVarDec4 = new CompoundVarDec();
        compoundVarDec4.vardeclist.add(new VarDec(new StringType(), Symbol.symbol("str")));
        compoundVarDec4.vardeclist.add(new VarDec(new IntType(), Symbol.symbol("i")));
        compoundVarDec4.vardeclist.add(new VarDec(new IntType(), Symbol.symbol("j")));
        FuncDec funcDec6 = new FuncDec(new StringType(), Symbol.symbol("substring"), compoundVarDec4, null);
        table.put(Symbol.symbol("substring"), new Pair<>(funcDec6,0));

        CompoundVarDec compoundVarDec5 = new CompoundVarDec();
        compoundVarDec5.vardeclist.add(new VarDec(new StringType(), Symbol.symbol("str1")));
        compoundVarDec5.vardeclist.add(new VarDec(new StringType(), Symbol.symbol("str2")));
        FuncDec funcDec7 = new FuncDec(new BoolType(), Symbol.symbol("stringEquals"), compoundVarDec5, null);
        table.put(Symbol.symbol("stringEquals"), new Pair<>(funcDec7,0));

        CompoundVarDec compoundVarDec6 = new CompoundVarDec();
        compoundVarDec6.vardeclist.add(new VarDec(new StringType(), Symbol.symbol("str1")));
        compoundVarDec6.vardeclist.add(new VarDec(new StringType(), Symbol.symbol("str2")));
        FuncDec funcDec8 = new FuncDec(new BoolType(), Symbol.symbol("stringLessThan"), compoundVarDec6, null);
        table.put(Symbol.symbol("atringLessThan"), new Pair<>(funcDec8,0));

        CompoundVarDec compoundVarDec7 = new CompoundVarDec();
        compoundVarDec7.vardeclist.add(new VarDec(new StringType(), Symbol.symbol("str1")));
        compoundVarDec7.vardeclist.add(new VarDec(new StringType(), Symbol.symbol("str2")));
        FuncDec funcDec9 = new FuncDec(new BoolType(), Symbol.symbol("stringLessThanOrEquals"), compoundVarDec7, null);
        table.put(Symbol.symbol("stringLessThanOrEquals"), new Pair<>(funcDec9,0));

        CompoundVarDec compoundVarDec8 = new CompoundVarDec();
        compoundVarDec8.vardeclist.add(new VarDec(new StringType(), Symbol.symbol("str")));
        FuncDec funcDec10 = new FuncDec(new IntType(), Symbol.symbol("parseInt"), compoundVarDec8, null);
        table.put(Symbol.symbol("parseInt"), new Pair<>(funcDec10,0));

        CompoundVarDec compoundVarDec9 = new CompoundVarDec();
        compoundVarDec9.vardeclist.add(new VarDec(new ArrayType(), Symbol.symbol("str")));
        FuncDec funcDec11 = new FuncDec(new IntType(), Symbol.symbol("size"), compoundVarDec9, null);
        table.put(Symbol.symbol("size"), new Pair<>(funcDec11,0));

        CompoundVarDec compoundVarDec10 = new CompoundVarDec();
        compoundVarDec10.vardeclist.add(new VarDec(new StringType(), Symbol.symbol("str")));
        FuncDec funcDec12 = new FuncDec(new IntType(), Symbol.symbol("length"), compoundVarDec10, null);
        table.put(Symbol.symbol("length"), new Pair<>(funcDec12,0));

        CompoundVarDec compoundVarDec11 = new CompoundVarDec();
        compoundVarDec11.vardeclist.add(new VarDec(new StringType(), Symbol.symbol("str")));
        compoundVarDec11.vardeclist.add(new VarDec(new IntType(), Symbol.symbol("i")));
        FuncDec funcDec13 = new FuncDec(new IntType(), Symbol.symbol("ord"), compoundVarDec11, null);
        table.put(Symbol.symbol("ord"), new Pair<>(funcDec13,0));

        evalByListener.stack.peek().round_2(table);

        Stack<ast> stack = new Stack<>();
        evalByListener.stack.peek().round_3(table, new FuncDec(), stack, 0);

        Prog.program = (Prog) evalByListener.stack.peek();
        Translate.globals = new ArrayList<>();
        Translate.strings = new ArrayList<>();

        Table pos = new Table();

        IR program = ((Prog)evalByListener.stack.peek()).translate(pos, table);

        new Translate(new PrintStream(output), program).translate();
    }

    public static void main(String[] args) throws IOException {
        new Main().compile(System.in, System.out);
    }
}