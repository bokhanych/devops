#!/bin/bash
wget -O web-page https://www.atlassian.com/continuous-delivery/continuous-integration
grep -oi "continuous integration" web-page | wc -l
