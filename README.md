csv-to-~~psd~~ pdf
==========
The PSD gem will export Photoshop layer data as a nested hash, including any text object layers. 
Find-and-replace operations can be made using a CSV as a dictionary. 

#####Unfortunately, the PSD gem does not support writing to a PSD, so no direct editing of a PSD file can be done currently.

###Instead, this is a script to perform similar operations on PDF files. 

This script:

>1. Reads a CSV file that contains two columns, with originals first, followed by translations.

>2. If the sample PDF contains any matches with the CSV "Original" column, it replaces it with the corresponding "Translation".

>3. A new PDF is written with the updated translations.

>4. A new CSV is then created with a third column, "Success", next to each successfully translated set.

Repository includes samples .csv and .pdf files to test.
