
public class LabA3 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		int x = Integer.parseInt(args[0]);
		int y = Integer.parseInt(args[1]);
		int z;
		
		System.out.println(Integer.toBinaryString(x));
		System.out.println(Integer.toBinaryString(y));
		System.out.println(Integer.toBinaryString(x&y));
		System.out.println(Integer.toBinaryString(x|y));
		System.out.println(Integer.toBinaryString(x^y));
		System.out.println(Integer.toBinaryString(~x));
			
	}

}
