#!/bin/bash

for ip in $(seq 50 55); do host 38.100.193.$ip; done | grep -v "not found"
