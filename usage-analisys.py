#!/usr/bin/python
import csv
import pprint

projs = list()
tbl = dict()
with open('year-month-nimbus.csv') as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    for row in readCSV:
        dstart = str(row[0]) + '-' + str(row[1]) + '-' + str(row[2])
        year_month = str(row[0]) + '-' + str(row[1])
        #print "server-" + dstart + ".csv"
        data_csv = "servers-" + dstart + ".csv"
        tbl[year_month] = dict()

        with open(data_csv) as dcsv:
            rcsv = csv.reader(dcsv, delimiter=',')
            for l in rcsv:
                if l[0] == 'Project':
                    continue
                print l[0], year_month, l[1]
                tbl[year_month][l[0]] = l[1]

                if l[0] not in projs:
                    projs.append(l[0])

#print
#print projs
#print        
#pprint.pprint(tbl)

with open('os-table.csv', 'w') as csvf:
    r1 = ["Projects"]
    for r in tbl:
        r1.append(r)

row1 = ','.join(r1)

print row1

