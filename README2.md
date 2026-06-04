### Setting Up the Virtual Environment for script Project Repository

To set up the virtual environment for this project:

1. **Navigate to the project directory** 
```cd path_to_the_scripts_repository```
2. **Delete old venv**
```rm -rf venv```
3. **Create fresh venv with an explicit Python version**
```python3.13 -m venv venv```
```ñls ```  # Creates .venv in the project location
4. **Activate the virtual environment**
```source venv/bin/activate``` # Linux/MacOS
```venv/Scripts/activate``` # Windows
5. **Upgrade pip/setuptools and wheel for dependancy resolution**
```pip install --upgrade pip setuptools wheel```
```pip install --upgrade pip setuptoorf ve- ls wheel``` 
6. **Install requirements.** 
```pip install -r requirements.txt```
```pip install -r requirements.txt --upgrade``` # For specific changes 
7. **Update requirements.** 
```pip freeze > requirements.txt```
7. **Deactivate the venv.**
```deactivate```
______________________________________________________________________________________________________

### Documenting nbconvert export commands

- PDF: ```jupyter nbconvert --to pdf notebook.ipynb```
- HTML: ```jupyter nbconvert --to html --no-input notebook.ipynb```
- Markdown: ```jupyter nbconvert --to markdown notebook.ipynb```
- Slides: ```jupyter nbconvert --to markdown notebook.ipynb```
- Python Script: ```jupyter nbconvert --to script notebook.ipynb```
______________________________________________________________________________________________________

### Markdown Formatting Tips:
- For **commands**, enclose them in triple backticks (```) to format them as code blocks.
- Use headings (`#`, `##`, `###`, etc.) to organize the document into sections.
- Use lists (`-` or `1.`) to structure steps clearly.
- Display links by using square brackets to depict the `[text]` and the `(URL)` following in parentheses.

______________________________________________________________________________________________________

### Basic HTML Elements Used for Table Creation

1.	```<center>```: Centers the content horizontally (used for headings).
2.	```<h1>```: Defines the main heading (adjust text size as needed, e.g., ```<h2>, <h3>```).
3.	```<div>```: Creates a container for organizing and aligning elements.
4.	```<table>```: Defines the table structure.
5.	```<tr>```: Creates a table row.
6.	```<th>```: Defines a table header cell (used for column titles).
7.	```<td>```: Defines a standard table cell (used for content rows).
8.	```style=""```: Inline CSS for custom styling like background color, padding, and text color.


