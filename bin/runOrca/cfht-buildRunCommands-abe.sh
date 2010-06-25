#!/bin/sh
if [ "x$DATAREL_DIR" == "x" ]; then
   echo -e "You must 'setup datarel' before use."
   exit 0
fi

if [ $# -lt 2 ] ; then
   echo -e "cfht-buildRunCommands.sh <runid> <inputlist>\nwhere\n   runid : unique ID for run\n   inputlist : full pathname to list of visit/ccd/amp to process.\nExample: cfht-buildRunCommands.sh raa20100521_01 /tmp/TestCfhtInput.txt"
   exit 0
fi

cat <<EOF
===========================
     orca.py -r ./pipeline -e $DATAREL_DIR/bin/runOrca/cfht-setupForOrcaUse-abe.sh -V 10 -P 10 ./cfht-orca-abe.paf $1
===========================
     announceDataset.py -r $1 -b lsst8.ncsa.uiuc.edu -t RawAvailable $2
===========================
     shutprod.py 1 $1
===========================
EOF