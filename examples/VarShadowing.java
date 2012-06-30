class VarShadowing {

	public static void main (String[] a) {
		System.out.println(new ET().getNum(2));
	}

}

class ET {

	int num;

	public int getNum(int num) {
		return num;
	}

}
