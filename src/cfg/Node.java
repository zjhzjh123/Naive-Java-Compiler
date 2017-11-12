package cfg;

import IR.Address;
import IR.Quadruple;
import IR.Temp;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by zhangjiaheng on 16/5/2.
 */
public class Node {
    public ArrayList<Temp> def, use;
    public Set<Temp>LiveIn, LiveOut;
    public ArrayList<Node> InNode, Outnode;
    public BasicBlock basicBlock;

    public Node(BasicBlock node){
        node.node = this;
        basicBlock = node;
        def = new ArrayList<>();
        use = new ArrayList<>();
        LiveIn = new HashSet<>();
        LiveOut = new HashSet<>();
        InNode = new ArrayList<Node>();
        Outnode = new ArrayList<Node>();
    }

}
