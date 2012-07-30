#!/bin/bash

show_parent_dirs()
{
   pwd | awk '
   BEGIN {
      MAXLEVEL=5;
   }
   {
      levels = gsub(/\//,"/");
      for (i = 1; i <= levels && i <= MAXLEVEL; i++)
      {
         gsub(/\/[^\/]+$/,"");  # delete one level
         (i == levels) && $1="/";
         printf("..%s\t%s\n", (i != 1) ? i : "" , $0);
      }
   }'
}


function_exists()
{
   FUNCTION_NAME=$1
   a_function_name="$1"

   [[ -z $a_function_name ]] && return 1

   declare -F "$a_function_name" > /dev/null 2>&1

   return $?
}

