    LIKE:
        The LIKE clause is used to match patterns in text columns.
        It does not check for exact equality like '='.
        Instead, it checks if a value *looks like* a pattern.

        LIKE uses two special wildcard symbols:
            %  → matches any number of characters (0, 1 or many)
            _  → matches exactly one character

        So LIKE is basically pattern-matching on strings.

    Examples:
        name LIKE 'A%'  
            → all names starting with 'A'

        name LIKE '%a'  
            → all names ending with 'a'

        name LIKE '%an%'  
            → names containing 'an' anywhere

        name LIKE 'A_'  
            → names with two characters, starting with A

        name LIKE '__a%'  
            → names where 3rd character is 'a'


    How it behaves:
        - LIKE is case-sensitive in PostgreSQL.
        - LIKE is not case-sensitive in MySQL (default settings).
        - For case-insensitive searching in PostgreSQL, use ILIKE.


    Summary:
        LIKE helps us filter text using patterns.
        % matches many characters.
        _ matches exactly one character.
        Perfect for searching names, cities, emails, etc.
