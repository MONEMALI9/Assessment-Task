#!/bin/bash

mkdir -p company_info

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
