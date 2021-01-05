#include "interconnect.h"
#include "iob_knn.h"
#include "KNNsw_reg.h"
#include <stdint.h>
#include "system.h"
#include "periphs.h"
#include <iob-uart.h>
#include "iob_timer.h"

//base address
static int base;

void knn_reset(){
  IO_SET(base, KNN_RESET, 1);
  IO_SET(base, KNN_RESET, 0);
}
void knn_start(){
  knn_reset();
  IO_SET(base, KNN_ENABLE, 1);
}

void knn_stop(){
  IO_SET(base, KNN_ENABLE, 0);
}

void knn_init(int base_address){
  base = base_address;
  knn_reset();
}

void put_testpoint(int Ax, int Ay){
  IO_SET(base, KNN_Ay, Ay);
  IO_SET(base, KNN_Ax, Ax);
}

void put_datapoint(int Bx, int By, char label){
  IO_SET(base, KNN_LABEL, label);
  IO_SET(base, KNN_By, By);
  IO_SET(base, KNN_Bx, Bx);
  IO_SET(base, KNN_PIP, 1);
  IO_SET(base, KNN_PIP, 0);
}

unsigned int take_Distance(){
  return (unsigned int) IO_GET(base, KNN_Dist);
}

unsigned char knn_read(int i){
  int c=i*8;
  unsigned int b=255;
  unsigned char a;
  a= (unsigned char) (IO_GET(base, KNN_Out) >> c) && b;
  return a;
}

unsigned int knn_read2(int i){
	char a=i;
  IO_SET(base, KNN_acesso, a);
  a= (unsigned int) IO_GET(base, KNN_Out2);
  return a;
}
