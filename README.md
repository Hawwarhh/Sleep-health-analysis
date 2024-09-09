Project Title: Analysis of Sleep, Health, and Lifestyle Dataset

Overview
This project involved a comprehensive analysis of a dataset encompassing various health and lifestyle metrics, such as sleep duration, quality of sleep, physical activity levels, stress levels, BMI categories, and more. The objective was to uncover patterns and correlations between these variables and to classify sleep quality using advanced machine learning models, including the C5.0 algorithm.

Tools & Libraries Used
R Programming Language: Primary tool for data manipulation, visualization, and analysis.
Tidyverse: A collection of R packages designed for data science, used for data wrangling and visualization.
Psych: Utilized for advanced statistical functions.
Caret: Applied for model training, validation, and evaluation.
C50: Used for implementing the C5.0 decision tree algorithm.
e1071: for SVM implementation.
ggplot2: For creating detailed and informative visualizations.

Key Insights & Visualizations

Sleep Duration and Quality of Sleep:
A significant portion of the population experiences suboptimal sleep duration (less than 6.5 hours), correlating with lower sleep quality scores.
Individuals with a sleep duration of 7-8 hours typically report better sleep quality.

Physical Activity Levels:
Higher physical activity levels are generally associated with better sleep quality. However, a subset of individuals with high activity levels still reported poor sleep, suggesting other influencing factors.

Stress and Sleep:
Higher stress levels are strongly correlated with poor sleep quality and shorter sleep duration. This relationship highlights the impact of mental health on sleep.

BMI and Sleep:
Overweight and obese individuals reported higher incidences of sleep disorders such as sleep apnea and insomnia, further linking physical health to sleep quality.

Blood Pressure and Sleep:
Elevated blood pressure readings were more common in individuals reporting poor sleep quality and shorter sleep durations.

Machine Learning Classification Results

C5.0 Algorithm:
The C5.0 algorithm was applied to classify sleep quality as either "Poor Sleep" or "Good Sleep" based on features such as sleep duration, physical activity level, stress level, BMI, and more.
Model Accuracy: The C5.0 model achieved an accuracy of 100% on the test set.

Feature Importance: The model identified stress levels, sleep duration, and physical activity as the most significant predictors of sleep quality.

Confusion Matrix:
True Positives (Poor Sleep correctly classified): 24
True Negatives (Good Sleep correctly classified): 50
False Positives: 0
False Negatives: 0
Precision: 100%
Recall: 100%

Interpretation:
Perfect Performance: The confusion matrix and associated metrics show that the C5.0 model performed perfectly on the test set, 
correctly classifying all instances of both "Poor Sleep" and "Good Sleep."

Practical Considerations:
While this level of performance is ideal, it is important to note that such results are rare in real-world scenarios and might indicate overfitting, especially if the dataset is small or not very diverse.
This perfect classification suggests that the model was very well-suited to the data provided. 
However, in practice, further validation with a different dataset would be important to confirm that this performance generalizes well.

SVM Model:
As a comparison, SVM was also used, achieving an outstanding accuracy, with slightly lower precision and recall than the C5.0 model.
These results indicate that the C5.0 algorithm is highly effective in predicting sleep quality, offering a robust model for identifying individuals at risk of poor sleep.

Conclusion
The analysis confirms that sleep health is multifactorial, influenced by physical activity, stress, BMI, and overall lifestyle. The results, combined with the C5.0 classification model, underline the importance of a balanced lifestyle for optimal sleep health and offer valuable insights for healthcare professionals aiming to improve patient outcomes related to sleep disorders.
