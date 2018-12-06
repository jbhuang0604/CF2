# Hierarchical Convolutional Features for Visual Tracking (ICCV 2015)

### Introduction

This is the research code for the paper:

[Chao Ma](https://sites.google.com/site/chaoma99/), [Jia-Bin Huang](https://sites.google.com/site/jbhuang0604/), [Xiaokang Yang](http://english.seiee.sjtu.edu.cn/english/detail/842_802.htm) and [Ming-Hsuan Yang](http://faculty.ucmerced.edu/mhyang/), "Hierarchical Convolutional Features for Visual Tracking", ICCV 2015    
- [PDF](https://uofi.box.com/shared/static/o8wkllte8sfyuvt8ei77o24we8l36qoj.pdf) 
- [Supplementary material](https://uofi.box.com/shared/static/6y3izswn40y6ckbwgm40ugledzp8fer9.pdf)
- [Project page](https://sites.google.com/site/jbhuang0604/publications/cf2)
- [Result visualization](https://sites.google.com/site/jbhuang0604/publications/cf2/visualization)

Compared to the original implemetation, we have improved the code to achieve better results:
1. We added the scale estimation module
2. We adjust the layer weights according to [our extension work published on TPAMI](https://github.com/chaoma99/HCFTstar)

To exactly reproduce the results reported in our ICCV 2015 paper, please check the early committed version [(4b895b5)](https://github.com/jbhuang0604/CF2/tree/4b895b516b2d73fc83174439729d2157902c9d63) 


### Citation

If you find the code and dataset useful in your research, please consider citing:

    @article{Ma-HCFTstar-2017,
        title={Robust Visual Tracking via Hierarchical Convolutional Features},
        Author = {Ma, Chao and Huang, Jia-Bin and Yang, Xiaokang and Yang, Ming-Hsuan},
        journal = {IEEE Transcations on Pattern Analysis and Machine Intelligence},
        pages={},
        Year = {2018}
    }

    @inproceedings{Ma-ICCV-2015,
        title={Hierarchical Convolutional Features for Visual Tracking},
        Author = {Ma, Chao and Huang, Jia-Bin and Yang, Xiaokang and Yang, Ming-Hsuan},
        booktitle = {Proceedings of the IEEE International Conference on Computer Vision},
        pages={},
        Year = {2015}
    }

### Contents
|  Folder    | description |
| ---|---|

Feedbacks and comments are welcome! Feel free to contact us via [chaoma99@gmail.com](mailto:chaoma99@gmail.com) or [jbhuang1@illinois.edu](mailto:jbhuang1@illinois.edu).

Enjoy!

### Results on visual tracking benchmark

One-pass evaluation (OPE) on the 50 tracking sequences in [Wu et al. CVPR 2013](https://sites.google.com/site/trackerbenchmark/benchmarks/v10)
<img src="https://uofi.box.com/shared/static/nqgw4qmce6bxz14z1w00lyz9lqqc2bi1.png" width="360" />
<img src="https://uofi.box.com/shared/static/l0crsgyrf98urmvhjzb7axfhok3txmq5.png" width="360" />

Spatial robustness evaluation (SRE) on the 50 tracking sequences in [Wu et al. CVPR 2013](https://sites.google.com/site/trackerbenchmark/benchmarks/v10)
<img src="https://uofi.box.com/shared/static/xywr7bp21oe9qblws87j9aub9x1112j4.png" width="360" />
<img src="https://uofi.box.com/shared/static/d3eiqtq0m6wpm3wcv3o1hs9uijknbeo3.png" width="360" />

Temporal robustness evaluation (TRE) on the 50 tracking sequences in [Wu et al. CVPR 2013](https://sites.google.com/site/trackerbenchmark/benchmarks/v10)
<img src="https://uofi.box.com/shared/static/p87gikib8i06nm5ov0n7vmcn1shb30wl.png" width="360" />
<img src="https://uofi.box.com/shared/static/nxjnvu30u7n3tyjsw84w1rcthrit1b11.png" width="360" />


One-pass evaluation (OPE) on the 100 tracking sequences in [Wu et al. PAMI 2015](https://sites.google.com/site/benchmarkpami) 
<img src="https://uofi.box.com/shared/static/q2ltzbj5faem653xlfpbilm3ylu01ww1.png" width="360" />
<img src="https://uofi.box.com/shared/static/cc4odpxk50mzucapsto6vzcnzl5jmb4g.png" width="360" />

Spatial robustness evaluation (SRE) on the 100 tracking sequences in [Wu et al. PAMI 2015](https://sites.google.com/site/benchmarkpami)
<img src="https://uofi.box.com/shared/static/9lhhxnedmwuz0x2n2vp9f6gksx8d6n0q.png" width="360" />
<img src="https://uofi.box.com/shared/static/law5r1i95ju2vudh45pk6h185zob7zgv.png" width="360" />

Temporal robustness evaluation (TRE) on the 100 tracking sequences in [Wu et al. PAMI 2015](https://sites.google.com/site/benchmarkpami)
<img src="https://uofi.box.com/shared/static/sivqdtmmu45vpjcmxrmfcn91j34ptbma.png" width="360" />
<img src="https://uofi.box.com/shared/static/859u4v9i5z4ja59vngnlz6tx4v1d5dkg.png" width="360" />
