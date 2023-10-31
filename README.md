<div align=center>
<h1>
    backup.sh
</h1>

<p>
    <a href="https://www.gnu.org/software/bash/"><img src="https://img.shields.io/badge/Language-Bash-green?logo=GNU%20Bash"></a>
    <a href="/LICENSE.txt"><img src="https://img.shields.io/badge/License-GNU_AGPLv3-blue?logo=GNU"></a>
</p>

<p>
    <a href="#description">Description</a> •
    <a href="#installation">Installation</a> •
    <a href="#usage">Usage</a> •
    <a href="#built-with">Built with</a> •
    <a href="#contributing">Contributing</a> •
    <a href="#author">Author</a> •
    <a href="#license">License</a>
</p>
</div>

## Description

[backup.sh](backup.sh) is a backup bash script to automate the creation of encrypted 7z archives.

## Installation

```sh
curl -O https://raw.githubusercontent.com/adrlsx/backup.sh/main/backup.sh
```

## Usage

Make sure the configuration file [config.sh](config.sh) is located in the same directory as the script [backup.sh](backup.sh).

Next, adapt the variables in [config.sh](config.sh) to your use case:

- Change the *OUTPUT_DIRECTORY* variable to match the target directory in which the encrypted 7z archive will be saved. This must be a full path or a relative path from the current working directory.
- Change the *BACKUP_NAME* variable to the desired name of the encrypted 7z archive. The current date will be appended at the end of the name.
- Change the *BACKUP_TARGET* variable to a list of folders and files to be backed up. These must be full paths or relative paths from the current working directory.

Once the variables have been set, you can simply execute the backup script:

```bash
bash backup.sh
```

## Built with

- [Bash](https://tiswww.case.edu/php/chet/bash/bashtop.html) - Bash is an sh-compatible command language interpreter that executes commands read from the standard input or from a file. Bash also incorporates useful features from the Korn and C shells (ksh and csh).

- [7-Zip 23.01](https://7-zip.org/) - 7-Zip is a file archiver with a high compression ratio. 7-Zip is free software with open source and most of the code is under the GNU LGPL license. It supports strong AES-256 encryption in 7z and ZIP formats. This script uses 7zzs, the standalone console version of 7-Zip (version compiled with static system library linking).

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Author

- [adrlsx](https://github.com/adrlsx)

## License

This project is licensed under the GNU AGPLv3 License - see the [LICENSE.txt](LICENSE.txt) file for details.

License chosen thanks to [choosealicense.com](https://choosealicense.com/).
