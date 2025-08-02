# EmiCore

Ok, now what?????

I guess we start with the file scanner. 

## File Scanner (Requirements)
- Should be able to recursively scan and index files and folders in a folder
- Should call the IMDB & musicbrainz API and populate the data in the necessary fields. 
- Should also fetch the images(posters, background images) in another background task. (Need a model for image attachments somehow.)
- Need an enum of sorts to classify media type. 
    - Movie
    - show
    - music
