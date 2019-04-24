

public class LabA5 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		
		int num = Integer.parseInt(args[0]);
		int z = num <<21;
		z = z>>>31;
		
		int mask = 1024;
		int y = num & mask;
		y=y>>10;		

		System.out.println(Integer.toBinaryString(z));
		System.out.println(Integer.toBinaryString(y));
		
	}

}
