#!/bin/bash
# Best practices - https://bertvv.github.io/cheat-sheets/Bash.html

set -o errexit    # Exit when a command fails, add || true to commands that are allowed to fail
set -o pipefail   # Do not hide errors within pipes
set -o nounset    # Exit if an attempt is made to expand an unset variable

text_format() {
    # Avoid hardcoded sequences thanks to tput: https://askubuntu.com/a/1167054 and https://stackoverflow.com/a/2924755
    readonly t_reset="$(tput sgr0 2>/dev/null || true)"
    readonly t_red="$(tput setaf 1 2>/dev/null || true)"
    readonly t_green="$(tput setaf 2 2>/dev/null || true)"
    readonly t_yellow="$(tput setaf 3 2>/dev/null || true)"
}

echoerr() {
    # printf usage for more reliability and to avoid swallowing arguments: https://stackoverflow.com/a/2990533
    # Combining with stderr redirection: https://stackoverflow.com/a/62235327
    >&2 printf "${t_red}ERROR: %s${t_reset}\n" "${*}"
}

echosuccess() {
    # printf usage for more reliability and to avoid swallowing arguments: https://stackoverflow.com/a/2990533
    # Combining with stderr redirection: https://stackoverflow.com/a/62235327
    >&2 printf "${t_green}SUCCESS: %s${t_reset}\n" "${*}"
}

echowarning() {
    # printf usage for more reliability and to avoid swallowing arguments: https://stackoverflow.com/a/2990533
    # Combining with stderr redirection: https://stackoverflow.com/a/62235327
    >&2 printf "${t_yellow}WARNING: %s${t_reset}\n" "${*}"
}

