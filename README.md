# Cracking the Emotional Code: Identifying Emotions through Electroencephalograms

Author: Muhammad Bilal Sajid  
Email: bilalsajid695@gmail.com
Phone: +923145844461

---

## Overview

This project presents a machine-learning-based system for emotion recognition using Electroencephalogram (EEG) signals. The system was designed and tested on the publicly available **DREAMER dataset** and aims to classify four distinct human emotions:

- **Sadness**
- **Joy**
- **Anger**
- **Pleasure**

By combining traditional signal processing techniques with feature selection and machine learning classifiers, the project achieved a top classification accuracy of **92.2%** using the Fine K-Nearest Neighbor (KNN) classifier.

---

## Methodology

- EEG signals were pre-processed using:
  - Band-stop IIR filtering to remove motion artifacts and noise.
  - Bandpass and high-pass filtering to isolate key EEG frequency bands:  
    Delta (1-4 Hz), Theta (4-8 Hz), Alpha (8-12 Hz), Beta (12-30 Hz), Gamma (>30 Hz).
  
- Feature extraction involved calculating:
  - **Shannon Energy**
  - **Log Energy**
  - **Hjorth Parameters**
  - **Power Spectral Density (PSD)**

- To address class imbalance, **ADASYN** (Adaptive Synthetic Sampling) was employed.
- **Chi-Square (CHI2)** feature selection reduced the feature set from 420 to the most significant 50.
- Multiple classifiers were tested, with Fine KNN showing the best results.

---

## Requirements

This project is implemented in **MATLAB**.  
You will need:

- MATLAB R2023a or later.
- Signal Processing Toolbox.
- Statistics and Machine Learning Toolbox.

---

## Publication

This project was published at **IEEE IBCAST 2023** under the title:  
**"Cracking the Emotional Code: Identifying Emotions through Electroencephalograms"**  
👉 *([Link to IEEE paper here](https://ieeexplore.ieee.org/document/10712834))*

---

## Video Demo

Watch the YouTube video demonstration of this project for a detailed walkthrough and live results:  
👉 *([Link to YouTube video here](https://www.youtube.com/watch?v=7pDj0y3pBpY))*

---

## License

This project is intended for academic and research use only.  
© Muhammad Bilal Sajid — 2023.

---