import os
import csv
def T1():
    # Path to collect data from the Resources folder
    electionDataCSV = os.path.join(
        '/Users/luoling/Desktop/gitclone/NUCHI201807DATA2/Homework/03-Python/Instructions/PyPoll/Resources',
        'election_data.csv')

    with open(electionDataCSV, newline="") as csvfile:
        csvreader = csv.reader(csvfile, delimiter=",")
        csv_header = next(csvfile)
        records = []
        for row in csvreader:
            Voter_id = row[0]
            records.append(Voter_id)

            county = row[1]
            Candidate = row[2]

        print("total voters:"+str(len(records)))

T1()

def T2():
    # Path to collect data from the Resources folder
    electionDataCSV = os.path.join(
        '/Users/luoling/Desktop/gitclone/NUCHI201807DATA2/Homework/03-Python/Instructions/PyPoll/Resources',
        'election_data.csv')
    candidates_voter = dict()
    total = 0
    with open(electionDataCSV, newline="") as csvfile:
        csvreader = csv.reader(csvfile, delimiter=",")
        csv_header = next(csvfile)
        for row in csvreader:
            Voter_id = row[0]
            county = row[1]
            Candidate = row[2]
            if Candidate in candidates_voter:
                voter = candidates_voter[Candidate]
                voter += 1
                candidates_voter[Candidate] = voter
            else:
                candidates_voter[Candidate] = 1
            total += 1
    voterid = list(candidates_voter.values())
    index = voterid.index(max(voterid))
    print(total)
    for can, v in candidates_voter.items():
        print(can+":" + str(float(v)/float(total)))
    cand = list(candidates_voter.keys())
    print("Winner:"+ cand[index])

T2()




