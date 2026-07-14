/* cap input rows for the captured run */
options obs=100;

/* The upstream script copies datasets between two external PostgreSQL
   schemas (a 3.5 -> 4.0 migration). To exercise the same PROC COPY logic
   in isolation, this bundle points the two libraries at local base-engine
   directories under WORK and seeds the source with a small mock dataset
   that stands in for the migrated tables. */
%let src = %sysfunc(pathname(work))/schscr35;
%let tgt = %sysfunc(pathname(work))/schscr40;
options dlcreatedir;
libname schscr35 "&src";
libname schscr40 "&tgt";

/* seed the source library with a couple of mock tables to migrate */
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
