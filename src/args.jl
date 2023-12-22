using ArgParse

function ARGUMENTS()
    cyan::String = "\u001b[36m"
    yellow::String = "\u001b[33m"
    nc::String = "\033[0m"
    settings = ArgParseSettings(
        prog="BackupX",
        description="""
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n
        **** generate wordlist by given pattern to find backup files ***
        \n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        """,
        epilog="""
        \n\n$(yellow)## Variables:$(nc)\n\n

        $(yellow)for example consider this url:$(nc) $(cyan)https://root:1234@api-v1.admin.mysite.co.uk:443/dir1/dir2/myfile.php?id=5678&user=nobody#nothing$(nc)\n\n

        $(yellow)# you can use below variables in your custom patterns:$(nc)\n\n

        * $(cyan)scheme:$(nc)    https\n
        * $(cyan)username:$(nc)  root\n
        * $(cyan)password:$(nc)  1234\n
        * $(cyan)host:$(nc)      api-v1.admin.mysite.co.uk\n
        * $(cyan)subdomain:$(nc) api-v1.admin -> "ap1-v1.admin", "ap1", "v1", "admin", "ap1-v1"\n
        * $(cyan)domain:$(nc)    mysite\n
        * $(cyan)tld:$(nc)       co.uk\n
        * $(cyan)port:$(nc)      443\n
        * $(cyan)path:$(nc)      /dir1/dir2/myfile.php\n
        * $(cyan)directory:$(nc) /dir1/dir2\n
        * $(cyan)file:$(nc)      myfile.php\n
        * $(cyan)fileN:$(nc)     myfile\n
        * $(cyan)fileE:$(nc)     php\n
        * $(cyan)query:$(nc)     id=5678&user=nobody\n
        * $(cyan)fragment:$(nc)  nothing\n
        
        * $(cyan)word:$(nc)      your custom words\n
        * $(cyan)ext:$(nc)       your custom extensions\n
        * $(cyan)num:$(nc)       numbers (i.e. 1-100)\n
        * $(cyan)y:$(nc)         years (i.e. 2022-2023)\n
        * $(cyan)m:$(nc)         months (i.e. 1-12)\n
        * $(cyan)d:$(nc)         days (i.e. 1-30)\n\n

        $(yellow)you can use \$ or % to define your variables in pattern: \$num or %num     \$ext or %ext$(nc)
      """
    )
    @add_arg_table settings begin
        "-u", "--url"
        help = "single url"
        arg_type = String

        "-U", "--urls"
        help = "multiple targets urls in file to crawl"
        arg_type = String

        "-s", "--stdin"
        help = "read from stdin"
        action = :store_true

        "-p", "--pattern"
        help = "pattern files"
        required = true
        arg_type = String

        "-w", "--wordlist"
        help = "words"

        "-e", "--extension"
        help = "extensions"

        "-y", "--year"
        help = "years"

        "-m", "--month"
        help = "month"

        "-d", "--day"
        help = "day"

        "-n", "--number"
        help = "numbers"
        arg_type = String

        "-o", "--output"
        help = "save output in file"
    end
    parsed_args = parse_args(ARGS, settings)
    return parsed_args
end