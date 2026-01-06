#!/bin/bash
# Check if IP of target is entered 
if [ -z "$1" ]
 then 
   echo "Correct usage is ./recon.sh <IP>"
   exit
 else
   echo "Target IP $1"
   echo "Running Nmap..."
# Run Nmap scan on target and save results to a file
   nmap -sV $1 > scan_results.txt
   echo "Scan complete - results written to scan_results.txt" 
fi 
# If the Samba port 445 is found and open, run enum4linux.
if grep 445 scan_results.txt | grep -iq open
  then 
    echo "Samba found. Enumeration started..."
    enum4linux -U -S $1 >> scan_results.txt
    echo "Enumeration complete."
    echo "Results added to scan_results.txt."
    echo "To view results, cat the file." 
  else 
    echo "Open SMB ports not found." 
fi 
