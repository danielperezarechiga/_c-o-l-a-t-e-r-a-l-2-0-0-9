
_thd1734kfg_

/*
_c o l a t e r a l 2 0 0 9 /09

Morelia, Michoacán,
A lanzarse el 9 de Septiembre del 2020,
empece a escribir/componer
el 4 de Septiembre
terminé la rola el 11 de septiembre.

*/


//Krispy, tiny, higher tone particles,
//discrete noise, minimal glitch set
//7-8min

s.meter;
s.makeWindow;
s.record;
s.stopRecording;
(
s.boot;
SynthDef("gpdef",
    { arg out=0, freq=440, sustain=0.05, amp=0.1;
        var env;
        env = EnvGen.kr(Env.perc(0.01, sustain), doneAction: Done.freeSelf) * amp;
        Out.ar(out, SinOsc.ar(freq, 0, env))
    }).add;
)

(
Fdef(\freq, 40);
Fdef(\dur, 0.14);

fork {
    loop {
        s.sendMsg("/s_new", "gpdef", -1, 1,1, \freq, Fdef(\freq).value);
        Fdef(\dur).value.wait;
    }
};
)

(
Fdef(\freq, 40);
Fdef(\dur, 0.2);

fork {
    loop {
        s.sendMsg("/s_new", "gpdef", -1, 1,1, \freq, Fdef(\freq).value);
        Fdef(\dur).value.wait;
    }
};
)



// synth by Rumush

(
SynthDef(\chaosGlitch2, {
	arg len = 10, fundFreq = 40, henA = 2, henB = 0.4, t = 1, gate = 1;
	var mainEnv = EnvGen.kr(Env.triangle(len,1), gate, doneAction:2);
	var speed = Array.geom(4, t, [1.75, 1.25].choose);
	var freq = Array.geom(8, fundFreq*2, 1.5);
	var pulse = {|rat1,rat2|LFPulse.ar(rat1, [0,0.5,1].choose)*LFPulse.ar(rat2)};
	var a = Lag.ar(HenonN.ar(
		speed.choose*(mainEnv*10000.rand),
		henA, henB,
	), 0.01);
	var bass = HPF.ar(SinOsc.ar(fundFreq!2*(a*1.0.rand), 0, Lag.ar(pulse.(t, speed.choose), 0.001)),20);
	var tone1 = HPF.ar(SinOsc.ar([(fundFreq+Rand(0,5))*a,(fundFreq+Rand(0,5))*a], 0, 0.01*pulse.(speed.choose, speed.choose)),20);
	var tone2 = HPF.ar(Pan2.ar(SinOsc.ar(freq.choose*a, 0, 0.1*pulse.(speed.choose, t)), a),20);
	var tone3 = HPF.ar(SinOsc.ar([freq.choose,freq.choose*a], 0, 0.05*pulse.(speed.choose, t)),20)*mainEnv.round(0.25);
	var noise = Pan2.ar(PinkNoise.ar(a*0.1*pulse.(t,t)), a);
	var impulse = RLPF.ar(Impulse.ar(pulse.(t, speed.choose), a), freq.choose+(a*10), 0.01, 0.1).tanh;

	Out.ar(0, (bass+tone1+tone2+tone3+noise+impulse).tanh);
	}
).store;
)

Synth(\chaosGlitch2,[\t,8000,\len,3.75,\fundFreq,0.2,\henB,1100,\henA,1000])
Synth(\chaosGlitch2,[\t,1,\len,0.2,\fundFreq,2000,\henB,200]);
Synth(\chaosGlitch2,[\t,0.05,\len,0.31,\fundFreq,80,\henB,20]);
Synth(\chaosGlitch2,[\t,0.5,\len,1,2,\fundFreq,8000,\henB,0.1,\henA,200]);
Synth(\chaosGlitch2,[\t,10,\len,1.2,\fundFreq,2000,\henB,20,\henA,1000]);


