#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#ifdef WIN32
#include <time.h>
#include <windows.h>
#else
#include <sys/time.h>
#endif

#include "WavFile.h"
#include "awi_constant.h"
#include "awi_aiaefs_api.h"

#ifdef WIN32
int gettimeofday(struct timeval *tp, void *tzp)
{
    time_t clock;
    struct tm tm;
    SYSTEMTIME wtm;
    GetLocalTime(&wtm);
    tm.tm_year = wtm.wYear - 1900;
    tm.tm_mon = wtm.wMonth - 1;
    tm.tm_mday = wtm.wDay;
    tm.tm_hour = wtm.wHour;
    tm.tm_min = wtm.wMinute;
    tm.tm_sec = wtm.wSecond;
    tm.tm_isdst = -1;
    clock = mktime(&tm);
    tp->tv_sec = clock;
    tp->tv_usec = wtm.wMilliseconds * 1000;
    return (0);
}
#endif

static void openFiles(WavInFile **inFile, WavOutFile **outFile, const char *inFileName, const char *outFileName) {
    int bits, samplerate, channels;

    // open input file...
    *inFile = new WavInFile(inFileName);

    // ... open output file with same sound parameters
    bits = (int) (*inFile)->getNumBits();
    samplerate = (int) (*inFile)->getSampleRate();
    channels = (int) (*inFile)->getNumChannels();

//    *outFile = new WavOutFile(outFileName, SAMPLE_RATE, bits, 1);
    *outFile = new WavOutFile(outFileName, samplerate, bits, 1);
}

int main(int argc, char *argv[]) {
//    short micInS16[HOP_SIZE], refInS16[HOP_SIZE], outS16[HOP_SIZE];
//    float micIn[HOP_SIZE], refIn[HOP_SIZE], out[HOP_SIZE];

//        const char * mic_path = argv[1];
//        const char * ref_path = argv[2];
    const char* mic_path = "D:\\workspace\\rvc\\c_proj\\c_training_bkp231207\\c_projs\\demos\\api_demo\\build\\Debug\\clean_fileid_1_32k.wav";
    //const char *mic_path = ".\clean_fileid_1_32k.wav";
//    const char *mic_path = "clean_fileid_1.wav";
    //const char *mic_path = "clean_c2.wav";
    const char *out_path = "D:\\workspace\\rvc\\c_proj\\c_training_bkp231207\\c_projs\\demos\\api_demo\\build\\Debug\\out111_nsout1121.wav";
    WavInFile *inFile;
    WavOutFile *outFile;

    // init
    saObjs *nsh = slt_audio_init();

    // Open input & output files
    openFiles(&inFile, &outFile, mic_path, out_path);
    if (!inFile || !outFile) {
        printf("E: failed to open files.\n");
        return -1;  // nothing to do.
    }

    // Attention: Set samplerate&channels if input format is changed. Get error if value is invalid.
    const int in_channs = (int) (inFile)->getNumChannels();
    set_input_acoustic_params(nsh, in_channs, (int) (inFile)->getSampleRate());
    // Attention: Set algorithm choice if choice is changed.
    set_alg_choice(nsh, OFF, OFF, OFF, 0);

//    int nSamples;
//    float sampleBuffer[IN_HOP_SIZE * in_channs];
    float *sampleBuffer = new float[IN_HOP_SIZE * in_channs];
    float outSampleBuffer[IN_HOP_SIZE];

    // calcute time cost.
    struct timeval t1, t2;
    long total_cost_us = 0, count = 0;

    // Process samples read from the input file
    while (inFile->eof() == 0) {
        // Read a chunk of samples from the input file
        int rsize = inFile->read(sampleBuffer, IN_HOP_SIZE * in_channs);
//        printf("%d\n", rsize);

        gettimeofday(&t1, NULL);
        // Output single channel.
        slt_audio_process(nsh, sampleBuffer, NULL, outSampleBuffer);
        gettimeofday(&t2, NULL);

        // printf("I: Frame time cost = %ld us\n", (t2.tv_sec - t1.tv_sec) * 1000000 + (t2.tv_usec - t1.tv_usec));
        total_cost_us += (t2.tv_sec - t1.tv_sec) * 1000000 + (t2.tv_usec - t1.tv_usec);
        count++;

        outFile->write(outSampleBuffer, IN_HOP_SIZE);
//        outFile->write(outSampleBuffer, HOP_SIZE);
    }

    printf("I: Total time cost = %ld us, single time cost per frame(%d ms) = %ld us.\n", total_cost_us,
        IN_HOP_SIZE / (IN_SAMPLE_RATE / 1000), total_cost_us / count);
    printf("I: count = %ld\n", count);
    printf("I: Done.\n");

    if (sampleBuffer) {
        delete[]sampleBuffer;
        sampleBuffer = NULL;
    }
    // Close WAV file handles & dispose of the objects
    delete inFile;
    delete outFile;
    slt_audio_release(nsh);
    return 0;
}
