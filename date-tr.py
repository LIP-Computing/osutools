#!/usr/bin/python
import csv

with open('year-month-nimbus.csv') as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    for row in readCSV:
        dstart = str(row[0]) + '-' + str(row[1]) + '-' + str(row[2])
        dend = str(row[0]) + '-' + str(row[1]) + '-' + str(row[3])
        print dstart, dend

