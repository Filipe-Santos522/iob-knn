#include "system.h"
#include "periphs.h"
#include <iob-uart.h>
#include "iob_timer.h"
#include "iob_knn.h"
#include <stdint.h>
#include "random.h" //random generator for bare metal

//uncomment to use rand from C lib 
//#define cmwc_rand rand

#ifdef DEBUG //type make DEBUG=1 to print debug info
#define S 12  //random seed
#define N 10  //data set size
#define K 4   //number of neighbours (K)
#define C 4   //number data classes
#define M 4   //number samples to be classified
#else
#define S 12   
#define N 100000
#define K 10  
#define C 4  
#define M 100 
#endif

#define INFINITE ~0

//
//Data structures
//

//labeled dataset
struct datum {
  short x;
  short y;
  unsigned char label;
} data[N], x[M];


///////////////////////////////////////////////////////////////////
int main() {
  unsigned long long elapsed;
  unsigned int elapsedu;

  //init uart
  uart_init(UART_BASE, FREQ/BAUD);

  //int vote accumulator
  int votes_acc[C] = {0};

  //generate random seed 
  random_init(S);

  //init dataset
  for (int i=0; i<N; i++) {
    //init coordinates
    data[i].x = (short) cmwc_rand();
    data[i].y = (short) cmwc_rand();

    //init label
    data[i].label = (unsigned char) (cmwc_rand()%C);
  }

#ifdef DEBUG
  uart_printf("\n\n\nDATASET\n");
  uart_printf("Idx \tX \tY \tLabel\n");
  for (int i=0; i<N; i++)
    uart_printf("%d \t%d \t%d \t%d\n", i, data[i].x,  data[i].y, data[i].label);
#endif
  
  //init test points
  for (int k=0; k<M; k++) {
    x[k].x  = (short) cmwc_rand();
    x[k].y  = (short) cmwc_rand();
    //x[k].label will be calculated by the algorithm
  }

#ifdef DEBUG
  uart_printf("\n\nTEST POINTS\n");
  uart_printf("Idx \tX \tY\n");
  for (int k=0; k<M; k++)
    uart_printf("%d \t%d \t%d\n", k, x[k].x, x[k].y);
#endif
  
  //
  // PROCESS DATA
  //

  //start knn here
  uart_printf("\nInit timer\n");
  uart_txwait();

  timer_init(TIMER_BASE);
  knn_init(KNN_BASE);


  for (int k=0; k<M; k++) { //for all test points
  //compute distances to dataset points
  knn_reset();

#ifdef DEBUG
    uart_printf("\n\nProcessing x[%d]:\n", k);
    uart_printf("Datum \tX \tY \tLabel \tDistance\n");
#endif

    knn_start();
    put_testpoint(x[k].x, x[k].y);
    unsigned int d=0;
    for (int i=0; i<N; i++) {
	put_datapoint(data[i].x, data[i].y, data[i].label);

	#ifdef DEBUG
	d=take_Distance();
        //dataset
        uart_printf("%d \t%d \t%d \t%d \t%d\n", i, data[i].x, data[i].y, data[i].label, d);
	#endif
    }
    //classify test point

    //clear all votes
    int votes[C] = {0};
    int best_votation = 0;
    int best_voted = 0;

    //make neighbours vote
    for (int j=0; j<K; j++) { //for all neighbors
      if ( (++votes[knn_read(j)]) > best_votation ) {
        best_voted = knn_read(j);
        best_votation = votes[best_voted];
      }
    }

    x[k].label = best_voted;

    votes_acc[best_voted]++;
    
#ifdef DEBUG
    uart_printf("\n\nNEIGHBORS of x[%d]=(%d, %d):\n", k, x[k].x, x[k].y);
    uart_printf("K \tDist \t\tLabel\n");
    for (int j=0; j<K; j++)
      uart_printf("%d \t%d \t%d\n", j+1, knn_read2(j),  knn_read(j));
    
    uart_printf("\n\nCLASSIFICATION of x[%d]:\n", k);
    uart_printf("X \tY \tLabel\n");
    uart_printf("%d \t%d \t%d\n\n\n", x[k].x, x[k].y, x[k].label);

#endif

  } //all test points classified

  //stop knn here
  //read current timer count, compute elapsed time
  elapsedu = timer_time_us(TIMER_BASE);
  uart_printf("\nExecution time: %dus @%dMHz\n\n", elapsedu, FREQ/1000000);

  
  //print classification distribution to check for statistical bias
  for (int l=0; l<C; l++){
    uart_printf("%d ", votes_acc[l]);
  uart_printf("\n");
  
}
}


