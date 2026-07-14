/* Adapted from copyDatafrom3_5to4_0.sas.

   Upstream defines two PostgreSQL libraries (source schema "schscr" on a
   3.5 server, target schema "schscr" on a 4.0 server) and copies every
   dataset from source to target. The two PostgreSQL servers are not
   reachable outside the author's environment, so this bundle points the
   two libraries at local base-engine directories and seeds the source
   with two small mock tables that stand in for the migrated schema. The
   PROC COPY step itself is unchanged from the author's original; a
   confirming print of one migrated table is added so the run has visible
   output. */

libname schscr35 "%sysfunc(pathname(work))/schscr35";
libname schscr40 "%sysfunc(pathname(work))/schscr40";

/* mock source tables standing in for the 3.5 schema */
data schscr35.customers;
    length customer_id 8 name $20 balance 8;
    input customer_id name $ balance;
    datalines;
1 Alpha 1500
2 Bravo 2750
3 Charlie 990
4 Delta 4300
5 Echo 120
;
run;

data schscr35.accounts;
    length account_id 8 customer_id 8 status $10;
    input account_id customer_id status $;
    datalines;
101 1 active
102 2 active
103 3 closed
104 4 active
105 5 pending
;
run;

/* 3. Copy everything from source to target */
proc copy in=schscr35 out=schscr40 memtype=data;
run;

/* confirm the migrated tables landed in the target library */
proc datasets library=schscr40 memtype=data details;
run;
quit;

title "schscr40.customers after migration";
proc print data=schscr40.customers;
run;
