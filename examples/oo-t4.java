class Test{
    public static void main(String[] a){
	System.out.println(new A().Start(10));
    }
}


class C {
    int size ;

    public int CStart(int sz){
	size = 3 * sz;
	return size;
    }
    public int get_size(){		// should be inherited
	return size;
    }
}

class B extends C {
    int var ;

    public int BStart(int sz){
	var = sz;
	size = 2 * var;		// slight chg
	return 0;
    }
}

class A{
    int size ;

    public int Start(int sz){
	B vb;
	size = sz;
	vb = new B();
	sz = vb.BStart(10);
	return vb.get_size();
    }
}

