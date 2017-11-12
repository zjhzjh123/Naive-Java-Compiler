package cfg;

import IR.Temp;

/**
 * Created by zhangjiaheng on 16/5/4.
 */
public class Edge{
    public Temp begin, end;
    public Edge(Temp begin, Temp end){
        this.begin = begin;
        this.end = end;
    }
}
