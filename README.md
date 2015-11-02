# enf-mp3
### Evaluation of ENF-based audio authencity algorithms [1,2] over .mp3 compressed signals

__./mp3readwrite__ contains code for reading and writing .mp3 files from matlab. Code developed by Dan Ellis, license details in ./mp3readwrite/license.txt file.

__./csv__ contains results for analysis on weka

__./dataset__ contains files created with sinteticSignalsGenerator.m

__./functions__ contains needed functions for main scripts

__convert_corpus_mp3.sh__ bash script for conversion of corpus ahumada[2] & carioca to .mp3 with LAME MP3 Econder (previous installation needed)

__enfMp3ChirpMain.m__ matlab code for spectral analysis of CHIRP + ENF synthetic file

__enfMp3SinMain.m__ maltab code for spectral analysis of SIN + ENF syntethic file

__enMp3VozMain.m__ matlab code for spectral analysis of Voice(recorded) + ENF(synthetic) file

__enftest_corpus.m__ matlab code for running ENF-based audio authencity algorithms [1,2] and exporting results on .csv files for Weka analysis. this runs over corpus ahumada[3] & carioca, not available in this repo, please email for more information.

__syntheticSignalsGeneration.m__ matlab code for generation of synth files. this are included in __./dataset__ directory

###References:

[1] Daniel Patricio Nicolalde Rodríguez, José Antonio Apolinário Jr, Luiz Wagner Pereira Biscainho, "Audio authenticity: Detecting ENF discontinuity with high precision phase analysis", IEEE Transactions on Information Forensics and Security, 2010.

[2] Paulo Antonio Andrade Esquef, Jose Antonio Apolinario, Luiz WP Biscainho, "Edit Detection in Speech Recordings via Instantaneous Electric Network Frequency Variations", IEEE Transactions on Information Forensics and Security, 2014. 

[3] Javier Ortega-Garcia, Joaquin Gonzalez-Rodriguez, Victoria Marrero-Aguiar, AHUMADA: A large speech corpus in Spanish for speaker characterization and identification, Journal: Speech Communication, 2000.


