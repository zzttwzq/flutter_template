#ifndef ___SLT_CORE_PROJS___
#define ___SLT_CORE_PROJS___

//#ifdef __cplusplus
//extern "C" {
//#endif    /* __cplusplus */


typedef struct saObjs saObjs;

enum algSwitch {
    OFF = 0,
    ON,
};

/*
*Summary: init func.
*Parameters:
*     None
*Return : alg objects.
*/
saObjs *slt_audio_init();

/*
*Summary: core process func.
*Parameters:
*     nsh: alg objects.
*     mic_buf : waveform input of mic.
*     spk_buf : waveform input of speaker.
*     out_buf : enhanced output.
*Return : none
*/
void slt_audio_process(saObjs *nsh, float *mic_buf, float *spk_buf, float *out_buf);

/*
*Summary: release func.
*Parameters:
*     nsh: alg objects.
*Return : none
*/
void slt_audio_release(saObjs *nsh);

/*
*Summary: Set input acoustic params function.
*Parameters:
*     nsh: alg objects.
*     channel: input channel.
*     samplerate: input samplerate.
*Return : none
*/
void set_input_acoustic_params(saObjs *nsh, int channel, int samplerate);

/*
*Summary: Turn on/off algorithm.
*Parameters:
*     nsh: alg objects.
*     ans_switch: whether to use ans algorithm, ON/OFF.
*     aec_switch: whether to use aec algorithm, ON/OFF.
*     vc_switch: whether to use voice conversation algorithm, ON/OFF.
*     f0_key: [-12，12]
*Return : none
*/
void set_alg_choice(saObjs *nsh, algSwitch ans_switch, algSwitch aec_switch, algSwitch vc_switch, int f0_key);

//#ifdef __cplusplus
//}        /* extern "C" */
//#endif    /* __cplusplus */

#endif
