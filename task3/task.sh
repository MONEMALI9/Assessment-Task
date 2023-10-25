#!/bin/bash

mkdir -p company_info

echo -e "Name,Age,PhoneNumber,Email,Salary,Department,CountryCode\nAllen,22,433 447-7961,Allen@vodafone.com.eg,800,IT,04\nWard,25,724-995-7762,Ward_ward@vodafone.com.eg,1600,Technology,22\nJones,24,987-123-4563,Jones*1@vodafone.com.eg,1250,Technology,04\nBlake,30,433-447-7964,Blake+30@vodafone.com.eg,2975,IT,04\nClark,28,1234567895,Clark.123@vodafone.com.eg,2850,IT,04\nScott,28,123-456-7896,Scott@vodafone-2.com.eg,2450,Technology,22\nKing,26,724-995-7767,King@vodafone.com.eg,3000,Technology,02\nTurner,35,433-447-7968,35Turner@vodafone.com.eg,5000,IT,02\nAdams,24,987 123 4569,Adams@vodafone.com.en.eg,1500,Technology,05 \nJames,22,123-456 (7810),James@vodafone.com.eg,1100,Technology,04\nMiller,23,142-156-7820,Miller-142@vodafone.com.eg,950,Technology,11\nFord,24,(724)-995-7339,Ford@vodafone.com.eg,1300,IT,22\nMartin,31,387-123-2561,Martin@vodafone.com..eg,3000,IT,02\nSmith,33,756-295-7722,Smith33@vodafone.com.eg,5000,Technology,02" > Employees.csv


total_employees=$(cat Employees.csv | tail -n +2 | wc -l)
echo "Total number of employees: $total_employees"

it_employees_count=$(awk -F',' '$6 == "IT" {print $1}' Employees.csv | wc -l)
echo "IT Employees Count: $it_employees_count" >> company_info/IT_employees_count.txt

average_age=$(awk -F',' 'NR>1 {sum+=$2} END {print sum/NR}' Employees.csv)
echo "Average Age: $average_age" >> company_info/employees_age_average.txt

max_salary=$(awk -F',' '$6 == "Technology" {print $5, $1, $3, $4}' Employees.csv | sort -k1 -n | tail -n 1)
min_salary=$(awk -F',' '$6 == "Technology" {print $5, $1, $3, $4}' Employees.csv | sort -k1 -n | head -n 1)
echo "Max Salary: $max_salary" >> company_info/technology_salaries.txt
echo "Min Salary: $min_salary" >> company_info/technology_salaries.txt

awk -F',' 'NR>1 && !($4 ~ /^[A-Za-z][A-Za-z0-9]*@([A-Za-z0-9.-]+[A-Za-z0-9])+\.[A-Za-z]{2,}$/)' Employees.csv > company_info/employees_invalid_email.txt

awk -F',' 'NR>1 && !($3 ~ /^[0-9]{3}-[0-9]{3}-[0-9]{4}$/)' Employees.csv > company_info/employees_invalid_numbers.txt

awk -F',' 'BEGIN {OFS=","} {sub(/-/, "", $7); $6 = "+" $6 "-" $7; $7 = ""}1' Employees.csv > temp.csv
mv temp.csv Employees.csv

ls company_info
