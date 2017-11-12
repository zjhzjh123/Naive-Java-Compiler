package IR;

import cfg.BasicBlock;
import cfg.Edge;
import cfg.FunctionCFG;
import cfg.Node;

import java.util.*;

/**
 * Created by zhangjiaheng on 16/5/4.
 */

public class GlobalTempAllocate{
    public FunctionCFG functionCFG;
    public Set<Temp> list;
    public Set<Temp> vist;
    public Map<Temp, MIPSRegister>mapping;
    public HashSet<Integer> hashSet;
    public Set<Integer> set;

    public GlobalTempAllocate(FunctionCFG functionCFG){
        this.functionCFG = functionCFG;
        vist = new HashSet<Temp>();
        list = new HashSet<Temp>();
        mapping = new HashMap<>();
        hashSet = new HashSet<Integer>();
        set = new HashSet<>();
    }

    public void BuildInterferenceGraph(){
        list = new HashSet<Temp>();
        for(Node node : functionCFG.graphnode){
            for(Quadruple quadruple : node.basicBlock.instr) {
                if(quadruple.getdef() != null){
                    for (Temp temp : quadruple.getdef()){
                        if(!temp.isString && !temp.isParam && !temp.isGlobal)
                            list.add(temp);
                    }
                }
                if(quadruple.getuse() != null){
                    for (Temp temp : quadruple.getuse()){
                        if(!temp.isString && !temp.isParam && !temp.isGlobal)
                            list.add(temp);
                    }
                }
            }

        for(Node node1 : functionCFG.graphnode){
            Set<Temp>livenow = new HashSet<Temp>();
            for(Temp i : node.LiveOut){
                livenow.add(i);
            }

            for(int k = node.basicBlock.instr.size() - 1; k >= 0; k--){
                Quadruple quadruple = node.basicBlock.instr.get(k);
                if(quadruple.getdef() != null) {
                    for (int i = 0; i < quadruple.getdef().size(); i++) {
                        for (Temp t : livenow) {

                            if (t.next.indexOf(quadruple.getdef().get(i)) == -1 && t.num != quadruple.getdef().get(i).num) {
                                if (!t.isString && !t.isParam && !t.isGlobal && !quadruple.getdef().get(i).isString
                                        && !quadruple.getdef().get(i).isGlobal && !quadruple.getdef().get(i).isParam) {

                                    t.next.add(quadruple.getdef().get(i));
                                }

                            }
                            if (quadruple.getdef().get(i).next.indexOf(t) == -1 && t.num != quadruple.getdef().get(i).num) {
                                if (!t.isString && !t.isParam && !t.isGlobal && !quadruple.getdef().get(i).isString
                                        && !quadruple.getdef().get(i).isGlobal && !quadruple.getdef().get(i).isParam) {
                                    quadruple.getdef().get(i).next.add(t);
                                }

                            }
                        }
                    }
                }
                if(quadruple.getdef() != null) {
                    for (int i = 0; i < quadruple.getdef().size(); i++) {
                        livenow.remove(quadruple.getdef().get(i));
                    }
                }
                if(quadruple.getuse() != null){
                    for(int i = 0; i < quadruple.getuse().size(); i++){
                        livenow.add(quadruple.getuse().get(i));
                        }
                    }
                }
            }
        }
    }

    public void BottomUpColoring(int k){

        Stack<Temp> stack = new Stack<Temp>();
        for(Temp temp : list){
            temp.degree = temp.next.size();
        }
        while(vist.size() != list.size()){
            int flag = 0;
            for(Temp temp0 : list){
                if(temp0.degree < k && !vist.contains(temp0)){
                    flag = 1;
                    stack.add(temp0);
                    vist.add(temp0);
                    for(int j = 0; j < temp0.next.size(); j++){
                        temp0.next.get(j).degree--;
                    }
                }
            }
            if(flag == 0){
                for(Temp temp0 : list){
                    stack.add(temp0);
                    vist.add(temp0);
                    for(int j = 0; j < temp0.next.size(); j++){
                        temp0.next.get(j).degree--;
                    }
                    break;
                }
            }
        }
        while(!stack.isEmpty()){
            Temp temp = stack.pop();

            int num = 0;
            hashSet.clear();

            for(int i = 0; i < temp.next.size(); i++){
                if(temp.next.get(i).color != 0){
                    hashSet.add(temp.next.get(i).color);
                    num++;
                }
            }
            for(int i = 1; i <= k; i++){
                if(!hashSet.contains(i))
                    temp.color = i;
            }

            if(temp.color != 0 ) {
                mapping.put(temp, MIPSRegister.get(temp.color));
                set.add(temp.color);
            }
        }
    //    System.err.println(toString());
    }

    @Override
    public String toString() {
        StringBuilder stringBuilder = new StringBuilder();
        for (Temp temp : mapping.keySet()) {
            MIPSRegister mipsRegister = mapping.get(temp);
            stringBuilder.append(temp.num).append(" ").append(mipsRegister).append("\n");
        }
        return stringBuilder.toString();
    }
}
