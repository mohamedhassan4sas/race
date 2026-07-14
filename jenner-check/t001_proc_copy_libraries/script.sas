/* Adapted from copyDatafrom3_5to4_0.sas.

   Upstream defines two PostgreSQL libraries (source schema "schscr" on a
   3.5 server, target schema "schscr" on a 4.0 server) and copies every
   dataset from source to target. Here the two libraries are provided by
   the autoexec as local base-engine directories so the same PROC COPY
   runs without external database servers; the copy step itself is
   unchanged from the author's original. */

/* 3. Copy everything from source to target */
proc copy in=schscr35 out=schscr40 memtype=data;
run;

/* confirm the migrated tables landed in the target library */
proc datasets library=schscr40 memtype=data details;
run;
quit;
