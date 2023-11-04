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

 If the *7zzs* binary is not found in PATH, the 7-Zip console version for 64-bit Linux x86-64 will be downloaded from the official [7-Zip](https://7-zip.org/) website. *7zz* and *7zzs* binaries will then be extracted to **~/.local/bin** and the downloaded archive will be deleted.

 This script only uses *7zzs*, the standalone console version of 7-Zip (version compiled with static system library linking).

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

Important notice: **symlinks will be followed when creating the archive**. Depending on how your data is organized, this can potentially create duplicate folders in the final archive. Exclude or delete symlinks before backing up to avoid unnecessarily increasing the size of the backup archive.

## Built with

- [Bash 5.2](https://tiswww.case.edu/php/chet/bash/bashtop.html) - Bash is an sh-compatible command language interpreter that executes commands read from the standard input or from a file. Bash is free software, distributed under the terms of the GPLv3 license.

- [7-Zip 23.01](https://7-zip.org/) - 7-Zip is a file archiver with a high compression ratio. 7-Zip is free and open source software and most of the code is under the GNU LGPL license. It supports strong AES-256 encryption in 7z and ZIP formats.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Author

- [adrlsx](https://github.com/adrlsx)

## License

This project is licensed under the GNU AGPLv3 License - see the [LICENSE.txt](LICENSE.txt) file for details.

License chosen thanks to [choosealicense.com](https://choosealicense.com/).
