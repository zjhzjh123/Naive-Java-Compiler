/**
 * Created by zhangjiaheng on 16/5/1.
 */
import IR.IR;
import antlr.BuildListener;
import antlr.zzzLexer;
import antlr.zzzParser;
import ast.*;
import com.sun.xml.internal.messaging.saaj.util.ByteInputStream;
import javafx.util.Pair;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import java.io.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;
import java.util.Stack;

import static org.junit.Assert.fail;

/**
 * Created by abcdabcd987 on 2016-04-13.
 */
@RunWith(Parameterized.class)
public class IRBuilderTest {
    @Parameterized.Parameters
    public static Collection<Object[]> data() {
        Collection<Object[]> params = new ArrayList<>();
        for (File f : new File("/Users/zhangjiaheng/IdeaProjects/compiler/testfile/ir/").listFiles()) {
            if (f.isFile() && f.getName().endsWith(".mx")) {
                params.add(new Object[] { "/Users/zhangjiaheng/IdeaProjects/compiler/testfile/ir/" + f.getName() });
            }
        }
        return params;
    }
    private String filename;
    public IRBuilderTest(String filename) {
        this.filename = filename;
    }
    @Test
    public void testPass() throws IOException, InterruptedException {
        System.out.println(filename);

        ByteArrayOutputStream irTextOut = new ByteArrayOutputStream();
        OutputStream tee = new TeeOutputStream(System.out, irTextOut); // if you need this, check out: https://gist.github.com/abcdabcd987/dbc9c82ccba90707da3e6f7d47a6468f
        PrintStream out = new PrintStream(tee);

        // ... Run your compiler
        //ir.accept(irPrinter);
        InputStream is = new FileInputStream(filename); // or System.in;
        //   InputStream is = System.in;
        ANTLRInputStream input = new ANTLRInputStream(is);
        zzzLexer lexer = new zzzLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        zzzParser parser = new zzzParser(tokens);
        ParseTree tree = parser.program(); // calc is the starting rule

        ParseTreeWalker walker = new ParseTreeWalker();
        BuildListener evalByListener = new BuildListener();
        walker.walk(evalByListener, tree);

        Table table = new Table();

      //  System.out.println(evalByListener.stack.peek().round_1(table));

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

        evalByListener.stack.peek().round_2(table);

        Stack<ast> stack = new Stack<>();
        evalByListener.stack.peek().round_3(table, new FuncDec(), stack, 0);
        Table pos = new Table();
        IR ret = ((Prog)evalByListener.stack.peek()).translate(pos, table);
        out.print(ret.print());
        out.flush();
        irTextOut.close();

        // Run the virtual machine
        byte[] irText = irTextOut.toByteArray();
        ByteInputStream vmIn = new ByteInputStream(irText, irText.length);
        LLIRInterpreter vm = new LLIRInterpreter(vmIn, false);
        vm.run();

        // Assert result
        BufferedReader br = new BufferedReader(new FileReader(filename));
        String line;
        do {
            line = br.readLine();
        } while (!line.startsWith("/*! assert:"));
        String assertion = line.replace("/*! assert:", "").trim();
        if (assertion.equals("exitcode")) {
            int expected = Integer.valueOf(br.readLine().trim());
            if (vm.getExitcode() != expected)
                throw new RuntimeException("exitcode = " + vm.getExitcode() + ", expected: " + expected);
        } else if (assertion.equals("exception")) {
            if (!vm.exitException())
                throw new RuntimeException("exit successfully, expected an exception.");
        } else {
            throw new RuntimeException("unknown assertion.");
        }
        br.close();
    }
}
