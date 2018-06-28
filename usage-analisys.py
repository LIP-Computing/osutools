#!/usr/bin/python
import csv
import pprint
import pandas as pd

tbl = dict()
with open('year-month-nimbus.csv') as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    for row in readCSV:
        dstart = str(row[0]) + '-' + str(row[1]) + '-' + str(row[2])
        year_month = str(row[0]) + '-' + str(row[1])
        data_csv = "servers-" + dstart + ".csv"
        tbl[year_month] = dict()

        with open(data_csv) as dcsv:
            rcsv = csv.reader(dcsv, delimiter=',')
            for l in rcsv:
                if l[0] == 'Project':
                    continue
                print l[0], year_month, l[1]
                tbl[year_month][l[0]] = l[1]

df = pd.DataFrame(tbl)

df.to_csv('os-table-instances.csv')


tbl = dict()
with open('year-month-nimbus.csv') as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    for row in readCSV:
        dstart = str(row[0]) + '-' + str(row[1]) + '-' + str(row[2])
        year_month = str(row[0]) + '-' + str(row[1])
        data_csv = "cpus-" + dstart + ".csv"
        tbl[year_month] = dict()

        with open(data_csv) as dcsv:
            rcsv = csv.reader(dcsv, delimiter=',')
            for l in rcsv:
                if l[0] == 'Project':
                    continue
                print l[0], year_month, l[1]
                tbl[year_month][l[0]] = l[1]

df = pd.DataFrame(tbl)

df.to_csv('os-table-cpus.csv')