Synth(\chaosGlitch2,[\t,7,\len,3.754,\fundFreq,357*16/9,\henB,11,\henA,1239]);
Synth(\chaosGlitch2,[\t,9,\len,3.754,\fundFreq,357,\henB,11,\henA,1239]);
Synth(\chaosGlitch2,[\t,5,\len,3.754,\fundFreq,357*5/4,\henB,11,\henA,1239]);
Synth(\chaosGlitch2,[\t,2,\len,3.754,\fundFreq,357*5/4,\henB,11,\henA,1239]);


//tarola


Synth(\chaosGlitch2,[\t,1,\len,0.2,\fundFreq,2000,\henB,200]);

//rutina init
(
~r2=Routine({
	Synth(\chaosGlitch2,[\t,1,\len,0.8,\fundFreq,10,\henB,0.01,\henA,0.02]);
	Synth(\chaosGlitch2,[\t,2,\len,3.754,\fundFreq,357*5/4,\henB,11,\henA,1239]);
	Synth(\chaosGlitch2,[\t,0.05,\len,5.31,\fundFreq,80,\henB,20]);
	Synth(\chaosGlitch2,[\t,0.05,\len,3.31,\fundFreq,80*16/9,\henB,20]);
	5.31.wait;
	Synth(\chaosGlitch2,[\t,0.05,\len,5.31,\fundFreq,80,\henB,20]);
	Synth(\chaosGlitch2,[\t,0.05,\len,3.31,\fundFreq,80*16/9,\henB,20]);
	5.31.wait;
	Synth(\chaosGlitch2,[\t,0.05,\len,5.31,\fundFreq,80,\henB,20]);
	Synth(\chaosGlitch2,[\t,0.05,\len,3.31,\fundFreq,80*16/9,\henB,20]);
	Synth(\chaosGlitch2,[\t,0.05,\len,3.31,\fundFreq,80*27/28,\henB,20]);
	5.31.wait;
	Synth(\chaosGlitch2,[\t,0.05,\len,5.31,\fundFreq,80,\henB,20]);
	Synth(\chaosGlitch2,[\t,0.05,\len,3.31,\fundFreq,80*16/9,\henB,20]);
	Synth(\chaosGlitch2,[\t,0.05,\len,3.31,\fundFreq,80*8/9,\henB,20]);
	5.31.wait;
}).play;

~r1=Routine({
	Synth(\chaosGlitch2,[\t,8000,\len,3.75,\fundFreq,0.2,\henB,1100,\henA,1000]);
	3.2.wait;
	Synth(\chaosGlitch2,[\t,1,\len,0.2,\fundFreq,2000,\henB,200]);
	3.2.wait;
	Synth(\chaosGlitch2,[\t,8000,\len,3.75,\fundFreq,0.2,\henB,1100,\henA,1000]);
	3.2.wait;
	Synth(\chaosGlitch2,[\t,1,\len,0.2,\fundFreq,2000,\henB,200]);
	3.2.wait;
	Synth(\chaosGlitch2,[\t,8000,\len,3.75,\fundFreq,0.2,\henB,1100,\henA,1000]);
	3.2.wait;
	Synth(\chaosGlitch2,[\t,1,\len,0.2,\fundFreq,2000,\henB,200]);
	3.2.wait;
	Synth(\chaosGlitch2,[\t,8000,\len,3.75,\fundFreq,0.2,\henB,1100,\henA,1000]);
	3.2.wait;
	Synth(\chaosGlitch2,[\t,1,\len,0.2,\fundFreq,2000,\henB,200]);
	3.2.wait;
}).play;
)

~a={SoundIn.ar(0,0.2)}.play; // que suenen las teclas

Synth(\chaosGlitch2,[\t,1,\len,0.8,\fundFreq,10,\henB,0.01,\henA,0.02]);
Synth(\chaosGlitch2,[\t,0.5,\len,3,\fundFreq,80,\henB,0.01,\henA,0.02])
Synth(\chaosGlitch2,[\t,0.5,\len,11,\fundFreq,40*5/4,\henB,0.01,\henA,0.02])
Synth(\chaosGlitch2,[\t,0.5,\len,15,\fundFreq,20*7/4,\henB,0.01,\henA,0.02])

//

s.meter;


s.record;
s.stopRecording;


