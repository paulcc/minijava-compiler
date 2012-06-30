
#include "rts.h"

int retval;	// for returning stuff

int stack[STACK_SIZE];
int *sp = stack + STACK_SIZE;

/* now as macros
void push(int x) {
	if (sp > stack) {
		*--sp = x;
	} else {
		fprintf(stderr, "Stack full\n");
	}
}

void pop(int n) {
	sp += n;
}

void grab (int n) {
	sp -= n;
}
*/

int crash_array(void) {
	fprintf(stderr, "Array out of bounds\n");
	exit(1);
}


int obj_alloc(int size, Ptr table[]) {
	char *x = malloc(size + sizeof(table));
	*((int *)x) = (int)table;
	return (int) (x + sizeof(table));
}

int main (int argc, char *argv[]) {
	return main_(sp);
}


int DEREF(int index, int* sp) {
	return ((*((Ptr **)(*sp)-1))[index]) (sp);
}

