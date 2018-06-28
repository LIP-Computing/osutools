#!/usr/bin/python
import csv

with open('year-month-nimbus.csv') as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    for row in readCSV:
        dstart = str(row[0]) + '-' + str(row[1]) + '-' + str(row[2])
        #print "server-" + dstart + ".csv"
        data_csv = "servers-" + dstart + ".csv"

        with open(data_csv) as dcsv:
            rcsv = csv.reader(dcsv, delimiter=',')
            for l in rcsv:
                print l[0], dstart, l[1]
        

