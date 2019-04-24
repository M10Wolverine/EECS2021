public class LabA6 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		
		int num = Integer.parseInt(args[0]);
		System.out.println(Integer.toBinaryString(num));
		
		int maskOne = 1024;
		int maskTwo= Integer.MAX_VALUE-2048;
		
		
		int z = maskOne | num;
		System.out.println(Integer.toBinaryString(z));
	 	z = maskTwo & z; 
		System.out.println(Integer.toBinaryString(z));
	}

}
