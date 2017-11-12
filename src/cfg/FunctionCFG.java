package cfg;

import IR.*;
import antlr.BuildListener;
import antlr.zzzParser;

import java.util.*;

/**
 * Created by zhangjiaheng on 16/5/2.
 */
public class FunctionCFG {
    public ArrayList<BasicBlock> node;
    public ArrayList<Node>graphnode;
    public Function function;
    public GlobalTempAllocate allocator;
    public ArrayList<BasicBlock> getNode;
    public Set<BasicBlock> basicBlocksSet;

    public void BuildBasicBlock(ArrayList<Quadruple>list){
        node = new ArrayList<BasicBlock>();
        for(int i = 0; i < list.size(); i++){
            if(list.get(i) instanceof Label){
                BasicBlock basicBlock = new BasicBlock();
                ((Label) list.get(i)).basicBlock = basicBlock;
                basicBlock.instr.add(list.get(i));
                for(int j = i + 1; j < list.size(); j++){
                    basicBlock.instr.add(list.get(j));
                    if(list.get(j) instanceof Goto || list.get(j) instanceof Branch) {
                        i = j;
                        break;
                    }
                }
                node.add(basicBlock);
            }
        }
    }
    public void dfs(BasicBlock basicBlock) {
        basicBlocksSet.add(basicBlock);
        getNode.add(basicBlock);
        if(basicBlock == null)
            return;
        int size = basicBlock.instr.size();
        if(size != 0){
            Quadruple quadruple = basicBlock.instr.get(size - 1);
            if(quadruple instanceof Goto){
                BasicBlock b = ((Goto) quadruple).label.basicBlock;
                if(!basicBlocksSet.contains(b))
                    dfs(b);
            }
            if(quadruple instanceof Branch){
                BasicBlock b = ((Branch) quadruple).begin.basicBlock;
                if(!basicBlocksSet.contains(b))
                    dfs(b);
            }
        }
    }

    public FunctionCFG(Function func){
        function = func;
        graphnode = new ArrayList<Node>();
        BuildBasicBlock(function.body);
        if(function.body != null){
            for(int i = 0; i < function.body.size(); i++){
                if(function.body.get(i) instanceof Call){
                    function.isLeaf = false;
                    break;
                }
            }
        }
/*
        for(BasicBlock b : node){
            System.out.println("************basicblock*********");
            for(Quadruple q : b.instr){
                System.out.println(q.print());
            }
        }
*/
        for(int i = 0; i < node.size(); i++){
            graphnode.add(new Node(node.get(i)));
        }
        for(Node i : graphnode){
            int size = i.basicBlock.instr.size();
            if(size != 0){
                Quadruple quadruple = i.basicBlock.instr.get(size - 1);
                if(quadruple instanceof Goto){
                    if(((Goto) quadruple).label.basicBlock != null)
                        i.Outnode.add(((Goto) quadruple).label.basicBlock.node);
                }
                if(quadruple instanceof Branch){
                    i.Outnode.add(((Branch) quadruple).begin.basicBlock.node);
                    i.Outnode.add(((Branch) quadruple).end.basicBlock.node);
                }
            }
        }
        getNode = new ArrayList<BasicBlock>();
        basicBlocksSet = new HashSet<>();
     //   for(int i = 0; i < node.size(); i++){
     //       if(!basicBlocksSet.contains(node.get(i))){
     //           dfs(node.get(i));
     //       }
     //   }
        node = getNode;
        for(int i = 0; i < node.size(); i++){
            int size = node.get(i).instr.size();
            if(size != 0){
                Quadruple quadruple = node.get(i).instr.get(size - 1);
                if(quadruple instanceof Goto)
                    node.get(i).instr.remove(quadruple);
            }
        }
        for(Node l : graphnode){
            l.use = new ArrayList<>();
            l.def = new ArrayList<>();
            for(Quadruple quadruple : l.basicBlock.instr){
                if(quadruple.getuse() != null){
                    for(Temp temp : quadruple.getuse()){
                        if(!l.def.contains(temp)){
                            l.use.add(temp);
                        }
                    }
                }
                if(quadruple.getdef() != null){
                    for(Temp temp : quadruple.getdef()){
                        l.def.add(temp);
                    }
                }
            }
        }
        for(Node l : graphnode){
            l.LiveIn = new HashSet<>();
            l.LiveOut = new HashSet<>();
        }
        while (true) {

            for (Node node : graphnode) {
                node.LiveIn = new HashSet<>();
                node.LiveOut.forEach(node.LiveIn::add);
                node.def.forEach(node.LiveIn::remove);
                node.use.forEach(node.LiveIn::add);
            }
            boolean modified = false;
            for (Node node : graphnode) {
                Set<Temp> LiveOut = node.LiveOut;
                node.LiveOut = new HashSet<>();
                for (Node successor : node.Outnode) {
                    successor.LiveIn.forEach(node.LiveOut::add);
                }
                if (!LiveOut.equals(node.LiveOut)) {
                    modified = true;
                }
            }

            if (!modified) {
                break;
            }
        }
/*
        for(int i = 0; i < graphnode.size(); i++){
            String s = "";
            s = s + "*******LIVEOUT*********" + "\n";
            for(Temp j : graphnode.get(i).LiveOut){
                s = s + "i = " + i + " " + j.num + "\n";
            }
            System.out.println(s);
        }
*/
    }
}
