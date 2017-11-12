/**
 * Created by zhangjiaheng on 16/4/6.
 */


import antlr.BuildListener;
import antlr.zzzLexer;
import antlr.zzzParser;
import ast.*;
import javafx.util.Pair;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;
import java.util.Stack;


/**
 * Created by abcdabcd987 on 2016-04-02.
 */
public class MidTerm {
    static int scope = 0;

    public static void main(String... args) throws IOException {
        /*try {
            System.out.println(filename);
            InputStream is = new FileInputStream(filename); // or System.in;
            ANTLRInputStream input = new ANTLRInputStream(is);
            //ANTLRInputStream input = new ANTLRInputStream(System.in);
            zzzLexer lexer = new zzzLexer(input);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            zzzParser parser = new zzzParser(tokens);
            ParseTree tree = parser.program(); // calc is the starting rule
            Boolean tet = true;
            if (parser.getNumberOfSyntaxErrors() != 0) {
                tet = false;
            }

            ParseTreeWalker walker = new ParseTreeWalker();
            BuildListener evalByListener = new BuildListener();
            walker.walk(evalByListener, tree);
            System.out.println("Listener:");

            // ast root = evalByListener.stack.peek();
            //   Printer printer = new Printer();
            // printer.visit(root);

            //    System.out.println(evalByListener.stack.peek().toString(0));
            boolean pass = tet;

            Table table = new Table();
            //System.out.println(evalByListener.stack.peek().round_1(table));
            pass = pass & evalByListener.stack.peek().round_1(table);

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
            table.put(Symbol.symbol("getString"), new Pair<>(funcDec2, 0));
            if (((FuncDec) ((Pair) table.get(Symbol.symbol("getString"))).getKey()).compoundvardec == null)
                System.out.println("SUCK");

            FuncDec funcDec3 = new FuncDec(new IntType(), Symbol.symbol("getInt"), null, null);
            table.put(Symbol.symbol("getInt"), new Pair<>(funcDec3, 0));

            CompoundVarDec compoundVarDec2 = new CompoundVarDec();
            compoundVarDec2.vardeclist.add(new VarDec(new IntType(), Symbol.symbol("i")));
            FuncDec funcDec4 = new FuncDec(new StringType(), Symbol.symbol("toString"), compoundVarDec2, null);
            table.put(Symbol.symbol("toString"), new Pair<>(funcDec4, 0));

            //System.out.println("hehehe");
            //System.out.println(evalByListener.stack.peek().round_2(table));
            pass &= evalByListener.stack.peek().round_2(table);
            //System.out.println("hehehe");
            Stack<ast> stack = new Stack<ast>();
            //System.out.println(evalByListener.stack.peek().round_3(table, new FuncDec(), stack));
            //System.out.println("hehehe");
            pass &= evalByListener.stack.peek().round_3(table, new FuncDec(), stack, scope);
            if (!pass) {
                throw new CompileError("!!!!");
            }
            if (!shouldPass) {
                fail("should not pass");
            }
        } catch (CompileError e) {
            if (shouldPass) {
                throw e;
            }
        }*/

        //InputStream is = new FileInputStream(filename);
        InputStream is = System.in;
        ANTLRInputStream input = new ANTLRInputStream(is);
        zzzLexer lexer = new zzzLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        zzzParser parser = new zzzParser(tokens);
        ParseTree tree = parser.program(); // calc is the starting rule

        ParseTreeWalker walker = new ParseTreeWalker();
        BuildListener evalByListener = new BuildListener();
        walker.walk(evalByListener, tree);

//        System.out.println(evalByListener.stack.peek().toString(0));

        boolean pass = parser.getNumberOfSyntaxErrors() == 0;

        Table table = new Table();

        System.out.println("**********ROUND 1**********");
        pass &= evalByListener.stack.peek().round_1(table);


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

        System.out.println("**********ROUND 2**********");
        pass &= evalByListener.stack.peek().round_2(table);

        System.out.println("**********ROUND 3**********");
        pass &= evalByListener.stack.peek().round_3(table, new FuncDec(), new Stack<>(), 0);
        if(!pass){
            System.exit(1);
        }
    }

}
