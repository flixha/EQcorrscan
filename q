GIT-CONFIG(1)                                                                            Git Manual                                                                           GIT-CONFIG(1)

[1mNAME[0m
       git-config - Get and set repository or global options

[1mSYNOPSIS[0m
       [4mgit[24m [4mconfig[24m [<file-option>] [--type=<type>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] name [value [value-pattern]]
       [4mgit[24m [4mconfig[24m [<file-option>] [--type=<type>] --add name value
       [4mgit[24m [4mconfig[24m [<file-option>] [--type=<type>] [--fixed-value] --replace-all name value [value-pattern]
       [4mgit[24m [4mconfig[24m [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get name [value-pattern]
       [4mgit[24m [4mconfig[24m [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all name [value-pattern]
       [4mgit[24m [4mconfig[24m [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp name_regex [value-pattern]
       [4mgit[24m [4mconfig[24m [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
       [4mgit[24m [4mconfig[24m [<file-option>] [--fixed-value] --unset name [value-pattern]
       [4mgit[24m [4mconfig[24m [<file-option>] [--fixed-value] --unset-all name [value-pattern]
       [4mgit[24m [4mconfig[24m [<file-option>] --rename-section old_name new_name
       [4mgit[24m [4mconfig[24m [<file-option>] --remove-section name
       [4mgit[24m [4mconfig[24m [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
       [4mgit[24m [4mconfig[24m [<file-option>] --get-color name [default]
       [4mgit[24m [4mconfig[24m [<file-option>] --get-colorbool name [stdout-is-tty]
       [4mgit[24m [4mconfig[24m [<file-option>] -e | --edit

[1mDESCRIPTION[0m
       You can query/set/replace/unset options with this command. The name is actually the section and the key separated by a dot, and the value will be escaped.

       Multiple lines can be added to an option by using the [1m--add [22moption. If you want to update or unset an option which can occur on multiple lines, a [1mvalue-pattern [22m(which is an
       extended regular expression, unless the [1m--fixed-value [22moption is given) needs to be given. Only the existing values that match the pattern are updated or unset. If you want to
       handle the lines that do [1mnot [22mmatch the pattern, just prepend a single exclamation mark in front (see also the section called "EXAMPLES"), but note that this only works when the
       [1m--fixed-value [22moption is not in use.

       The [1m--type=<type> [22moption instructs [4mgit[24m [4mconfig[24m to ensure that incoming and outgoing values are canonicalize-able under the given <type>. If no [1m--type=<type> [22mis given, no
       canonicalization will be performed. Callers may unset an existing [1m--type [22mspecifier with [1m--no-type[22m.

       When reading, the values are read from the system, global and repository local configuration files by default, and options [1m--system[22m, [1m--global[22m, [1m--local[22m, [1m--worktree [22mand [1m--file[0m
       [1m<filename> [22mcan be used to tell the command to read from only that location (see the section called "FILES").

       When writing, the new value is written to the repository local configuration file by default, and options [1m--system[22m, [1m--global[22m, [1m--worktree[22m, [1m--file <filename> [22mcan be used to tell the
       command to write to that location (you can say [1m--local [22mbut that is the default).

       This command will fail with non-zero status upon error. Some exit codes are:

       +o   The section or key is invalid (ret=1),

       +o   no section or name was provided (ret=2),

       +o   the config file is invalid (ret=3),

       +o   the config file cannot be written (ret=4),

       +o   you try to unset an option which does not exist (ret=5),

       +o   you try to unset/set an option for which multiple lines match (ret=5), or

       +o   you try to use an invalid regexp (ret=6).

       On success, the command returns the exit code 0.

[1mOPTIONS[0m
       --replace-all
           Default behavior is to replace at most one line. This replaces all lines matching the key (and optionally the [1mvalue-pattern[22m).

       --add
           Adds a new line to the option without altering any existing values. This is the same as providing [4m^$[24m as the [1mvalue-pattern [22min [1m--replace-all[22m.

       --get
           Get the value for a given key (optionally filtered by a regex matching the value). Returns error code 1 if the key was not found and the last value if multiple key values were
           found.

       --get-all
           Like get, but returns all values for a multi-valued key.

       --get-regexp
           Like --get-all, but interprets the name as a regular expression and writes out the key names. Regular expression matching is currently case-sensitive and done against a
           canonicalized version of the key in which section and variable names are lowercased, but subsection names are not.

       --get-urlmatch name URL
           When given a two-part name section.key, the value for section.<url>.key whose <url> part matches the best to the given URL is returned (if no such key exists, the value for
           section.key is used as a fallback). When given just the section as name, do so for all the keys in the section and list them. Returns error code 1 if no value is found.

       --global
           For writing options: write to global [1m~/.gitconfig [22mfile rather than the repository [1m.git/config[22m, write to [1m$XDG_CONFIG_HOME/git/config [22mfile if this file exists and the
           [1m~/.gitconfig [22mfile doesn't.

           For reading options: read only from global [1m~/.gitconfig [22mand from [1m$XDG_CONFIG_HOME/git/config [22mrather than from all available files.

           See also the section called "FILES".

       --system
           For writing options: write to system-wide [1m$(prefix)/etc/gitconfig [22mrather than the repository [1m.git/config[22m.

           For reading options: read only from system-wide [1m$(prefix)/etc/gitconfig [22mrather than from all available files.

           See also the section called "FILES".

       --local
           For writing options: write to the repository [1m.git/config [22mfile. This is the default behavior.

           For reading options: read only from the repository [1m.git/config [22mrather than from all available files.

           See also the section called "FILES".

       --worktree
           Similar to [1m--local [22mexcept that [1m.git/config.worktree [22mis read from or written to if [1mextensions.worktreeConfig [22mis present. If not it's the same as [1m--local[22m.

       -f config-file, --file config-file
           Use the given config file instead of the one specified by GIT_CONFIG.

       --blob blob
           Similar to [1m--file [22mbut use the given blob instead of a file. E.g. you can use [4mmaster:.gitmodules[24m to read values from the file [4m.gitmodules[24m in the master branch. See "SPECIFYING
           REVISIONS" section in [1mgitrevisions[22m(7) for a more complete list of ways to spell blob names.

       --remove-section
           Remove the given section from the configuration file.

       --rename-section
           Rename the given section to a new name.

       --unset
           Remove the line matching the key from config file.

       --unset-all
           Remove all lines matching the key from config file.

       -l, --list
           List all variables set in config file, along with their values.

       --fixed-value
           When used with the [1mvalue-pattern [22margument, treat [1mvalue-pattern [22mas an exact string instead of a regular expression. This will restrict the name/value pairs that are matched to
           only those where the value is exactly equal to the [1mvalue-pattern[22m.

       --type <type>
           [4mgit[24m [4mconfig[24m will ensure that any input or output is valid under the given type constraint(s), and will canonicalize outgoing values in [1m<type>[22m's canonical form.

           Valid [1m<type>[22m's include:

           +o   [4mbool[24m: canonicalize values as either "true" or "false".

           +o   [4mint[24m: canonicalize values as simple decimal numbers. An optional suffix of [4mk[24m, [4mm[24m, or [4mg[24m will cause the value to be multiplied by 1024, 1048576, or 1073741824 upon input.

           +o   [4mbool-or-int[24m: canonicalize according to either [4mbool[24m or [4mint[24m, as described above.

           +o   [4mpath[24m: canonicalize by adding a leading [1m~ [22mto the value of [1m$HOME [22mand [1m~user [22mto the home directory for the specified user. This specifier has no effect when setting the value
               (but you can use [1mgit config section.variable ~/ [22mfrom the command line to let your shell do the expansion.)

           +o   [4mexpiry-date[24m: canonicalize by converting from a fixed or relative date-string to a timestamp. This specifier has no effect when setting the value.

           +o   [4mcolor[24m: When getting a value, canonicalize by converting to an ANSI color escape sequence. When setting a value, a sanity-check is performed to ensure that the given value
               is canonicalize-able as an ANSI color, but it is written as-is.

       --bool, --int, --bool-or-int, --path, --expiry-date
           Historical options for selecting a type specifier. Prefer instead [1m--type [22m(see above).

       --no-type
           Un-sets the previously set type specifier (if one was previously set). This option requests that [4mgit[24m [4mconfig[24m not canonicalize the retrieved variable.  [1m--no-type [22mhas no effect
           without [1m--type=<type> [22mor [1m--<type>[22m.

       -z, --null
           For all options that output values and/or keys, always end values with the null character (instead of a newline). Use newline instead as a delimiter between key and value. This
           allows for secure parsing of the output without getting confused e.g. by values that contain line breaks.

       --name-only
           Output only the names of config variables for [1m--list [22mor [1m--get-regexp[22m.

       --show-origin
           Augment the output of all queried config options with the origin type (file, standard input, blob, command line) and the actual origin (config file path, ref, or blob id if
           applicable).

       --show-scope
           Similar to [1m--show-origin [22min that it augments the output of all queried config options with the scope of that value (local, global, system, command).

       --get-colorbool name [stdout-is-tty]
           Find the color setting for [1mname [22m(e.g.  [1mcolor.diff[22m) and output "true" or "false".  [1mstdout-is-tty [22mshould be either "true" or "false", and is taken into account when configuration
           says "auto". If [1mstdout-is-tty [22mis missing, then checks the standard output of the command itself, and exits with status 0 if color is to be used, or exits with status 1
           otherwise. When the color setting for [1mname [22mis undefined, the command uses [1mcolor.ui [22mas fallback.

       --get-color name [default]
           Find the color configured for [1mname [22m(e.g.  [1mcolor.diff.new[22m) and output it as the ANSI color escape sequence to the standard output. The optional [1mdefault [22mparameter is used
           instead, if there is no color configured for [1mname[22m.

           [1m--type=color [--default=<default>] [22mis preferred over [1m--get-color [22m(but note that [1m--get-color [22mwill omit the trailing newline printed by [1m--type=color[22m).

       -e, --edit
           Opens an editor to modify the specified config file; either [1m--system[22m, [1m--global[22m, or repository (default).

       --[no-]includes
           Respect [1minclude.*  [22mdirectives in config files when looking up values. Defaults to [1moff [22mwhen a specific file is given (e.g., using [1m--file[22m, [1m--global[22m, etc) and [1mon [22mwhen searching
           all config files.

       --default <value>
           When using [1m--get[22m, and the requested variable is not found, behave as if <value> were the value assigned to the that variable.

[1mCONFIGURATION[0m
       [1mpager.config [22mis only respected when listing configuration, i.e., when using [1m--list [22mor any of the [1m--get-* [22mwhich may return multiple results. The default is to use a pager.

[1mFILES[0m
       If not set explicitly with [1m--file[22m, there are four files where [4mgit[24m [4mconfig[24m will search for configuration options:

       $(prefix)/etc/gitconfig
           System-wide configuration file.

       $XDG_CONFIG_HOME/git/config
           Second user-specific configuration file. If $XDG_CONFIG_HOME is not set or empty, [1m$HOME/.config/git/config [22mwill be used. Any single-valued variable set in this file will be
           overwritten by whatever is in [1m~/.gitconfig[22m. It is a good idea not to create this file if you sometimes use older versions of Git, as support for this file was added fairly
           recently.

       ~/.gitconfig
           User-specific configuration file. Also called "global" configuration file.

       $GIT_DIR/config
           Repository specific configuration file.

       $GIT_DIR/config.worktree
           This is optional and is only searched when [1mextensions.worktreeConfig [22mis present in $GIT_DIR/config.

       If no further options are given, all reading options will read all of these files that are available. If the global or the system-wide configuration file are not available they
       will be ignored. If the repository configuration file is not available or readable, [4mgit[24m [4mconfig[24m will exit with a non-zero error code. However, in neither case will an error message
       be issued.

       The files are read in the order given above, with last value found taking precedence over values read earlier. When multiple values are taken then all values of a key from all
       files will be used.

       You may override individual configuration parameters when running any git command by using the [1m-c [22moption. See [1mgit[22m(1) for details.

       All writing options will per default write to the repository specific configuration file. Note that this also affects options like [1m--replace-all [22mand [1m--unset[22m. [4mgit[24m [4mconfig[24m [1mwill only[0m
       [1mever change one file at a time[22m.

       You can override these rules either by command-line options or by environment variables. The [1m--global[22m, [1m--system [22mand [1m--worktree [22moptions will limit the file used to the global,
       system-wide or per-worktree file respectively. The [1mGIT_CONFIG [22menvironment variable has a similar effect, but you can specify any filename you want.

[1mENVIRONMENT[0m
       GIT_CONFIG
           Take the configuration from the given file instead of .git/config. Using the "--global" option forces this to ~/.gitconfig. Using the "--system" option forces this to
           $(prefix)/etc/gitconfig.

       GIT_CONFIG_NOSYSTEM
           Whether to skip reading settings from the system-wide $(prefix)/etc/gitconfig file. See [1mgit[22m(1) for details.

       See also the section called "FILES".

[1mEXAMPLES[0m
       Given a .git/config like this:

           #
           # This is the config file, and
           # a '#' or ';' character indicates
           # a comment
           #

           ; core variables
           [core]
                   ; Don't trust file modes
                   filemode = false

           ; Our diff algorithm
           [diff]
                   external = /usr/local/bin/diff-wrapper
                   renames = true

           ; Proxy settings
           [core]
                   gitproxy=proxy-command for kernel.org
                   gitproxy=default-proxy ; for all the rest

           ; HTTP
           [http]
                   sslVerify
           [http "https://weak.example.com"]
                   sslVerify = false
                   cookieFile = /tmp/cookie.txt

       you can set the filemode to true with

           % git config core.filemode true

       The hypothetical proxy command entries actually have a postfix to discern what URL they apply to. Here is how to change the entry for kernel.org to "ssh".

           % git config core.gitproxy '"ssh" for kernel.org' 'for kernel.org$'

       This makes sure that only the key/value pair for kernel.org is replaced.

       To delete the entry for renames, do

           % git config --unset diff.renames

       If you want to delete an entry for a multivar (like core.gitproxy above), you have to provide a regex matching the value of exactly one line.

       To query the value for a given key, do

           % git config --get core.filemode

       or

           % git config core.filemode

       or, to query a multivar:

           % git config --get core.gitproxy "for kernel.org$"

       If you want to know all the values for a multivar, do:

           % git config --get-all core.gitproxy

       If you like to live dangerously, you can replace [1mall [22mcore.gitproxy by a new one with

           % git config --replace-all core.gitproxy ssh

       However, if you really only want to replace the line for the default proxy, i.e. the one without a "for ..." postfix, do something like this:

           % git config core.gitproxy ssh '! for '

       To actually match only values with an exclamation mark, you have to

           % git config section.key value '[!]'

       To add a new proxy, without altering any of the existing ones, use

           % git config --add core.gitproxy '"proxy-command" for example.com'

       An example to use customized color from the configuration in your script:

           #!/bin/sh
           WS=$(git config --get-color color.diff.whitespace "blue reverse")
           RESET=$(git config --get-color "" "reset")
           echo "${WS}your whitespace color or blue reverse${RESET}"

       For URLs in [1mhttps://weak.example.com[22m, [1mhttp.sslVerify [22mis set to false, while it is set to [1mtrue [22mfor all others:

           % git config --type=bool --get-urlmatch http.sslverify https://good.example.com
           true
           % git config --type=bool --get-urlmatch http.sslverify https://weak.example.com
           false
           % git config --get-urlmatch http https://weak.example.com
           http.cookieFile /tmp/cookie.txt
           http.sslverify false

[1mCONFIGURATION FILE[0m
       The Git configuration file contains a number of variables that affect the Git commands' behavior. The files [1m.git/config [22mand optionally [1mconfig.worktree [22m(see the "CONFIGURATION FILE"
       section of [1mgit-worktree[22m(1)) in each repository are used to store the configuration for that repository, and [1m$HOME/.gitconfig [22mis used to store a per-user configuration as fallback
       values for the [1m.git/config [22mfile. The file [1m/etc/gitconfig [22mcan be used to store a system-wide default configuration.

       The configuration variables are used by both the Git plumbing and the porcelains. The variables are divided into sections, wherein the fully qualified variable name of the variable
       itself is the last dot-separated segment and the section name is everything before the last dot. The variable names are case-insensitive, allow only alphanumeric characters and [1m-[22m,
       and must start with an alphabetic character. Some variables may appear multiple times; we say then that the variable is multivalued.

   [1mSyntax[0m
       The syntax is fairly flexible and permissive; whitespaces are mostly ignored. The [4m#[24m and [4m;[24m characters begin comments to the end of line, blank lines are ignored.

       The file consists of sections and variables. A section begins with the name of the section in square brackets and continues until the next section begins. Section names are
       case-insensitive. Only alphanumeric characters, [1m- [22mand [1m. [22mare allowed in section names. Each variable must belong to some section, which means that there must be a section header
       before the first setting of a variable.

       Sections can be further divided into subsections. To begin a subsection put its name in double quotes, separated by space from the section name, in the section header, like in the
       example below:

                   [section "subsection"]

       Subsection names are case sensitive and can contain any characters except newline and the null byte. Doublequote [1m" [22mand backslash can be included by escaping them as [1m\" [22mand [1m\\[22m,
       respectively. Backslashes preceding other characters are dropped when reading; for example, [1m\t [22mis read as [1mt [22mand [1m\0 [22mis read as [1m0 [22mSection headers cannot span multiple lines.
       Variables may belong directly to a section or to a given subsection. You can have [1m[section] [22mif you have [1m[section "subsection"][22m, but you don't need to.

       There is also a deprecated [1m[section.subsection] [22msyntax. With this syntax, the subsection name is converted to lower-case and is also compared case sensitively. These subsection
       names follow the same restrictions as section names.

       All the other lines (and the remainder of the line after the section header) are recognized as setting variables, in the form [4mname[24m [4m=[24m [4mvalue[24m (or just [4mname[24m, which is a short-hand to
       say that the variable is the boolean "true"). The variable names are case-insensitive, allow only alphanumeric characters and [1m-[22m, and must start with an alphabetic character.

       A line that defines a value can be continued to the next line by ending it with a [1m\[22m; the backslash and the end-of-line are stripped. Leading whitespaces after [4mname[24m [4m=[24m, the remainder
       of the line after the first comment character [4m#[24m or [4m;[24m, and trailing whitespaces of the line are discarded unless they are enclosed in double quotes. Internal whitespaces within the
       value are retained verbatim.

       Inside double quotes, double quote [1m" [22mand backslash [1m\ [22mcharacters must be escaped: use [1m\" [22mfor [1m" [22mand [1m\\ [22mfor [1m\[22m.

       The following escape sequences (beside [1m\" [22mand [1m\\[22m) are recognized: [1m\n [22mfor newline character (NL), [1m\t [22mfor horizontal tabulation (HT, TAB) and [1m\b [22mfor backspace (BS). Other char escape
       sequences (including octal escape sequences) are invalid.

   [1mIncludes[0m
       The [1minclude [22mand [1mincludeIf [22msections allow you to include config directives from another source. These sections behave identically to each other with the exception that [1mincludeIf[0m
       sections may be ignored if their condition does not evaluate to true; see "Conditional includes" below.

       You can include a config file from another by setting the special [1minclude.path [22m(or [1mincludeIf.*.path[22m) variable to the name of the file to be included. The variable takes a pathname
       as its value, and is subject to tilde expansion. These variables can be given multiple times.

       The contents of the included file are inserted immediately, as if they had been found at the location of the include directive. If the value of the variable is a relative path, the
       path is considered to be relative to the configuration file in which the include directive was found. See below for examples.

   [1mConditional includes[0m
       You can include a config file from another conditionally by setting a [1mincludeIf.<condition>.path [22mvariable to the name of the file to be included.

       The condition starts with a keyword followed by a colon and some data whose format and meaning depends on the keyword. Supported keywords are:

       [1mgitdir[0m
           The data that follows the keyword [1mgitdir: [22mis used as a glob pattern. If the location of the .git directory matches the pattern, the include condition is met.

           The .git location may be auto-discovered, or come from [1m$GIT_DIR [22menvironment variable. If the repository is auto discovered via a .git file (e.g. from submodules, or a linked
           worktree), the .git location would be the final location where the .git directory is, not where the .git file is.

           The pattern can contain standard globbing wildcards and two additional ones, [1m**/ [22mand [1m/**[22m, that can match multiple path components. Please refer to [1mgitignore[22m(5) for details. For
           convenience:

           +o   If the pattern starts with [1m~/[22m, [1m~ [22mwill be substituted with the content of the environment variable [1mHOME[22m.

           +o   If the pattern starts with [1m./[22m, it is replaced with the directory containing the current config file.

           +o   If the pattern does not start with either [1m~/[22m, [1m./ [22mor [1m/[22m, [1m**/ [22mwill be automatically prepended. For example, the pattern [1mfoo/bar [22mbecomes [1m**/foo/bar [22mand would match
               [1m/any/path/to/foo/bar[22m.

           +o   If the pattern ends with [1m/[22m, [1m** [22mwill be automatically added. For example, the pattern [1mfoo/ [22mbecomes [1mfoo/**[22m. In other words, it matches "foo" and everything inside,
               recursively.

       [1mgitdir/i[0m
           This is the same as [1mgitdir [22mexcept that matching is done case-insensitively (e.g. on case-insensitive file systems)

       [1monbranch[0m
           The data that follows the keyword [1monbranch: [22mis taken to be a pattern with standard globbing wildcards and two additional ones, [1m**/ [22mand [1m/**[22m, that can match multiple path
           components. If we are in a worktree where the name of the branch that is currently checked out matches the pattern, the include condition is met.

           If the pattern ends with [1m/[22m, [1m** [22mwill be automatically added. For example, the pattern [1mfoo/ [22mbecomes [1mfoo/**[22m. In other words, it matches all branches that begin with [1mfoo/[22m. This is
           useful if your branches are organized hierarchically and you would like to apply a configuration to all the branches in that hierarchy.

       A few more notes on matching via [1mgitdir [22mand [1mgitdir/i[22m:

       +o   Symlinks in [1m$GIT_DIR [22mare not resolved before matching.

       +o   Both the symlink & realpath versions of paths will be matched outside of [1m$GIT_DIR[22m. E.g. if ~/git is a symlink to /mnt/storage/git, both [1mgitdir:~/git [22mand [1mgitdir:/mnt/storage/git[0m
           will match.

           This was not the case in the initial release of this feature in v2.13.0, which only matched the realpath version. Configuration that wants to be compatible with the initial
           release of this feature needs to either specify only the realpath version, or both versions.

       +o   Note that "../" is not special and will match literally, which is unlikely what you want.

   [1mExample[0m
           # Core variables
           [core]
                   ; Don't trust file modes
                   filemode = false

           # Our diff algorithm
           [diff]
                   external = /usr/local/bin/diff-wrapper
                   renames = true

           [branch "devel"]
                   remote = origin
                   merge = refs/heads/devel

           # Proxy settings
           [core]
                   gitProxy="ssh" for "kernel.org"
                   gitProxy=default-proxy ; for the rest

           [include]
                   path = /path/to/foo.inc ; include by absolute path
                   path = foo.inc ; find "foo.inc" relative to the current file
                   path = ~/foo.inc ; find "foo.inc" in your `$HOME` directory

           ; include if $GIT_DIR is /path/to/foo/.git
           [includeIf "gitdir:/path/to/foo/.git"]
                   path = /path/to/foo.inc

           ; include for all repositories inside /path/to/group
           [includeIf "gitdir:/path/to/group/"]
                   path = /path/to/foo.inc

           ; include for all repositories inside $HOME/to/group
           [includeIf "gitdir:~/to/group/"]
                   path = /path/to/foo.inc

           ; relative paths are always relative to the including
           ; file (if the condition is true); their location is not
           ; affected by the condition
           [includeIf "gitdir:/path/to/group/"]
                   path = foo.inc

           ; include only if we are in a worktree where foo-branch is
           ; currently checked out
           [includeIf "onbranch:foo-branch"]
                   path = foo.inc

   [1mValues[0m
       Values of many variables are treated as a simple string, but there are variables that take values of specific types and there are rules as to how to spell them.

       boolean
           When a variable is said to take a boolean value, many synonyms are accepted for [4mtrue[24m and [4mfalse[24m; these are all case-insensitive.

           true
               Boolean true literals are [1myes[22m, [1mon[22m, [1mtrue[22m, and [1m1[22m. Also, a variable defined without [1m= <value> [22mis taken as true.

           false
               Boolean false literals are [1mno[22m, [1moff[22m, [1mfalse[22m, [1m0 [22mand the empty string.

               When converting a value to its canonical form using the [1m--type=bool [22mtype specifier, [4mgit[24m [4mconfig[24m will ensure that the output is "true" or "false" (spelled in lowercase).

       integer
           The value for many variables that specify various sizes can be suffixed with [1mk[22m, [1mM[22m,... to mean "scale the number by 1024", "by 1024x1024", etc.

       color
           The value for a variable that takes a color is a list of colors (at most two, one for foreground and one for background) and attributes (as many as you want), separated by
           spaces.

           The basic colors accepted are [1mnormal[22m, [1mblack[22m, [1mred[22m, [1mgreen[22m, [1myellow[22m, [1mblue[22m, [1mmagenta[22m, [1mcyan [22mand [1mwhite[22m. The first color given is the foreground; the second is the background. All the
           basic colors except [1mnormal [22mhave a bright variant that can be specified by prefixing the color with [1mbright[22m, like [1mbrightred[22m.

           Colors may also be given as numbers between 0 and 255; these use ANSI 256-color mode (but note that not all terminals may support this). If your terminal supports it, you may
           also specify 24-bit RGB values as hex, like [1m#ff0ab3[22m.

           The accepted attributes are [1mbold[22m, [1mdim[22m, [1mul[22m, [1mblink[22m, [1mreverse[22m, [1mitalic[22m, and [1mstrike [22m(for crossed-out or "strikethrough" letters). The position of any attributes with respect to the
           colors (before, after, or in between), doesn't matter. Specific attributes may be turned off by prefixing them with [1mno [22mor [1mno- [22m(e.g., [1mnoreverse[22m, [1mno-ul[22m, etc).

           An empty color string produces no color effect at all. This can be used to avoid coloring specific elements without disabling color entirely.

           For git's pre-defined color slots, the attributes are meant to be reset at the beginning of each item in the colored output. So setting [1mcolor.decorate.branch [22mto [1mblack [22mwill
           paint that branch name in a plain [1mblack[22m, even if the previous thing on the same output line (e.g. opening parenthesis before the list of branch names in [1mlog --decorate [22moutput)
           is set to be painted with [1mbold [22mor some other attribute. However, custom log formats may do more complicated and layered coloring, and the negated forms may be useful there.

       pathname
           A variable that takes a pathname value can be given a string that begins with "[1m~/[22m" or "[1m~user/[22m", and the usual tilde expansion happens to such a string: [1m~/ [22mis expanded to the
           value of [1m$HOME[22m, and [1m~user/ [22mto the specified user's home directory.

   [1mVariables[0m
       Note that this list is non-comprehensive and not necessarily complete. For command-specific variables, you will find a more detailed description in the appropriate manual page.

       Other git-related tools may and do use their own variables. When inventing new variables for use in your own tool, make sure their names do not conflict with those that are used by
       Git itself and other popular tools, and describe them in your documentation.

       advice.*
           These variables control various optional help messages designed to aid new users. All [4madvice.*[24m  variables default to [4mtrue[24m, and you can tell Git that you do not need help by
           setting these to [4mfalse[24m:

           fetchShowForcedUpdates
               Advice shown when [1mgit-fetch[22m(1) takes a long time to calculate forced updates after ref updates, or to warn that the check is disabled.

           pushUpdateRejected
               Set this variable to [4mfalse[24m if you want to disable [4mpushNonFFCurrent[24m, [4mpushNonFFMatching[24m, [4mpushAlreadyExists[24m, [4mpushFetchFirst[24m, [4mpushNeedsForce[24m, and [4mpushRefNeedsUpdate[0m
               simultaneously.

           pushNonFFCurrent
               Advice shown when [1mgit-push[22m(1) fails due to a non-fast-forward update to the current branch.

           pushNonFFMatching
               Advice shown when you ran [1mgit-push[22m(1) and pushed [4mmatching[24m [4mrefs[24m explicitly (i.e. you used [4m:[24m, or specified a refspec that isn't your current branch) and it resulted in a
               non-fast-forward error.

           pushAlreadyExists
               Shown when [1mgit-push[22m(1) rejects an update that does not qualify for fast-forwarding (e.g., a tag.)

           pushFetchFirst
               Shown when [1mgit-push[22m(1) rejects an update that tries to overwrite a remote ref that points at an object we do not have.

           pushNeedsForce
               Shown when [1mgit-push[22m(1) rejects an update that tries to overwrite a remote ref that points at an object that is not a commit-ish, or make the remote ref point at an object
               that is not a commit-ish.

           pushUnqualifiedRefname
               Shown when [1mgit-push[22m(1) gives up trying to guess based on the source and destination refs what remote ref namespace the source belongs in, but where we can still suggest
               that the user push to either refs/heads/* or refs/tags/* based on the type of the source object.

           pushRefNeedsUpdate
               Shown when [1mgit-push[22m(1) rejects a forced update of a branch when its remote-tracking ref has updates that we do not have locally.

           statusAheadBehind
               Shown when [1mgit-status[22m(1) computes the ahead/behind counts for a local ref compared to its remote tracking ref, and that calculation takes longer than expected. Will not
               appear if [1mstatus.aheadBehind [22mis false or the option [1m--no-ahead-behind [22mis given.

           statusHints
               Show directions on how to proceed from the current state in the output of [1mgit-status[22m(1), in the template shown when writing commit messages in [1mgit-commit[22m(1), and in the
               help message shown by [1mgit-switch[22m(1) or [1mgit-checkout[22m(1) when switching branch.

           statusUoption
               Advise to consider using the [1m-u [22moption to [1mgit-status[22m(1) when the command takes more than 2 seconds to enumerate untracked files.

           commitBeforeMerge
               Advice shown when [1mgit-merge[22m(1) refuses to merge to avoid overwriting local changes.

           resetQuiet
               Advice to consider using the [1m--quiet [22moption to [1mgit-reset[22m(1) when the command takes more than 2 seconds to enumerate unstaged changes after reset.

           resolveConflict
               Advice shown by various commands when conflicts prevent the operation from being performed.

           sequencerInUse
               Advice shown when a sequencer command is already in progress.

           implicitIdentity
               Advice on how to set your identity configuration when your information is guessed from the system username and domain name.

           detachedHead
               Advice shown when you used [1mgit-switch[22m(1) or [1mgit-checkout[22m(1) to move to the detach HEAD state, to instruct how to create a local branch after the fact.

           checkoutAmbiguousRemoteBranchName
               Advice shown when the argument to [1mgit-checkout[22m(1) and [1mgit-switch[22m(1) ambiguously resolves to a remote tracking branch on more than one remote in situations where an
               unambiguous argument would have otherwise caused a remote-tracking branch to be checked out. See the [1mcheckout.defaultRemote [22mconfiguration variable for how to set a given
               remote to used by default in some situations where this advice would be printed.

           amWorkDir
               Advice that shows the location of the patch file when [1mgit-am[22m(1) fails to apply it.

           rmHints
               In case of failure in the output of [1mgit-rm[22m(1), show directions on how to proceed from the current state.

           addEmbeddedRepo
               Advice on what to do when you've accidentally added one git repo inside of another.

           ignoredHook
               Advice shown if a hook is ignored because the hook is not set as executable.

           waitingForEditor
               Print a message to the terminal whenever Git is waiting for editor input from the user.

           nestedTag
               Advice shown if a user attempts to recursively tag a tag object.

           submoduleAlternateErrorStrategyDie
               Advice shown when a submodule.alternateErrorStrategy option configured to "die" causes a fatal error.

           addIgnoredFile
               Advice shown if a user attempts to add an ignored file to the index.

           addEmptyPathspec
               Advice shown if a user runs the add command without providing the pathspec parameter.

       core.fileMode
           Tells Git if the executable bit of files in the working tree is to be honored.

           Some filesystems lose the executable bit when a file that is marked as executable is checked out, or checks out a non-executable file with executable bit on.  [1mgit-clone[22m(1) or
           [1mgit-init[22m(1) probe the filesystem to see if it handles the executable bit correctly and this variable is automatically set as necessary.

           A repository, however, may be on a filesystem that handles the filemode correctly, and this variable is set to [4mtrue[24m when created, but later may be made accessible from another
           environment that loses the filemode (e.g. exporting ext4 via CIFS mount, visiting a Cygwin created repository with Git for Windows or Eclipse). In such a case it may be
           necessary to set this variable to [4mfalse[24m. See [1mgit-update-index[22m(1).

           The default is true (when core.filemode is not specified in the config file).

       core.hideDotFiles
           (Windows-only) If true, mark newly-created directories and files whose name starts with a dot as hidden. If [4mdotGitOnly[24m, only the [1m.git/ [22mdirectory is hidden, but no other files
           starting with a dot. The default mode is [4mdotGitOnly[24m.

       core.ignoreCase
           Internal variable which enables various workarounds to enable Git to work better on filesystems that are not case sensitive, like APFS, HFS+, FAT, NTFS, etc. For example, if a
           directory listing finds "makefile" when Git expects "Makefile", Git will assume it is really the same file, and continue to remember it as "Makefile".

           The default is false, except [1mgit-clone[22m(1) or [1mgit-init[22m(1) will probe and set core.ignoreCase true if appropriate when the repository is created.

           Git relies on the proper configuration of this variable for your operating and file system. Modifying this value may result in unexpected behavior.

       core.precomposeUnicode
           This option is only used by Mac OS implementation of Git. When core.precomposeUnicode=true, Git reverts the unicode decomposition of filenames done by Mac OS. This is useful
           when sharing a repository between Mac OS and Linux or Windows. (Git for Windows 1.7.10 or higher is needed, or Git under cygwin 1.7). When false, file names are handled fully
           transparent by Git, which is backward compatible with older versions of Git.

       core.protectHFS
           If set to true, do not allow checkout of paths that would be considered equivalent to [1m.git [22mon an HFS+ filesystem. Defaults to [1mtrue [22mon Mac OS, and [1mfalse [22melsewhere.

       core.protectNTFS
           If set to true, do not allow checkout of paths that would cause problems with the NTFS filesystem, e.g. conflict with 8.3 "short" names. Defaults to [1mtrue [22mon Windows, and [1mfalse[0m
           elsewhere.

       core.fsmonitor
           If set, the value of this variable is used as a command which will identify all files that may have changed since the requested date/time. This information is used to speed up
           git by avoiding unnecessary processing of files that have not changed. See the "fsmonitor-watchman" section of [1mgithooks[22m(5).

       core.fsmonitorHookVersion
           Sets the version of hook that is to be used when calling fsmonitor. There are currently versions 1 and 2. When this is not set, version 2 will be tried first and if it fails
           then version 1 will be tried. Version 1 uses a timestamp as input to determine which files have changes since that time but some monitors like watchman have race conditions
           when used with a timestamp. Version 2 uses an opaque string so that the monitor can return something that can be used to determine what files have changed without race
           conditions.

       core.trustctime
           If false, the ctime differences between the index and the working tree are ignored; useful when the inode change time is regularly modified by something outside Git (file
           system crawlers and some backup systems). See [1mgit-update-index[22m(1). True by default.

       core.splitIndex
           If true, the split-index feature of the index will be used. See [1mgit-update-index[22m(1). False by default.

       core.untrackedCache
           Determines what to do about the untracked cache feature of the index. It will be kept, if this variable is unset or set to [1mkeep[22m. It will automatically be added if set to [1mtrue[22m.
           And it will automatically be removed, if set to [1mfalse[22m. Before setting it to [1mtrue[22m, you should check that mtime is working properly on your system. See [1mgit-update-index[22m(1).  [1mkeep[0m
           by default, unless [1mfeature.manyFiles [22mis enabled which sets this setting to [1mtrue [22mby default.

       core.checkStat
           When missing or is set to [1mdefault[22m, many fields in the stat structure are checked to detect if a file has been modified since Git looked at it. When this configuration variable
           is set to [1mminimal[22m, sub-second part of mtime and ctime, the uid and gid of the owner of the file, the inode number (and the device number, if Git was compiled to use it), are
           excluded from the check among these fields, leaving only the whole-second part of mtime (and ctime, if [1mcore.trustCtime [22mis set) and the filesize to be checked.

           There are implementations of Git that do not leave usable values in some fields (e.g. JGit); by excluding these fields from the comparison, the [1mminimal [22mmode may help
           interoperability when the same repository is used by these other systems at the same time.

       core.quotePath
           Commands that output paths (e.g.  [4mls-files[24m, [4mdiff[24m), will quote "unusual" characters in the pathname by enclosing the pathname in double-quotes and escaping those characters with
           backslashes in the same way C escapes control characters (e.g.  [1m\t [22mfor TAB, [1m\n [22mfor LF, [1m\\ [22mfor backslash) or bytes with values larger than 0x80 (e.g. octal [1m\302\265 [22mfor "micro"
           in UTF-8). If this variable is set to false, bytes higher than 0x80 are not considered "unusual" any more. Double-quotes, backslash and control characters are always escaped
           regardless of the setting of this variable. A simple space character is not considered "unusual". Many commands can output pathnames completely verbatim using the [1m-z [22moption.
           The default value is true.

       core.eol
           Sets the line ending type to use in the working directory for files that are marked as text (either by having the [1mtext [22mattribute set, or by having [1mtext=auto [22mand Git
           auto-detecting the contents as text). Alternatives are [4mlf[24m, [4mcrlf[24m and [4mnative[24m, which uses the platform's native line ending. The default value is [1mnative[22m. See [1mgitattributes[22m(5) for
           more information on end-of-line conversion. Note that this value is ignored if [1mcore.autocrlf [22mis set to [1mtrue [22mor [1minput[22m.

       core.safecrlf
           If true, makes Git check if converting [1mCRLF [22mis reversible when end-of-line conversion is active. Git will verify if a command modifies a file in the work tree either directly
           or indirectly. For example, committing a file followed by checking out the same file should yield the original file in the work tree. If this is not the case for the current
           setting of [1mcore.autocrlf[22m, Git will reject the file. The variable can be set to "warn", in which case Git will only warn about an irreversible conversion but continue the
           operation.

           CRLF conversion bears a slight chance of corrupting data. When it is enabled, Git will convert CRLF to LF during commit and LF to CRLF during checkout. A file that contains a
           mixture of LF and CRLF before the commit cannot be recreated by Git. For text files this is the right thing to do: it corrects line endings such that we have only LF line
           endings in the repository. But for binary files that are accidentally classified as text the conversion can corrupt data.

           If you recognize such corruption early you can easily fix it by setting the conversion type explicitly in .gitattributes. Right after committing you still have the original
           file in your work tree and this file is not yet corrupted. You can explicitly tell Git that this file is binary and Git will handle the file appropriately.

           Unfortunately, the desired effect of cleaning up text files with mixed line endings and the undesired effect of corrupting binary files cannot be distinguished. In both cases
           CRLFs are removed in an irreversible way. For text files this is the right thing to do because CRLFs are line endings, while for binary files converting CRLFs corrupts data.

           Note, this safety check does not mean that a checkout will generate a file identical to the original file for a different setting of [1mcore.eol [22mand [1mcore.autocrlf[22m, but only for
           the current one. For example, a text file with [1mLF [22mwould be accepted with [1mcore.eol=lf [22mand could later be checked out with [1mcore.eol=crlf[22m, in which case the resulting file would
           contain [1mCRLF[22m, although the original file contained [1mLF[22m. However, in both work trees the line endings would be consistent, that is either all [1mLF [22mor all [1mCRLF[22m, but never mixed. A
           file with mixed line endings would be reported by the [1mcore.safecrlf [22mmechanism.

       core.autocrlf
           Setting this variable to "true" is the same as setting the [1mtext [22mattribute to "auto" on all files and core.eol to "crlf". Set to true if you want to have [1mCRLF [22mline endings in
           your working directory and the repository has LF line endings. This variable can be set to [4minput[24m, in which case no output conversion is performed.

       core.checkRoundtripEncoding
           A comma and/or whitespace separated list of encodings that Git performs UTF-8 round trip checks on if they are used in an [1mworking-tree-encoding [22mattribute (see
           [1mgitattributes[22m(5)). The default value is [1mSHIFT-JIS[22m.

       core.symlinks
           If false, symbolic links are checked out as small plain files that contain the link text.  [1mgit-update-index[22m(1) and [1mgit-add[22m(1) will not change the recorded type to regular file.
           Useful on filesystems like FAT that do not support symbolic links.

           The default is true, except [1mgit-clone[22m(1) or [1mgit-init[22m(1) will probe and set core.symlinks false if appropriate when the repository is created.

       core.gitProxy
           A "proxy command" to execute (as [4mcommand[24m [4mhost[24m [4mport[24m) instead of establishing direct connection to the remote server when using the Git protocol for fetching. If the variable
           value is in the "COMMAND for DOMAIN" format, the command is applied only on hostnames ending with the specified domain string. This variable may be set multiple times and is
           matched in the given order; the first match wins.

           Can be overridden by the [1mGIT_PROXY_COMMAND [22menvironment variable (which always applies universally, without the special "for" handling).

           The special string [1mnone [22mcan be used as the proxy command to specify that no proxy be used for a given domain pattern. This is useful for excluding servers inside a firewall
           from proxy use, while defaulting to a common proxy for external domains.

       core.sshCommand
           If this variable is set, [1mgit fetch [22mand [1mgit push [22mwill use the specified command instead of [1mssh [22mwhen they need to connect to a remote system. The command is in the same form as
           the [1mGIT_SSH_COMMAND [22menvironment variable and is overridden when the environment variable is set.

       core.ignoreStat
           If true, Git will avoid using lstat() calls to detect if files have changed by setting the "assume-unchanged" bit for those tracked files which it has updated identically in
           both the index and working tree.

           When files are modified outside of Git, the user will need to stage the modified files explicitly (e.g. see [4mExamples[24m section in [1mgit-update-index[22m(1)). Git will not normally
           detect changes to those files.

           This is useful on systems where lstat() calls are very slow, such as CIFS/Microsoft Windows.

           False by default.

       core.preferSymlinkRefs
           Instead of the default "symref" format for HEAD and other symbolic reference files, use symbolic links. This is sometimes needed to work with old scripts that expect HEAD to be
           a symbolic link.

       core.alternateRefsCommand
           When advertising tips of available history from an alternate, use the shell to execute the specified command instead of [1mgit-for-each-ref[22m(1). The first argument is the absolute
           path of the alternate. Output must contain one hex object id per line (i.e., the same as produced by [1mgit for-each-ref --format='%(objectname)'[22m).

           Note that you cannot generally put [1mgit for-each-ref [22mdirectly into the config value, as it does not take a repository path as an argument (but you can wrap the command above in
           a shell script).

       core.alternateRefsPrefixes
           When listing references from an alternate, list only references that begin with the given prefix. Prefixes match as if they were given as arguments to [1mgit-for-each-ref[22m(1). To
           list multiple prefixes, separate them with whitespace. If [1mcore.alternateRefsCommand [22mis set, setting [1mcore.alternateRefsPrefixes [22mhas no effect.

       core.bare
           If true this repository is assumed to be [4mbare[24m and has no working directory associated with it. If this is the case a number of commands that require a working directory will be
           disabled, such as [1mgit-add[22m(1) or [1mgit-merge[22m(1).

           This setting is automatically guessed by [1mgit-clone[22m(1) or [1mgit-init[22m(1) when the repository was created. By default a repository that ends in "/.git" is assumed to be not bare
           (bare = false), while all other repositories are assumed to be bare (bare = true).

       core.worktree
           Set the path to the root of the working tree. If [1mGIT_COMMON_DIR [22menvironment variable is set, core.worktree is ignored and not used for determining the root of working tree.
           This can be overridden by the [1mGIT_WORK_TREE [22menvironment variable and the [1m--work-tree [22mcommand-line option. The value can be an absolute path or relative to the path to the .git
           directory, which is either specified by --git-dir or GIT_DIR, or automatically discovered. If --git-dir or GIT_DIR is specified but none of --work-tree, GIT_WORK_TREE and
           core.worktree is specified, the current working directory is regarded as the top level of your working tree.

           Note that this variable is honored even when set in a configuration file in a ".git" subdirectory of a directory and its value differs from the latter directory (e.g.
           "/path/to/.git/config" has core.worktree set to "/different/path"), which is most likely a misconfiguration. Running Git commands in the "/path/to" directory will still use
           "/different/path" as the root of the work tree and can cause confusion unless you know what you are doing (e.g. you are creating a read-only snapshot of the same index to a
           location different from the repository's usual working tree).

       core.logAllRefUpdates
           Enable the reflog. Updates to a ref <ref> is logged to the file "[1m$GIT_DIR/logs/<ref>[22m", by appending the new and old SHA-1, the date/time and the reason of the update, but only
           when the file exists. If this configuration variable is set to [1mtrue[22m, missing "[1m$GIT_DIR/logs/<ref>[22m" file is automatically created for branch heads (i.e. under [1mrefs/heads/[22m),
           remote refs (i.e. under [1mrefs/remotes/[22m), note refs (i.e. under [1mrefs/notes/[22m), and the symbolic ref [1mHEAD[22m. If it is set to [1malways[22m, then a missing reflog is automatically created
           for any ref under [1mrefs/[22m.

           This information can be used to determine what commit was the tip of a branch "2 days ago".

           This value is true by default in a repository that has a working directory associated with it, and false by default in a bare repository.

       core.repositoryFormatVersion
           Internal variable identifying the repository format and layout version.

       core.sharedRepository
           When [4mgroup[24m (or [4mtrue[24m), the repository is made shareable between several users in a group (making sure all the files and objects are group-writable). When [4mall[24m (or [4mworld[24m or
           [4meverybody[24m), the repository will be readable by all users, additionally to being group-shareable. When [4mumask[24m (or [4mfalse[24m), Git will use permissions reported by umask(2). When
           [4m0xxx[24m, where [4m0xxx[24m is an octal number, files in the repository will have this mode value.  [4m0xxx[24m will override user's umask value (whereas the other options will only override
           requested parts of the user's umask value). Examples: [4m0660[24m will make the repo read/write-able for the owner and group, but inaccessible to others (equivalent to [4mgroup[24m unless
           umask is e.g.  [4m0022[24m).  [4m0640[24m is a repository that is group-readable but not group-writable. See [1mgit-init[22m(1). False by default.

       core.warnAmbiguousRefs
           If true, Git will warn you if the ref name you passed it is ambiguous and might match multiple refs in the repository. True by default.

       core.compression
           An integer -1..9, indicating a default compression level. -1 is the zlib default. 0 means no compression, and 1..9 are various speed/size tradeoffs, 9 being slowest. If set,
           this provides a default to other compression variables, such as [1mcore.looseCompression [22mand [1mpack.compression[22m.

       core.looseCompression
           An integer -1..9, indicating the compression level for objects that are not in a pack file. -1 is the zlib default. 0 means no compression, and 1..9 are various speed/size
           tradeoffs, 9 being slowest. If not set, defaults to core.compression. If that is not set, defaults to 1 (best speed).

       core.packedGitWindowSize
           Number of bytes of a pack file to map into memory in a single mapping operation. Larger window sizes may allow your system to process a smaller number of large pack files more
           quickly. Smaller window sizes will negatively affect performance due to increased calls to the operating system's memory manager, but may improve performance when accessing a
           large number of large pack files.

           Default is 1 MiB if NO_MMAP was set at compile time, otherwise 32 MiB on 32 bit platforms and 1 GiB on 64 bit platforms. This should be reasonable for all users/operating
           systems. You probably do not need to adjust this value.

           Common unit suffixes of [4mk[24m, [4mm[24m, or [4mg[24m are supported.

       core.packedGitLimit
           Maximum number of bytes to map simultaneously into memory from pack files. If Git needs to access more than this many bytes at once to complete an operation it will unmap
           existing regions to reclaim virtual address space within the process.

           Default is 256 MiB on 32 bit platforms and 32 TiB (effectively unlimited) on 64 bit platforms. This should be reasonable for all users/operating systems, except on the largest
           projects. You probably do not need to adjust this value.

           Common unit suffixes of [4mk[24m, [4mm[24m, or [4mg[24m are supported.

       core.deltaBaseCacheLimit
           Maximum number of bytes per thread to reserve for caching base objects that may be referenced by multiple deltified objects. By storing the entire decompressed base objects in
           a cache Git is able to avoid unpacking and decompressing frequently used base objects multiple times.

           Default is 96 MiB on all platforms. This should be reasonable for all users/operating systems, except on the largest projects. You probably do not need to adjust this value.

           Common unit suffixes of [4mk[24m, [4mm[24m, or [4mg[24m are supported.

       core.bigFileThreshold
           Files larger than this size are stored deflated, without attempting delta compression. Storing large files without delta compression avoids excessive memory usage, at the
           slight expense of increased disk usage. Additionally files larger than this size are always treated as binary.

           Default is 512 MiB on all platforms. This should be reasonable for most projects as source code and other text files can still be delta compressed, but larger binary media
           files won't be.

           Common unit suffixes of [4mk[24m, [4mm[24m, or [4mg[24m are supported.

       core.excludesFile
           Specifies the pathname to the file that contains patterns to describe paths that are not meant to be tracked, in addition to [1m.gitignore [22m(per-directory) and [1m.git/info/exclude[22m.
           Defaults to [1m$XDG_CONFIG_HOME/git/ignore[22m. If [1m$XDG_CONFIG_HOME [22mis either not set or empty, [1m$HOME/.config/git/ignore [22mis used instead. See [1mgitignore[22m(5).

       core.askPass
           Some commands (e.g. svn and http interfaces) that interactively ask for a password can be told to use an external program given via the value of this variable. Can be
           overridden by the [1mGIT_ASKPASS [22menvironment variable. If not set, fall back to the value of the [1mSSH_ASKPASS [22menvironment variable or, failing that, a simple password prompt. The
           external program shall be given a suitable prompt as command-line argument and write the password on its STDOUT.

       core.attributesFile
           In addition to [1m.gitattributes [22m(per-directory) and [1m.git/info/attributes[22m, Git looks into this file for attributes (see [1mgitattributes[22m(5)). Path expansions are made the same way as
           for [1mcore.excludesFile[22m. Its default value is [1m$XDG_CONFIG_HOME/git/attributes[22m. If [1m$XDG_CONFIG_HOME [22mis either not set or empty, [1m$HOME/.config/git/attributes [22mis used instead.

       core.hooksPath
           By default Git will look for your hooks in the [1m$GIT_DIR/hooks [22mdirectory. Set this to different path, e.g.  [1m/etc/git/hooks[22m, and Git will try to find your hooks in that
           directory, e.g.  [1m/etc/git/hooks/pre-receive [22minstead of in [1m$GIT_DIR/hooks/pre-receive[22m.

           The path can be either absolute or relative. A relative path is taken as relative to the directory where the hooks are run (see the "DESCRIPTION" section of [1mgithooks[22m(5)).

           This configuration variable is useful in cases where you'd like to centrally configure your Git hooks instead of configuring them on a per-repository basis, or as a more
           flexible and centralized alternative to having an [1minit.templateDir [22mwhere you've changed default hooks.

       core.editor
           Commands such as [1mcommit [22mand [1mtag [22mthat let you edit messages by launching an editor use the value of this variable when it is set, and the environment variable [1mGIT_EDITOR [22mis not
           set. See [1mgit-var[22m(1).

       core.commentChar
           Commands such as [1mcommit [22mand [1mtag [22mthat let you edit messages consider a line that begins with this character commented, and removes them after the editor returns (default [4m#[24m).

           If set to "auto", [1mgit-commit [22mwould select a character that is not the beginning character of any line in existing commit messages.

       core.filesRefLockTimeout
           The length of time, in milliseconds, to retry when trying to lock an individual reference. Value 0 means not to retry at all; -1 means to try indefinitely. Default is 100
           (i.e., retry for 100ms).

       core.packedRefsTimeout
           The length of time, in milliseconds, to retry when trying to lock the [1mpacked-refs [22mfile. Value 0 means not to retry at all; -1 means to try indefinitely. Default is 1000 (i.e.,
           retry for 1 second).

       core.pager
           Text viewer for use by Git commands (e.g., [4mless[24m). The value is meant to be interpreted by the shell. The order of preference is the [1m$GIT_PAGER [22menvironment variable, then
           [1mcore.pager [22mconfiguration, then [1m$PAGER[22m, and then the default chosen at compile time (usually [4mless[24m).

           When the [1mLESS [22menvironment variable is unset, Git sets it to [1mFRX [22m(if [1mLESS [22menvironment variable is set, Git does not change it at all). If you want to selectively override Git's
           default setting for [1mLESS[22m, you can set [1mcore.pager [22mto e.g.  [1mless -S[22m. This will be passed to the shell by Git, which will translate the final command to [1mLESS=FRX less -S[22m. The
           environment does not set the [1mS [22moption but the command line does, instructing less to truncate long lines. Similarly, setting [1mcore.pager [22mto [1mless -+F [22mwill deactivate the [1mF [22moption
           specified by the environment from the command-line, deactivating the "quit if one screen" behavior of [1mless[22m. One can specifically activate some flags for particular commands:
           for example, setting [1mpager.blame [22mto [1mless -S [22menables line truncation only for [1mgit blame[22m.

           Likewise, when the [1mLV [22menvironment variable is unset, Git sets it to [1m-c[22m. You can override this setting by exporting [1mLV [22mwith another value or setting [1mcore.pager [22mto [1mlv +c[22m.

       core.whitespace
           A comma separated list of common whitespace problems to notice.  [4mgit[24m [4mdiff[24m will use [1mcolor.diff.whitespace [22mto highlight them, and [4mgit[24m [4mapply[24m [4m--whitespace=error[24m will consider them
           as errors. You can prefix [1m- [22mto disable any of them (e.g.  [1m-trailing-space[22m):

           +o   [1mblank-at-eol [22mtreats trailing whitespaces at the end of the line as an error (enabled by default).

           +o   [1mspace-before-tab [22mtreats a space character that appears immediately before a tab character in the initial indent part of the line as an error (enabled by default).

           +o   [1mindent-with-non-tab [22mtreats a line that is indented with space characters instead of the equivalent tabs as an error (not enabled by default).

           +o   [1mtab-in-indent [22mtreats a tab character in the initial indent part of the line as an error (not enabled by default).

           +o   [1mblank-at-eof [22mtreats blank lines added at the end of file as an error (enabled by default).

           +o   [1mtrailing-space [22mis a short-hand to cover both [1mblank-at-eol [22mand [1mblank-at-eof[22m.

           +o   [1mcr-at-eol [22mtreats a carriage-return at the end of line as part of the line terminator, i.e. with it, [1mtrailing-space [22mdoes not trigger if the character before such a
               carriage-return is not a whitespace (not enabled by default).

           +o   [1mtabwidth=<n> [22mtells how many character positions a tab occupies; this is relevant for [1mindent-with-non-tab [22mand when Git fixes [1mtab-in-indent [22merrors. The default tab width is
               8. Allowed values are 1 to 63.

       core.fsyncObjectFiles
           This boolean will enable [4mfsync()[24m when writing object files.

           This is a total waste of time and effort on a filesystem that orders data writes properly, but can be useful for filesystems that do not use journalling (traditional UNIX
           filesystems) or that only journal metadata and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").

       core.preloadIndex
           Enable parallel index preload for operations like [4mgit[24m [4mdiff[0m

           This can speed up operations like [4mgit[24m [4mdiff[24m and [4mgit[24m [4mstatus[24m especially on filesystems like NFS that have weak caching semantics and thus relatively high IO latencies. When
           enabled, Git will do the index comparison to the filesystem data in parallel, allowing overlapping IO's. Defaults to true.

       core.unsetenvvars
           Windows-only: comma-separated list of environment variables' names that need to be unset before spawning any other process. Defaults to [1mPERL5LIB [22mto account for the fact that
           Git for Windows insists on using its own Perl interpreter.

       core.restrictinheritedhandles
           Windows-only: override whether spawned processes inherit only standard file handles ([1mstdin[22m, [1mstdout [22mand [1mstderr[22m) or all handles. Can be [1mauto[22m, [1mtrue [22mor [1mfalse[22m. Defaults to [1mauto[22m,
           which means [1mtrue [22mon Windows 7 and later, and [1mfalse [22mon older Windows versions.

       core.createObject
           You can set this to [4mlink[24m, in which case a hardlink followed by a delete of the source are used to make sure that object creation will not overwrite existing objects.

           On some file system/operating system combinations, this is unreliable. Set this config setting to [4mrename[24m there; However, This will remove the check that makes sure that
           existing object files will not get overwritten.

       core.notesRef
           When showing commit messages, also show notes which are stored in the given ref. The ref must be fully qualified. If the given ref does not exist, it is not an error but means
           that no notes should be printed.

           This setting defaults to "refs/notes/commits", and it can be overridden by the [1mGIT_NOTES_REF [22menvironment variable. See [1mgit-notes[22m(1).

       core.commitGraph
           If true, then git will read the commit-graph file (if it exists) to parse the graph structure of commits. Defaults to true. See [1mgit-commit-graph[22m(1) for more information.

       core.useReplaceRefs
           If set to [1mfalse[22m, behave as if the [1m--no-replace-objects [22moption was given on the command line. See [1mgit[22m(1) and [1mgit-replace[22m(1) for more information.

       core.multiPackIndex
           Use the multi-pack-index file to track multiple packfiles using a single index. See [1mgit-multi-pack-index[22m(1) for more information. Defaults to true.

       core.sparseCheckout
           Enable "sparse checkout" feature. See [1mgit-sparse-checkout[22m(1) for more information.

       core.sparseCheckoutCone
           Enables the "cone mode" of the sparse checkout feature. When the sparse-checkout file contains a limited set of patterns, then this mode provides significant performance
           advantages. See [1mgit-sparse-checkout[22m(1) for more information.

       core.abbrev
           Set the length object names are abbreviated to. If unspecified or set to "auto", an appropriate value is computed based on the approximate number of packed objects in your
           repository, which hopefully is enough for abbreviated object names to stay unique for some time. The minimum length is 4.

       add.ignoreErrors, add.ignore-errors (deprecated)
           Tells [4mgit[24m [4madd[24m to continue adding files when some files cannot be added due to indexing errors. Equivalent to the [1m--ignore-errors [22moption of [1mgit-add[22m(1).  [1madd.ignore-errors [22mis
           deprecated, as it does not follow the usual naming convention for configuration variables.

       add.interactive.useBuiltin
           [EXPERIMENTAL] Set to [1mtrue [22mto use the experimental built-in implementation of the interactive version of [1mgit-add[22m(1) instead of the Perl script version. Is [1mfalse [22mby default.

       alias.*
           Command aliases for the [1mgit[22m(1) command wrapper - e.g. after defining [1malias.last = cat-file commit HEAD[22m, the invocation [1mgit last [22mis equivalent to [1mgit cat-file commit HEAD[22m. To
           avoid confusion and troubles with script usage, aliases that hide existing Git commands are ignored. Arguments are split by spaces, the usual shell quoting and escaping is
           supported. A quote pair or a backslash can be used to quote them.

           Note that the first word of an alias does not necessarily have to be a command. It can be a command-line option that will be passed into the invocation of [1mgit[22m. In particular,
           this is useful when used with [1m-c [22mto pass in one-time configurations or [1m-p [22mto force pagination. For example, [1mloud-rebase = -c commit.verbose=true rebase [22mcan be defined such that
           running [1mgit loud-rebase [22mwould be equivalent to [1mgit -c commit.verbose=true rebase[22m. Also, [1mps = -p status [22mwould be a helpful alias since [1mgit ps [22mwould paginate the output of [1mgit[0m
           [1mstatus [22mwhere the original command does not.

           If the alias expansion is prefixed with an exclamation point, it will be treated as a shell command. For example, defining [1malias.new = !gitk --all --not ORIG_HEAD[22m, the
           invocation [1mgit new [22mis equivalent to running the shell command [1mgitk --all --not ORIG_HEAD[22m. Note that shell commands will be executed from the top-level directory of a
           repository, which may not necessarily be the current directory.  [1mGIT_PREFIX [22mis set as returned by running [1mgit rev-parse --show-prefix [22mfrom the original current directory. See
           [1mgit-rev-parse[22m(1).

       am.keepcr
           If true, git-am will call git-mailsplit for patches in mbox format with parameter [1m--keep-cr[22m. In this case git-mailsplit will not remove [1m\r [22mfrom lines ending with [1m\r\n[22m. Can be
           overridden by giving [1m--no-keep-cr [22mfrom the command line. See [1mgit-am[22m(1), [1mgit-mailsplit[22m(1).

       am.threeWay
           By default, [1mgit am [22mwill fail if the patch does not apply cleanly. When set to true, this setting tells [1mgit am [22mto fall back on 3-way merge if the patch records the identity of
           blobs it is supposed to apply to and we have those blobs available locally (equivalent to giving the [1m--3way [22moption from the command line). Defaults to [1mfalse[22m. See [1mgit-am[22m(1).

       apply.ignoreWhitespace
           When set to [4mchange[24m, tells [4mgit[24m [4mapply[24m to ignore changes in whitespace, in the same way as the [1m--ignore-space-change [22moption. When set to one of: no, none, never, false tells [4mgit[0m
           [4mapply[24m to respect all whitespace differences. See [1mgit-apply[22m(1).

       apply.whitespace
           Tells [4mgit[24m [4mapply[24m how to handle whitespaces, in the same way as the [1m--whitespace [22moption. See [1mgit-apply[22m(1).

       blame.blankBoundary
           Show blank commit object name for boundary commits in [1mgit-blame[22m(1). This option defaults to false.

       blame.coloring
           This determines the coloring scheme to be applied to blame output. It can be [4mrepeatedLines[24m, [4mhighlightRecent[24m, or [4mnone[24m which is the default.

       blame.date
           Specifies the format used to output dates in [1mgit-blame[22m(1). If unset the iso format is used. For supported values, see the discussion of the [1m--date [22moption at [1mgit-log[22m(1).

       blame.showEmail
           Show the author email instead of author name in [1mgit-blame[22m(1). This option defaults to false.

       blame.showRoot
           Do not treat root commits as boundaries in [1mgit-blame[22m(1). This option defaults to false.

       blame.ignoreRevsFile
           Ignore revisions listed in the file, one unabbreviated object name per line, in [1mgit-blame[22m(1). Whitespace and comments beginning with [1m# [22mare ignored. This option may be repeated
           multiple times. Empty file names will reset the list of ignored revisions. This option will be handled before the command line option [1m--ignore-revs-file[22m.

       blame.markUnblamables
           Mark lines that were changed by an ignored revision that we could not attribute to another commit with a [4m*[24m in the output of [1mgit-blame[22m(1).

       blame.markIgnoredLines
           Mark lines that were changed by an ignored revision that we attributed to another commit with a [4m?[24m  in the output of [1mgit-blame[22m(1).

       branch.autoSetupMerge
           Tells [4mgit[24m [4mbranch[24m, [4mgit[24m [4mswitch[24m and [4mgit[24m [4mcheckout[24m to set up new branches so that [1mgit-pull[22m(1) will appropriately merge from the starting point branch. Note that even if this option
           is not set, this behavior can be chosen per-branch using the [1m--track [22mand [1m--no-track [22moptions. The valid settings are: [1mfalse [22m-- no automatic setup is done; [1mtrue [22m-- automatic
           setup is done when the starting point is a remote-tracking branch; [1malways [22m--  automatic setup is done when the starting point is either a local branch or remote-tracking
           branch. This option defaults to true.

       branch.autoSetupRebase
           When a new branch is created with [4mgit[24m [4mbranch[24m, [4mgit[24m [4mswitch[24m or [4mgit[24m [4mcheckout[24m that tracks another branch, this variable tells Git to set up pull to rebase instead of merge (see
           "branch.<name>.rebase"). When [1mnever[22m, rebase is never automatically set to true. When [1mlocal[22m, rebase is set to true for tracked branches of other local branches. When [1mremote[22m,
           rebase is set to true for tracked branches of remote-tracking branches. When [1malways[22m, rebase will be set to true for all tracking branches. See "branch.autoSetupMerge" for
           details on how to set up a branch to track another branch. This option defaults to never.

       branch.sort
           This variable controls the sort ordering of branches when displayed by [1mgit-branch[22m(1). Without the "--sort=<value>" option provided, the value of this variable will be used as
           the default. See [1mgit-for-each-ref[22m(1) field names for valid values.

       branch.<name>.remote
           When on branch <name>, it tells [4mgit[24m [4mfetch[24m and [4mgit[24m [4mpush[24m which remote to fetch from/push to. The remote to push to may be overridden with [1mremote.pushDefault [22m(for all branches).
           The remote to push to, for the current branch, may be further overridden by [1mbranch.<name>.pushRemote[22m. If no remote is configured, or if you are not on any branch, it defaults
           to [1morigin [22mfor fetching and [1mremote.pushDefault [22mfor pushing. Additionally, [1m.  [22m(a period) is the current local repository (a dot-repository), see [1mbranch.<name>.merge[22m's final note
           below.

       branch.<name>.pushRemote
           When on branch <name>, it overrides [1mbranch.<name>.remote [22mfor pushing. It also overrides [1mremote.pushDefault [22mfor pushing from branch <name>. When you pull from one place (e.g.
           your upstream) and push to another place (e.g. your own publishing repository), you would want to set [1mremote.pushDefault [22mto specify the remote to push to for all branches, and
           use this option to override it for a specific branch.

       branch.<name>.merge
           Defines, together with branch.<name>.remote, the upstream branch for the given branch. It tells [4mgit[24m [4mfetch[24m/[4mgit[24m [4mpull[24m/[4mgit[24m [4mrebase[24m which branch to merge and can also affect [4mgit[24m [4mpush[0m
           (see push.default). When in branch <name>, it tells [4mgit[24m [4mfetch[24m the default refspec to be marked for merging in FETCH_HEAD. The value is handled like the remote part of a
           refspec, and must match a ref which is fetched from the remote given by "branch.<name>.remote". The merge information is used by [4mgit[24m [4mpull[24m (which at first calls [4mgit[24m [4mfetch[24m) to
           lookup the default branch for merging. Without this option, [4mgit[24m [4mpull[24m defaults to merge the first refspec fetched. Specify multiple values to get an octopus merge. If you wish
           to setup [4mgit[24m [4mpull[24m so that it merges into <name> from another branch in the local repository, you can point branch.<name>.merge to the desired branch, and use the relative path
           setting [1m.  [22m(a period) for branch.<name>.remote.

       branch.<name>.mergeOptions
           Sets default options for merging into branch <name>. The syntax and supported options are the same as those of [1mgit-merge[22m(1), but option values containing whitespace characters
           are currently not supported.

       branch.<name>.rebase
           When true, rebase the branch <name> on top of the fetched branch, instead of merging the default branch from the default remote when "git pull" is run. See "pull.rebase" for
           doing this in a non branch-specific manner.

           When [1mmerges [22m(or just [4mm[24m), pass the [1m--rebase-merges [22moption to [4mgit[24m [4mrebase[24m so that the local merge commits are included in the rebase (see [1mgit-rebase[22m(1) for details).

           When [1mpreserve [22m(or just [4mp[24m, deprecated in favor of [1mmerges[22m), also pass [1m--preserve-merges [22malong to [4mgit[24m [4mrebase[24m so that locally committed merge commits will not be flattened by
           running [4mgit[24m [4mpull[24m.

           When the value is [1minteractive [22m(or just [4mi[24m), the rebase is run in interactive mode.

           [1mNOTE[22m: this is a possibly dangerous operation; do [1mnot [22muse it unless you understand the implications (see [1mgit-rebase[22m(1) for details).

       branch.<name>.description
           Branch description, can be edited with [1mgit branch --edit-description[22m. Branch description is automatically added in the format-patch cover letter or request-pull summary.

       browser.<tool>.cmd
           Specify the command to invoke the specified browser. The specified command is evaluated in shell with the URLs passed as arguments. (See [1mgit-web--browse[22m(1).)

       browser.<tool>.path
           Override the path for the given tool that may be used to browse HTML help (see [1m-w [22moption in [1mgit-help[22m(1)) or a working repository in gitweb (see [1mgit-instaweb[22m(1)).

       checkout.defaultRemote
           When you run [1mgit checkout <something> [22mor [1mgit switch <something> [22mand only have one remote, it may implicitly fall back on checking out and tracking e.g.  [1morigin/<something>[22m.
           This stops working as soon as you have more than one remote with a [1m<something> [22mreference. This setting allows for setting the name of a preferred remote that should always win
           when it comes to disambiguation. The typical use-case is to set this to [1morigin[22m.

           Currently this is used by [1mgit-switch[22m(1) and [1mgit-checkout[22m(1) when [1mgit checkout <something> [22mor [1mgit switch <something> [22mwill checkout the [1m<something> [22mbranch on another remote, and
           by [1mgit-worktree[22m(1) when [1mgit worktree add [22mrefers to a remote branch. This setting might be used for other checkout-like commands or functionality in the future.

       checkout.guess
           Provides the default value for the [1m--guess [22mor [1m--no-guess [22moption in [1mgit checkout [22mand [1mgit switch[22m. See [1mgit-switch[22m(1) and [1mgit-checkout[22m(1).

       clean.requireForce
           A boolean to make git-clean do nothing unless given -f, -i or -n. Defaults to true.

       clone.defaultRemoteName
           The name of the remote to create when cloning a repository. Defaults to [1morigin[22m, and can be overridden by passing the [1m--origin [22mcommand-line option to [1mgit-clone[22m(1).

       color.advice
           A boolean to enable/disable color in hints (e.g. when a push failed, see [1madvice.*  [22mfor a list). May be set to [1malways[22m, [1mfalse [22m(or [1mnever[22m) or [1mauto [22m(or [1mtrue[22m), in which case colors
           are used only when the error output goes to a terminal. If unset, then the value of [1mcolor.ui [22mis used ([1mauto [22mby default).

       color.advice.hint
           Use customized color for hints.

       color.blame.highlightRecent
           This can be used to color the metadata of a blame line depending on age of the line.

           This setting should be set to a comma-separated list of color and date settings, starting and ending with a color, the dates should be set from oldest to newest. The metadata
           will be colored given the colors if the line was introduced before the given timestamp, overwriting older timestamped colors.

           Instead of an absolute timestamp relative timestamps work as well, e.g. 2.weeks.ago is valid to address anything older than 2 weeks.

           It defaults to [4mblue,12[24m [4mmonth[24m [4mago,white,1[24m [4mmonth[24m [4mago,red[24m, which colors everything older than one year blue, recent changes between one month and one year old are kept white, and
           lines introduced within the last month are colored red.

       color.blame.repeatedLines
           Use the customized color for the part of git-blame output that is repeated meta information per line (such as commit id, author name, date and timezone). Defaults to cyan.

       color.branch
           A boolean to enable/disable color in the output of [1mgit-branch[22m(1). May be set to [1malways[22m, [1mfalse [22m(or [1mnever[22m) or [1mauto [22m(or [1mtrue[22m), in which case colors are used only when the output
           is to a terminal. If unset, then the value of [1mcolor.ui [22mis used ([1mauto [22mby default).

       color.branch.<slot>
           Use customized color for branch coloration.  [1m<slot> [22mis one of [1mcurrent [22m(the current branch), [1mlocal [22m(a local branch), [1mremote [22m(a remote-tracking branch in refs/remotes/), [1mupstream[0m
           (upstream tracking branch), [1mplain [22m(other refs).

       color.diff
           Whether to use ANSI escape sequences to add color to patches. If this is set to [1malways[22m, [1mgit-diff[22m(1), [1mgit-log[22m(1), and [1mgit-show[22m(1) will use color for all patches. If it is set to
           [1mtrue [22mor [1mauto[22m, those commands will only use color when output is to the terminal. If unset, then the value of [1mcolor.ui [22mis used ([1mauto [22mby default).

           This does not affect [1mgit-format-patch[22m(1) or the [4mgit-diff-*[24m plumbing commands. Can be overridden on the command line with the [1m--color[=<when>] [22moption.

       color.diff.<slot>
           Use customized color for diff colorization.  [1m<slot> [22mspecifies which part of the patch to use the specified color, and is one of [1mcontext [22m(context text - [1mplain [22mis a historical
           synonym), [1mmeta [22m(metainformation), [1mfrag [22m(hunk header), [4mfunc[24m (function in hunk header), [1mold [22m(removed lines), [1mnew [22m(added lines), [1mcommit [22m(commit headers), [1mwhitespace [22m(highlighting
           whitespace errors), [1moldMoved [22m(deleted lines), [1mnewMoved [22m(added lines), [1moldMovedDimmed[22m, [1moldMovedAlternative[22m, [1moldMovedAlternativeDimmed[22m, [1mnewMovedDimmed[22m, [1mnewMovedAlternative[0m
           [1mnewMovedAlternativeDimmed [22m(See the [4m<mode>[24m setting of [4m--color-moved[24m in [1mgit-diff[22m(1) for details), [1mcontextDimmed[22m, [1moldDimmed[22m, [1mnewDimmed[22m, [1mcontextBold[22m, [1moldBold[22m, and [1mnewBold [22m(see [1mgit-[0m
           [1mrange-diff[22m(1) for details).

       color.decorate.<slot>
           Use customized color for [4mgit[24m [4mlog[24m [4m--decorate[24m output.  [1m<slot> [22mis one of [1mbranch[22m, [1mremoteBranch[22m, [1mtag[22m, [1mstash [22mor [1mHEAD [22mfor local branches, remote-tracking branches, tags, stash and
           HEAD, respectively and [1mgrafted [22mfor grafted commits.

       color.grep
           When set to [1malways[22m, always highlight matches. When [1mfalse [22m(or [1mnever[22m), never. When set to [1mtrue [22mor [1mauto[22m, use color only when the output is written to the terminal. If unset, then
           the value of [1mcolor.ui [22mis used ([1mauto [22mby default).

       color.grep.<slot>
           Use customized color for grep colorization.  [1m<slot> [22mspecifies which part of the line to use the specified color, and is one of

           [1mcontext[0m
               non-matching text in context lines (when using [1m-A[22m, [1m-B[22m, or [1m-C[22m)

           [1mfilename[0m
               filename prefix (when not using [1m-h[22m)

           [1mfunction[0m
               function name lines (when using [1m-p[22m)

           [1mlineNumber[0m
               line number prefix (when using [1m-n[22m)

           [1mcolumn[0m
               column number prefix (when using [1m--column[22m)

           [1mmatch[0m
               matching text (same as setting [1mmatchContext [22mand [1mmatchSelected[22m)

           [1mmatchContext[0m
               matching text in context lines

           [1mmatchSelected[0m
               matching text in selected lines

           [1mselected[0m
               non-matching text in selected lines

           [1mseparator[0m
               separators between fields on a line ([1m:[22m, [1m-[22m, and [1m=[22m) and between hunks ([1m--[22m)

       color.interactive
           When set to [1malways[22m, always use colors for interactive prompts and displays (such as those used by "git-add --interactive" and "git-clean --interactive"). When false (or [1mnever[22m),
           never. When set to [1mtrue [22mor [1mauto[22m, use colors only when the output is to the terminal. If unset, then the value of [1mcolor.ui [22mis used ([1mauto [22mby default).

       color.interactive.<slot>
           Use customized color for [4mgit[24m [4madd[24m [4m--interactive[24m and [4mgit[24m [4mclean[24m [4m--interactive[24m output.  [1m<slot> [22mmay be [1mprompt[22m, [1mheader[22m, [1mhelp [22mor [1merror[22m, for four distinct types of normal output from
           interactive commands.

       color.pager
           A boolean to enable/disable colored output when the pager is in use (default is true).

       color.push
           A boolean to enable/disable color in push errors. May be set to [1malways[22m, [1mfalse [22m(or [1mnever[22m) or [1mauto [22m(or [1mtrue[22m), in which case colors are used only when the error output goes to a
           terminal. If unset, then the value of [1mcolor.ui [22mis used ([1mauto [22mby default).

       color.push.error
           Use customized color for push errors.

       color.remote
           If set, keywords at the start of the line are highlighted. The keywords are "error", "warning", "hint" and "success", and are matched case-insensitively. May be set to [1malways[22m,
           [1mfalse [22m(or [1mnever[22m) or [1mauto [22m(or [1mtrue[22m). If unset, then the value of [1mcolor.ui [22mis used ([1mauto [22mby default).

       color.remote.<slot>
           Use customized color for each remote keyword.  [1m<slot> [22mmay be [1mhint[22m, [1mwarning[22m, [1msuccess [22mor [1merror [22mwhich match the corresponding keyword.

       color.showBranch
           A boolean to enable/disable color in the output of [1mgit-show-branch[22m(1). May be set to [1malways[22m, [1mfalse [22m(or [1mnever[22m) or [1mauto [22m(or [1mtrue[22m), in which case colors are used only when the
           output is to a terminal. If unset, then the value of [1mcolor.ui [22mis used ([1mauto [22mby default).

       color.status
           A boolean to enable/disable color in the output of [1mgit-status[22m(1). May be set to [1malways[22m, [1mfalse [22m(or [1mnever[22m) or [1mauto [22m(or [1mtrue[22m), in which case colors are used only when the output
           is to a terminal. If unset, then the value of [1mcolor.ui [22mis used ([1mauto [22mby default).

       color.status.<slot>
           Use customized color for status colorization.  [1m<slot> [22mis one of [1mheader [22m(the header text of the status message), [1madded [22mor [1mupdated [22m(files which are added but not committed),
           [1mchanged [22m(files which are changed but not added in the index), [1muntracked [22m(files which are not tracked by Git), [1mbranch [22m(the current branch), [1mnobranch [22m(the color the [4mno[24m [4mbranch[0m
           warning is shown in, defaulting to red), [1mlocalBranch [22mor [1mremoteBranch [22m(the local and remote branch names, respectively, when branch and tracking information is displayed in the
           status short-format), or [1munmerged [22m(files which have unmerged changes).

       color.transport
           A boolean to enable/disable color when pushes are rejected. May be set to [1malways[22m, [1mfalse [22m(or [1mnever[22m) or [1mauto [22m(or [1mtrue[22m), in which case colors are used only when the error output
           goes to a terminal. If unset, then the value of [1mcolor.ui [22mis used ([1mauto [22mby default).

       color.transport.rejected
           Use customized color when a push was rejected.

       color.ui
           This variable determines the default value for variables such as [1mcolor.diff [22mand [1mcolor.grep [22mthat control the use of color per command family. Its scope will expand as more
           commands learn configuration to set a default for the [1m--color [22moption. Set it to [1mfalse [22mor [1mnever [22mif you prefer Git commands not to use color unless enabled explicitly with some
           other configuration or the [1m--color [22moption. Set it to [1malways [22mif you want all output not intended for machine consumption to use color, to [1mtrue [22mor [1mauto [22m(this is the default since
           Git 1.8.4) if you want such output to use color when written to the terminal.

       column.ui
           Specify whether supported commands should output in columns. This variable consists of a list of tokens separated by spaces or commas:

           These options control when the feature should be enabled (defaults to [4mnever[24m):

           [1malways[0m
               always show in columns

           [1mnever[0m
               never show in columns

           [1mauto[0m
               show in columns if the output is to the terminal

           These options control layout (defaults to [4mcolumn[24m). Setting any of these implies [4malways[24m if none of [4malways[24m, [4mnever[24m, or [4mauto[24m are specified.

           [1mcolumn[0m
               fill columns before rows

           [1mrow[0m
               fill rows before columns

           [1mplain[0m
               show in one column

           Finally, these options can be combined with a layout option (defaults to [4mnodense[24m):

           [1mdense[0m
               make unequal size columns to utilize more space

           [1mnodense[0m
               make equal size columns

       column.branch
           Specify whether to output branch listing in [1mgit branch [22min columns. See [1mcolumn.ui [22mfor details.

       column.clean
           Specify the layout when list items in [1mgit clean -i[22m, which always shows files and directories in columns. See [1mcolumn.ui [22mfor details.

       column.status
           Specify whether to output untracked files in [1mgit status [22min columns. See [1mcolumn.ui [22mfor details.

       column.tag
           Specify whether to output tag listing in [1mgit tag [22min columns. See [1mcolumn.ui [22mfor details.

       commit.cleanup
           This setting overrides the default of the [1m--cleanup [22moption in [1mgit commit[22m. See [1mgit-commit[22m(1) for details. Changing the default can be useful when you always want to keep lines
           that begin with comment character [1m# [22min your log message, in which case you would do [1mgit config commit.cleanup whitespace [22m(note that you will have to remove the help lines that
           begin with [1m# [22min the commit log template yourself, if you do this).

       commit.gpgSign
           A boolean to specify whether all commits should be GPG signed. Use of this option when doing operations such as rebase can result in a large number of commits being signed. It
           may be convenient to use an agent to avoid typing your GPG passphrase several times.

       commit.status
           A boolean to enable/disable inclusion of status information in the commit message template when using an editor to prepare the commit message. Defaults to true.

       commit.template
           Specify the pathname of a file to use as the template for new commit messages.

       commit.verbose
           A boolean or int to specify the level of verbose with [1mgit commit[22m. See [1mgit-commit[22m(1).

       commitGraph.maxNewFilters
           Specifies the default value for the [1m--max-new-filters [22moption of [1mgit commit-graph write [22m(c.f., [1mgit-commit-graph[22m(1)).

       commitGraph.readChangedPaths
           If true, then git will use the changed-path Bloom filters in the commit-graph file (if it exists, and they are present). Defaults to true. See [1mgit-commit-graph[22m(1) for more
           information.

       credential.helper
           Specify an external helper to be called when a username or password credential is needed; the helper may consult external storage to avoid prompting the user for the
           credentials. This is normally the name of a credential helper with possible arguments, but may also be an absolute path with arguments or, if preceded by [1m![22m, shell commands.

           Note that multiple helpers may be defined. See [1mgitcredentials[22m(7) for details and examples.

       credential.useHttpPath
           When acquiring credentials, consider the "path" component of an http or https URL to be important. Defaults to false. See [1mgitcredentials[22m(7) for more information.

       credential.username
           If no username is set for a network authentication, use this username by default. See credential.<context>.* below, and [1mgitcredentials[22m(7).

       credential.<url>.*
           Any of the credential.* options above can be applied selectively to some credentials. For example "credential.https://example.com.username" would set the default username only
           for https connections to example.com. See [1mgitcredentials[22m(7) for details on how URLs are matched.

       credentialCache.ignoreSIGHUP
           Tell git-credential-cache--daemon to ignore SIGHUP, instead of quitting.

       credentialStore.lockTimeoutMS
           The length of time, in milliseconds, for git-credential-store to retry when trying to lock the credentials file. Value 0 means not to retry at all; -1 means to try
           indefinitely. Default is 1000 (i.e., retry for 1s).

       completion.commands
           This is only used by git-completion.bash to add or remove commands from the list of completed commands. Normally only porcelain commands and a few select others are completed.
           You can add more commands, separated by space, in this variable. Prefixing the command with [4m-[24m will remove it from the existing list.

       diff.autoRefreshIndex
           When using [4mgit[24m [4mdiff[24m to compare with work tree files, do not consider stat-only change as changed. Instead, silently run [1mgit update-index --refresh [22mto update the cached stat
           information for paths whose contents in the work tree match the contents in the index. This option defaults to true. Note that this affects only [4mgit[24m [4mdiff[24m Porcelain, and not
           lower level [4mdiff[24m commands such as [4mgit[24m [4mdiff-files[24m.

       diff.dirstat
           A comma separated list of [1m--dirstat [22mparameters specifying the default behavior of the [1m--dirstat [22moption to [1mgit-diff[22m(1) and friends. The defaults can be overridden on the command
           line (using [1m--dirstat=<param1,param2,...>[22m). The fallback defaults (when not changed by [1mdiff.dirstat[22m) are [1mchanges,noncumulative,3[22m. The following parameters are available:

           [1mchanges[0m
               Compute the dirstat numbers by counting the lines that have been removed from the source, or added to the destination. This ignores the amount of pure code movements within
               a file. In other words, rearranging lines in a file is not counted as much as other changes. This is the default behavior when no parameter is given.

           [1mlines[0m
               Compute the dirstat numbers by doing the regular line-based diff analysis, and summing the removed/added line counts. (For binary files, count 64-byte chunks instead, since
               binary files have no natural concept of lines). This is a more expensive [1m--dirstat [22mbehavior than the [1mchanges [22mbehavior, but it does count rearranged lines within a file as
               much as other changes. The resulting output is consistent with what you get from the other [1m--*stat [22moptions.

           [1mfiles[0m
               Compute the dirstat numbers by counting the number of files changed. Each changed file counts equally in the dirstat analysis. This is the computationally cheapest
               [1m--dirstat [22mbehavior, since it does not have to look at the file contents at all.

           [1mcumulative[0m
               Count changes in a child directory for the parent directory as well. Note that when using [1mcumulative[22m, the sum of the percentages reported may exceed 100%. The default
               (non-cumulative) behavior can be specified with the [1mnoncumulative [22mparameter.

           <limit>
               An integer parameter specifies a cut-off percent (3% by default). Directories contributing less than this percentage of the changes are not shown in the output.

           Example: The following will count changed files, while ignoring directories with less than 10% of the total amount of changed files, and accumulating child directory counts in
           the parent directories: [1mfiles,10,cumulative[22m.

       diff.statGraphWidth
           Limit the width of the graph part in --stat output. If set, applies to all commands generating --stat output except format-patch.

       diff.context
           Generate diffs with <n> lines of context instead of the default of 3. This value is overridden by the -U option.

       diff.interHunkContext
           Show the context between diff hunks, up to the specified number of lines, thereby fusing the hunks that are close to each other. This value serves as the default for the
           [1m--inter-hunk-context [22mcommand line option.

       diff.external
           If this config variable is set, diff generation is not performed using the internal diff machinery, but using the given command. Can be overridden with the `GIT_EXTERNAL_DIFF'
           environment variable. The command is called with parameters as described under "git Diffs" in [1mgit[22m(1). Note: if you want to use an external diff program only on a subset of your
           files, you might want to use [1mgitattributes[22m(5) instead.

       diff.ignoreSubmodules
           Sets the default value of --ignore-submodules. Note that this affects only [4mgit[24m [4mdiff[24m Porcelain, and not lower level [4mdiff[24m commands such as [4mgit[24m [4mdiff-files[24m.  [4mgit[24m [4mcheckout[24m and [4mgit[0m
           [4mswitch[24m also honor this setting when reporting uncommitted changes. Setting it to [4mall[24m disables the submodule summary normally shown by [4mgit[24m [4mcommit[24m and [4mgit[24m [4mstatus[24m when
           [1mstatus.submoduleSummary [22mis set unless it is overridden by using the --ignore-submodules command-line option. The [4mgit[24m [4msubmodule[24m commands are not affected by this setting.

       diff.mnemonicPrefix
           If set, [4mgit[24m [4mdiff[24m uses a prefix pair that is different from the standard "a/" and "b/" depending on what is being compared. When this configuration is in effect, reverse diff
           output also swaps the order of the prefixes:

           [1mgit diff[0m
               compares the (i)ndex and the (w)ork tree;

           [1mgit diff HEAD[0m
               compares a (c)ommit and the (w)ork tree;

           [1mgit diff --cached[0m
               compares a (c)ommit and the (i)ndex;

           [1mgit diff HEAD:file1 file2[0m
               compares an (o)bject and a (w)ork tree entity;

           [1mgit diff --no-index a b[0m
               compares two non-git things (1) and (2).

       diff.noprefix
           If set, [4mgit[24m [4mdiff[24m does not show any source or destination prefix.

       diff.relative
           If set to [4mtrue[24m, [4mgit[24m [4mdiff[24m does not show changes outside of the directory and show pathnames relative to the current directory.

       diff.orderFile
           File indicating how to order files within a diff. See the [4m-O[24m option to [1mgit-diff[22m(1) for details. If [1mdiff.orderFile [22mis a relative pathname, it is treated as relative to the top
           of the working tree.

       diff.renameLimit
           The number of files to consider when performing the copy/rename detection; equivalent to the [4mgit[24m [4mdiff[24m option [1m-l[22m. This setting has no effect if rename detection is turned off.

       diff.renames
           Whether and how Git detects renames. If set to "false", rename detection is disabled. If set to "true", basic rename detection is enabled. If set to "copies" or "copy", Git
           will detect copies, as well. Defaults to true. Note that this affects only [4mgit[24m [4mdiff[24m Porcelain like [1mgit-diff[22m(1) and [1mgit-log[22m(1), and not lower level commands such as [1mgit-diff-[0m
           [1mfiles[22m(1).

       diff.suppressBlankEmpty
           A boolean to inhibit the standard behavior of printing a space before each empty output line. Defaults to false.

       diff.submodule
           Specify the format in which differences in submodules are shown. The "short" format just shows the names of the commits at the beginning and end of the range. The "log" format
           lists the commits in the range like [1mgit-submodule[22m(1) [1msummary [22mdoes. The "diff" format shows an inline diff of the changed contents of the submodule. Defaults to "short".

       diff.wordRegex
           A POSIX Extended Regular Expression used to determine what is a "word" when performing word-by-word difference calculations. Character sequences that match the regular
           expression are "words", all other characters are [1mignorable [22mwhitespace.

       diff.<driver>.command
           The custom diff driver command. See [1mgitattributes[22m(5) for details.

       diff.<driver>.xfuncname
           The regular expression that the diff driver should use to recognize the hunk header. A built-in pattern may also be used. See [1mgitattributes[22m(5) for details.

       diff.<driver>.binary
           Set this option to true to make the diff driver treat files as binary. See [1mgitattributes[22m(5) for details.

       diff.<driver>.textconv
           The command that the diff driver should call to generate the text-converted version of a file. The result of the conversion is used to generate a human-readable diff. See
           [1mgitattributes[22m(5) for details.

       diff.<driver>.wordRegex
           The regular expression that the diff driver should use to split words in a line. See [1mgitattributes[22m(5) for details.

       diff.<driver>.cachetextconv
           Set this option to true to make the diff driver cache the text conversion outputs. See [1mgitattributes[22m(5) for details.

       diff.tool
           Controls which diff tool is used by [1mgit-difftool[22m(1). This variable overrides the value configured in [1mmerge.tool[22m. The list below shows the valid built-in values. Any other value
           is treated as a custom diff tool and requires that a corresponding difftool.<tool>.cmd variable is defined.

       diff.guitool
           Controls which diff tool is used by [1mgit-difftool[22m(1) when the -g/--gui flag is specified. This variable overrides the value configured in [1mmerge.guitool[22m. The list below shows the
           valid built-in values. Any other value is treated as a custom diff tool and requires that a corresponding difftool.<guitool>.cmd variable is defined.

           +o   bc3

           +o   gvimdiff

           +o   gvimdiff2

           +o   gvimdiff3

           +o   nvimdiff

           +o   nvimdiff2

           +o   vimdiff2

           +o   vimdiff3

       diff.indentHeuristic
           Set this option to [1mfalse [22mto disable the default heuristics that shift diff hunk boundaries to make patches easier to read.

       diff.algorithm
           Choose a diff algorithm. The variants are as follows:

           [1mdefault[22m, [1mmyers[0m
               The basic greedy diff algorithm. Currently, this is the default.

           [1mminimal[0m
               Spend extra time to make sure the smallest possible diff is produced.

           [1mpatience[0m
               Use "patience diff" algorithm when generating patches.

           [1mhistogram[0m
               This algorithm extends the patience algorithm to "support low-occurrence common elements".

       diff.wsErrorHighlight
           Highlight whitespace errors in the [1mcontext[22m, [1mold [22mor [1mnew [22mlines of the diff. Multiple values are separated by comma, [1mnone [22mresets previous values, [1mdefault [22mreset the list to [1mnew [22mand
           [1mall [22mis a shorthand for [1mold,new,context[22m. The whitespace errors are colored with [1mcolor.diff.whitespace[22m. The command line option [1m--ws-error-highlight=<kind> [22moverrides this
           setting.

       diff.colorMoved
           If set to either a valid [1m<mode> [22mor a true value, moved lines in a diff are colored differently, for details of valid modes see [4m--color-moved[24m in [1mgit-diff[22m(1). If simply set to
           true the default color mode will be used. When set to false, moved lines are not colored.

       diff.colorMovedWS
           When moved lines are colored using e.g. the [1mdiff.colorMoved [22msetting, this option controls the [1m<mode> [22mhow spaces are treated for details of valid modes see [4m--color-moved-ws[24m in
           [1mgit-diff[22m(1).

       difftool.<tool>.path
           Override the path for the given tool. This is useful in case your tool is not in the PATH.

       difftool.<tool>.cmd
           Specify the command to invoke the specified diff tool. The specified command is evaluated in shell with the following variables available: [4mLOCAL[24m is set to the name of the
           temporary file containing the contents of the diff pre-image and [4mREMOTE[24m is set to the name of the temporary file containing the contents of the diff post-image.

       difftool.prompt
           Prompt before each invocation of the diff tool.

       extensions.objectFormat
           Specify the hash algorithm to use. The acceptable values are [1msha1 [22mand [1msha256[22m. If not specified, [1msha1 [22mis assumed. It is an error to specify this key unless
           [1mcore.repositoryFormatVersion [22mis 1.

           Note that this setting should only be set by [1mgit-init[22m(1) or [1mgit-clone[22m(1). Trying to change it after initialization will not work and will produce hard-to-diagnose issues.

       fastimport.unpackLimit
           If the number of objects imported by [1mgit-fast-import[22m(1) is below this limit, then the objects will be unpacked into loose object files. However if the number of imported
           objects equals or exceeds this limit then the pack will be stored as a pack. Storing the pack from a fast-import can make the import operation complete faster, especially on
           slow filesystems. If not set, the value of [1mtransfer.unpackLimit [22mis used instead.

       feature.*
           The config settings that start with [1mfeature.  [22mmodify the defaults of a group of other config settings. These groups are created by the Git developer community as recommended
           defaults and are subject to change. In particular, new config options may be added with different defaults.

       feature.experimental
           Enable config options that are new to Git, and are being considered for future defaults. Config settings included here may be added or removed with each release, including
           minor version updates. These settings may have unintended interactions since they are so new. Please enable this setting if you are interested in providing feedback on
           experimental features. The new default values are:

           +o   [1mfetch.negotiationAlgorithm=skipping [22mmay improve fetch negotiation times by skipping more commits at a time, reducing the number of round trips.

       feature.manyFiles
           Enable config options that optimize for repos with many files in the working directory. With many files, commands such as [1mgit status [22mand [1mgit checkout [22mmay be slow and these new
           defaults improve performance:

           +o   [1mindex.version=4 [22menables path-prefix compression in the index.

           +o   [1mcore.untrackedCache=true [22menables the untracked cache. This setting assumes that mtime is working on your machine.

       fetch.recurseSubmodules
           This option controls whether [1mgit fetch [22m(and the underlying fetch in [1mgit pull[22m) will recursively fetch into populated submodules. This option can be set either to a boolean value
           or to [4mon-demand[24m. Setting it to a boolean changes the behavior of fetch and pull to recurse unconditionally into submodules when set to true or to not recurse at all when set to
           false. When set to [4mon-demand[24m, fetch and pull will only recurse into a populated submodule when its superproject retrieves a commit that updates the submodule's reference.
           Defaults to [4mon-demand[24m, or to the value of [4msubmodule.recurse[24m if set.

       fetch.fsckObjects
           If it is set to true, git-fetch-pack will check all fetched objects. See [1mtransfer.fsckObjects [22mfor what's checked. Defaults to false. If not set, the value of
           [1mtransfer.fsckObjects [22mis used instead.

       fetch.fsck.<msg-id>
           Acts like [1mfsck.<msg-id>[22m, but is used by [1mgit-fetch-pack[22m(1) instead of [1mgit-fsck[22m(1). See the [1mfsck.<msg-id> [22mdocumentation for details.

       fetch.fsck.skipList
           Acts like [1mfsck.skipList[22m, but is used by [1mgit-fetch-pack[22m(1) instead of [1mgit-fsck[22m(1). See the [1mfsck.skipList [22mdocumentation for details.

       fetch.unpackLimit
           If the number of objects fetched over the Git native transfer is below this limit, then the objects will be unpacked into loose object files. However if the number of received
           objects equals or exceeds this limit then the received pack will be stored as a pack, after adding any missing delta bases. Storing the pack from a push can make the push
           operation complete faster, especially on slow filesystems. If not set, the value of [1mtransfer.unpackLimit [22mis used instead.

       fetch.prune
           If true, fetch will automatically behave as if the [1m--prune [22moption was given on the command line. See also [1mremote.<name>.prune [22mand the PRUNING section of [1mgit-fetch[22m(1).

       fetch.pruneTags
           If true, fetch will automatically behave as if the [1mrefs/tags/*:refs/tags/* [22mrefspec was provided when pruning, if not set already. This allows for setting both this option and
           [1mfetch.prune [22mto maintain a 1=1 mapping to upstream refs. See also [1mremote.<name>.pruneTags [22mand the PRUNING section of [1mgit-fetch[22m(1).

       fetch.output
           Control how ref update status is printed. Valid values are [1mfull [22mand [1mcompact[22m. Default value is [1mfull[22m. See section OUTPUT in [1mgit-fetch[22m(1) for detail.

       fetch.negotiationAlgorithm
           Control how information about the commits in the local repository is sent when negotiating the contents of the packfile to be sent by the server. Set to "skipping" to use an
           algorithm that skips commits in an effort to converge faster, but may result in a larger-than-necessary packfile; or set to "noop" to not send any information at all, which
           will almost certainly result in a larger-than-necessary packfile, but will skip the negotiation step. The default is "default" which instructs Git to use the default algorithm
           that never skips commits (unless the server has acknowledged it or one of its descendants). If [1mfeature.experimental [22mis enabled, then this setting defaults to "skipping".
           Unknown values will cause [4mgit[24m [4mfetch[24m to error out.

           See also the [1m--negotiation-tip [22moption for [1mgit-fetch[22m(1).

       fetch.showForcedUpdates
           Set to false to enable [1m--no-show-forced-updates [22min [1mgit-fetch[22m(1) and [1mgit-pull[22m(1) commands. Defaults to true.

       fetch.parallel
           Specifies the maximal number of fetch operations to be run in parallel at a time (submodules, or remotes when the [1m--multiple [22moption of [1mgit-fetch[22m(1) is in effect).

           A value of 0 will give some reasonable default. If unset, it defaults to 1.

           For submodules, this setting can be overridden using the [1msubmodule.fetchJobs [22mconfig setting.

       fetch.writeCommitGraph
           Set to true to write a commit-graph after every [1mgit fetch [22mcommand that downloads a pack-file from a remote. Using the [1m--split [22moption, most executions will create a very small
           commit-graph file on top of the existing commit-graph file(s). Occasionally, these files will merge and the write may take longer. Having an updated commit-graph file helps
           performance of many Git commands, including [1mgit merge-base[22m, [1mgit push -f[22m, and [1mgit log --graph[22m. Defaults to false.

       format.attach
           Enable multipart/mixed attachments as the default for [4mformat-patch[24m. The value can also be a double quoted string which will enable attachments as the default and set the value
           as the boundary. See the --attach option in [1mgit-format-patch[22m(1).

       format.from
           Provides the default value for the [1m--from [22moption to format-patch. Accepts a boolean value, or a name and email address. If false, format-patch defaults to [1m--no-from[22m, using
           commit authors directly in the "From:" field of patch mails. If true, format-patch defaults to [1m--from[22m, using your committer identity in the "From:" field of patch mails and
           including a "From:" field in the body of the patch mail if different. If set to a non-boolean value, format-patch uses that value instead of your committer identity. Defaults
           to false.

       format.numbered
           A boolean which can enable or disable sequence numbers in patch subjects. It defaults to "auto" which enables it only if there is more than one patch. It can be enabled or
           disabled for all messages by setting it to "true" or "false". See --numbered option in [1mgit-format-patch[22m(1).

       format.headers
           Additional email headers to include in a patch to be submitted by mail. See [1mgit-format-patch[22m(1).

       format.to, format.cc
           Additional recipients to include in a patch to be submitted by mail. See the --to and --cc options in [1mgit-format-patch[22m(1).

       format.subjectPrefix
           The default for format-patch is to output files with the [4m[PATCH][24m subject prefix. Use this variable to change that prefix.

       format.coverFromDescription
           The default mode for format-patch to determine which parts of the cover letter will be populated using the branch's description. See the [1m--cover-from-description [22moption in [1mgit-[0m
           [1mformat-patch[22m(1).

       format.signature
           The default for format-patch is to output a signature containing the Git version number. Use this variable to change that default. Set this variable to the empty string ("") to
           suppress signature generation.

       format.signatureFile
           Works just like format.signature except the contents of the file specified by this variable will be used as the signature.

       format.suffix
           The default for format-patch is to output files with the suffix [1m.patch[22m. Use this variable to change that suffix (make sure to include the dot if you want it).

       format.encodeEmailHeaders
           Encode email headers that have non-ASCII characters with "Q-encoding" (described in RFC 2047) for email transmission. Defaults to true.

       format.pretty
           The default pretty format for log/show/whatchanged command, See [1mgit-log[22m(1), [1mgit-show[22m(1), [1mgit-whatchanged[22m(1).

       format.thread
           The default threading style for [4mgit[24m [4mformat-patch[24m. Can be a boolean value, or [1mshallow [22mor [1mdeep[22m.  [1mshallow [22mthreading makes every mail a reply to the head of the series, where the
           head is chosen from the cover letter, the [1m--in-reply-to[22m, and the first patch mail, in this order.  [1mdeep [22mthreading makes every mail a reply to the previous one. A true boolean
           value is the same as [1mshallow[22m, and a false value disables threading.

       format.signOff
           A boolean value which lets you enable the [1m-s/--signoff [22moption of format-patch by default.  [1mNote: [22mAdding the [1mSigned-off-by [22mtrailer to a patch should be a conscious act and means
           that you certify you have the rights to submit this work under the same open source license. Please see the [4mSubmittingPatches[24m document for further discussion.

       format.coverLetter
           A boolean that controls whether to generate a cover-letter when format-patch is invoked, but in addition can be set to "auto", to generate a cover-letter only when there's more
           than one patch. Default is false.

       format.outputDirectory
           Set a custom directory to store the resulting files instead of the current working directory. All directory components will be created.

       format.filenameMaxLength
           The maximum length of the output filenames generated by the [1mformat-patch [22mcommand; defaults to 64. Can be overridden by the [1m--filename-max-length=<n> [22mcommand line option.

       format.useAutoBase
           A boolean value which lets you enable the [1m--base=auto [22moption of format-patch by default. Can also be set to "whenAble" to allow enabling [1m--base=auto [22mif a suitable base is
           available, but to skip adding base info otherwise without the format dying.

       format.notes
           Provides the default value for the [1m--notes [22moption to format-patch. Accepts a boolean value, or a ref which specifies where to get notes. If false, format-patch defaults to
           [1m--no-notes[22m. If true, format-patch defaults to [1m--notes[22m. If set to a non-boolean value, format-patch defaults to [1m--notes=<ref>[22m, where [1mref [22mis the non-boolean value. Defaults to
           false.

           If one wishes to use the ref [1mref/notes/true[22m, please use that literal instead.

           This configuration can be specified multiple times in order to allow multiple notes refs to be included. In that case, it will behave similarly to multiple [1m--[no-]notes[=][0m
           options passed in. That is, a value of [1mtrue [22mwill show the default notes, a value of [1m<ref> [22mwill also show notes from that notes ref and a value of [1mfalse [22mwill negate previous
           configurations and not show notes.

           For example,

               [format]
                       notes = true
                       notes = foo
                       notes = false
                       notes = bar

           will only show notes from [1mrefs/notes/bar[22m.

       filter.<driver>.clean
           The command which is used to convert the content of a worktree file to a blob upon checkin. See [1mgitattributes[22m(5) for details.

       filter.<driver>.smudge
           The command which is used to convert the content of a blob object to a worktree file upon checkout. See [1mgitattributes[22m(5) for details.

       fsck.<msg-id>
           During fsck git may find issues with legacy data which wouldn't be generated by current versions of git, and which wouldn't be sent over the wire if [1mtransfer.fsckObjects [22mwas
           set. This feature is intended to support working with legacy repositories containing such data.

           Setting [1mfsck.<msg-id> [22mwill be picked up by [1mgit-fsck[22m(1), but to accept pushes of such data set [1mreceive.fsck.<msg-id> [22minstead, or to clone or fetch it set [1mfetch.fsck.<msg-id>[22m.

           The rest of the documentation discusses [1mfsck.*  [22mfor brevity, but the same applies for the corresponding [1mreceive.fsck.*  [22mand [1mfetch.<msg-id>.*[22m. variables.

           Unlike variables like [1mcolor.ui [22mand [1mcore.editor [22mthe [1mreceive.fsck.<msg-id> [22mand [1mfetch.fsck.<msg-id> [22mvariables will not fall back on the [1mfsck.<msg-id> [22mconfiguration if they aren't
           set. To uniformly configure the same fsck settings in different circumstances all three of them they must all set to the same values.

           When [1mfsck.<msg-id> [22mis set, errors can be switched to warnings and vice versa by configuring the [1mfsck.<msg-id> [22msetting where the [1m<msg-id> [22mis the fsck message ID and the value is
           one of [1merror[22m, [1mwarn [22mor [1mignore[22m. For convenience, fsck prefixes the error/warning with the message ID, e.g. "missingEmail: invalid author/committer line - missing email" means
           that setting [1mfsck.missingEmail = ignore [22mwill hide that issue.

           In general, it is better to enumerate existing objects with problems with [1mfsck.skipList[22m, instead of listing the kind of breakages these problematic objects share to be ignored,
           as doing the latter will allow new instances of the same breakages go unnoticed.

           Setting an unknown [1mfsck.<msg-id> [22mvalue will cause fsck to die, but doing the same for [1mreceive.fsck.<msg-id> [22mand [1mfetch.fsck.<msg-id> [22mwill only cause git to warn.

       fsck.skipList
           The path to a list of object names (i.e. one unabbreviated SHA-1 per line) that are known to be broken in a non-fatal way and should be ignored. On versions of Git 2.20 and
           later comments ([4m#[24m), empty lines, and any leading and trailing whitespace is ignored. Everything but a SHA-1 per line will error out on older versions.

           This feature is useful when an established project should be accepted despite early commits containing errors that can be safely ignored such as invalid committer email
           addresses. Note: corrupt objects cannot be skipped with this setting.

           Like [1mfsck.<msg-id> [22mthis variable has corresponding [1mreceive.fsck.skipList [22mand [1mfetch.fsck.skipList [22mvariants.

           Unlike variables like [1mcolor.ui [22mand [1mcore.editor [22mthe [1mreceive.fsck.skipList [22mand [1mfetch.fsck.skipList [22mvariables will not fall back on the [1mfsck.skipList [22mconfiguration if they aren't
           set. To uniformly configure the same fsck settings in different circumstances all three of them they must all set to the same values.

           Older versions of Git (before 2.20) documented that the object names list should be sorted. This was never a requirement, the object names could appear in any order, but when
           reading the list we tracked whether the list was sorted for the purposes of an internal binary search implementation, which could save itself some work with an already sorted
           list. Unless you had a humongous list there was no reason to go out of your way to pre-sort the list. After Git version 2.20 a hash implementation is used instead, so there's
           now no reason to pre-sort the list.

       gc.aggressiveDepth
           The depth parameter used in the delta compression algorithm used by [4mgit[24m [4mgc[24m [4m--aggressive[24m. This defaults to 50, which is the default for the [1m--depth [22moption when [1m--aggressive[0m
           isn't in use.

           See the documentation for the [1m--depth [22moption in [1mgit-repack[22m(1) for more details.

       gc.aggressiveWindow
           The window size parameter used in the delta compression algorithm used by [4mgit[24m [4mgc[24m [4m--aggressive[24m. This defaults to 250, which is a much more aggressive window size than the
           default [1m--window [22mof 10.

           See the documentation for the [1m--window [22moption in [1mgit-repack[22m(1) for more details.

       gc.auto
           When there are approximately more than this many loose objects in the repository, [1mgit gc --auto [22mwill pack them. Some Porcelain commands use this command to perform a
           light-weight garbage collection from time to time. The default value is 6700.

           Setting this to 0 disables not only automatic packing based on the number of loose objects, but any other heuristic [1mgit gc --auto [22mwill otherwise use to determine if there's
           work to do, such as [1mgc.autoPackLimit[22m.

       gc.autoPackLimit
           When there are more than this many packs that are not marked with [1m*.keep [22mfile in the repository, [1mgit gc --auto [22mconsolidates them into one larger pack. The default value is 50.
           Setting this to 0 disables it. Setting [1mgc.auto [22mto 0 will also disable this.

           See the [1mgc.bigPackThreshold [22mconfiguration variable below. When in use, it'll affect how the auto pack limit works.

       gc.autoDetach
           Make [1mgit gc --auto [22mreturn immediately and run in background if the system supports it. Default is true.

       gc.bigPackThreshold
           If non-zero, all packs larger than this limit are kept when [1mgit gc [22mis run. This is very similar to [1m--keep-largest-pack [22mexcept that all packs that meet the threshold are kept,
           not just the largest pack. Defaults to zero. Common unit suffixes of [4mk[24m, [4mm[24m, or [4mg[24m are supported.

           Note that if the number of kept packs is more than gc.autoPackLimit, this configuration variable is ignored, all packs except the base pack will be repacked. After this the
           number of packs should go below gc.autoPackLimit and gc.bigPackThreshold should be respected again.

           If the amount of memory estimated for [1mgit repack [22mto run smoothly is not available and [1mgc.bigPackThreshold [22mis not set, the largest pack will also be excluded (this is the
           equivalent of running [1mgit gc [22mwith [1m--keep-largest-pack[22m).

       gc.writeCommitGraph
           If true, then gc will rewrite the commit-graph file when [1mgit-gc[22m(1) is run. When using [1mgit gc --auto [22mthe commit-graph will be updated if housekeeping is required. Default is
           true. See [1mgit-commit-graph[22m(1) for details.

       gc.logExpiry
           If the file gc.log exists, then [1mgit gc --auto [22mwill print its content and exit with status zero instead of running unless that file is more than [4mgc.logExpiry[24m old. Default is
           "1.day". See [1mgc.pruneExpire [22mfor more ways to specify its value.

       gc.packRefs
           Running [1mgit pack-refs [22min a repository renders it unclonable by Git versions prior to 1.5.1.2 over dumb transports such as HTTP. This variable determines whether [4mgit[24m [4mgc[24m runs [1mgit[0m
           [1mpack-refs[22m. This can be set to [1mnotbare [22mto enable it within all non-bare repos or it can be set to a boolean value. The default is [1mtrue[22m.

       gc.pruneExpire
           When [4mgit[24m [4mgc[24m is run, it will call [4mprune[24m [4m--expire[24m [4m2.weeks.ago[24m. Override the grace period with this config variable. The value "now" may be used to disable this grace period and
           always prune unreachable objects immediately, or "never" may be used to suppress pruning. This feature helps prevent corruption when [4mgit[24m [4mgc[24m runs concurrently with another
           process writing to the repository; see the "NOTES" section of [1mgit-gc[22m(1).

       gc.worktreePruneExpire
           When [4mgit[24m [4mgc[24m is run, it calls [4mgit[24m [4mworktree[24m [4mprune[24m [4m--expire[24m [4m3.months.ago[24m. This config variable can be used to set a different grace period. The value "now" may be used to disable
           the grace period and prune [1m$GIT_DIR/worktrees [22mimmediately, or "never" may be used to suppress pruning.

       gc.reflogExpire, gc.<pattern>.reflogExpire
           [4mgit[24m [4mreflog[24m [4mexpire[24m removes reflog entries older than this time; defaults to 90 days. The value "now" expires all entries immediately, and "never" suppresses expiration
           altogether. With "<pattern>" (e.g. "refs/stash") in the middle the setting applies only to the refs that match the <pattern>.

       gc.reflogExpireUnreachable, gc.<pattern>.reflogExpireUnreachable
           [4mgit[24m [4mreflog[24m [4mexpire[24m removes reflog entries older than this time and are not reachable from the current tip; defaults to 30 days. The value "now" expires all entries immediately,
           and "never" suppresses expiration altogether. With "<pattern>" (e.g. "refs/stash") in the middle, the setting applies only to the refs that match the <pattern>.

           These types of entries are generally created as a result of using [1mgit commit --amend [22mor [1mgit rebase [22mand are the commits prior to the amend or rebase occurring. Since these
           changes are not part of the current project most users will want to expire them sooner, which is why the default is more aggressive than [1mgc.reflogExpire[22m.

       gc.rerereResolved
           Records of conflicted merge you resolved earlier are kept for this many days when [4mgit[24m [4mrerere[24m [4mgc[24m is run. You can also use more human-readable "1.month.ago", etc. The default is
           60 days. See [1mgit-rerere[22m(1).

       gc.rerereUnresolved
           Records of conflicted merge you have not resolved are kept for this many days when [4mgit[24m [4mrerere[24m [4mgc[24m is run. You can also use more human-readable "1.month.ago", etc. The default is
           15 days. See [1mgit-rerere[22m(1).

       gitcvs.commitMsgAnnotation
           Append this string to each commit message. Set to empty string to disable this feature. Defaults to "via git-CVS emulator".

       gitcvs.enabled
           Whether the CVS server interface is enabled for this repository. See [1mgit-cvsserver[22m(1).

       gitcvs.logFile
           Path to a log file where the CVS server interface well... logs various stuff. See [1mgit-cvsserver[22m(1).

       gitcvs.usecrlfattr
           If true, the server will look up the end-of-line conversion attributes for files to determine the [1m-k [22mmodes to use. If the attributes force Git to treat a file as text, the [1m-k[0m
           mode will be left blank so CVS clients will treat it as text. If they suppress text conversion, the file will be set with [4m-kb[24m mode, which suppresses any newline munging the
           client might otherwise do. If the attributes do not allow the file type to be determined, then [1mgitcvs.allBinary [22mis used. See [1mgitattributes[22m(5).

       gitcvs.allBinary
           This is used if [1mgitcvs.usecrlfattr [22mdoes not resolve the correct [4m-kb[24m mode to use. If true, all unresolved files are sent to the client in mode [4m-kb[24m. This causes the client to
           treat them as binary files, which suppresses any newline munging it otherwise might do. Alternatively, if it is set to "guess", then the contents of the file are examined to
           decide if it is binary, similar to [1mcore.autocrlf[22m.

       gitcvs.dbName
           Database used by git-cvsserver to cache revision information derived from the Git repository. The exact meaning depends on the used database driver, for SQLite (which is the
           default driver) this is a filename. Supports variable substitution (see [1mgit-cvsserver[22m(1) for details). May not contain semicolons ([1m;[22m). Default: [4m%Ggitcvs.%m.sqlite[0m

       gitcvs.dbDriver
           Used Perl DBI driver. You can specify any available driver for this here, but it might not work. git-cvsserver is tested with [4mDBD::SQLite[24m, reported to work with [4mDBD::Pg[24m, and
           reported [1mnot [22mto work with [4mDBD::mysql[24m. Experimental feature. May not contain double colons ([1m:[22m). Default: [4mSQLite[24m. See [1mgit-cvsserver[22m(1).

       gitcvs.dbUser, gitcvs.dbPass
           Database user and password. Only useful if setting [1mgitcvs.dbDriver[22m, since SQLite has no concept of database users and/or passwords.  [4mgitcvs.dbUser[24m supports variable
           substitution (see [1mgit-cvsserver[22m(1) for details).

       gitcvs.dbTableNamePrefix
           Database table name prefix. Prepended to the names of any database tables used, allowing a single database to be used for several repositories. Supports variable substitution
           (see [1mgit-cvsserver[22m(1) for details). Any non-alphabetic characters will be replaced with underscores.

       All gitcvs variables except for [1mgitcvs.usecrlfattr [22mand [1mgitcvs.allBinary [22mcan also be specified as [4mgitcvs.<access_method>.<varname>[24m (where [4maccess_method[24m is one of "ext" and
       "pserver") to make them apply only for the given access method.

       gitweb.category, gitweb.description, gitweb.owner, gitweb.url
           See [1mgitweb[22m(1) for description.

       gitweb.avatar, gitweb.blame, gitweb.grep, gitweb.highlight, gitweb.patches, gitweb.pickaxe, gitweb.remote_heads, gitweb.showSizes, gitweb.snapshot
           See [1mgitweb.conf[22m(5) for description.

       grep.lineNumber
           If set to true, enable [1m-n [22moption by default.

       grep.column
           If set to true, enable the [1m--column [22moption by default.

       grep.patternType
           Set the default matching behavior. Using a value of [4mbasic[24m, [4mextended[24m, [4mfixed[24m, or [4mperl[24m will enable the [1m--basic-regexp[22m, [1m--extended-regexp[22m, [1m--fixed-strings[22m, or [1m--perl-regexp [22moption
           accordingly, while the value [4mdefault[24m will return to the default matching behavior.

       grep.extendedRegexp
           If set to true, enable [1m--extended-regexp [22moption by default. This option is ignored when the [1mgrep.patternType [22moption is set to a value other than [4mdefault[24m.

       grep.threads
           Number of grep worker threads to use. See [1mgrep.threads [22min [1mgit-grep[22m(1) for more information.

       grep.fallbackToNoIndex
           If set to true, fall back to git grep --no-index if git grep is executed outside of a git repository. Defaults to false.

       gpg.program
           Use this custom program instead of "[1mgpg[22m" found on [1m$PATH [22mwhen making or verifying a PGP signature. The program must support the same command-line interface as GPG, namely, to
           verify a detached signature, "[1mgpg --verify $signature - <$file[22m" is run, and the program is expected to signal a good signature by exiting with code 0, and to generate an
           ASCII-armored detached signature, the standard input of "[1mgpg -bsau $key[22m" is fed with the contents to be signed, and the program is expected to send the result to its standard
           output.

       gpg.format
           Specifies which key format to use when signing with [1m--gpg-sign[22m. Default is "openpgp" and another possible value is "x509".

       gpg.<format>.program
           Use this to customize the program used for the signing format you chose. (see [1mgpg.program [22mand [1mgpg.format[22m) [1mgpg.program [22mcan still be used as a legacy synonym for
           [1mgpg.openpgp.program[22m. The default value for [1mgpg.x509.program [22mis "gpgsm".

       gpg.minTrustLevel
           Specifies a minimum trust level for signature verification. If this option is unset, then signature verification for merge operations require a key with at least [1mmarginal[0m
           trust. Other operations that perform signature verification require a key with at least [1mundefined [22mtrust. Setting this option overrides the required trust-level for all
           operations. Supported values, in increasing order of significance:

           +o   [1mundefined[0m

           +o   [1mnever[0m

           +o   [1mmarginal[0m

           +o   [1mfully[0m

           +o   [1multimate[0m

       gui.commitMsgWidth
           Defines how wide the commit message window is in the [1mgit-gui[22m(1). "75" is the default.

       gui.diffContext
           Specifies how many context lines should be used in calls to diff made by the [1mgit-gui[22m(1). The default is "5".

       gui.displayUntracked
           Determines if [1mgit-gui[22m(1) shows untracked files in the file list. The default is "true".

       gui.encoding
           Specifies the default encoding to use for displaying of file contents in [1mgit-gui[22m(1) and [1mgitk[22m(1). It can be overridden by setting the [4mencoding[24m attribute for relevant files (see
           [1mgitattributes[22m(5)). If this option is not set, the tools default to the locale encoding.

       gui.matchTrackingBranch
           Determines if new branches created with [1mgit-gui[22m(1) should default to tracking remote branches with matching names or not. Default: "false".

       gui.newBranchTemplate
           Is used as suggested name when creating new branches using the [1mgit-gui[22m(1).

       gui.pruneDuringFetch
           "true" if [1mgit-gui[22m(1) should prune remote-tracking branches when performing a fetch. The default value is "false".

       gui.trustmtime
           Determines if [1mgit-gui[22m(1) should trust the file modification timestamp or not. By default the timestamps are not trusted.

       gui.spellingDictionary
           Specifies the dictionary used for spell checking commit messages in the [1mgit-gui[22m(1). When set to "none" spell checking is turned off.

       gui.fastCopyBlame
           If true, [4mgit[24m [4mgui[24m [4mblame[24m uses [1m-C [22minstead of [1m-C -C [22mfor original location detection. It makes blame significantly faster on huge repositories at the expense of less thorough copy
           detection.

       gui.copyBlameThreshold
           Specifies the threshold to use in [4mgit[24m [4mgui[24m [4mblame[24m original location detection, measured in alphanumeric characters. See the [1mgit-blame[22m(1) manual for more information on copy
           detection.

       gui.blamehistoryctx
           Specifies the radius of history context in days to show in [1mgitk[22m(1) for the selected commit, when the [1mShow History Context [22mmenu item is invoked from [4mgit[24m [4mgui[24m [4mblame[24m. If this
           variable is set to zero, the whole history is shown.

       guitool.<name>.cmd
           Specifies the shell command line to execute when the corresponding item of the [1mgit-gui[22m(1) [1mTools [22mmenu is invoked. This option is mandatory for every tool. The command is
           executed from the root of the working directory, and in the environment it receives the name of the tool as [1mGIT_GUITOOL[22m, the name of the currently selected file as [4mFILENAME[24m,
           and the name of the current branch as [4mCUR_BRANCH[24m (if the head is detached, [4mCUR_BRANCH[24m is empty).

       guitool.<name>.needsFile
           Run the tool only if a diff is selected in the GUI. It guarantees that [4mFILENAME[24m is not empty.

       guitool.<name>.noConsole
           Run the command silently, without creating a window to display its output.

       guitool.<name>.noRescan
           Don't rescan the working directory for changes after the tool finishes execution.

       guitool.<name>.confirm
           Show a confirmation dialog before actually running the tool.

       guitool.<name>.argPrompt
           Request a string argument from the user, and pass it to the tool through the [1mARGS [22menvironment variable. Since requesting an argument implies confirmation, the [4mconfirm[24m option
           has no effect if this is enabled. If the option is set to [4mtrue[24m, [4myes[24m, or [4m1[24m, the dialog uses a built-in generic prompt; otherwise the exact value of the variable is used.

       guitool.<name>.revPrompt
           Request a single valid revision from the user, and set the [1mREVISION [22menvironment variable. In other aspects this option is similar to [4margPrompt[24m, and can be used together with
           it.

       guitool.<name>.revUnmerged
           Show only unmerged branches in the [4mrevPrompt[24m subdialog. This is useful for tools similar to merge or rebase, but not for things like checkout or reset.

       guitool.<name>.title
           Specifies the title to use for the prompt dialog. The default is the tool name.

       guitool.<name>.prompt
           Specifies the general prompt string to display at the top of the dialog, before subsections for [4margPrompt[24m and [4mrevPrompt[24m. The default value includes the actual command.

       help.browser
           Specify the browser that will be used to display help in the [4mweb[24m format. See [1mgit-help[22m(1).

       help.format
           Override the default help format used by [1mgit-help[22m(1). Values [4mman[24m, [4minfo[24m, [4mweb[24m and [4mhtml[24m are supported.  [4mman[24m is the default.  [4mweb[24m and [4mhtml[24m are the same.

       help.autoCorrect
           If git detects typos and can identify exactly one valid command similar to the error, git will automatically run the intended command after waiting a duration of time defined
           by this configuration value in deciseconds (0.1 sec). If this value is 0, the suggested corrections will be shown, but not executed. If it is a negative integer, or
           "immediate", the suggested command is run immediately. If "never", suggestions are not shown at all. The default value is zero.

       help.htmlPath
           Specify the path where the HTML documentation resides. File system paths and URLs are supported. HTML pages will be prefixed with this path when help is displayed in the [4mweb[0m
           format. This defaults to the documentation path of your Git installation.

       http.proxy
           Override the HTTP proxy, normally configured using the [4mhttp_proxy[24m, [4mhttps_proxy[24m, and [4mall_proxy[24m environment variables (see [1mcurl(1)[22m). In addition to the syntax understood by curl,
           it is possible to specify a proxy string with a user name but no password, in which case git will attempt to acquire one in the same way it does for other credentials. See
           [1mgitcredentials[22m(7) for more information. The syntax thus is [4m[protocol://][user[:password]@]proxyhost[:port][24m. This can be overridden on a per-remote basis; see
           remote.<name>.proxy

       http.proxyAuthMethod
           Set the method with which to authenticate against the HTTP proxy. This only takes effect if the configured proxy string contains a user name part (i.e. is of the form [4muser@host[0m
           or [4muser@host:port[24m). This can be overridden on a per-remote basis; see [1mremote.<name>.proxyAuthMethod[22m. Both can be overridden by the [1mGIT_HTTP_PROXY_AUTHMETHOD [22menvironment
           variable. Possible values are:

           +o   [1manyauth [22m- Automatically pick a suitable authentication method. It is assumed that the proxy answers an unauthenticated request with a 407 status code and one or more
               Proxy-authenticate headers with supported authentication methods. This is the default.

           +o   [1mbasic [22m- HTTP Basic authentication

           +o   [1mdigest [22m- HTTP Digest authentication; this prevents the password from being transmitted to the proxy in clear text

           +o   [1mnegotiate [22m- GSS-Negotiate authentication (compare the --negotiate option of [1mcurl(1)[22m)

           +o   [1mntlm [22m- NTLM authentication (compare the --ntlm option of [1mcurl(1)[22m)

       http.proxySSLCert
           The pathname of a file that stores a client certificate to use to authenticate with an HTTPS proxy. Can be overridden by the [1mGIT_PROXY_SSL_CERT [22menvironment variable.

       http.proxySSLKey
           The pathname of a file that stores a private key to use to authenticate with an HTTPS proxy. Can be overridden by the [1mGIT_PROXY_SSL_KEY [22menvironment variable.

       http.proxySSLCertPasswordProtected
           Enable Git's password prompt for the proxy SSL certificate. Otherwise OpenSSL will prompt the user, possibly many times, if the certificate or private key is encrypted. Can be
           overriden by the [1mGIT_PROXY_SSL_CERT_PASSWORD_PROTECTED [22menvironment variable.

       http.proxySSLCAInfo
           Pathname to the file containing the certificate bundle that should be used to verify the proxy with when using an HTTPS proxy. Can be overriden by the [1mGIT_PROXY_SSL_CAINFO[0m
           environment variable.

       http.emptyAuth
           Attempt authentication without seeking a username or password. This can be used to attempt GSS-Negotiate authentication without specifying a username in the URL, as libcurl
           normally requires a username for authentication.

       http.delegation
           Control GSSAPI credential delegation. The delegation is disabled by default in libcurl since version 7.21.7. Set parameter to tell the server what it is allowed to delegate
           when it comes to user credentials. Used with GSS/kerberos. Possible values are:

           +o   [1mnone [22m- Don't allow any delegation.

           +o   [1mpolicy [22m- Delegates if and only if the OK-AS-DELEGATE flag is set in the Kerberos service ticket, which is a matter of realm policy.

           +o   [1malways [22m- Unconditionally allow the server to delegate.

       http.extraHeader
           Pass an additional HTTP header when communicating with a server. If more than one such entry exists, all of them are added as extra headers. To allow overriding the settings
           inherited from the system config, an empty value will reset the extra headers to the empty list.

       http.cookieFile
           The pathname of a file containing previously stored cookie lines, which should be used in the Git http session, if they match the server. The file format of the file to read
           cookies from should be plain HTTP headers or the Netscape/Mozilla cookie file format (see [1mcurl(1)[22m). NOTE that the file specified with http.cookieFile is used only as input
           unless http.saveCookies is set.

       http.saveCookies
           If set, store cookies received during requests to the file specified by http.cookieFile. Has no effect if http.cookieFile is unset.

       http.version
           Use the specified HTTP protocol version when communicating with a server. If you want to force the default. The available and default version depend on libcurl. Currently the
           possible values of this option are:

           +o   HTTP/2

           +o   HTTP/1.1

       http.sslVersion
           The SSL version to use when negotiating an SSL connection, if you want to force the default. The available and default version depend on whether libcurl was built against NSS
           or OpenSSL and the particular configuration of the crypto library in use. Internally this sets the [4mCURLOPT_SSL_VERSION[24m option; see the libcurl documentation for more details on
           the format of this option and for the ssl version supported. Currently the possible values of this option are:

           +o   sslv2

           +o   sslv3

           +o   tlsv1

           +o   tlsv1.0

           +o   tlsv1.1

           +o   tlsv1.2

           +o   tlsv1.3

           Can be overridden by the [1mGIT_SSL_VERSION [22menvironment variable. To force git to use libcurl's default ssl version and ignore any explicit http.sslversion option, set
           [1mGIT_SSL_VERSION [22mto the empty string.

       http.sslCipherList
           A list of SSL ciphers to use when negotiating an SSL connection. The available ciphers depend on whether libcurl was built against NSS or OpenSSL and the particular
           configuration of the crypto library in use. Internally this sets the [4mCURLOPT_SSL_CIPHER_LIST[24m option; see the libcurl documentation for more details on the format of this list.

           Can be overridden by the [1mGIT_SSL_CIPHER_LIST [22menvironment variable. To force git to use libcurl's default cipher list and ignore any explicit http.sslCipherList option, set
           [1mGIT_SSL_CIPHER_LIST [22mto the empty string.

       http.sslVerify
           Whether to verify the SSL certificate when fetching or pushing over HTTPS. Defaults to true. Can be overridden by the [1mGIT_SSL_NO_VERIFY [22menvironment variable.

       http.sslCert
           File containing the SSL certificate when fetching or pushing over HTTPS. Can be overridden by the [1mGIT_SSL_CERT [22menvironment variable.

       http.sslKey
           File containing the SSL private key when fetching or pushing over HTTPS. Can be overridden by the [1mGIT_SSL_KEY [22menvironment variable.

       http.sslCertPasswordProtected
           Enable Git's password prompt for the SSL certificate. Otherwise OpenSSL will prompt the user, possibly many times, if the certificate or private key is encrypted. Can be
           overridden by the [1mGIT_SSL_CERT_PASSWORD_PROTECTED [22menvironment variable.

       http.sslCAInfo
           File containing the certificates to verify the peer with when fetching or pushing over HTTPS. Can be overridden by the [1mGIT_SSL_CAINFO [22menvironment variable.

       http.sslCAPath
           Path containing files with the CA certificates to verify the peer with when fetching or pushing over HTTPS. Can be overridden by the [1mGIT_SSL_CAPATH [22menvironment variable.

       http.sslBackend
           Name of the SSL backend to use (e.g. "openssl" or "schannel"). This option is ignored if cURL lacks support for choosing the SSL backend at runtime.

       http.schannelCheckRevoke
           Used to enforce or disable certificate revocation checks in cURL when http.sslBackend is set to "schannel". Defaults to [1mtrue [22mif unset. Only necessary to disable this if Git
           consistently errors and the message is about checking the revocation status of a certificate. This option is ignored if cURL lacks support for setting the relevant SSL option
           at runtime.

       http.schannelUseSSLCAInfo
           As of cURL v7.60.0, the Secure Channel backend can use the certificate bundle provided via [1mhttp.sslCAInfo[22m, but that would override the Windows Certificate Store. Since this is
           not desirable by default, Git will tell cURL not to use that bundle by default when the [1mschannel [22mbackend was configured via [1mhttp.sslBackend[22m, unless [1mhttp.schannelUseSSLCAInfo[0m
           overrides this behavior.

       http.pinnedpubkey
           Public key of the https service. It may either be the filename of a PEM or DER encoded public key file or a string starting with [4msha256//[24m followed by the base64 encoded sha256
           hash of the public key. See also libcurl [4mCURLOPT_PINNEDPUBLICKEY[24m. git will exit with an error if this option is set but not supported by cURL.

       http.sslTry
           Attempt to use AUTH SSL/TLS and encrypted data transfers when connecting via regular FTP protocol. This might be needed if the FTP server requires it for security reasons or
           you wish to connect securely whenever remote FTP server supports it. Default is false since it might trigger certificate verification errors on misconfigured servers.

       http.maxRequests
           How many HTTP requests to launch in parallel. Can be overridden by the [1mGIT_HTTP_MAX_REQUESTS [22menvironment variable. Default is 5.

       http.minSessions
           The number of curl sessions (counted across slots) to be kept across requests. They will not be ended with curl_easy_cleanup() until http_cleanup() is invoked. If
           USE_CURL_MULTI is not defined, this value will be capped at 1. Defaults to 1.

       http.postBuffer
           Maximum size in bytes of the buffer used by smart HTTP transports when POSTing data to the remote system. For requests larger than this buffer size, HTTP/1.1 and
           Transfer-Encoding: chunked is used to avoid creating a massive pack file locally. Default is 1 MiB, which is sufficient for most requests.

           Note that raising this limit is only effective for disabling chunked transfer encoding and therefore should be used only where the remote server or a proxy only supports
           HTTP/1.0 or is noncompliant with the HTTP standard. Raising this is not, in general, an effective solution for most push problems, but can increase memory consumption
           significantly since the entire buffer is allocated even for small pushes.

       http.lowSpeedLimit, http.lowSpeedTime
           If the HTTP transfer speed is less than [4mhttp.lowSpeedLimit[24m for longer than [4mhttp.lowSpeedTime[24m seconds, the transfer is aborted. Can be overridden by the [1mGIT_HTTP_LOW_SPEED_LIMIT[0m
           and [1mGIT_HTTP_LOW_SPEED_TIME [22menvironment variables.

       http.noEPSV
           A boolean which disables using of EPSV ftp command by curl. This can helpful with some "poor" ftp servers which don't support EPSV mode. Can be overridden by the
           [1mGIT_CURL_FTP_NO_EPSV [22menvironment variable. Default is false (curl will use EPSV).

       http.userAgent
           The HTTP USER_AGENT string presented to an HTTP server. The default value represents the version of the client Git such as git/1.7.1. This option allows you to override this
           value to a more common value such as Mozilla/4.0. This may be necessary, for instance, if connecting through a firewall that restricts HTTP connections to a set of common
           USER_AGENT strings (but not including those like git/1.7.1). Can be overridden by the [1mGIT_HTTP_USER_AGENT [22menvironment variable.

       http.followRedirects
           Whether git should follow HTTP redirects. If set to [1mtrue[22m, git will transparently follow any redirect issued by a server it encounters. If set to [1mfalse[22m, git will treat all
           redirects as errors. If set to [1minitial[22m, git will follow redirects only for the initial request to a remote, but not for subsequent follow-up HTTP requests. Since git uses the
           redirected URL as the base for the follow-up requests, this is generally sufficient. The default is [1minitial[22m.

       http.<url>.*
           Any of the http.* options above can be applied selectively to some URLs. For a config key to match a URL, each element of the config key is compared to that of the URL, in the
           following order:

            1. Scheme (e.g., [1mhttps [22min [1mhttps://example.com/[22m). This field must match exactly between the config key and the URL.

            2. Host/domain name (e.g., [1mexample.com [22min [1mhttps://example.com/[22m). This field must match between the config key and the URL. It is possible to specify a [1m* [22mas part of the host
               name to match all subdomains at this level.  [1mhttps://*.example.com/ [22mfor example would match [1mhttps://foo.example.com/[22m, but not [1mhttps://foo.bar.example.com/[22m.

            3. Port number (e.g., [1m8080 [22min [1mhttp://example.com:8080/[22m). This field must match exactly between the config key and the URL. Omitted port numbers are automatically converted to
               the correct default for the scheme before matching.

            4. Path (e.g., [1mrepo.git [22min [1mhttps://example.com/repo.git[22m). The path field of the config key must match the path field of the URL either exactly or as a prefix of
               slash-delimited path elements. This means a config key with path [1mfoo/ [22mmatches URL path [1mfoo/bar[22m. A prefix can only match on a slash ([1m/[22m) boundary. Longer matches take
               precedence (so a config key with path [1mfoo/bar [22mis a better match to URL path [1mfoo/bar [22mthan a config key with just path [1mfoo/[22m).

            5. User name (e.g., [1muser [22min [1mhttps://user@example.com/repo.git[22m). If the config key has a user name it must match the user name in the URL exactly. If the config key does not
               have a user name, that config key will match a URL with any user name (including none), but at a lower precedence than a config key with a user name.

           The list above is ordered by decreasing precedence; a URL that matches a config key's path is preferred to one that matches its user name. For example, if the URL is
           [1mhttps://user@example.com/foo/bar [22ma config key match of [1mhttps://example.com/foo [22mwill be preferred over a config key match of [1mhttps://user@example.com[22m.

           All URLs are normalized before attempting any matching (the password part, if embedded in the URL, is always ignored for matching purposes) so that equivalent URLs that are
           simply spelled differently will match properly. Environment variable settings always override any matches. The URLs that are matched against are those given directly to Git
           commands. This means any URLs visited as a result of a redirection do not participate in matching.

       i18n.commitEncoding
           Character encoding the commit messages are stored in; Git itself does not care per se, but this information is necessary e.g. when importing commits from emails or in the gitk
           graphical history browser (and possibly at other places in the future or in other porcelains). See e.g.  [1mgit-mailinfo[22m(1). Defaults to [4mutf-8[24m.

       i18n.logOutputEncoding
           Character encoding the commit messages are converted to when running [4mgit[24m [4mlog[24m and friends.

       imap.folder
           The folder to drop the mails into, which is typically the Drafts folder. For example: "INBOX.Drafts", "INBOX/Drafts" or "[Gmail]/Drafts". Required.

       imap.tunnel
           Command used to setup a tunnel to the IMAP server through which commands will be piped instead of using a direct network connection to the server. Required when imap.host is
           not set.

       imap.host
           A URL identifying the server. Use an [1mimap:// [22mprefix for non-secure connections and an [1mimaps:// [22mprefix for secure connections. Ignored when imap.tunnel is set, but required
           otherwise.

       imap.user
           The username to use when logging in to the server.

       imap.pass
           The password to use when logging in to the server.

       imap.port
           An integer port number to connect to on the server. Defaults to 143 for imap:// hosts and 993 for imaps:// hosts. Ignored when imap.tunnel is set.

       imap.sslverify
           A boolean to enable/disable verification of the server certificate used by the SSL/TLS connection. Default is [1mtrue[22m. Ignored when imap.tunnel is set.

       imap.preformattedHTML
           A boolean to enable/disable the use of html encoding when sending a patch. An html encoded patch will be bracketed with <pre> and have a content type of text/html. Ironically,
           enabling this option causes Thunderbird to send the patch as a plain/text, format=fixed email. Default is [1mfalse[22m.

       imap.authMethod
           Specify authenticate method for authentication with IMAP server. If Git was built with the NO_CURL option, or if your curl version is older than 7.34.0, or if you're running
           git-imap-send with the [1m--no-curl [22moption, the only supported method is [4mCRAM-MD5[24m. If this is not set then [4mgit[24m [4mimap-send[24m uses the basic IMAP plaintext LOGIN command.

       index.recordEndOfIndexEntries
           Specifies whether the index file should include an "End Of Index Entry" section. This reduces index load time on multiprocessor machines but produces a message "ignoring EOIE
           extension" when reading the index using Git versions before 2.20. Defaults to [4mtrue[24m if index.threads has been explicitly enabled, [4mfalse[24m otherwise.

       index.recordOffsetTable
           Specifies whether the index file should include an "Index Entry Offset Table" section. This reduces index load time on multiprocessor machines but produces a message "ignoring
           IEOT extension" when reading the index using Git versions before 2.20. Defaults to [4mtrue[24m if index.threads has been explicitly enabled, [4mfalse[24m otherwise.

       index.threads
           Specifies the number of threads to spawn when loading the index. This is meant to reduce index load time on multiprocessor machines. Specifying 0 or [4mtrue[24m will cause Git to
           auto-detect the number of CPU's and set the number of threads accordingly. Specifying 1 or [4mfalse[24m will disable multithreading. Defaults to [4mtrue[24m.

       index.version
           Specify the version with which new index files should be initialized. This does not affect existing repositories. If [1mfeature.manyFiles [22mis enabled, then the default is 4.

       init.templateDir
           Specify the directory from which templates will be copied. (See the "TEMPLATE DIRECTORY" section of [1mgit-init[22m(1).)

       init.defaultBranch
           Allows overriding the default branch name e.g. when initializing a new repository or when cloning an empty repository.

       instaweb.browser
           Specify the program that will be used to browse your working repository in gitweb. See [1mgit-instaweb[22m(1).

       instaweb.httpd
           The HTTP daemon command-line to start gitweb on your working repository. See [1mgit-instaweb[22m(1).

       instaweb.local
           If true the web server started by [1mgit-instaweb[22m(1) will be bound to the local IP (127.0.0.1).

       instaweb.modulePath
           The default module path for [1mgit-instaweb[22m(1) to use instead of /usr/lib/apache2/modules. Only used if httpd is Apache.

       instaweb.port
           The port number to bind the gitweb httpd to. See [1mgit-instaweb[22m(1).

       interactive.singleKey
           In interactive commands, allow the user to provide one-letter input with a single key (i.e., without hitting enter). Currently this is used by the [1m--patch [22mmode of [1mgit-add[22m(1),
           [1mgit-checkout[22m(1), [1mgit-restore[22m(1), [1mgit-commit[22m(1), [1mgit-reset[22m(1), and [1mgit-stash[22m(1). Note that this setting is silently ignored if portable keystroke input is not available;
           requires the Perl module Term::ReadKey.

       interactive.diffFilter
           When an interactive command (such as [1mgit add --patch[22m) shows a colorized diff, git will pipe the diff through the shell command defined by this configuration variable. The
           command may mark up the diff further for human consumption, provided that it retains a one-to-one correspondence with the lines in the original diff. Defaults to disabled (no
           filtering).

       log.abbrevCommit
           If true, makes [1mgit-log[22m(1), [1mgit-show[22m(1), and [1mgit-whatchanged[22m(1) assume [1m--abbrev-commit[22m. You may override this option with [1m--no-abbrev-commit[22m.

       log.date
           Set the default date-time mode for the [4mlog[24m command. Setting a value for log.date is similar to using [4mgit[24m [4mlog[24m's [1m--date [22moption. See [1mgit-log[22m(1) for details.

       log.decorate
           Print out the ref names of any commits that are shown by the log command. If [4mshort[24m is specified, the ref name prefixes [4mrefs/heads/[24m, [4mrefs/tags/[24m and [4mrefs/remotes/[24m will not be
           printed. If [4mfull[24m is specified, the full ref name (including prefix) will be printed. If [4mauto[24m is specified, then if the output is going to a terminal, the ref names are shown as
           if [4mshort[24m were given, otherwise no ref names are shown. This is the same as the [1m--decorate [22moption of the [1mgit log[22m.

       log.excludeDecoration
           Exclude the specified patterns from the log decorations. This is similar to the [1m--decorate-refs-exclude [22mcommand-line option, but the config option can be overridden by the
           [1m--decorate-refs [22moption.

       log.follow
           If [1mtrue[22m, [1mgit log [22mwill act as if the [1m--follow [22moption was used when a single <path> is given. This has the same limitations as [1m--follow[22m, i.e. it cannot be used to follow multiple
           files and does not work well on non-linear history.

       log.graphColors
           A list of colors, separated by commas, that can be used to draw history lines in [1mgit log --graph[22m.

       log.showRoot
           If true, the initial commit will be shown as a big creation event. This is equivalent to a diff against an empty tree. Tools like [1mgit-log[22m(1) or [1mgit-whatchanged[22m(1), which
           normally hide the root commit will now show it. True by default.

       log.showSignature
           If true, makes [1mgit-log[22m(1), [1mgit-show[22m(1), and [1mgit-whatchanged[22m(1) assume [1m--show-signature[22m.

       log.mailmap
           If true, makes [1mgit-log[22m(1), [1mgit-show[22m(1), and [1mgit-whatchanged[22m(1) assume [1m--use-mailmap[22m, otherwise assume [1m--no-use-mailmap[22m. True by default.

       mailinfo.scissors
           If true, makes [1mgit-mailinfo[22m(1) (and therefore [1mgit-am[22m(1)) act by default as if the --scissors option was provided on the command-line. When active, this features removes
           everything from the message body before a scissors line (i.e. consisting mainly of ">8", "8<" and "-").

       mailmap.file
           The location of an augmenting mailmap file. The default mailmap, located in the root of the repository, is loaded first, then the mailmap file pointed to by this variable. The
           location of the mailmap file may be in a repository subdirectory, or somewhere outside of the repository itself. See [1mgit-shortlog[22m(1) and [1mgit-blame[22m(1).

       mailmap.blob
           Like [1mmailmap.file[22m, but consider the value as a reference to a blob in the repository. If both [1mmailmap.file [22mand [1mmailmap.blob [22mare given, both are parsed, with entries from
           [1mmailmap.file [22mtaking precedence. In a bare repository, this defaults to [1mHEAD:.mailmap[22m. In a non-bare repository, it defaults to empty.

       maintenance.auto
           This boolean config option controls whether some commands run [1mgit maintenance run --auto [22mafter doing their normal work. Defaults to true.

       maintenance.strategy
           This string config option provides a way to specify one of a few recommended schedules for background maintenance. This only affects which tasks are run during [1mgit maintenance[0m
           [1mrun --schedule=X [22mcommands, provided no [1m--task=<task> [22marguments are provided. Further, if a [1mmaintenance.<task>.schedule [22mconfig value is set, then that value is used instead of
           the one provided by [1mmaintenance.strategy[22m. The possible strategy strings are:

           +o   [1mnone[22m: This default setting implies no task are run at any schedule.

           +o   [1mincremental[22m: This setting optimizes for performing small maintenance activities that do not delete any data. This does not schedule the [1mgc [22mtask, but runs the [1mprefetch [22mand
               [1mcommit-graph [22mtasks hourly and the [1mloose-objects [22mand [1mincremental-repack [22mtasks daily.

       maintenance.<task>.enabled
           This boolean config option controls whether the maintenance task with name [1m<task> [22mis run when no [1m--task [22moption is specified to [1mgit maintenance run[22m. These config values are
           ignored if a [1m--task [22moption exists. By default, only [1mmaintenance.gc.enabled [22mis true.

       maintenance.<task>.schedule
           This config option controls whether or not the given [1m<task> [22mruns during a [1mgit maintenance run --schedule=<frequency> [22mcommand. The value must be one of "hourly", "daily", or
           "weekly".

       maintenance.commit-graph.auto
           This integer config option controls how often the [1mcommit-graph [22mtask should be run as part of [1mgit maintenance run --auto[22m. If zero, then the [1mcommit-graph [22mtask will not run with
           the [1m--auto [22moption. A negative value will force the task to run every time. Otherwise, a positive value implies the command should run when the number of reachable commits that
           are not in the commit-graph file is at least the value of [1mmaintenance.commit-graph.auto[22m. The default value is 100.

       maintenance.loose-objects.auto
           This integer config option controls how often the [1mloose-objects [22mtask should be run as part of [1mgit maintenance run --auto[22m. If zero, then the [1mloose-objects [22mtask will not run with
           the [1m--auto [22moption. A negative value will force the task to run every time. Otherwise, a positive value implies the command should run when the number of loose objects is at
           least the value of [1mmaintenance.loose-objects.auto[22m. The default value is 100.

       maintenance.incremental-repack.auto
           This integer config option controls how often the [1mincremental-repack [22mtask should be run as part of [1mgit maintenance run --auto[22m. If zero, then the [1mincremental-repack [22mtask will
           not run with the [1m--auto [22moption. A negative value will force the task to run every time. Otherwise, a positive value implies the command should run when the number of pack-files
           not in the multi-pack-index is at least the value of [1mmaintenance.incremental-repack.auto[22m. The default value is 10.

       man.viewer
           Specify the programs that may be used to display help in the [4mman[24m format. See [1mgit-help[22m(1).

       man.<tool>.cmd
           Specify the command to invoke the specified man viewer. The specified command is evaluated in shell with the man page passed as argument. (See [1mgit-help[22m(1).)

       man.<tool>.path
           Override the path for the given tool that may be used to display help in the [4mman[24m format. See [1mgit-help[22m(1).

       merge.conflictStyle
           Specify the style in which conflicted hunks are written out to working tree files upon merge. The default is "merge", which shows a [1m<<<<<<< [22mconflict marker, changes made by one
           side, a [1m======= [22mmarker, changes made by the other side, and then a [1m>>>>>>> [22mmarker. An alternate style, "diff3", adds a [1m||||||| [22mmarker and the original text before the [1m=======[0m
           marker.

       merge.defaultToUpstream
           If merge is called without any commit argument, merge the upstream branches configured for the current branch by using their last observed values stored in their
           remote-tracking branches. The values of the [1mbranch.<current branch>.merge [22mthat name the branches at the remote named by [1mbranch.<current branch>.remote [22mare consulted, and then
           they are mapped via [1mremote.<remote>.fetch [22mto their corresponding remote-tracking branches, and the tips of these tracking branches are merged.

       merge.ff
           By default, Git does not create an extra merge commit when merging a commit that is a descendant of the current commit. Instead, the tip of the current branch is
           fast-forwarded. When set to [1mfalse[22m, this variable tells Git to create an extra merge commit in such a case (equivalent to giving the [1m--no-ff [22moption from the command line). When
           set to [1monly[22m, only such fast-forward merges are allowed (equivalent to giving the [1m--ff-only [22moption from the command line).

       merge.verifySignatures
           If true, this is equivalent to the --verify-signatures command line option. See [1mgit-merge[22m(1) for details.

       merge.branchdesc
           In addition to branch names, populate the log message with the branch description text associated with them. Defaults to false.

       merge.log
           In addition to branch names, populate the log message with at most the specified number of one-line descriptions from the actual commits that are being merged. Defaults to
           false, and true is a synonym for 20.

       merge.suppressDest
           By adding a glob that matches the names of integration branches to this multi-valued configuration variable, the default merge message computed for merges into these
           integration branches will omit "into <branch name>" from its title.

           An element with an empty value can be used to clear the list of globs accumulated from previous configuration entries. When there is no [1mmerge.suppressDest [22mvariable defined, the
           default value of [1mmaster [22mis used for backward compatibility.

       merge.renameLimit
           The number of files to consider when performing rename detection during a merge; if not specified, defaults to the value of diff.renameLimit. This setting has no effect if
           rename detection is turned off.

       merge.renames
           Whether Git detects renames. If set to "false", rename detection is disabled. If set to "true", basic rename detection is enabled. Defaults to the value of diff.renames.

       merge.directoryRenames
           Whether Git detects directory renames, affecting what happens at merge time to new files added to a directory on one side of history when that directory was renamed on the
           other side of history. If merge.directoryRenames is set to "false", directory rename detection is disabled, meaning that such new files will be left behind in the old
           directory. If set to "true", directory rename detection is enabled, meaning that such new files will be moved into the new directory. If set to "conflict", a conflict will be
           reported for such paths. If merge.renames is false, merge.directoryRenames is ignored and treated as false. Defaults to "conflict".

       merge.renormalize
           Tell Git that canonical representation of files in the repository has changed over time (e.g. earlier commits record text files with CRLF line endings, but recent ones use LF
           line endings). In such a repository, Git can convert the data recorded in commits to a canonical form before performing a merge to reduce unnecessary conflicts. For more
           information, see section "Merging branches with differing checkin/checkout attributes" in [1mgitattributes[22m(5).

       merge.stat
           Whether to print the diffstat between ORIG_HEAD and the merge result at the end of the merge. True by default.

       merge.autoStash
           When set to true, automatically create a temporary stash entry before the operation begins, and apply it after the operation ends. This means that you can run merge on a dirty
           worktree. However, use with care: the final stash application after a successful merge might result in non-trivial conflicts. This option can be overridden by the
           [1m--no-autostash [22mand [1m--autostash [22moptions of [1mgit-merge[22m(1). Defaults to false.

       merge.tool
           Controls which merge tool is used by [1mgit-mergetool[22m(1). The list below shows the valid built-in values. Any other value is treated as a custom merge tool and requires that a
           corresponding mergetool.<tool>.cmd variable is defined.

       merge.guitool
           Controls which merge tool is used by [1mgit-mergetool[22m(1) when the -g/--gui flag is specified. The list below shows the valid built-in values. Any other value is treated as a
           custom merge tool and requires that a corresponding mergetool.<guitool>.cmd variable is defined.

           +o   bc3

           +o   gvimdiff

           +o   gvimdiff2

           +o   gvimdiff3

           +o   nvimdiff

           +o   nvimdiff2

           +o   vimdiff2

           +o   vimdiff3

       merge.verbosity
           Controls the amount of output shown by the recursive merge strategy. Level 0 outputs nothing except a final error message if conflicts were detected. Level 1 outputs only
           conflicts, 2 outputs conflicts and file changes. Level 5 and above outputs debugging information. The default is level 2. Can be overridden by the [1mGIT_MERGE_VERBOSITY[0m
           environment variable.

       merge.<driver>.name
           Defines a human-readable name for a custom low-level merge driver. See [1mgitattributes[22m(5) for details.

       merge.<driver>.driver
           Defines the command that implements a custom low-level merge driver. See [1mgitattributes[22m(5) for details.

       merge.<driver>.recursive
           Names a low-level merge driver to be used when performing an internal merge between common ancestors. See [1mgitattributes[22m(5) for details.

       mergetool.<tool>.path
           Override the path for the given tool. This is useful in case your tool is not in the PATH.

       mergetool.<tool>.cmd
           Specify the command to invoke the specified merge tool. The specified command is evaluated in shell with the following variables available: [4mBASE[24m is the name of a temporary file
           containing the common base of the files to be merged, if available; [4mLOCAL[24m is the name of a temporary file containing the contents of the file on the current branch; [4mREMOTE[24m is
           the name of a temporary file containing the contents of the file from the branch being merged; [4mMERGED[24m contains the name of the file to which the merge tool should write the
           results of a successful merge.

       mergetool.<tool>.trustExitCode
           For a custom merge command, specify whether the exit code of the merge command can be used to determine whether the merge was successful. If this is not set to true then the
           merge target file timestamp is checked and the merge assumed to have been successful if the file has been updated, otherwise the user is prompted to indicate the success of the
           merge.

       mergetool.meld.hasOutput
           Older versions of [1mmeld [22mdo not support the [1m--output [22moption. Git will attempt to detect whether [1mmeld [22msupports [1m--output [22mby inspecting the output of [1mmeld --help[22m. Configuring
           [1mmergetool.meld.hasOutput [22mwill make Git skip these checks and use the configured value instead. Setting [1mmergetool.meld.hasOutput [22mto [1mtrue [22mtells Git to unconditionally use the
           [1m--output [22moption, and [1mfalse [22mavoids using [1m--output[22m.

       mergetool.meld.useAutoMerge
           When the [1m--auto-merge [22mis given, meld will merge all non-conflicting parts automatically, highlight the conflicting parts and wait for user decision. Setting
           [1mmergetool.meld.useAutoMerge [22mto [1mtrue [22mtells Git to unconditionally use the [1m--auto-merge [22moption with [1mmeld[22m. Setting this value to [1mauto [22mmakes git detect whether [1m--auto-merge [22mis
           supported and will only use [1m--auto-merge [22mwhen available. A value of [1mfalse [22mavoids using [1m--auto-merge [22maltogether, and is the default value.

       mergetool.keepBackup
           After performing a merge, the original file with conflict markers can be saved as a file with a [1m.orig [22mextension. If this variable is set to [1mfalse [22mthen this file is not
           preserved. Defaults to [1mtrue [22m(i.e. keep the backup files).

       mergetool.keepTemporaries
           When invoking a custom merge tool, Git uses a set of temporary files to pass to the tool. If the tool returns an error and this variable is set to [1mtrue[22m, then these temporary
           files will be preserved, otherwise they will be removed after the tool has exited. Defaults to [1mfalse[22m.

       mergetool.writeToTemp
           Git writes temporary [4mBASE[24m, [4mLOCAL[24m, and [4mREMOTE[24m versions of conflicting files in the worktree by default. Git will attempt to use a temporary directory for these files when set
           [1mtrue[22m. Defaults to [1mfalse[22m.

       mergetool.prompt
           Prompt before each invocation of the merge resolution program.

       notes.mergeStrategy
           Which merge strategy to choose by default when resolving notes conflicts. Must be one of [1mmanual[22m, [1mours[22m, [1mtheirs[22m, [1munion[22m, or [1mcat_sort_uniq[22m. Defaults to [1mmanual[22m. See "NOTES MERGE
           STRATEGIES" section of [1mgit-notes[22m(1) for more information on each strategy.

       notes.<name>.mergeStrategy
           Which merge strategy to choose when doing a notes merge into refs/notes/<name>. This overrides the more general "notes.mergeStrategy". See the "NOTES MERGE STRATEGIES" section
           in [1mgit-notes[22m(1) for more information on the available strategies.

       notes.displayRef
           The (fully qualified) refname from which to show notes when showing commit messages. The value of this variable can be set to a glob, in which case notes from all matching refs
           will be shown. You may also specify this configuration variable several times. A warning will be issued for refs that do not exist, but a glob that does not match any refs is
           silently ignored.

           This setting can be overridden with the [1mGIT_NOTES_DISPLAY_REF [22menvironment variable, which must be a colon separated list of refs or globs.

           The effective value of "core.notesRef" (possibly overridden by GIT_NOTES_REF) is also implicitly added to the list of refs to be displayed.

       notes.rewrite.<command>
           When rewriting commits with <command> (currently [1mamend [22mor [1mrebase[22m) and this variable is set to [1mtrue[22m, Git automatically copies your notes from the original to the rewritten
           commit. Defaults to [1mtrue[22m, but see "notes.rewriteRef" below.

       notes.rewriteMode
           When copying notes during a rewrite (see the "notes.rewrite.<command>" option), determines what to do if the target commit already has a note. Must be one of [1moverwrite[22m,
           [1mconcatenate[22m, [1mcat_sort_uniq[22m, or [1mignore[22m. Defaults to [1mconcatenate[22m.

           This setting can be overridden with the [1mGIT_NOTES_REWRITE_MODE [22menvironment variable.

       notes.rewriteRef
           When copying notes during a rewrite, specifies the (fully qualified) ref whose notes should be copied. The ref may be a glob, in which case notes in all matching refs will be
           copied. You may also specify this configuration several times.

           Does not have a default value; you must configure this variable to enable note rewriting. Set it to [1mrefs/notes/commits [22mto enable rewriting for the default commit notes.

           This setting can be overridden with the [1mGIT_NOTES_REWRITE_REF [22menvironment variable, which must be a colon separated list of refs or globs.

       pack.window
           The size of the window used by [1mgit-pack-objects[22m(1) when no window size is given on the command line. Defaults to 10.

       pack.depth
           The maximum delta depth used by [1mgit-pack-objects[22m(1) when no maximum depth is given on the command line. Defaults to 50. Maximum value is 4095.

       pack.windowMemory
           The maximum size of memory that is consumed by each thread in [1mgit-pack-objects[22m(1) for pack window memory when no limit is given on the command line. The value can be suffixed
           with "k", "m", or "g". When left unconfigured (or set explicitly to 0), there will be no limit.

       pack.compression
           An integer -1..9, indicating the compression level for objects in a pack file. -1 is the zlib default. 0 means no compression, and 1..9 are various speed/size tradeoffs, 9
           being slowest. If not set, defaults to core.compression. If that is not set, defaults to -1, the zlib default, which is "a default compromise between speed and compression
           (currently equivalent to level 6)."

           Note that changing the compression level will not automatically recompress all existing objects. You can force recompression by passing the -F option to [1mgit-repack[22m(1).

       pack.allowPackReuse
           When true, and when reachability bitmaps are enabled, pack-objects will try to send parts of the bitmapped packfile verbatim. This can reduce memory and CPU usage to serve
           fetches, but might result in sending a slightly larger pack. Defaults to true.

       pack.island
           An extended regular expression configuring a set of delta islands. See "DELTA ISLANDS" in [1mgit-pack-objects[22m(1) for details.

       pack.islandCore
           Specify an island name which gets to have its objects be packed first. This creates a kind of pseudo-pack at the front of one pack, so that the objects from the specified
           island are hopefully faster to copy into any pack that should be served to a user requesting these objects. In practice this means that the island specified should likely
           correspond to what is the most commonly cloned in the repo. See also "DELTA ISLANDS" in [1mgit-pack-objects[22m(1).

       pack.deltaCacheSize
           The maximum memory in bytes used for caching deltas in [1mgit-pack-objects[22m(1) before writing them out to a pack. This cache is used to speed up the writing object phase by not
           having to recompute the final delta result once the best match for all objects is found. Repacking large repositories on machines which are tight with memory might be badly
           impacted by this though, especially if this cache pushes the system into swapping. A value of 0 means no limit. The smallest size of 1 byte may be used to virtually disable
           this cache. Defaults to 256 MiB.

       pack.deltaCacheLimit
           The maximum size of a delta, that is cached in [1mgit-pack-objects[22m(1). This cache is used to speed up the writing object phase by not having to recompute the final delta result
           once the best match for all objects is found. Defaults to 1000. Maximum value is 65535.

       pack.threads
           Specifies the number of threads to spawn when searching for best delta matches. This requires that [1mgit-pack-objects[22m(1) be compiled with pthreads otherwise this option is
           ignored with a warning. This is meant to reduce packing time on multiprocessor machines. The required amount of memory for the delta search window is however multiplied by the
           number of threads. Specifying 0 will cause Git to auto-detect the number of CPU's and set the number of threads accordingly.

       pack.indexVersion
           Specify the default pack index version. Valid values are 1 for legacy pack index used by Git versions prior to 1.5.2, and 2 for the new pack index with capabilities for packs
           larger than 4 GB as well as proper protection against the repacking of corrupted packs. Version 2 is the default. Note that version 2 is enforced and this config option ignored
           whenever the corresponding pack is larger than 2 GB.

           If you have an old Git that does not understand the version 2 [1m*.idx [22mfile, cloning or fetching over a non native protocol (e.g. "http") that will copy both [1m*.pack [22mfile and
           corresponding [1m*.idx [22mfile from the other side may give you a repository that cannot be accessed with your older version of Git. If the [1m*.pack [22mfile is smaller than 2 GB, however,
           you can use [1mgit-index-pack[22m(1) on the *.pack file to regenerate the [1m*.idx [22mfile.

       pack.packSizeLimit
           The maximum size of a pack. This setting only affects packing to a file when repacking, i.e. the git:// protocol is unaffected. It can be overridden by the [1m--max-pack-size[0m
           option of [1mgit-repack[22m(1). Reaching this limit results in the creation of multiple packfiles; which in turn prevents bitmaps from being created. The minimum size allowed is
           limited to 1 MiB. The default is unlimited. Common unit suffixes of [4mk[24m, [4mm[24m, or [4mg[24m are supported.

       pack.useBitmaps
           When true, git will use pack bitmaps (if available) when packing to stdout (e.g., during the server side of a fetch). Defaults to true. You should not generally need to turn
           this off unless you are debugging pack bitmaps.

       pack.useSparse
           When true, git will default to using the [4m--sparse[24m option in [4mgit[24m [4mpack-objects[24m when the [4m--revs[24m option is present. This algorithm only walks trees that appear in paths that
           introduce new objects. This can have significant performance benefits when computing a pack to send a small change. However, it is possible that extra objects are added to the
           pack-file if the included commits contain certain types of direct renames. Default is [1mtrue[22m.

       pack.writeBitmaps (deprecated)
           This is a deprecated synonym for [1mrepack.writeBitmaps[22m.

       pack.writeBitmapHashCache
           When true, git will include a "hash cache" section in the bitmap index (if one is written). This cache can be used to feed git's delta heuristics, potentially leading to better
           deltas between bitmapped and non-bitmapped objects (e.g., when serving a fetch between an older, bitmapped pack and objects that have been pushed since the last gc). The
           downside is that it consumes 4 bytes per object of disk space. Defaults to true.

       pager.<cmd>
           If the value is boolean, turns on or off pagination of the output of a particular Git subcommand when writing to a tty. Otherwise, turns on pagination for the subcommand using
           the pager specified by the value of [1mpager.<cmd>[22m. If [1m--paginate [22mor [1m--no-pager [22mis specified on the command line, it takes precedence over this option. To disable pagination for
           all commands, set [1mcore.pager [22mor [1mGIT_PAGER [22mto [1mcat[22m.

       pretty.<name>
           Alias for a --pretty= format string, as specified in [1mgit-log[22m(1). Any aliases defined here can be used just as the built-in pretty formats could. For example, running [1mgit config[0m
           [1mpretty.changelog "format:* %H %s" [22mwould cause the invocation [1mgit log --pretty=changelog [22mto be equivalent to running [1mgit log "--pretty=format:* %H %s"[22m. Note that an alias with
           the same name as a built-in format will be silently ignored.

       protocol.allow
           If set, provide a user defined default policy for all protocols which don't explicitly have a policy ([1mprotocol.<name>.allow[22m). By default, if unset, known-safe protocols (http,
           https, git, ssh, file) have a default policy of [1malways[22m, known-dangerous protocols (ext) have a default policy of [1mnever[22m, and all other protocols have a default policy of [1muser[22m.
           Supported policies:

           +o   [1malways [22m- protocol is always able to be used.

           +o   [1mnever [22m- protocol is never able to be used.

           +o   [1muser [22m- protocol is only able to be used when [1mGIT_PROTOCOL_FROM_USER [22mis either unset or has a value of 1. This policy should be used when you want a protocol to be directly
               usable by the user but don't want it used by commands which execute clone/fetch/push commands without user input, e.g. recursive submodule initialization.

       protocol.<name>.allow
           Set a policy to be used by protocol [1m<name> [22mwith clone/fetch/push commands. See [1mprotocol.allow [22mabove for the available policies.

           The protocol names currently used by git are:

           +o   [1mfile[22m: any local file-based path (including [1mfile:// [22mURLs, or local paths)

           +o   [1mgit[22m: the anonymous git protocol over a direct TCP connection (or proxy, if configured)

           +o   [1mssh[22m: git over ssh (including [1mhost:path [22msyntax, [1mssh://[22m, etc).

           +o   [1mhttp[22m: git over http, both "smart http" and "dumb http". Note that this does [4mnot[24m include [1mhttps[22m; if you want to configure both, you must do so individually.

           +o   any external helpers are named by their protocol (e.g., use [1mhg [22mto allow the [1mgit-remote-hg [22mhelper)

       protocol.version
           If set, clients will attempt to communicate with a server using the specified protocol version. If the server does not support it, communication falls back to version 0. If
           unset, the default is [1m2[22m. Supported versions:

           +o   [1m0 [22m- the original wire protocol.

           +o   [1m1 [22m- the original wire protocol with the addition of a version string in the initial response from the server.

           +o   [1m2 [22m- [34m[1mwire protocol version 2[0m[1m[22m[1].

       pull.ff
           By default, Git does not create an extra merge commit when merging a commit that is a descendant of the current commit. Instead, the tip of the current branch is
           fast-forwarded. When set to [1mfalse[22m, this variable tells Git to create an extra merge commit in such a case (equivalent to giving the [1m--no-ff [22moption from the command line). When
           set to [1monly[22m, only such fast-forward merges are allowed (equivalent to giving the [1m--ff-only [22moption from the command line). This setting overrides [1mmerge.ff [22mwhen pulling.

       pull.rebase
           When true, rebase branches on top of the fetched branch, instead of merging the default branch from the default remote when "git pull" is run. See "branch.<name>.rebase" for
           setting this on a per-branch basis.

           When [1mmerges [22m(or just [4mm[24m), pass the [1m--rebase-merges [22moption to [4mgit[24m [4mrebase[24m so that the local merge commits are included in the rebase (see [1mgit-rebase[22m(1) for details).

           When [1mpreserve [22m(or just [4mp[24m, deprecated in favor of [1mmerges[22m), also pass [1m--preserve-merges [22malong to [4mgit[24m [4mrebase[24m so that locally committed merge commits will not be flattened by
           running [4mgit[24m [4mpull[24m.

           When the value is [1minteractive [22m(or just [4mi[24m), the rebase is run in interactive mode.

           [1mNOTE[22m: this is a possibly dangerous operation; do [1mnot [22muse it unless you understand the implications (see [1mgit-rebase[22m(1) for details).

       pull.octopus
           The default merge strategy to use when pulling multiple branches at once.

       pull.twohead
           The default merge strategy to use when pulling a single branch.

       push.default
           Defines the action [1mgit push [22mshould take if no refspec is given (whether from the command-line, config, or elsewhere). Different values are well-suited for specific workflows;
           for instance, in a purely central workflow (i.e. the fetch source is equal to the push destination), [1mupstream [22mis probably what you want. Possible values are:

           +o   [1mnothing [22m- do not push anything (error out) unless a refspec is given. This is primarily meant for people who want to avoid mistakes by always being explicit.

           +o   [1mcurrent [22m- push the current branch to update a branch with the same name on the receiving end. Works in both central and non-central workflows.

           +o   [1mupstream [22m- push the current branch back to the branch whose changes are usually integrated into the current branch (which is called [1m@{upstream}[22m). This mode only makes sense
               if you are pushing to the same repository you would normally pull from (i.e. central workflow).

           +o   [1mtracking [22m- This is a deprecated synonym for [1mupstream[22m.

           +o   [1msimple [22m- in centralized workflow, work like [1mupstream [22mwith an added safety to refuse to push if the upstream branch's name is different from the local one.

               When pushing to a remote that is different from the remote you normally pull from, work as [1mcurrent[22m. This is the safest option and is suited for beginners.

               This mode has become the default in Git 2.0.

           +o   [1mmatching [22m- push all branches having the same name on both ends. This makes the repository you are pushing to remember the set of branches that will be pushed out (e.g. if
               you always push [4mmaint[24m and [4mmaster[24m there and no other branches, the repository you push to will have these two branches, and your local [4mmaint[24m and [4mmaster[24m will be pushed
               there).

               To use this mode effectively, you have to make sure [4mall[24m the branches you would push out are ready to be pushed out before running [4mgit[24m [4mpush[24m, as the whole point of this mode
               is to allow you to push all of the branches in one go. If you usually finish work on only one branch and push out the result, while other branches are unfinished, this mode
               is not for you. Also this mode is not suitable for pushing into a shared central repository, as other people may add new branches there, or update the tip of existing
               branches outside your control.

               This used to be the default, but not since Git 2.0 ([1msimple [22mis the new default).

       push.followTags
           If set to true enable [1m--follow-tags [22moption by default. You may override this configuration at time of push by specifying [1m--no-follow-tags[22m.

       push.gpgSign
           May be set to a boolean value, or the string [4mif-asked[24m. A true value causes all pushes to be GPG signed, as if [1m--signed [22mis passed to [1mgit-push[22m(1). The string [4mif-asked[24m causes
           pushes to be signed if the server supports it, as if [1m--signed=if-asked [22mis passed to [4mgit[24m [4mpush[24m. A false value may override a value from a lower-priority config file. An explicit
           command-line flag always overrides this config option.

       push.pushOption
           When no [1m--push-option=<option> [22margument is given from the command line, [1mgit push [22mbehaves as if each <value> of this variable is given as [1m--push-option=<value>[22m.

           This is a multi-valued variable, and an empty value can be used in a higher priority configuration file (e.g.  [1m.git/config [22min a repository) to clear the values inherited from a
           lower priority configuration files (e.g.  [1m$HOME/.gitconfig[22m).

               Example:

               /etc/gitconfig
                 push.pushoption = a
                 push.pushoption = b

               ~/.gitconfig
                 push.pushoption = c

               repo/.git/config
                 push.pushoption =
                 push.pushoption = b

               This will result in only b (a and c are cleared).

       push.recurseSubmodules
           Make sure all submodule commits used by the revisions to be pushed are available on a remote-tracking branch. If the value is [4mcheck[24m then Git will verify that all submodule
           commits that changed in the revisions to be pushed are available on at least one remote of the submodule. If any commits are missing, the push will be aborted and exit with
           non-zero status. If the value is [4mon-demand[24m then all submodules that changed in the revisions to be pushed will be pushed. If on-demand was not able to push all necessary
           revisions it will also be aborted and exit with non-zero status. If the value is [4mno[24m then default behavior of ignoring submodules when pushing is retained. You may override this
           configuration at time of push by specifying [4m--recurse-submodules=check|on-demand|no[24m. If not set, [4mno[24m is used by default, unless [4msubmodule.recurse[24m is set (in which case a [4mtrue[0m
           value means [4mon-demand[24m).

       push.useForceIfIncludes
           If set to "true", it is equivalent to specifying [1m--force-if-includes [22mas an option to [1mgit-push[22m(1) in the command line. Adding [1m--no-force-if-includes [22mat the time of push
           overrides this configuration setting.

       rebase.useBuiltin
           Unused configuration variable. Used in Git versions 2.20 and 2.21 as an escape hatch to enable the legacy shellscript implementation of rebase. Now the built-in rewrite of it
           in C is always used. Setting this will emit a warning, to alert any remaining users that setting this now does nothing.

       rebase.backend
           Default backend to use for rebasing. Possible choices are [4mapply[24m or [4mmerge[24m. In the future, if the merge backend gains all remaining capabilities of the apply backend, this
           setting may become unused.

       rebase.stat
           Whether to show a diffstat of what changed upstream since the last rebase. False by default.

       rebase.autoSquash
           If set to true enable [1m--autosquash [22moption by default.

       rebase.autoStash
           When set to true, automatically create a temporary stash entry before the operation begins, and apply it after the operation ends. This means that you can run rebase on a dirty
           worktree. However, use with care: the final stash application after a successful rebase might result in non-trivial conflicts. This option can be overridden by the
           [1m--no-autostash [22mand [1m--autostash [22moptions of [1mgit-rebase[22m(1). Defaults to false.

       rebase.missingCommitsCheck
           If set to "warn", git rebase -i will print a warning if some commits are removed (e.g. a line was deleted), however the rebase will still proceed. If set to "error", it will
           print the previous warning and stop the rebase, [4mgit[24m [4mrebase[24m [4m--edit-todo[24m can then be used to correct the error. If set to "ignore", no checking is done. To drop a commit without
           warning or error, use the [1mdrop [22mcommand in the todo list. Defaults to "ignore".

       rebase.instructionFormat
           A format string, as specified in [1mgit-log[22m(1), to be used for the todo list during an interactive rebase. The format will automatically have the long commit hash prepended to the
           format.

       rebase.abbreviateCommands
           If set to true, [1mgit rebase [22mwill use abbreviated command names in the todo list resulting in something like this:

                       p deadbee The oneline of the commit
                       p fa1afe1 The oneline of the next commit
                       ...

           instead of:

                       pick deadbee The oneline of the commit
                       pick fa1afe1 The oneline of the next commit
                       ...

           Defaults to false.

       rebase.rescheduleFailedExec
           Automatically reschedule [1mexec [22mcommands that failed. This only makes sense in interactive mode (or when an [1m--exec [22moption was provided). This is the same as specifying the
           [1m--reschedule-failed-exec [22moption.

       receive.advertiseAtomic
           By default, git-receive-pack will advertise the atomic push capability to its clients. If you don't want to advertise this capability, set this variable to false.

       receive.advertisePushOptions
           When set to true, git-receive-pack will advertise the push options capability to its clients. False by default.

       receive.autogc
           By default, git-receive-pack will run "git-gc --auto" after receiving data from git-push and updating refs. You can stop it by setting this variable to false.

       receive.certNonceSeed
           By setting this variable to a string, [1mgit receive-pack [22mwill accept a [1mgit push --signed [22mand verifies it by using a "nonce" protected by HMAC using this string as a secret key.

       receive.certNonceSlop
           When a [1mgit push --signed [22msent a push certificate with a "nonce" that was issued by a receive-pack serving the same repository within this many seconds, export the "nonce" found
           in the certificate to [1mGIT_PUSH_CERT_NONCE [22mto the hooks (instead of what the receive-pack asked the sending side to include). This may allow writing checks in [1mpre-receive [22mand
           [1mpost-receive [22ma bit easier. Instead of checking [1mGIT_PUSH_CERT_NONCE_SLOP [22menvironment variable that records by how many seconds the nonce is stale to decide if they want to
           accept the certificate, they only can check [1mGIT_PUSH_CERT_NONCE_STATUS [22mis [1mOK[22m.

       receive.fsckObjects
           If it is set to true, git-receive-pack will check all received objects. See [1mtransfer.fsckObjects [22mfor what's checked. Defaults to false. If not set, the value of
           [1mtransfer.fsckObjects [22mis used instead.

       receive.fsck.<msg-id>
           Acts like [1mfsck.<msg-id>[22m, but is used by [1mgit-receive-pack[22m(1) instead of [1mgit-fsck[22m(1). See the [1mfsck.<msg-id> [22mdocumentation for details.

       receive.fsck.skipList
           Acts like [1mfsck.skipList[22m, but is used by [1mgit-receive-pack[22m(1) instead of [1mgit-fsck[22m(1). See the [1mfsck.skipList [22mdocumentation for details.

       receive.keepAlive
           After receiving the pack from the client, [1mreceive-pack [22mmay produce no output (if [1m--quiet [22mwas specified) while processing the pack, causing some networks to drop the TCP
           connection. With this option set, if [1mreceive-pack [22mdoes not transmit any data in this phase for [1mreceive.keepAlive [22mseconds, it will send a short keepalive packet. The default is
           5 seconds; set to 0 to disable keepalives entirely.

       receive.unpackLimit
           If the number of objects received in a push is below this limit then the objects will be unpacked into loose object files. However if the number of received objects equals or
           exceeds this limit then the received pack will be stored as a pack, after adding any missing delta bases. Storing the pack from a push can make the push operation complete
           faster, especially on slow filesystems. If not set, the value of [1mtransfer.unpackLimit [22mis used instead.

       receive.maxInputSize
           If the size of the incoming pack stream is larger than this limit, then git-receive-pack will error out, instead of accepting the pack file. If not set or set to 0, then the
           size is unlimited.

       receive.denyDeletes
           If set to true, git-receive-pack will deny a ref update that deletes the ref. Use this to prevent such a ref deletion via a push.

       receive.denyDeleteCurrent
           If set to true, git-receive-pack will deny a ref update that deletes the currently checked out branch of a non-bare repository.

       receive.denyCurrentBranch
           If set to true or "refuse", git-receive-pack will deny a ref update to the currently checked out branch of a non-bare repository. Such a push is potentially dangerous because
           it brings the HEAD out of sync with the index and working tree. If set to "warn", print a warning of such a push to stderr, but allow the push to proceed. If set to false or
           "ignore", allow such pushes with no message. Defaults to "refuse".

           Another option is "updateInstead" which will update the working tree if pushing into the current branch. This option is intended for synchronizing working directories when one
           side is not easily accessible via interactive ssh (e.g. a live web site, hence the requirement that the working directory be clean). This mode also comes in handy when
           developing inside a VM to test and fix code on different Operating Systems.

           By default, "updateInstead" will refuse the push if the working tree or the index have any difference from the HEAD, but the [1mpush-to-checkout [22mhook can be used to customize
           this. See [1mgithooks[22m(5).

       receive.denyNonFastForwards
           If set to true, git-receive-pack will deny a ref update which is not a fast-forward. Use this to prevent such an update via a push, even if that push is forced. This
           configuration variable is set when initializing a shared repository.

       receive.hideRefs
           This variable is the same as [1mtransfer.hideRefs[22m, but applies only to [1mreceive-pack [22m(and so affects pushes, but not fetches). An attempt to update or delete a hidden ref by [1mgit[0m
           [1mpush [22mis rejected.

       receive.procReceiveRefs
           This is a multi-valued variable that defines reference prefixes to match the commands in [1mreceive-pack[22m. Commands matching the prefixes will be executed by an external hook
           "proc-receive", instead of the internal [1mexecute_commands [22mfunction. If this variable is not defined, the "proc-receive" hook will never be used, and all commands will be
           executed by the internal [1mexecute_commands [22mfunction.

           For example, if this variable is set to "refs/for", pushing to reference such as "refs/for/master" will not create or update a reference named "refs/for/master", but may create
           or update a pull request directly by running the hook "proc-receive".

           Optional modifiers can be provided in the beginning of the value to filter commands for specific actions: create (a), modify (m), delete (d). A [1m!  [22mcan be included in the
           modifiers to negate the reference prefix entry. E.g.:

               git config --system --add receive.procReceiveRefs ad:refs/heads
               git config --system --add receive.procReceiveRefs !:refs/heads

       receive.updateServerInfo
           If set to true, git-receive-pack will run git-update-server-info after receiving data from git-push and updating refs.

       receive.shallowUpdate
           If set to true, .git/shallow can be updated when new refs require new shallow roots. Otherwise those refs are rejected.

       remote.pushDefault
           The remote to push to by default. Overrides [1mbranch.<name>.remote [22mfor all branches, and is overridden by [1mbranch.<name>.pushRemote [22mfor specific branches.

       remote.<name>.url
           The URL of a remote repository. See [1mgit-fetch[22m(1) or [1mgit-push[22m(1).

       remote.<name>.pushurl
           The push URL of a remote repository. See [1mgit-push[22m(1).

       remote.<name>.proxy
           For remotes that require curl (http, https and ftp), the URL to the proxy to use for that remote. Set to the empty string to disable proxying for that remote.

       remote.<name>.proxyAuthMethod
           For remotes that require curl (http, https and ftp), the method to use for authenticating against the proxy in use (probably set in [1mremote.<name>.proxy[22m). See
           [1mhttp.proxyAuthMethod[22m.

       remote.<name>.fetch
           The default set of "refspec" for [1mgit-fetch[22m(1). See [1mgit-fetch[22m(1).

       remote.<name>.push
           The default set of "refspec" for [1mgit-push[22m(1). See [1mgit-push[22m(1).

       remote.<name>.mirror
           If true, pushing to this remote will automatically behave as if the [1m--mirror [22moption was given on the command line.

       remote.<name>.skipDefaultUpdate
           If true, this remote will be skipped by default when updating using [1mgit-fetch[22m(1) or the [1mupdate [22msubcommand of [1mgit-remote[22m(1).

       remote.<name>.skipFetchAll
           If true, this remote will be skipped by default when updating using [1mgit-fetch[22m(1) or the [1mupdate [22msubcommand of [1mgit-remote[22m(1).

       remote.<name>.receivepack
           The default program to execute on the remote side when pushing. See option --receive-pack of [1mgit-push[22m(1).

       remote.<name>.uploadpack
           The default program to execute on the remote side when fetching. See option --upload-pack of [1mgit-fetch-pack[22m(1).

       remote.<name>.tagOpt
           Setting this value to --no-tags disables automatic tag following when fetching from remote <name>. Setting it to --tags will fetch every tag from remote <name>, even if they
           are not reachable from remote branch heads. Passing these flags directly to [1mgit-fetch[22m(1) can override this setting. See options --tags and --no-tags of [1mgit-fetch[22m(1).

       remote.<name>.vcs
           Setting this to a value <vcs> will cause Git to interact with the remote with the git-remote-<vcs> helper.

       remote.<name>.prune
           When set to true, fetching from this remote by default will also remove any remote-tracking references that no longer exist on the remote (as if the [1m--prune [22moption was given on
           the command line). Overrides [1mfetch.prune [22msettings, if any.

       remote.<name>.pruneTags
           When set to true, fetching from this remote by default will also remove any local tags that no longer exist on the remote if pruning is activated in general via
           [1mremote.<name>.prune[22m, [1mfetch.prune [22mor [1m--prune[22m. Overrides [1mfetch.pruneTags [22msettings, if any.

           See also [1mremote.<name>.prune [22mand the PRUNING section of [1mgit-fetch[22m(1).

       remote.<name>.promisor
           When set to true, this remote will be used to fetch promisor objects.

       remote.<name>.partialclonefilter
           The filter that will be applied when fetching from this promisor remote.

       remotes.<group>
           The list of remotes which are fetched by "git remote update <group>". See [1mgit-remote[22m(1).

       repack.useDeltaBaseOffset
           By default, [1mgit-repack[22m(1) creates packs that use delta-base offset. If you need to share your repository with Git older than version 1.4.4, either directly or via a dumb
           protocol such as http, then you need to set this option to "false" and repack. Access from old Git versions over the native protocol are unaffected by this option.

       repack.packKeptObjects
           If set to true, makes [1mgit repack [22mact as if [1m--pack-kept-objects [22mwas passed. See [1mgit-repack[22m(1) for details. Defaults to [1mfalse [22mnormally, but [1mtrue [22mif a bitmap index is being
           written (either via [1m--write-bitmap-index [22mor [1mrepack.writeBitmaps[22m).

       repack.useDeltaIslands
           If set to true, makes [1mgit repack [22mact as if [1m--delta-islands [22mwas passed. Defaults to [1mfalse[22m.

       repack.writeBitmaps
           When true, git will write a bitmap index when packing all objects to disk (e.g., when [1mgit repack -a [22mis run). This index can speed up the "counting objects" phase of subsequent
           packs created for clones and fetches, at the cost of some disk space and extra time spent on the initial repack. This has no effect if multiple packfiles are created. Defaults
           to true on bare repos, false otherwise.

       rerere.autoUpdate
           When set to true, [1mgit-rerere [22mupdates the index with the resulting contents after it cleanly resolves conflicts using previously recorded resolution. Defaults to false.

       rerere.enabled
           Activate recording of resolved conflicts, so that identical conflict hunks can be resolved automatically, should they be encountered again. By default, [1mgit-rerere[22m(1) is enabled
           if there is an [1mrr-cache [22mdirectory under the [1m$GIT_DIR[22m, e.g. if "rerere" was previously used in the repository.

       reset.quiet
           When set to true, [4mgit[24m [4mreset[24m will default to the [4m--quiet[24m option.

       sendemail.identity
           A configuration identity. When given, causes values in the [4msendemail.<identity>[24m subsection to take precedence over values in the [4msendemail[24m section. The default identity is the
           value of [1msendemail.identity[22m.

       sendemail.smtpEncryption
           See [1mgit-send-email[22m(1) for description. Note that this setting is not subject to the [4midentity[24m mechanism.

       sendemail.smtpssl (deprecated)
           Deprecated alias for [4msendemail.smtpEncryption[24m [4m=[24m [4mssl[24m.

       sendemail.smtpsslcertpath
           Path to ca-certificates (either a directory or a single file). Set it to an empty string to disable certificate verification.

       sendemail.<identity>.*
           Identity-specific versions of the [4msendemail.*[24m  parameters found below, taking precedence over those when this identity is selected, through either the command-line or
           [1msendemail.identity[22m.

       sendemail.aliasesFile, sendemail.aliasFileType, sendemail.annotate, sendemail.bcc, sendemail.cc, sendemail.ccCmd, sendemail.chainReplyTo, sendemail.confirm,
       sendemail.envelopeSender, sendemail.from, sendemail.multiEdit, sendemail.signedoffbycc, sendemail.smtpPass, sendemail.suppresscc, sendemail.suppressFrom, sendemail.to,
       sendemail.tocmd, sendemail.smtpDomain, sendemail.smtpServer, sendemail.smtpServerPort, sendemail.smtpServerOption, sendemail.smtpUser, sendemail.thread, sendemail.transferEncoding,
       sendemail.validate, sendemail.xmailer
           See [1mgit-send-email[22m(1) for description.

       sendemail.signedoffcc (deprecated)
           Deprecated alias for [1msendemail.signedoffbycc[22m.

       sendemail.smtpBatchSize
           Number of messages to be sent per connection, after that a relogin will happen. If the value is 0 or undefined, send all messages in one connection. See also the [1m--batch-size[0m
           option of [1mgit-send-email[22m(1).

       sendemail.smtpReloginDelay
           Seconds wait before reconnecting to smtp server. See also the [1m--relogin-delay [22moption of [1mgit-send-email[22m(1).

       sendemail.forbidSendmailVariables
           To avoid common misconfiguration mistakes, [1mgit-send-email[22m(1) will abort with a warning if any configuration options for "sendmail" exist. Set this variable to bypass the check.

       sequence.editor
           Text editor used by [1mgit rebase -i [22mfor editing the rebase instruction file. The value is meant to be interpreted by the shell when it is used. It can be overridden by the
           [1mGIT_SEQUENCE_EDITOR [22menvironment variable. When not configured the default commit message editor is used instead.

       showBranch.default
           The default set of branches for [1mgit-show-branch[22m(1). See [1mgit-show-branch[22m(1).

       splitIndex.maxPercentChange
           When the split index feature is used, this specifies the percent of entries the split index can contain compared to the total number of entries in both the split index and the
           shared index before a new shared index is written. The value should be between 0 and 100. If the value is 0 then a new shared index is always written, if it is 100 a new shared
           index is never written. By default the value is 20, so a new shared index is written if the number of entries in the split index would be greater than 20 percent of the total
           number of entries. See [1mgit-update-index[22m(1).

       splitIndex.sharedIndexExpire
           When the split index feature is used, shared index files that were not modified since the time this variable specifies will be removed when a new shared index file is created.
           The value "now" expires all entries immediately, and "never" suppresses expiration altogether. The default value is "2.weeks.ago". Note that a shared index file is considered
           modified (for the purpose of expiration) each time a new split-index file is either created based on it or read from it. See [1mgit-update-index[22m(1).

       ssh.variant
           By default, Git determines the command line arguments to use based on the basename of the configured SSH command (configured using the environment variable [1mGIT_SSH [22mor
           [1mGIT_SSH_COMMAND [22mor the config setting [1mcore.sshCommand[22m). If the basename is unrecognized, Git will attempt to detect support of OpenSSH options by first invoking the configured
           SSH command with the [1m-G [22m(print configuration) option and will subsequently use OpenSSH options (if that is successful) or no options besides the host and remote command (if it
           fails).

           The config variable [1mssh.variant [22mcan be set to override this detection. Valid values are [1mssh [22m(to use OpenSSH options), [1mplink[22m, [1mputty[22m, [1mtortoiseplink[22m, [1msimple [22m(no options except the
           host and remote command). The default auto-detection can be explicitly requested using the value [1mauto[22m. Any other value is treated as [1mssh[22m. This setting can also be overridden
           via the environment variable [1mGIT_SSH_VARIANT[22m.

           The current command-line parameters used for each variant are as follows:

           +o   [1mssh [22m- [-p port] [-4] [-6] [-o option] [username@]host command

           +o   [1msimple [22m- [username@]host command

           +o   [1mplink [22mor [1mputty [22m- [-P port] [-4] [-6] [username@]host command

           +o   [1mtortoiseplink [22m- [-P port] [-4] [-6] -batch [username@]host command

           Except for the [1msimple [22mvariant, command-line parameters are likely to change as git gains new features.

       status.relativePaths
           By default, [1mgit-status[22m(1) shows paths relative to the current directory. Setting this variable to [1mfalse [22mshows paths relative to the repository root (this was the default for
           Git prior to v1.5.4).

       status.short
           Set to true to enable --short by default in [1mgit-status[22m(1). The option --no-short takes precedence over this variable.

       status.branch
           Set to true to enable --branch by default in [1mgit-status[22m(1). The option --no-branch takes precedence over this variable.

       status.aheadBehind
           Set to true to enable [1m--ahead-behind [22mand false to enable [1m--no-ahead-behind [22mby default in [1mgit-status[22m(1) for non-porcelain status formats. Defaults to true.

       status.displayCommentPrefix
           If set to true, [1mgit-status[22m(1) will insert a comment prefix before each output line (starting with [1mcore.commentChar[22m, i.e.  [1m# [22mby default). This was the behavior of [1mgit-status[22m(1)
           in Git 1.8.4 and previous. Defaults to false.

       status.renameLimit
           The number of files to consider when performing rename detection in [1mgit-status[22m(1) and [1mgit-commit[22m(1). Defaults to the value of diff.renameLimit.

       status.renames
           Whether and how Git detects renames in [1mgit-status[22m(1) and [1mgit-commit[22m(1) . If set to "false", rename detection is disabled. If set to "true", basic rename detection is enabled.
           If set to "copies" or "copy", Git will detect copies, as well. Defaults to the value of diff.renames.

       status.showStash
           If set to true, [1mgit-status[22m(1) will display the number of entries currently stashed away. Defaults to false.

       status.showUntrackedFiles
           By default, [1mgit-status[22m(1) and [1mgit-commit[22m(1) show files which are not currently tracked by Git. Directories which contain only untracked files, are shown with the directory name
           only. Showing untracked files means that Git needs to lstat() all the files in the whole repository, which might be slow on some systems. So, this variable controls how the
           commands displays the untracked files. Possible values are:

           +o   [1mno [22m- Show no untracked files.

           +o   [1mnormal [22m- Show untracked files and directories.

           +o   [1mall [22m- Show also individual files in untracked directories.

           If this variable is not specified, it defaults to [4mnormal[24m. This variable can be overridden with the -u|--untracked-files option of [1mgit-status[22m(1) and [1mgit-commit[22m(1).

       status.submoduleSummary
           Defaults to false. If this is set to a non zero number or true (identical to -1 or an unlimited number), the submodule summary will be enabled and a summary of commits for
           modified submodules will be shown (see --summary-limit option of [1mgit-submodule[22m(1)). Please note that the summary output command will be suppressed for all submodules when
           [1mdiff.ignoreSubmodules [22mis set to [4mall[24m or only for those submodules where [1msubmodule.<name>.ignore=all[22m. The only exception to that rule is that status and commit will show staged
           submodule changes. To also view the summary for ignored submodules you can either use the --ignore-submodules=dirty command-line option or the [4mgit[24m [4msubmodule[24m [4msummary[24m command,
           which shows a similar output but does not honor these settings.

       stash.useBuiltin
           Unused configuration variable. Used in Git versions 2.22 to 2.26 as an escape hatch to enable the legacy shellscript implementation of stash. Now the built-in rewrite of it in
           C is always used. Setting this will emit a warning, to alert any remaining users that setting this now does nothing.

       stash.showPatch
           If this is set to true, the [1mgit stash show [22mcommand without an option will show the stash entry in patch form. Defaults to false. See description of [4mshow[24m command in [1mgit-[0m
           [1mstash[22m(1).

       stash.showStat
           If this is set to true, the [1mgit stash show [22mcommand without an option will show diffstat of the stash entry. Defaults to true. See description of [4mshow[24m command in [1mgit-stash[22m(1).

       submodule.<name>.url
           The URL for a submodule. This variable is copied from the .gitmodules file to the git config via [4mgit[24m [4msubmodule[24m [4minit[24m. The user can change the configured URL before obtaining the
           submodule via [4mgit[24m [4msubmodule[24m [4mupdate[24m. If neither submodule.<name>.active or submodule.active are set, the presence of this variable is used as a fallback to indicate whether the
           submodule is of interest to git commands. See [1mgit-submodule[22m(1) and [1mgitmodules[22m(5) for details.

       submodule.<name>.update
           The method by which a submodule is updated by [4mgit[24m [4msubmodule[24m [4mupdate[24m, which is the only affected command, others such as [4mgit[24m [4mcheckout[24m [4m--recurse-submodules[24m are unaffected. It
           exists for historical reasons, when [4mgit[24m [4msubmodule[24m was the only command to interact with submodules; settings like [1msubmodule.active [22mand [1mpull.rebase [22mare more specific. It is
           populated by [1mgit submodule init [22mfrom the [1mgitmodules[22m(5) file. See description of [4mupdate[24m command in [1mgit-submodule[22m(1).

       submodule.<name>.branch
           The remote branch name for a submodule, used by [1mgit submodule update --remote[22m. Set this option to override the value found in the [1m.gitmodules [22mfile. See [1mgit-submodule[22m(1) and
           [1mgitmodules[22m(5) for details.

       submodule.<name>.fetchRecurseSubmodules
           This option can be used to control recursive fetching of this submodule. It can be overridden by using the --[no-]recurse-submodules command-line option to "git fetch" and "git
           pull". This setting will override that from in the [1mgitmodules[22m(5) file.

       submodule.<name>.ignore
           Defines under what circumstances "git status" and the diff family show a submodule as modified. When set to "all", it will never be considered modified (but it will nonetheless
           show up in the output of status and commit when it has been staged), "dirty" will ignore all changes to the submodules work tree and takes only differences between the HEAD of
           the submodule and the commit recorded in the superproject into account. "untracked" will additionally let submodules with modified tracked files in their work tree show up.
           Using "none" (the default when this option is not set) also shows submodules that have untracked files in their work tree as changed. This setting overrides any setting made in
           .gitmodules for this submodule, both settings can be overridden on the command line by using the "--ignore-submodules" option. The [4mgit[24m [4msubmodule[24m commands are not affected by
           this setting.

       submodule.<name>.active
           Boolean value indicating if the submodule is of interest to git commands. This config option takes precedence over the submodule.active config option. See [1mgitsubmodules[22m(7) for
           details.

       submodule.active
           A repeated field which contains a pathspec used to match against a submodule's path to determine if the submodule is of interest to git commands. See [1mgitsubmodules[22m(7) for
           details.

       submodule.recurse
           Specifies if commands recurse into submodules by default. This applies to all commands that have a [1m--recurse-submodules [22moption ([1mcheckout[22m, [1mfetch[22m, [1mgrep[22m, [1mpull[22m, [1mpush[22m, [1mread-tree[22m,
           [1mreset[22m, [1mrestore [22mand [1mswitch[22m) except [1mclone [22mand [1mls-files[22m. Defaults to false. When set to true, it can be deactivated via the [1m--no-recurse-submodules [22moption. Note that some Git
           commands lacking this option may call some of the above commands affected by [1msubmodule.recurse[22m; for instance [1mgit remote update [22mwill call [1mgit fetch [22mbut does not have a
           [1m--no-recurse-submodules [22moption. For these commands a workaround is to temporarily change the configuration value by using [1mgit -c submodule.recurse=0[22m.

       submodule.fetchJobs
           Specifies how many submodules are fetched/cloned at the same time. A positive integer allows up to that number of submodules fetched in parallel. A value of 0 will give some
           reasonable default. If unset, it defaults to 1.

       submodule.alternateLocation
           Specifies how the submodules obtain alternates when submodules are cloned. Possible values are [1mno[22m, [1msuperproject[22m. By default [1mno [22mis assumed, which doesn't add references. When
           the value is set to [1msuperproject [22mthe submodule to be cloned computes its alternates location relative to the superprojects alternate.

       submodule.alternateErrorStrategy
           Specifies how to treat errors with the alternates for a submodule as computed via [1msubmodule.alternateLocation[22m. Possible values are [1mignore[22m, [1minfo[22m, [1mdie[22m. Default is [1mdie[22m. Note that
           if set to [1mignore [22mor [1minfo[22m, and if there is an error with the computed alternate, the clone proceeds as if no alternate was specified.

       tag.forceSignAnnotated
           A boolean to specify whether annotated tags created should be GPG signed. If [1m--annotate [22mis specified on the command line, it takes precedence over this option.

       tag.sort
           This variable controls the sort ordering of tags when displayed by [1mgit-tag[22m(1). Without the "--sort=<value>" option provided, the value of this variable will be used as the
           default.

       tag.gpgSign
           A boolean to specify whether all tags should be GPG signed. Use of this option when running in an automated script can result in a large number of tags being signed. It is
           therefore convenient to use an agent to avoid typing your gpg passphrase several times. Note that this option doesn't affect tag signing behavior enabled by "-u <keyid>" or
           "--local-user=<keyid>" options.

       tar.umask
           This variable can be used to restrict the permission bits of tar archive entries. The default is 0002, which turns off the world write bit. The special value "user" indicates
           that the archiving user's umask will be used instead. See umask(2) and [1mgit-archive[22m(1).

       Trace2 config settings are only read from the system and global config files; repository local and worktree config files and [1m-c [22mcommand line arguments are not respected.

       trace2.normalTarget
           This variable controls the normal target destination. It may be overridden by the [1mGIT_TRACE2 [22menvironment variable. The following table shows possible values.

       trace2.perfTarget
           This variable controls the performance target destination. It may be overridden by the [1mGIT_TRACE2_PERF [22menvironment variable. The following table shows possible values.

       trace2.eventTarget
           This variable controls the event target destination. It may be overridden by the [1mGIT_TRACE2_EVENT [22menvironment variable. The following table shows possible values.

           +o   [1m0 [22mor [1mfalse [22m- Disables the target.

           +o   [1m1 [22mor [1mtrue [22m- Writes to [1mSTDERR[22m.

           +o   [1m[2-9] [22m- Writes to the already opened file descriptor.

           +o   [1m<absolute-pathname> [22m- Writes to the file in append mode. If the target already exists and is a directory, the traces will be written to files (one per process) underneath
               the given directory.

           +o   [1maf_unix:[<socket_type>:]<absolute-pathname> [22m- Write to a Unix DomainSocket (on platforms that support them). Socket type can be either [1mstream [22mor [1mdgram[22m; if omitted Git will
               try both.

       trace2.normalBrief
           Boolean. When true [1mtime[22m, [1mfilename[22m, and [1mline [22mfields are omitted from normal output. May be overridden by the [1mGIT_TRACE2_BRIEF [22menvironment variable. Defaults to false.

       trace2.perfBrief
           Boolean. When true [1mtime[22m, [1mfilename[22m, and [1mline [22mfields are omitted from PERF output. May be overridden by the [1mGIT_TRACE2_PERF_BRIEF [22menvironment variable. Defaults to false.

       trace2.eventBrief
           Boolean. When true [1mtime[22m, [1mfilename[22m, and [1mline [22mfields are omitted from event output. May be overridden by the [1mGIT_TRACE2_EVENT_BRIEF [22menvironment variable. Defaults to false.

       trace2.eventNesting
           Integer. Specifies desired depth of nested regions in the event output. Regions deeper than this value will be omitted. May be overridden by the [1mGIT_TRACE2_EVENT_NESTING[0m
           environment variable. Defaults to 2.

       trace2.configParams
           A comma-separated list of patterns of "important" config settings that should be recorded in the trace2 output. For example, [1mcore.*,remote.*.url [22mwould cause the trace2 output
           to contain events listing each configured remote. May be overridden by the [1mGIT_TRACE2_CONFIG_PARAMS [22menvironment variable. Unset by default.

       trace2.envVars
           A comma-separated list of "important" environment variables that should be recorded in the trace2 output. For example, [1mGIT_HTTP_USER_AGENT,GIT_CONFIG [22mwould cause the trace2
           output to contain events listing the overrides for HTTP user agent and the location of the Git configuration file (assuming any are set). May be overriden by the
           [1mGIT_TRACE2_ENV_VARS [22menvironment variable. Unset by default.

       trace2.destinationDebug
           Boolean. When true Git will print error messages when a trace target destination cannot be opened for writing. By default, these errors are suppressed and tracing is silently
           disabled. May be overridden by the [1mGIT_TRACE2_DST_DEBUG [22menvironment variable.

       trace2.maxFiles
           Integer. When writing trace files to a target directory, do not write additional traces if we would exceed this many files. Instead, write a sentinel file that will block
           further tracing to this directory. Defaults to 0, which disables this check.

       transfer.fsckObjects
           When [1mfetch.fsckObjects [22mor [1mreceive.fsckObjects [22mare not set, the value of this variable is used instead. Defaults to false.

           When set, the fetch or receive will abort in the case of a malformed object or a link to a nonexistent object. In addition, various other issues are checked for, including
           legacy issues (see [1mfsck.<msg-id>[22m), and potential security issues like the existence of a [1m.GIT [22mdirectory or a malicious [1m.gitmodules [22mfile (see the release notes for v2.2.1 and
           v2.17.1 for details). Other sanity and security checks may be added in future releases.

           On the receiving side, failing fsckObjects will make those objects unreachable, see "QUARANTINE ENVIRONMENT" in [1mgit-receive-pack[22m(1). On the fetch side, malformed objects will
           instead be left unreferenced in the repository.

           Due to the non-quarantine nature of the [1mfetch.fsckObjects [22mimplementation it cannot be relied upon to leave the object store clean like [1mreceive.fsckObjects [22mcan.

           As objects are unpacked they're written to the object store, so there can be cases where malicious objects get introduced even though the "fetch" failed, only to have a
           subsequent "fetch" succeed because only new incoming objects are checked, not those that have already been written to the object store. That difference in behavior should not
           be relied upon. In the future, such objects may be quarantined for "fetch" as well.

           For now, the paranoid need to find some way to emulate the quarantine environment if they'd like the same protection as "push". E.g. in the case of an internal mirror do the
           mirroring in two steps, one to fetch the untrusted objects, and then do a second "push" (which will use the quarantine) to another internal repo, and have internal clients
           consume this pushed-to repository, or embargo internal fetches and only allow them once a full "fsck" has run (and no new fetches have happened in the meantime).

       transfer.hideRefs
           String(s) [1mreceive-pack [22mand [1mupload-pack [22muse to decide which refs to omit from their initial advertisements. Use more than one definition to specify multiple prefix strings. A
           ref that is under the hierarchies listed in the value of this variable is excluded, and is hidden when responding to [1mgit push [22mor [1mgit fetch[22m. See [1mreceive.hideRefs [22mand
           [1muploadpack.hideRefs [22mfor program-specific versions of this config.

           You may also include a [1m!  [22min front of the ref name to negate the entry, explicitly exposing it, even if an earlier entry marked it as hidden. If you have multiple hideRefs
           values, later entries override earlier ones (and entries in more-specific config files override less-specific ones).

           If a namespace is in use, the namespace prefix is stripped from each reference before it is matched against [1mtransfer.hiderefs [22mpatterns. For example, if [1mrefs/heads/master [22mis
           specified in [1mtransfer.hideRefs [22mand the current namespace is [1mfoo[22m, then [1mrefs/namespaces/foo/refs/heads/master [22mis omitted from the advertisements but [1mrefs/heads/master [22mand
           [1mrefs/namespaces/bar/refs/heads/master [22mare still advertised as so-called "have" lines. In order to match refs before stripping, add a [1m^ [22min front of the ref name. If you combine
           [1m!  [22mand [1m^[22m, [1m!  [22mmust be specified first.

           Even if you hide refs, a client may still be able to steal the target objects via the techniques described in the "SECURITY" section of the [1mgitnamespaces[22m(7) man page; it's best
           to keep private data in a separate repository.

       transfer.unpackLimit
           When [1mfetch.unpackLimit [22mor [1mreceive.unpackLimit [22mare not set, the value of this variable is used instead. The default value is 100.

       transfer.advertiseSID
           Boolean. When true, client and server processes will advertise their unique session IDs to their remote counterpart. Defaults to false.

       uploadarchive.allowUnreachable
           If true, allow clients to use [1mgit archive --remote [22mto request any tree, whether reachable from the ref tips or not. See the discussion in the "SECURITY" section of [1mgit-upload-[0m
           [1marchive[22m(1) for more details. Defaults to [1mfalse[22m.

       uploadpack.hideRefs
           This variable is the same as [1mtransfer.hideRefs[22m, but applies only to [1mupload-pack [22m(and so affects only fetches, not pushes). An attempt to fetch a hidden ref by [1mgit fetch [22mwill
           fail. See also [1muploadpack.allowTipSHA1InWant[22m.

       uploadpack.allowTipSHA1InWant
           When [1muploadpack.hideRefs [22mis in effect, allow [1mupload-pack [22mto accept a fetch request that asks for an object at the tip of a hidden ref (by default, such a request is rejected).
           See also [1muploadpack.hideRefs[22m. Even if this is false, a client may be able to steal objects via the techniques described in the "SECURITY" section of the [1mgitnamespaces[22m(7) man
           page; it's best to keep private data in a separate repository.

       uploadpack.allowReachableSHA1InWant
           Allow [1mupload-pack [22mto accept a fetch request that asks for an object that is reachable from any ref tip. However, note that calculating object reachability is computationally
           expensive. Defaults to [1mfalse[22m. Even if this is false, a client may be able to steal objects via the techniques described in the "SECURITY" section of the [1mgitnamespaces[22m(7) man
           page; it's best to keep private data in a separate repository.

       uploadpack.allowAnySHA1InWant
           Allow [1mupload-pack [22mto accept a fetch request that asks for any object at all. Defaults to [1mfalse[22m.

       uploadpack.keepAlive
           When [1mupload-pack [22mhas started [1mpack-objects[22m, there may be a quiet period while [1mpack-objects [22mprepares the pack. Normally it would output progress information, but if [1m--quiet [22mwas
           used for the fetch, [1mpack-objects [22mwill output nothing at all until the pack data begins. Some clients and networks may consider the server to be hung and give up. Setting this
           option instructs [1mupload-pack [22mto send an empty keepalive packet every [1muploadpack.keepAlive [22mseconds. Setting this option to 0 disables keepalive packets entirely. The default is
           5 seconds.

       uploadpack.packObjectsHook
           If this option is set, when [1mupload-pack [22mwould run [1mgit pack-objects [22mto create a packfile for a client, it will run this shell command instead. The [1mpack-objects [22mcommand and
           arguments it [4mwould[24m have run (including the [1mgit pack-objects [22mat the beginning) are appended to the shell command. The stdin and stdout of the hook are treated as if [1mpack-objects[0m
           itself was run. I.e., [1mupload-pack [22mwill feed input intended for [1mpack-objects [22mto the hook, and expects a completed packfile on stdout.

           Note that this configuration variable is ignored if it is seen in the repository-level config (this is a safety measure against fetching from untrusted repositories).

       uploadpack.allowFilter
           If this option is set, [1mupload-pack [22mwill support partial clone and partial fetch object filtering.

       uploadpackfilter.allow
           Provides a default value for unspecified object filters (see: the below configuration variable). Defaults to [1mtrue[22m.

       uploadpackfilter.<filter>.allow
           Explicitly allow or ban the object filter corresponding to [1m<filter>[22m, where [1m<filter> [22mmay be one of: [1mblob:none[22m, [1mblob:limit[22m, [1mtree[22m, [1msparse:oid[22m, or [1mcombine[22m. If using combined
           filters, both [1mcombine [22mand all of the nested filter kinds must be allowed. Defaults to [1muploadpackfilter.allow[22m.

       uploadpackfilter.tree.maxDepth
           Only allow [1m--filter=tree:<n> [22mwhen [1m<n> [22mis no more than the value of [1muploadpackfilter.tree.maxDepth[22m. If set, this also implies [1muploadpackfilter.tree.allow=true[22m, unless this
           configuration variable had already been set. Has no effect if unset.

       uploadpack.allowRefInWant
           If this option is set, [1mupload-pack [22mwill support the [1mref-in-want [22mfeature of the protocol version 2 [1mfetch [22mcommand. This feature is intended for the benefit of load-balanced
           servers which may not have the same view of what OIDs their refs point to due to replication delay.

       url.<base>.insteadOf
           Any URL that starts with this value will be rewritten to start, instead, with <base>. In cases where some site serves a large number of repositories, and serves them with
           multiple access methods, and some users need to use different access methods, this feature allows people to specify any of the equivalent URLs and have Git automatically
           rewrite the URL to the best alternative for the particular user, even for a never-before-seen repository on the site. When more than one insteadOf strings match a given URL,
           the longest match is used.

           Note that any protocol restrictions will be applied to the rewritten URL. If the rewrite changes the URL to use a custom protocol or remote helper, you may need to adjust the
           [1mprotocol.*.allow [22mconfig to permit the request. In particular, protocols you expect to use for submodules must be set to [1malways [22mrather than the default of [1muser[22m. See the
           description of [1mprotocol.allow [22mabove.

       url.<base>.pushInsteadOf
           Any URL that starts with this value will not be pushed to; instead, it will be rewritten to start with <base>, and the resulting URL will be pushed to. In cases where some site
           serves a large number of repositories, and serves them with multiple access methods, some of which do not allow push, this feature allows people to specify a pull-only URL and
           have Git automatically use an appropriate URL to push, even for a never-before-seen repository on the site. When more than one pushInsteadOf strings match a given URL, the
           longest match is used. If a remote has an explicit pushurl, Git will ignore this setting for that remote.

       user.name, user.email, author.name, author.email, committer.name, committer.email
           The [1muser.name [22mand [1muser.email [22mvariables determine what ends up in the [1mauthor [22mand [1mcommitter [22mfield of commit objects. If you need the [1mauthor [22mor [1mcommitter [22mto be different, the
           [1mauthor.name[22m, [1mauthor.email[22m, [1mcommitter.name [22mor [1mcommitter.email [22mvariables can be set. Also, all of these can be overridden by the [1mGIT_AUTHOR_NAME[22m, [1mGIT_AUTHOR_EMAIL[22m,
           [1mGIT_COMMITTER_NAME[22m, [1mGIT_COMMITTER_EMAIL [22mand [1mEMAIL [22menvironment variables.

           Note that the [1mname [22mforms of these variables conventionally refer to some form of a personal name. See [1mgit-commit[22m(1) and the environment variables section of [1mgit[22m(1) for more
           information on these settings and the [1mcredential.username [22moption if you're looking for authentication credentials instead.

       user.useConfigOnly
           Instruct Git to avoid trying to guess defaults for [1muser.email [22mand [1muser.name[22m, and instead retrieve the values only from the configuration. For example, if you have multiple
           email addresses and would like to use a different one for each repository, then with this configuration option set to [1mtrue [22min the global config along with a name, Git will
           prompt you to set up an email before making new commits in a newly cloned repository. Defaults to [1mfalse[22m.

       user.signingKey
           If [1mgit-tag[22m(1) or [1mgit-commit[22m(1) is not selecting the key you want it to automatically when creating a signed tag or commit, you can override the default selection with this
           variable. This option is passed unchanged to gpg's --local-user parameter, so you may specify a key using any method that gpg supports.

       versionsort.prereleaseSuffix (deprecated)
           Deprecated alias for [1mversionsort.suffix[22m. Ignored if [1mversionsort.suffix [22mis set.

       versionsort.suffix
           Even when version sort is used in [1mgit-tag[22m(1), tagnames with the same base version but different suffixes are still sorted lexicographically, resulting e.g. in prerelease tags
           appearing after the main release (e.g. "1.0-rc1" after "1.0"). This variable can be specified to determine the sorting order of tags with different suffixes.

           By specifying a single suffix in this variable, any tagname containing that suffix will appear before the corresponding main release. E.g. if the variable is set to "-rc", then
           all "1.0-rcX" tags will appear before "1.0". If specified multiple times, once per suffix, then the order of suffixes in the configuration will determine the sorting order of
           tagnames with those suffixes. E.g. if "-pre" appears before "-rc" in the configuration, then all "1.0-preX" tags will be listed before any "1.0-rcX" tags. The placement of the
           main release tag relative to tags with various suffixes can be determined by specifying the empty suffix among those other suffixes. E.g. if the suffixes "-rc", "", "-ck" and
           "-bfs" appear in the configuration in this order, then all "v4.8-rcX" tags are listed first, followed by "v4.8", then "v4.8-ckX" and finally "v4.8-bfsX".

           If more than one suffixes match the same tagname, then that tagname will be sorted according to the suffix which starts at the earliest position in the tagname. If more than
           one different matching suffixes start at that earliest position, then that tagname will be sorted according to the longest of those suffixes. The sorting order between
           different suffixes is undefined if they are in multiple config files.

       web.browser
           Specify a web browser that may be used by some commands. Currently only [1mgit-instaweb[22m(1) and [1mgit-help[22m(1) may use it.

       worktree.guessRemote
           If no branch is specified and neither [1m-b [22mnor [1m-B [22mnor [1m--detach [22mis used, then [1mgit worktree add [22mdefaults to creating a new branch from HEAD. If [1mworktree.guessRemote [22mis set to true,
           [1mworktree add [22mtries to find a remote-tracking branch whose name uniquely matches the new branch name. If such a branch exists, it is checked out and set as "upstream" for the
           new branch. If no such match can be found, it falls back to creating a new branch from the current HEAD.

[1mBUGS[0m
       When using the deprecated [1m[section.subsection] [22msyntax, changing a value will result in adding a multi-line key instead of a change, if the subsection is given with at least one
       uppercase character. For example when the config looks like

             [section.subsection]
               key = value1

       and running [1mgit config section.Subsection.key value2 [22mwill result in

             [section.subsection]
               key = value1
               key = value2

[1mGIT[0m
       Part of the [1mgit[22m(1) suite

[1mNOTES[0m
        1. wire protocol version 2
           git-htmldocs/technical/protocol-v2.html

Git 2.30.0                                                                               12/27/2020                                                                           GIT-CONFIG(1)
