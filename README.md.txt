The repository contains 4 files:

-codebook.		codebook for "tidy_dataset.txt"
-README.md		
-run_analysis.R		R script with the code for downloading and processing the data, gives "tidy_dataset.txt" as output
-tidy_dataset.txt	The final dataset, containing the averge value for the mean() and std() variables for every subject-activity combination
_________________________________________________________________________________________________________________________________________________

Brief description for the R script:

-Downloading the dataset
-Unzipping the dataset
-##Train dataset: 
	loading train dataset and feature names; 
	setting the column names; loading the subject and lables; 
	binding together the subject, labels and train dataset

-##Test dataset: 
	loading test dataset and feature names; 
	setting the column names; loading the subject and lables; 
	binding together the subject, labels and test dataset

-##Merge: 
	merging the train and test datasets by rows; 
	reading the acivity labels; 
	replacing the activity numbers with activity names

-##Extract and final tidy dataset: 
	extracting the variables for the mean() and std(); 
	creating a new variable for the interaction of subject and activity; 
	calculating the mean for each variable and subject-activity combination; 
	writing the final "tidy_dataset.txt"
___________________________________________________________________________________________________________________________________________________

To load the "tidy_dataset.txt" use:
data <- read.table("./tidy_dataset.txt", header = TRUE)
View(data)