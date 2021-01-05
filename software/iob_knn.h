#pragma once

//Functions
void knn_reset();
void knn_start();	
void knn_stop();
void knn_init( int base_address);
void put_testpoint(int Ax, int Ay);
void put_datapoint(int Bx, int By, char label);
unsigned int take_Distance();
unsigned char knn_read(int i);
unsigned int knn_read2(int i);
