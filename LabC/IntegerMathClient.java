import java.util.Scanner;
public class IntegerMathClient
{
public static void main(String[] args)
{
System.out.print(IntegerMath.MAX_VALUE);
System.out.print(IntegerMath.SIZE);
System.out.println(IntegerMath.getCount());
int a = new Scanner(System.in).nextInt();
IntegerMath.setCount(a);
System.out.println(IntegerMath.getCount());
}
}
