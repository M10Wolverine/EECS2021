
public class LabA7 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		
		int num = Integer.parseInt(args[0]);
		System.out.println(Integer.toBinaryString(num));
		
		int bitTen = num << 21;
		bitTen = bitTen >>> 31;

		int  bitTwty = num<< 11;
		bitTwty = bitTwty >>>31;

		int z;
		
		if (bitTen == bitTwty){
		System.out.println(Integer.toBinaryString(num));
		}
		else{
			if (bitTen == 1)
			{
				int maskTwo = bitTen << 21;
				z = maskTwo | num;
			}

			else
			{	
				bitTen=1;
				int maskTwo = bitTen<<21;
				z = maskTwo & num;  
			}
			if (bitTwty == 1)
			{
				int maskOne = bitTwty << 11;
				z = maskOne | num;
			}

			else{			{	
				bitT

				maskOne = ~maskOne;

			System.out.println(Integer.toBinaryString(z));
		}
		
		
	}

}
