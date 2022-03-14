# sensor_project
Classifying human or empty space ultrasonic echo, resulting from RedPitaya Sensor at FRA-UAS

Threshold : - t 170 1000: 2100 Measurements
- Belt Empty close (BEC): 300
- Human Belt close (BHC): 300
- Human still Belt close (BSHC): 300
- Empty close  (EC): 400 
- Human close (HC): 400
- Human still close (SHC): 400

Apply Gabor transform to ADC echo signal to generate image dataset (img_size = [183x230x1]), then using CNN to learn and predict the results

Only create 700 images per class to avoid imbalance data

1000 images to train + 400 images to validate, confusion matrix can be seen as following:

![alt text](https://github.com/long2811/sensor_project/blob/main/result/confusionmatrixhighresolution.PNG)
