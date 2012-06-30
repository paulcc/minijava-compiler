class Test{
    public static void main(String[] a){
	System.out.println(new A().Start(10));
    }
}


class A extends B {
    int size ;

    public int Start(int sz){
	B vb;
	size = sz;
	vb = new B();
	sz = vb.BStart(10);
	return vb.get_size();
    }
}

class B extends A {
    int var ;

    public int BStart(int sz){
	var = sz;
	size = 2 * sz;
	return 0;
    }
    public int get_size(){
	return size;
    }
}
