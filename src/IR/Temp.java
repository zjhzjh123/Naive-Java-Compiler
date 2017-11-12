package IR;

import java.util.ArrayList;

/**
 * Created by zhangjiaheng on 16/4/26.
 */
public class Temp extends Address{
    public static int tempCount = 0;
    public static int GlobalTemp = 0;
    public int num;
    public String name;
    //public int judge;
    public ArrayList<Temp> next;
    public int degree;
    public int color = 0;
    boolean sp = false;
    public Temp(){
        num = tempCount++;
        next = new ArrayList<Temp>();
        name = null;
        color = 0;
    }
    public static void clear(){
        tempCount = 0;
    }
    public Temp(String name){
        num = GlobalTemp++;
        this.name = name;
        next = new ArrayList<Temp>();
        color = 0;
    }
    @Override
    public String print() {
        return "$" + num;
    }
}
