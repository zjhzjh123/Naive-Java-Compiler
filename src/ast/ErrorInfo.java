package ast;

/**
 * Created by zhangjiaheng on 16/4/2.
 */
public class ErrorInfo extends ast{
    public int col, row;
    public ErrorInfo(int acol, int arow){col = acol; row = arow;}

    @Override
    public String toString(int d) {
        return "row = " + row + "col = " + col + "\n";
    }
}
