## Installation

You can install the package from GitHub with:

```r
# If devtools is not installed:
install.packages("devtools")

# Install the stable branch of the package ZekDex (recommended)
devtools::install_github("zekrom-vale/ZekDex")

# Or, install the main branch of the package ZekDex (May be in an unusable state)
devtools::install_github("zekrom-vale/ZekDex", ref = "main")

# Or, install a specific version of the package ZekDex using a tag
# For example, to install version v0.1.3-beta:
devtools::install_github("zekrom-vale/ZekDex", ref = "v0.1.3-beta")
```

## Download and Extract

Here's how you can download and extract these files using Python, Command Prompt (cmd), and Shell:

### Python

You can use the `requests` and `zipfile` libraries in Python to download and extract the zip file:

```python
import requests, zipfile, io

url = "https://raw.githubusercontent.com/zekrom-vale/ZekDex/stable/data/data.zip"
response = requests.get(url)
zip_file = zipfile.ZipFile(io.BytesIO(response.content))
zip_file.extractall("data") # path to the extraction directory
```

### Command Prompt (cmd)

In Windows, you can use `curl` to download the file and `tar` to extract it:

```cmd
curl -L -o data.tar.gz "https://raw.githubusercontent.com/zekrom-vale/ZekDex/stable/data/data.tar.gz"
tar -xvzf data.tar.gz -C "data" :: path to the extraction directory
```

### Shell

In Unix-based systems, you can use `wget` to download the file and `tar` to extract it:

```bash
wget "https://raw.githubusercontent.com/zekrom-vale/ZekDex/stable/data/data.tar.gz"
tar -xvzf data.tar.gz -C "data" # path to the extraction directory
```