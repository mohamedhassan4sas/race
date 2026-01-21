libname schscr35 postgres 
    server   = "10.225.13.121" 
    port     = 5432 
    database = "tenant1" 
    schema   = "schscr"
    user     = "dbmsowner" 
    password = "Orion123";



libname schscr40 postgres 
    server   = "sasserver.demo.sas.com" 
    port     = 5432 
    database = "amlcore" 
    schema   = "schscr"
    user     = "postgres" 
    password = "Orion123";



/* 3. Copy everything from source to target */
proc copy in=schscr35 out=schscr40 memtype=data;
run;