welcome() {
    # ASCII art generator
    # https://www.kammerl.de/ascii/AsciiSignature.php
    # Font: rounded, colorized with 'lolcat --force'
    printf '
[38;2;43;252;88m [39m[38;2;46;253;84m_[39m[38;2;49;253;80m [39m[38;2;52;254;76m [39m[38;2;56;254;73m [39m[38;2;59;254;69m [39m[38;2;63;254;65m [39m[38;2;67;254;61m [39m[38;2;70;254;58m [39m[38;2;74;254;54m [39m[38;2;78;254;51m [39m[38;2;82;253;48m [39m[38;2;86;252;44m [39m[38;2;90;251;41m [39m[38;2;94;250;38m [39m[38;2;98;249;35m [39m[38;2;102;248;32m [39m[38;2;107;246;30m [39m[38;2;111;245;27m [39m[38;2;115;243;24m_[39m[38;2;119;241;22m [39m[38;2;123;240;20m [39m[38;2;128;237;17m [39m[38;2;132;235;15m [39m[38;2;136;233;13m [39m[38;2;140;231;12m [39m[38;2;144;228;10m [39m[38;2;149;225;8m [39m[38;2;153;223;7m [39m[38;2;157;220;6m [39m[38;2;161;217;5m [39m[38;2;165;214;4m [39m[38;2;169;211;3m [39m[38;2;173;207;2m [39m[38;2;177;204;1m [39m[38;2;181;201;1m [39m[38;2;185;197;1m [39m[38;2;188;194;1m [39m[38;2;192;190;1m [39m[38;2;196;186;1m [39m[38;2;199;182;1m [39m[38;2;203;179;1m [39m[38;2;206;175;2m [39m[38;2;209;171;2m_[39m[38;2;213;167;3m [39m[38;2;216;163;4m [39m[38;2;219;159;5m [39m[38;2;222;154;7m [39m[38;2;224;150;8m [39m[38;2;227;146;9m[39m
[38;2;52;254;76m|[39m[38;2;56;254;73m [39m[38;2;59;254;69m|[39m[38;2;63;254;65m [39m[38;2;67;254;61m [39m[38;2;70;254;58m [39m[38;2;74;254;54m [39m[38;2;78;254;51m [39m[38;2;82;253;48m [39m[38;2;86;252;44m [39m[38;2;90;251;41m [39m[38;2;94;250;38m [39m[38;2;98;249;35m [39m[38;2;102;248;32m [39m[38;2;107;246;30m [39m[38;2;111;245;27m [39m[38;2;115;243;24m [39m[38;2;119;241;22m [39m[38;2;123;240;20m|[39m[38;2;128;237;17m [39m[38;2;132;235;15m|[39m[38;2;136;233;13m [39m[38;2;140;231;12m [39m[38;2;144;228;10m [39m[38;2;149;225;8m [39m[38;2;153;223;7m [39m[38;2;157;220;6m [39m[38;2;161;217;5m [39m[38;2;165;214;4m [39m[38;2;169;211;3m [39m[38;2;173;207;2m [39m[38;2;177;204;1m [39m[38;2;181;201;1m [39m[38;2;185;197;1m [39m[38;2;188;194;1m [39m[38;2;192;190;1m [39m[38;2;196;186;1m [39m[38;2;199;182;1m [39m[38;2;203;179;1m [39m[38;2;206;175;2m [39m[38;2;209;171;2m [39m[38;2;213;167;3m [39m[38;2;216;163;4m|[39m[38;2;219;159;5m [39m[38;2;222;154;7m|[39m[38;2;224;150;8m [39m[38;2;227;146;9m [39m[38;2;230;142;11m [39m[38;2;232;138;13m [39m[38;2;234;133;15m[39m
[38;2;63;254;65m|[39m[38;2;67;254;61m [39m[38;2;70;254;58m|[39m[38;2;74;254;54m_[39m[38;2;78;254;51m_[39m[38;2;82;253;48m [39m[38;2;86;252;44m [39m[38;2;90;251;41m_[39m[38;2;94;250;38m_[39m[38;2;98;249;35m_[39m[38;2;102;248;32m_[39m[38;2;107;246;30m_[39m[38;2;111;245;27m [39m[38;2;115;243;24m [39m[38;2;119;241;22m_[39m[38;2;123;240;20m_[39m[38;2;128;237;17m_[39m[38;2;132;235;15m_[39m[38;2;136;233;13m|[39m[38;2;140;231;12m [39m[38;2;144;228;10m|[39m[38;2;149;225;8m [39m[38;2;153;223;7m [39m[38;2;157;220;6m_[39m[38;2;161;217;5m [39m[38;2;165;214;4m_[39m[38;2;169;211;3m [39m[38;2;173;207;2m [39m[38;2;177;204;1m [39m[38;2;181;201;1m_[39m[38;2;185;197;1m [39m[38;2;188;194;1m_[39m[38;2;192;190;1m_[39m[38;2;196;186;1m_[39m[38;2;199;182;1m_[39m[38;2;203;179;1m [39m[38;2;206;175;2m [39m[38;2;209;171;2m [39m[38;2;213;167;3m [39m[38;2;216;163;4m_[39m[38;2;219;159;5m_[39m[38;2;222;154;7m_[39m[38;2;224;150;8m|[39m[38;2;227;146;9m [39m[38;2;230;142;11m|[39m[38;2;232;138;13m_[39m[38;2;234;133;15m_[39m[38;2;237;129;17m [39m[38;2;239;125;19m [39m[38;2;241;121;21m[39m
[38;2;74;254;54m|[39m[38;2;78;254;51m [39m[38;2;82;253;48m [39m[38;2;86;252;44m_[39m[38;2;90;251;41m [39m[38;2;94;250;38m\[39m[38;2;98;249;35m([39m[38;2;102;248;32m_[39m[38;2;107;246;30m_[39m[38;2;111;245;27m_[39m[38;2;115;243;24m_[39m[38;2;119;241;22m [39m[38;2;123;240;20m|[39m[38;2;128;237;17m/[39m[38;2;132;235;15m [39m[38;2;136;233;13m_[39m[38;2;140;231;12m_[39m[38;2;144;228;10m_[39m[38;2;149;225;8m)[39m[38;2;153;223;7m [39m[38;2;157;220;6m|[39m[38;2;161;217;5m_[39m[38;2;165;214;4m/[39m[38;2;169;211;3m [39m[38;2;173;207;2m)[39m[38;2;177;204;1m [39m[38;2;181;201;1m|[39m[38;2;185;197;1m [39m[38;2;188;194;1m|[39m[38;2;192;190;1m [39m[38;2;196;186;1m|[39m[38;2;199;182;1m [39m[38;2;203;179;1m [39m[38;2;206;175;2m_[39m[38;2;209;171;2m [39m[38;2;213;167;3m\[39m[38;2;216;163;4m [39m[38;2;219;159;5m [39m[38;2;222;154;7m/[39m[38;2;224;150;8m_[39m[38;2;227;146;9m_[39m[38;2;230;142;11m_[39m[38;2;232;138;13m)[39m[38;2;234;133;15m [39m[38;2;237;129;17m [39m[38;2;239;125;19m_[39m[38;2;241;121;21m [39m[38;2;243;116;23m\[39m[38;2;244;112;26m [39m[38;2;246;108;29m[39m
[38;2;86;252;44m|[39m[38;2;90;251;41m [39m[38;2;94;250;38m|[39m[38;2;98;249;35m_[39m[38;2;102;248;32m)[39m[38;2;107;246;30m [39m[38;2;111;245;27m)[39m[38;2;115;243;24m [39m[38;2;119;241;22m_[39m[38;2;123;240;20m_[39m[38;2;128;237;17m_[39m[38;2;132;235;15m [39m[38;2;136;233;13m([39m[38;2;140;231;12m [39m[38;2;144;228;10m([39m[38;2;149;225;8m_[39m[38;2;153;223;7m_[39m[38;2;157;220;6m_[39m[38;2;161;217;5m|[39m[38;2;165;214;4m [39m[38;2;169;211;3m [39m[38;2;173;207;2m_[39m[38;2;177;204;1m [39m[38;2;181;201;1m([39m[38;2;185;197;1m|[39m[38;2;188;194;1m [39m[38;2;192;190;1m|[39m[38;2;196;186;1m_[39m[38;2;199;182;1m|[39m[38;2;203;179;1m [39m[38;2;206;175;2m|[39m[38;2;209;171;2m [39m[38;2;213;167;3m|[39m[38;2;216;163;4m_[39m[38;2;219;159;5m|[39m[38;2;222;154;7m [39m[38;2;224;150;8m|[39m[38;2;227;146;9m|[39m[38;2;230;142;11m_[39m[38;2;232;138;13m_[39m[38;2;234;133;15m_[39m[38;2;237;129;17m [39m[38;2;239;125;19m|[39m[38;2;241;121;21m [39m[38;2;243;116;23m|[39m[38;2;244;112;26m [39m[38;2;246;108;29m|[39m[38;2;247;104;31m [39m[38;2;249;100;34m|[39m[38;2;250;96;37m[39m
[38;2;98;249;35m|[39m[38;2;102;248;32m_[39m[38;2;107;246;30m_[39m[38;2;111;245;27m_[39m[38;2;115;243;24m_[39m[38;2;119;241;22m/[39m[38;2;123;240;20m\[39m[38;2;128;237;17m_[39m[38;2;132;235;15m_[39m[38;2;136;233;13m_[39m[38;2;140;231;12m_[39m[38;2;144;228;10m_[39m[38;2;149;225;8m|[39m[38;2;153;223;7m\[39m[38;2;157;220;6m_[39m[38;2;161;217;5m_[39m[38;2;165;214;4m_[39m[38;2;169;211;3m_[39m[38;2;173;207;2m)[39m[38;2;177;204;1m_[39m[38;2;181;201;1m|[39m[38;2;185;197;1m [39m[38;2;188;194;1m\[39m[38;2;192;190;1m_[39m[38;2;196;186;1m)[39m[38;2;199;182;1m_[39m[38;2;203;179;1m_[39m[38;2;206;175;2m_[39m[38;2;209;171;2m_[39m[38;2;213;167;3m/[39m[38;2;216;163;4m|[39m[38;2;219;159;5m [39m[38;2;222;154;7m [39m[38;2;224;150;8m_[39m[38;2;227;146;9m_[39m[38;2;230;142;11m([39m[38;2;232;138;13m_[39m[38;2;234;133;15m|[39m[38;2;237;129;17m_[39m[38;2;239;125;19m_[39m[38;2;241;121;21m_[39m[38;2;243;116;23m/[39m[38;2;244;112;26m|[39m[38;2;246;108;29m_[39m[38;2;247;104;31m|[39m[38;2;249;100;34m [39m[38;2;250;96;37m|[39m[38;2;251;92;40m_[39m[38;2;252;88;43m|[39m[38;2;253;84;46m[39m
[38;2;111;245;27m [39m[38;2;115;243;24m [39m[38;2;119;241;22m [39m[38;2;123;240;20m [39m[38;2;128;237;17m [39m[38;2;132;235;15m [39m[38;2;136;233;13m [39m[38;2;140;231;12m [39m[38;2;144;228;10m [39m[38;2;149;225;8m [39m[38;2;153;223;7m [39m[38;2;157;220;6m [39m[38;2;161;217;5m [39m[38;2;165;214;4m [39m[38;2;169;211;3m [39m[38;2;173;207;2m [39m[38;2;177;204;1m [39m[38;2;181;201;1m [39m[38;2;185;197;1m [39m[38;2;188;194;1m [39m[38;2;192;190;1m [39m[38;2;196;186;1m [39m[38;2;199;182;1m [39m[38;2;203;179;1m [39m[38;2;206;175;2m [39m[38;2;209;171;2m [39m[38;2;213;167;3m [39m[38;2;216;163;4m [39m[38;2;219;159;5m [39m[38;2;222;154;7m [39m[38;2;224;150;8m|[39m[38;2;227;146;9m_[39m[38;2;230;142;11m|[39m[38;2;232;138;13m [39m[38;2;234;133;15m [39m[38;2;237;129;17m [39m[38;2;239;125;19m [39m[38;2;241;121;21m [39m[38;2;243;116;23m [39m[38;2;244;112;26m [39m[38;2;246;108;29m [39m[38;2;247;104;31m [39m[38;2;249;100;34m [39m[38;2;250;96;37m [39m[38;2;251;92;40m [39m[38;2;252;88;43m [39m[38;2;253;84;46m [39m[38;2;253;80;50m [39m[38;2;254;76;53m [39m[38;2;254;72;56m[39m
\n'
    echo 'Backup bash script to automate the creation of encrypted 7z archives.'
    echo
}

sourcing() {
    # Config filename
    local -r config_file="$(dirname ${0})/config.sh"

    # Verify the config file exists and is readable
    if [[ -r "${config_file}" ]]; then
        # Source the config file to access the required variables
        source "${config_file}"

        # Verify the required variables are all set
        if [[ -z "${OUTPUT_DIRECTORY}" ]] || [[ -z "${BACKUP_NAME}" ]] || [[ -z "${BACKUP_TARGET}" ]]; then
            echoerr "One of the required variable in '${config_file}' is not set. Exiting..."
            echo
            exit 1
        fi
    else
        echoerr "Config file '${config_file}' does not exist or is not readable. Exiting..."
        echo
        exit 1
    fi
}

binaries_installation() {
    # Define 7-Zip binary target for installation
    local -r binary_version="2301"
    local -r binary_url="https://7-zip.org/a/7z${binary_version}-linux-x64.tar.xz"
    local -r binary_temp_path="/tmp/7z${binary_version}.tar.xz"

    # Create folder for 7-Zip binaries
    mkdir -p "${binary_path}"

    # 7-Zip installation
    echo "Installing 7-Zip from source to ${binary_path}..."
    # Download 7-Zip archive in /tmp
    curl --silent "${binary_url}" --output "${binary_temp_path}"
    # Extract binaries from 7-Zip archive to ~/.local/bin/
    tar --extract --lzma --file "${binary_temp_path}" --directory "${binary_path}" 7zz 7zzs
    # Remove 7-Zip archive from /tmp
    rm -f "${binary_temp_path}"

    # Exit if 7zzs install was not successfull
    if [[ -z "$(7zzs)" ]] && [[ -z "$(${binary_path}/7zzs)" ]]; then
        echoerr "Installation of 7-Zip from source failed. Exiting..."
        echo
        exit 1
    fi
}

verification() {
    # Source the config file to get access to the required variables
    sourcing
     
    # Create the output directory
    mkdir -p "$(realpath ${OUTPUT_DIRECTORY})"

    # Verify if 7zzs is installed
    if [[ -z "$(7zzs)" ]] && [[ -z "$(${binary_path}/7zzs)" ]]; then
        # Error message when 7zzs is not available
        echowarning "Command '7zzs' is not available. Trying to install 7-Zip from source..."

        # Install 7-Zip from source
        binaries_installation
    fi
    
    # Variable to count the number of wrong targets
    local nb_wrong_target=0
    # Variable to have the full path of each backup target
    local target_list=""

    # Test the validity of each target
    for target in ${BACKUP_TARGET}; do
        # Get the full path for the target
        target="$(realpath ${target})"
        if [[ -d "${target}" ]] || [[ -r "${target}" ]]; then
            # Append the target full path to the list
            target_list="${target_list} ${target}"
        else
            # Display error message
            echoerr "'${target}' was not found. Please edit the BACKUP_TARGET variable."
            # Increment wrong target count
            ((nb_wrong_target=nb_wrong_target+1))
        fi
    done
    
    # Output the number of wrong targets and exit
    if [[ "${nb_wrong_target}" -ne 0 ]]; then
        echoerr "There were ${nb_wrong_target} wrong target(s). Exiting..."
        echo
        exit 1
    fi

    # Declare the readonly global variable to be accessible by other functions
    readonly TARGET_LIST="${target_list}"
}

backup() {
    # Define path for 7zip binaries
    # verification() and binaries_installation() functions cannot run if this variable is not well defined
    local -r binary_path="$(realpath ${HOME}/.local/bin)"

    # verification() function sources variables from config file, checks them and test the validity of each target
    # Hence, backup is not possible if this function has not been run successfully
    verification

    # Ask the user for the archive password
    local archive_password verification_password
    read -s -r -p "Enter archive password: " archive_password
    echo
    read -s -r -p "Verify password: " verification_password
    echo

    # Check if passwords match
    if [[ "${archive_password}" != "${verification_password}" ]]; then
        echoerr "Passwords do not match. Exiting..."
        echo
        exit 1
    fi

    # Save current date
    local current_date="$(date --iso-8601='date')"
    
    # File naming
    local -r backup_file="$(realpath ${OUTPUT_DIRECTORY}/${BACKUP_NAME})"
    
    # Verify if the file does not already exist
    if [[ -f "${backup_file}-${current_date}.7z" ]]; then
        # Append minutes and seconds if the file already exists
        current_date="$(date --iso-8601='seconds')"
    fi
    
    # Final archive name
    local -r archive_name="${backup_file}-${current_date}.7z"

    # Backup everything in an encrypted 7z archive, word spitting is wanted for the TARGET_LIST variable
    "${binary_path}/7zzs" a -t7z -mhe=on -p"${archive_password}" "${archive_name}" ${TARGET_LIST}

    # Verify if the encrypted 7z archive was successfully created
    if [[ -r "${archive_name}" ]]; then
        # Give minimal rights to the encrypted 7z archive
        chmod 600 "${archive_name}"
        # Display success message
        echosuccess "${archive_name} was successfully created !"
        echo
    else
        # Display error message
        echoerr "Archive creation failed. Exiting..."
        echo
        exit 1
    fi
}

welcome
text_format
backup