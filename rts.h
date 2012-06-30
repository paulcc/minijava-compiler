
#include <stdio.h>
#include <stdlib.h>

#define STACK_SIZE 10000
extern int* sp, stack[STACK_SIZE];

#define push(x) { if (sp > stack) { *--sp = x; } \
			else { fprintf(stderr, "Stack full\n"); } }

#define pop(n) { sp += n; }

#define grab(n) { sp -= n; }

typedef int (*Ptr)(int *);

/*
 * doesn't work?
#define DEREF(index,sp) ( *((Ptr**)(*sp)-1) [index]  (sp))
(*((Ptr **)(x-4)))[0],
*/

extern int DEREF(int, int*);


extern int crash_array(void);

extern int obj_alloc(int, Ptr[]);

extern int retval;


