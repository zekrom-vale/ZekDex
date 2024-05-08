## Bash
In Bash, you can use `wget` to download all .csv files.

```bash
# Download all .csv files from Base URL of the data folder in the stable branch
wget -r -np -nd -A csv "https://raw.githubusercontent.com/zekrom-vale/ZekDex/stable/data/"
```