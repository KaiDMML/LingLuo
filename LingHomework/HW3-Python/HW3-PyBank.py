import os
import csv

def T1():
   # Path to collect data from the Resources folder
   Budget_dataCSV = os.path.join('/Users/luoling/Desktop/gitclone/NUCHI201807DATA2/Homework/03-Python/Instructions/PyBank/Resources', 'budget_data.csv')
   month_dict = dict()
   with open(Budget_dataCSV, newline="") as csvfile:
      csvreader = csv.reader(csvfile, delimiter=",")
      csv_header = next(csvfile)
      # print(f"Header: {csv_header}")
      for row in csvreader:

         date_str = row[0]
         revenue_str = row[1]
         date1 = date_str.split('-')[0]
         # print (date1)
         if date1 in month_dict:
            cur = month_dict[date1]
            cur += 1
            month_dict[date1] = cur
         else:
            month_dict[date1] = 1
   month = month_dict.keys()

   print("Total month:" + " "+ str(len(month)))


def total(numlist):
   theTotal = 0
   for i in numlist:
      theTotal= theTotal + i
   return theTotal

def T2():
   # Path to collect data from the Resources folder
   Budget_dataCSV = os.path.join(
      '/Users/luoling/Desktop/gitclone/NUCHI201807DATA2/Homework/03-Python/Instructions/PyBank/Resources',
      'budget_data.csv')
   month_dict = dict()
   with open(Budget_dataCSV, newline="") as csvfile:
      csvreader = csv.reader(csvfile, delimiter=",")
      csv_header = next(csvfile)
      # print(f"Header: {csv_header}")
      num_list = []
      for row in csvreader:
         date_str = row[0]
         revenue_str = row[1]
         num_list.append(float(revenue_str))

      #Call total function
      res = total(num_list)
      print('the total revenue :' + str(res))


def AvgChange(num_list):
   MonthsChange = []
   for i in range(1,len(num_list)):
      cur_revenue = num_list[i]
      prev_revenue = num_list[i-1]
      change = cur_revenue-prev_revenue
      MonthsChange.append(change)

   avg_change = float(sum(MonthsChange))/float(len(MonthsChange))
   return avg_change

def T3():
   # Path to collect data from the Resources folder
   Budget_dataCSV = os.path.join(
      '/Users/luoling/Desktop/gitclone/NUCHI201807DATA2/Homework/03-Python/Instructions/PyBank/Resources',
      'budget_data.csv')
   month_dict = dict()
   with open(Budget_dataCSV, newline="") as csvfile:
      csvreader = csv.reader(csvfile, delimiter=",")
      csv_header = next(csvfile)
      # print(f"Header: {csv_header}")
      num_list = []
      for row in csvreader:
         date_str = row[0]
         revenue_str = row[1]
         num_list.append(float(revenue_str))
           # call AvgChange
      avg= AvgChange(num_list)
      print('Average  Change :' + str(avg))

def AvgChange1(num_list):
   MonthsChange = []
   for i in range(1,len(num_list)):
      cur_revenue = num_list[i]
      prev_revenue = num_list[i-1]
      change = cur_revenue-prev_revenue
      MonthsChange.append(change)

   avg_change = float(sum(MonthsChange))/float(len(MonthsChange))
   return MonthsChange
def T4():
   # Path to collect data from the Resources folder
   Budget_dataCSV = os.path.join(
      '/Users/luoling/Desktop/gitclone/NUCHI201807DATA2/Homework/03-Python/Instructions/PyBank/Resources',
      'budget_data.csv')
   month_dict = dict()
   with open(Budget_dataCSV, newline="") as csvfile:
      csvreader = csv.reader(csvfile, delimiter=",")
      csv_header = next(csvfile)
      num_list = []
      for row in csvreader:
         date_str = row[0]
         revenue_str = row[1]
         num_list.append(float(revenue_str))
         # call AvgChange1 and sort
      avg1 = AvgChange1(num_list)
      avg1.sort()
      print('largest decrease:',avg1[0])





T1()
T2()
T3()
T4()












