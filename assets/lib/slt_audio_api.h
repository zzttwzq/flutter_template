#ifndef ___SLT_CORE_PROJS___
#define ___SLT_CORE_PROJS___

//#ifdef __cplusplus
//extern "C" {
//#endif    /* __cplusplus */


//typedef struct saObjs saObjs;

//enum algSwitch {
//    OFF = 0,
//    ON,
//};
//
//enum retState {
//    Success = 0,
//    Failure,
//    Error,
//};


/*
*Summary: init func.
*Parameters:
*     None
*Return : 0.
*/
//saObjs *slt_audio_init();
int slt_audio_init();

/*
*Summary: Mic core process func.
*Parameters:
*     nsh: alg objects.
*     mic_buf : waveform input of mic.
*     spk_buf : waveform input of speaker.
*     out_buf : enhanced output.
*Return : none
*/
//int slt_audio_mic_process(saObjs *nsh, float *mic_buf, float *spk_buf, float *out_buf);
//int slt_audio_mic_process(float mic_buf[], float spk_buf[], float out_buf[]);
int slt_audio_mic_process(float *mic_buf, float *spk_buf, float *out_buf);

/*
*Summary: release func.
*Parameters:
*     nsh: alg objects.
*Return : none
*/
//int slt_audio_release(saObjs *nsh);
int slt_audio_release();

/*
*Summary: Set input acoustic params function.
*Parameters:
*     nsh: alg objects.
*     channel: input channel.
*     samplerate: input samplerate, must be 48k.
*Return : none
*/
//int set_input_acoustic_params(saObjs *nsh, int channel, int samplerate);
int set_input_acoustic_params(int channel, int samplerate);

/*
*Summary: Turn on/off algorithm.
*Parameters:
*     nsh: alg objects.
*     ans_switch: whether to use ans algorithm, ON 1/OFF 0.
*     aec_switch: whether to use aec algorithm, ON 1/OFF 0.
*     vc_switch: whether to use voice conversation algorithm, ON 1/OFF 0.
*     f0_key: [-12，12]
*Return : none
*/
//int set_alg_choice(saObjs *nsh, algSwitch ans_switch, algSwitch aec_switch, algSwitch vc_switch, int f0_key);
int set_alg_choice(int ans_switch, int aec_switch, int vc_switch, int f0_key);

//#ifdef __cplusplus
//}        /* extern "C" */
//#endif    /* __cplusplus */

#endif
