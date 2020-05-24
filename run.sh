#!/bin/bash

if [ $1 = "dust" ]
then
    shift 
    cd /src && /dust/dust/build/bin/dust $@
elif [ $1 = "dust_pre" ]
then
    shift 
    cd /src && /dust/dust/build/bin/dust_pre $@
elif [ $1 = "dust_post" ]
then
    shift 
    cd /src && /dust/dust/build/bin/dust_post $@
else
   echo "None of the condition met"
fi

