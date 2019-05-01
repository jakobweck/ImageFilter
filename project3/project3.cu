#include <iostream>
#include <fstream>
#include <cuda.h>
#include "cuda_runtime.h"
#include "../ImageWriter/ImageWriter.h"
#include "../ImageReader/ImageReader.h"
#include "../Packed3DArray/Packed3DArray.h"
using namespace std;

int main(int argc, char *argv[]){

    ImageReader* ir = ImageReader::create("../Images/door.jpg");
    if (ir == nullptr) exit(1);

	cryph::Packed3DArray<unsigned char>* rgb = ir->getInternalPacked3DArrayImage();
	int xres = ir->getWidth();
	int yres = ir->getHeight();
    int size = xres*yres;
    unsigned char* rChannelH = new unsigned char[size];
    unsigned char* gChannelH = new unsigned char[size];
    unsigned char* bChannelH = new unsigned char[size];
	for (int r=0 ; r<yres ; r++)
		for (int c=0 ; c<xres ; c++)
		{
			unsigned char R = rgb->getDataElement(r, c, 0);
			unsigned char G = rgb->getDataElement(r, c, 1);
			unsigned char B = rgb->getDataElement(r, c, 2);
			// (This simple demo does not modify the alpha channel, if present.)
			// Circular shift the colors:
            rChannelH[r*c] = R;
            gChannelH[r*c] = G;
            bChannelH[r*c] = B;
		}
	
    unsigned char* rChannelD;
    cudaMalloc((void**)&rChannelD, size);
    unsigned char* gChannelD;
    cudaMalloc((void**)&gChannelD, size);
    unsigned char* bChannelD;
    cudaMalloc((void**)&bChannelD, size);
    cudaMemcpy(rChannelD, rChannelH, size, cudaMemcpyHostToDevice);
	cudaMemcpy(gChannelD, gChannelH, size, cudaMemcpyHostToDevice);
    cudaMemcpy(bChannelD, bChannelH, size, cudaMemcpyHostToDevice);



    ifstream filterFile;
    filterFile.open(argv[2]);
    float x;
    while(filterFile >> x){

    }

  //  cudaMalloc((void**)&d_X, size);

}