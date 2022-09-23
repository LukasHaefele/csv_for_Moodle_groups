# Introduction

This is a commandline tool one can use to create a .csv file to upload to moodle to add existing users to an existing global group or create the group in the "system" environment and add the users. 

# Usage

The list should be named "input.txt" and be formatted like this:
g [Groupname]                         to initialize a group
[ID] [lastname], [firstname]          to state a user

All users underneath a new groupname will be added to the new group.

The Code will attempt any combination between up to three first and last names of a person and check it against the user list you can get by importing all users from moodle and rename it to "user.csv" the code can automatically parse it on it's own. All users that cannot be found by any variation in the user.csv file will be put out to the "erred.txt" file. All found users will be added to "output.csv", this list can be uploaded right away to the user management tab in Moodle. 
