#!/usr/bin/python
import csv

projs = list()
with open('year-month-nimbus.csv') as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    for row in readCSV:
        dstart = str(row[0]) + '-' + str(row[1]) + '-' + str(row[2])
        year_month = str(row[0]) + '-' + str(row[1])
        #print "server-" + dstart + ".csv"
        data_csv = "servers-" + dstart + ".csv"

        with open(data_csv) as dcsv:
            rcsv = csv.reader(dcsv, delimiter=',')
            for l in rcsv:
                print l[0], year_month, l[1]
                if l[0] not in projs:
                    projs.append(l[0])

print
print projs
        

