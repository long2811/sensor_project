# sensor_project
Classifying human or empty space ultrasonic echo, resulting from RedPitaya Sensor at FRA-UAS

Threshold : - t 170 1000: 2100 Measurements
- Belt Empty close (BEC): 300
- Human Belt close (BHC): 300
- Human still Belt close (BSHC): 300
- Empty close  (EC): 400 
- Human close (HC): 400
- Human still close (SHC): 400

Apply Gabor transform to ADC echo signal to generate image dataset ( low img_size = [183x230x1], high img_size = [361x456x1]), then using CNN to learn and predict the results

Only create 700 images per class to avoid imbalance data

1200 images to train + 200 images to validate, confusion matrix can be seen as following:

![alt text](https://github.com/long2811/sensor_project/blob/main/result/confusionmatrixhighresolution.PNG)

# How to use the GUI
1. Put ADC output file from REDPITAYA sensor in the SAME directory as sensor_project_GUI.mlapp\
Note: ADC file must have AT LEAST 2 rows of data, otherwise the app will not read it !

2. Rename it EXACTLY to adc.txt, otherwise the app will not find it !

3. Open sensor_project_GUI.mlapp (Matlab with additional Toolboxes requires)

4. Click on "Import adc.txt" button

5. The left-side plot should show a random echo sample from the adc.txt\
Note: Please ignore the warning: "spectrogram.png is missing" by Matlab

6. Next, click on "Gabor transform" button

7. The right-side plot will show the spectrogram, resulting from the random echo sample respectively

8. Now, click on "Export" button\
Note: Please do not click or hover your mouse on the Gabor plot, otherwise it will distort the image file "spectrogram.png"

9. Wait until the blue lamp is on, indicating that the image file is sucessfully exported !

10. Finally, click on "Load CNN & predict" button, the prediction will be indicated by a red lamp\
Note: Ensure CNNnet.mat is located in the SAME directory as sensor_project_GUI.mlapp\
Note: Run the application at first time will cost extra time to fully load the network
![alt text](https://github.com/long2811/sensor_project/blob/main/result/sensor_project_app.PNG)
