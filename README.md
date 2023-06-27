
# Intro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# help to generate wordlist based on patterns to fuzz backup files (backup killer)

# read from:
* Url
* File
* STDIN
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Install
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                            *** julia ***

# install julia: https://julialang.org/downloads/
# then run this commands in terminal:

* 1. julia -e 'using Pkg; Pkg.add("JSON"); Pkg.add("ArgParse")'
* 2. git clone https://github.com/mrmeeseeks01/BackupX.git
* 3. cd BackupX/
* 4. julia BackupX.jl -h


# or you can use docker:

* 1. git clone https://github.com/mrmeeseeks01/BackupX.git
* 2. cd BackupX/
* 3. docker build -t backupx .
* 4. docker run -it backupx
* 5. press ; to enabled shell mode
* 6. julia BackupX.jl -h
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Switches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# optional arguments:

*  -h, --help            show this help message and exit
*  -u, --url             single url
*  -U, --urls            multiple urls in file
*  -s, --stdin           read url(s) from stdin
*  -p, --pattern         pattern file
*  -w, --wordlist        wordlist file
*  -e, --extension       extensions file
*  -n, --number          number range (i.e. 1-100)
*  -y, --year            year range (i.e. 2022-2023)
*  -m, --month           month range (i.e. 1-12)
*  -d, --day             day range (i.e. 1-30)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Examples
* for custom threads, should pass -t [int] to julia
~~~
> julia -t 2 BackupX.jl [switches]
~~~
* generate wordlist by your custom input
~~~
> julia BackupX.jl -U [file] -p [file] -w [file] -e [file] -n [min-max] -y [min-max] -m [min-max] -d [min-max]
~~~

# Variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# for example consider this url: https://root:1234@api-v1.admin.mysite.co.uk:443/dir1/dir2/myfile.php?id=5678&user=nobody#nothing
# you can use below variables in your custom patterns:

* scheme:    https
* username:  root
* password:  1234
* host:      api-v1.admin.mysite.co.uk
* subdomain: api-v1.admin                    ->   "ap1-v1.admin", "ap1", "v1", "admin", "ap1-v1"
* domain:    mysite
* tld:       co.uk
* port:      443
* path:      /dir1/dir2/myfile.php
* directory: /dir1/dir2
* file:      myfile.php
* query:     ?id=5678&user=nobody
* fragment:  #nothing

* num:       numbers (i.e. 1-100)
* y:         years (i.e. 2022-2023)
* m:         months (i.e. 1-12)
* d:         days (i.e. 1-30)


# you can use $ or % to define your variables in pattern: $num or %num     $ext or %ext
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Example of using Variables in Patterns.json
~~~
{
    "patterns":[
        "$domain.$ext",
        "$host.$ext",
        "$subdomain.$domain.$ext",
        "$host%num.$ext",
        "$domain%num.$ext",
        "$subdomain.$ext",
        "$file.$ext",
        "$file~",
        "$path.$ext",
        ".$file",
        ".$domain.$ext",
        ".$file.$ext",
        "$path~",
        "$directory/.$file.$ext",
        "$word.$ext",
        "$directory/$word.$ext",
        "$directory/$word"
    ],
     "date-formats":[
         "$domain.%y.$ext",
         "$domain.%y-%m-%d.$ext",
         "$host.%y-%m-%d.$ext",
         "$host.%y%m%d.$ext",
         "$host.%y%m%d.$ext",
         "$directory/%y-%m-%d.$ext"
    ]
}
~~~