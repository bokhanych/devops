#!/bin/bash

#download page
wget -O web-page https://www.atlassian.com/continuous-delivery/continuous-integration

#count of phrases
echo -n "Count of continuous integration: " 
grep -oi "continuous integration" web-page | wc -l

#костыли и палки (из-за регистра)
sed -i "s%continuous integration%CI_abbreviation%g" web-page
sed -i "s%Continuous integration%CI_abbreviation%g" web-page
sed -i "s%Continuous Integration%CI_abbreviation%g" web-page

#count of abbreviation
echo -n "Count of CI_abbreviation: " 
grep -oi "CI_abbreviation" web-page | wc -l