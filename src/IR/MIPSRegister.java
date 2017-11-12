package IR;

/**
 * Created by zhangjiaheng on 16/5/4.
 */
public class MIPSRegister{

    public static MIPSRegister v0 = new MIPSRegister("$v0");
    public static MIPSRegister v1 = new MIPSRegister("$v1");
    public static MIPSRegister a0 = new MIPSRegister("$a0");
    public static MIPSRegister a1 = new MIPSRegister("$a1");
    public static MIPSRegister a2 = new MIPSRegister("$a2");
    public static MIPSRegister a3 = new MIPSRegister("$a3");
    public static MIPSRegister t0 = new MIPSRegister("$t0");
    public static MIPSRegister t1 = new MIPSRegister("$t1");
    public static MIPSRegister t2 = new MIPSRegister("$t2");
    public static MIPSRegister t3 = new MIPSRegister("$t3");
    public static MIPSRegister t4 = new MIPSRegister("$t4");
    public static MIPSRegister t5 = new MIPSRegister("$t5");
    public static MIPSRegister t6 = new MIPSRegister("$t6");
    public static MIPSRegister t7 = new MIPSRegister("$t7");
    public static MIPSRegister t8 = new MIPSRegister("$t8");
    public static MIPSRegister t9 = new MIPSRegister("$t9");
    public static MIPSRegister s0 = new MIPSRegister("$s0");
    public static MIPSRegister s1 = new MIPSRegister("$s1");
    public static MIPSRegister s2 = new MIPSRegister("$s2");
    public static MIPSRegister s3 = new MIPSRegister("$s3");
    public static MIPSRegister s4 = new MIPSRegister("$s4");
    public static MIPSRegister s5 = new MIPSRegister("$s5");
    public static MIPSRegister s6 = new MIPSRegister("$s6");
    public static MIPSRegister s7 = new MIPSRegister("$s7");
    public static MIPSRegister sp = new MIPSRegister("$sp");
    public static MIPSRegister fp = new MIPSRegister("$fp");
    public static MIPSRegister gp = new MIPSRegister("$gp");
    public static MIPSRegister at = new MIPSRegister("$at");
    public static MIPSRegister ra = new MIPSRegister("$ra");
    public static MIPSRegister w0 = new MIPSRegister("$w0");
    public static MIPSRegister k0 = new MIPSRegister("$k0");
    public static MIPSRegister k1 = new MIPSRegister("$k1");

    public String name;
    public static MIPSRegister get(int num){
        switch (num){
            case 0:
                return a3;
            case 1:
                return k1;
            case 2:
                return gp;
            case 3:
                return fp;
            case 4:
                return v1;
            case 5:
                return s5;
            case 6:
                return s6;
            case 7:
                return s7;
            case 8:
                return t2;
            case 9:
                return t3;
            case 10:
                return t4;
            case 11:
                return t5;
            case 12:
                return t6;
            case 13:
                return t7;
            case 14:
                return t8;
            case 15:
                return t9;
            case 16:
                return s0;
            case 17:
                return s1;
            case 18:
                return s2;
            case 19:
                return s3;
            case 20:
                return s4;
            case 21:
                return k0;
            case 22:
                return a2;
            case 23:
                return a1;
            case 24:
                return a0;
            case 25:
                return t1;
            case 26:
                return t0;
            case 27:
                return at;
            case 28:
                return v0;
            case 29:
                return w0;
            case 30:
                return ra;
            case 31:
                return fp;

        }
        return null;
    }

    public MIPSRegister(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
