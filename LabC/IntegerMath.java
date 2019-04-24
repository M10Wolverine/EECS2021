public class IntegerMath
{
public static final int MAX_VALUE = 2147483647;
public static final byte SIZE = 32;
private static int count = 0;

// Accessor for the count attribute
public static int getCount()
{
int result = IntegerMath.count;
return result;
}
// Mutator for the count attribute
public static void setCount(int count)
{
IntegerMath.count = count;
}
}
