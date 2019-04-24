
public class LabA2 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		int num = Integer.parseInt(args[0]);
		System.out.println("0x"+Integer.toHexString(num));
		int numTwo= Integer.reverse(num);
		System.out.println("0x"+Integer.toHexString(numTwo));
		int numThree=Integer.reverseBytes(num);
		System.out.println("0x"+Integer.toHexString(numThree));
	}

}
