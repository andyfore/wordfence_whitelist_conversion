# wordfence_whitelist_conversion.sh
A utility script designed to programmatically update the whitelisted IP addresses in the field of the WAF of the WordFence plugin for the WordPress CMS.

**Script name** wordfence_whitelist_conversion.sh

*Created* 2019-04-07

*Original Author* Andrew Fore [andy.fore@arfore.com](mailto:andy.fore@arfore.com)

**File List**

* wordfence_whitelist_conversion.sh - this is the main script file

##Info
Currently this script is designed to run under the bash shell on CentOS 7.

##Usage

Currently the script takes no commandline options

```bash
# wordfence_whitelist_conversion.sh
```

##To Do
- validate that the field contents are empty
- filter out CNAME results from the operation
- allow for adding IP ranges