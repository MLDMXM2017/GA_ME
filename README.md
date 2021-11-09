# Micro-expression Recognition using Advanced Genetic Algorithm

A neural network with genetic algorithm is designed to extract the high level features to perform the facial micro-expression recognition on three emotion classes (positive, negative and surprise).

Example of micro-expressions:

<img src="https://github.com/christy1206/biwoof/blob/pictures/006_006_1_2.gif" width="200" height="200"/> <img src="https://github.com/christy1206/biwoof/blob/pictures/s03_s03_po_11.gif" width="200" height="200"/> <img src="https://github.com/christy1206/biwoof/blob/pictures/sub11_EP15_04f.gif" width="200" height="200"/>

SAMM (006_006_1_2), SMIC (s03_s03_po_11), CASME II (sub11_EP15_04f)

GA is a search heuristic algorithm based on natural evolution towards a better solution. The key function is it can stimulate the features extracted for replication, crossover, and mutation. Prior to the GA implementation, the benchmark preprocessing method and feature extractors are directly adopted herein. Succinctly, the complete proposed framework composes three main steps: the apex frame acquisition, optical flow approximation, and feature extraction with CNN architecture.

![](https://github.com/Vikifall/GA/blob/main/Flow%20diagram.png)

The recognition results achieved are:

![](https://github.com/Vikifall/GA/blob/main/result.png)

The databases include CASME II (145 videos), SMIC (164 videos) and SAMM (133 videos). "Full" is the composite database of the 3 databases (442 videos).

Software is written and tested using Matlab 2019b, toolbox required:
1) Deep Learning Toolbox
2) Parallel Computing Toolbox 
3) Computer Vision System Toolbox

The files include:
1) GA_libsvm.m : Script which trains results of 68 groups (LOSO) with GA 
2) crosspop.m : The crossover process of GA's chromosome
3) variation.m : The mutation process of GA's chromosome
4) judgepop.m : Determine whether the elemental difference between the two chromosomes is greater than the mutation rate
5) select_libsvm.m : The selected features are classified through the classifier
6) input : Input data features (442*400) extracted from STSTNet

If you use this method in your research, please cite:

@article{LIU2021116153,
title = {Micro-expression recognition using advanced genetic algorithm},
journal = {Signal Processing: Image Communication},
volume = {93},
pages = {116153},
year = {2021},
issn = {0923-5965},
doi = {https://doi.org/10.1016/j.image.2021.116153},
url = {https://www.sciencedirect.com/science/article/pii/S0923596521000114},
author = {Kun-Hong Liu and Qiu-Shi Jin and Huang-Chao Xu and Yee-Siang Gan and Sze-Teng Liong},
keywords = {Genetic algorithm, Apex, CNN, Optical flow, Micro-expression, Recognition},
abstract = {In recent years, numerous facial expression recognition related applications had been commercialized in the market. Many of them achieved promising and reliable performance results in real-world applications. In contrast, the automated micro-expression recognition system relevant research analysis is still greatly lacking. This is because of the nature of the micro-expression that is usually appeared with relatively lesser duration and lower intensity. However, due to its uncontrollable, subtlety, and spontaneity properties, it is capable to reveal one’s concealed genuine feelings. Therefore, this paper attempts to improve the performance of current micro-expression recognition systems by introducing an efficient and effective algorithm. Particularly, we employ genetic algorithms (GA) to discover an optimal solution in order to facilitate the computational process in producing better recognition results. Prior to the GA implementation, the benchmark preprocessing method and feature extractors are directly adopted herein. Succinctly, the complete proposed framework composes three main steps: the apex frame acquisition, optical flow approximation, and feature extraction with CNN architecture. Experiments are conducted on the composite dataset that is made up of three publicly available databases, viz, CASME II, SMIC, and SAMM. The recognition performance tends to prevail the state-of-the-art methods by attaining an accuracy of 85.9% and F1-score of 83.7%.}
}

If you have suggestions or questions regarding this method, please reach out to stliong@fcu.edu.tw

Thank you for your interest and support.
