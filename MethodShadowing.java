class MethodShadowing {

	public static void main (String[] a) {
		System.out.println(new ETb().getNum(2));
	}

}

class ETa {

	int num;

	public int getNum(int num) {
		num = 1;
		return num;
	}

}

class ETb extends ETa {

	public int getNum(int num) {
		return num;
	}

}
