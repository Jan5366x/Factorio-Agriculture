#!/bin/bash

grep "name =" Factorio-Agriculture/prototypes/item.lua|cut -d "=" -f2|cut -d "\"" -f2 > item_names

cat Factorio-Agriculture/locale/de/main.cfg|cut -d "=" -f1|grep -v "\[item"|awk 'NF' > names_de
cat Factorio-Agriculture/locale/en/main.cfg|cut -d "=" -f1|grep -v "\[item"|awk 'NF' > names_en

echo "Diff DE"
diff item_names names_de
echo "--------------------------------------------------------------"
echo "Diff EN"
diff item_names names_en

