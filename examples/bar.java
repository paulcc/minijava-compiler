class QuickSort{
    public static void main(String[] a){
	System.out.println(new A().Start(10));
    }
}


class A{
    int size ;

    public int Start(int sz){
	B vb;
	size = sz;
	vb = new B();
	sz = vb.Start(10);
	return vb.var;	// of course, not allowed
    }
}

class B {
    int var ;

    public int Start(int sz){
	var = sz;
	return 0;
    }
}
