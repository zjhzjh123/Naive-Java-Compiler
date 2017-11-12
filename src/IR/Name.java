package IR;

/**
 * Created by zhangjiaheng on 16/4/26.
 */
public class Name extends Address{
    public String name;

    public Name(){
        name = null;
    }
    public String print(){return  null;}
    public Name(String name){
        this.name = name;
    }
}
