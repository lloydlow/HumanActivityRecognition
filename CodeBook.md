##Codebook that describes variables in HumanRecognitionActivity dataset
###Variable name - descriptions
* window_sample - Each record corresponds to a measurement and this variable keeps the record. For the test dataset, there are 2947 records whereas for the training dataset, there are 7352 records. Total is 10299 records. So, a number is given to track each of these records, from 1 to 10299. [1 - 10299]
* subject_id - A unique identifier given to identify each individual in the experiment. It ranges from 1 - 30. [1-30]
* dataset_type - There are two types of datasets, train or test. 70% of the volunteers were selected for the 
train data and 30% for the test data. [train or test]
* set - This is the set of values from the orginal X_train.txt or X_test.txt. [values in  X_train.txt or X_test.txt]
* label - This is the label used for training or test labels. [1-6]
* body_type - This variable keeps whether the body or total was used for the measurement of triaxial acceleration or angular velocity. [body or total]
* measurement_type - This variable keeps whether the triaxial acceleration (acc) or angular velocity (gyro) was used for the measurement. [acc or gryo]
* angle - This variable keeps whether it was direction x,y or z that was used for the measurement. [x,y,z]
* value_of_activity - This variable contain the all values for each body_type (e.g. body), measurement_type (e.g. acc) and angle (e.g. x). [values in Inertial Signals folder, e.g. body_acc_x_test.txt] 
