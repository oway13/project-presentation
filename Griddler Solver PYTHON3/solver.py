import griddler

#Input: List of 0/1 integers
#Returns: String of 0/1 integers
def toBin(intlist):
    return ''.join(str(e) for e in intlist)

def bw_or(common, old):
    strlen = len(common)
    orlist = int(common, 2)|int(old, 2)
    b_or = bin(orlist)
    return b_or.zfill(strlen)

#Input: list of int lists of equal length
#Process: Converts each list to a binary string,
#         then bitwise-ANDs them to find the common bits
#Returns: bit string of common bits
def common(intlistlist):
    comlist = int(toBin(intlistlist[0]), 2)
    strlen = len(intlistlist[0])
    for bitstring in intlistlist:
        bint = int(toBin(bitstring), 2)
        comlist = bint & comlist
    comlist = bin(comlist)
    return comlist.zfill(strlen)

#Inputs: matchlist: list of positions that all intlists must have set
#        intlist: Single intlist to match against
#Returns: Boolean, whether or not they match
def match(matchlist, intlist):
    match = int(toBin(matchlist), 2)
    qint = int(toBin(intlist), 2)
    return match & qint == match

#Input: Int
#Returns: Int's Bitstring
def bin(s):
    return str(s) if s<=1 else bin(s>>1) + str(s&1)

#https://stackoverflow.com/questions/39192777/how-to-split-a-list-into-n-groups-in-all-possible-combinations-of-group-length-a
def sorted_k_partitions(seq, k):
    """Returns a list of all unique k-partitions of `seq`.

    Each partition is a list of parts, and each part is a tuple.

    The parts in each individual partition will be sorted in shortlex
    order (i.e., by length first, then lexicographically).

    The overall list of partitions will then be sorted by the length
    of their first part, the length of their second part, ...,
    the length of their last part, and then lexicographically.
    """
    n = len(seq)
    groups = []  # a list of lists, currently empty

    def generate_partitions(i):
        if i >= n:
            yield list(map(tuple, groups))
        else:
            if n - i > k - len(groups):
                for group in groups:
                    group.append(seq[i])
                    yield from generate_partitions(i + 1)
                    group.pop()

            if len(groups) < k:
                groups.append([seq[i]])
                yield from generate_partitions(i + 1)
                groups.pop()

    result = generate_partitions(0)

    # Sort the parts in each partition in shortlex order
    result = [sorted(ps, key = lambda p: (len(p), p)) for ps in result]
    # Sort partitions by the length of each part, then lexicographically.
    result = sorted(result, key = lambda ps: (*map(len, ps), ps))

    intlistlist = []
    for i in result:
        if i not in intlistlist:
            intlistlist.append(i)

    return intlistlist

#Input: listlen: Total length of list to work within
#       intreqs: ordered list for order and length of runs
#Returns: list of lists with proper order and length of runs
def intlist_gen(listlen, intreqs):
    intlistlist = []
    blanks = listlen - sum(intreqs)
    zeros = blanks
    betweens = len(intreqs) - 1

    #If multiple, but only one possible value
    if blanks == betweens:
        intlist = []
        for i in range(len(intreqs)):
            for j in range(intreqs[i]):
                intlist.append(1)
            intlist.append(0)
        intlist.pop()
        intlistlist.append(intlist)
    #If one, but only one possible value
    elif blanks == 0 and betweens == 0:
        intlist = []
        for i in range(intreqs[0]):
            intlist.append(1)
        intlistlist.append(intlist)
    #If one, but many possible values
    elif betweens == 0 and not blanks == 0:
        for i in range(blanks+1):
            intlist = []
            b_used = 0
            for j in range(i):
                intlist.append(0)
                b_used += 1
            for k in range(intreqs[0]):
                intlist.append(1)
            for l in range(blanks - b_used):
                intlist.append(0)
            intlistlist.append(intlist)
    #If multiple, but many possible values
    else:
        #For each run in the list of runs
        for run_num in range(len(intreqs)+1):
            intlist = []
            b_remains = blanks - betweens
            #If we are past runs, put runs that we are past first
            if not run_num == 0:
                for prev_runs in range(run_num):
                    #Put Ones for length of run
                    for ones in range(intreqs[prev_runs]):
                        intlist.append(1)
                    intlist.append(0)
            #Put remaining zeros before this run
            for all_zeros in range(b_remains):
                intlist.append(0)
            #Put remaining runs in the list of runs
            for rem_runs in range(run_num, len(intreqs)):
                #Put Ones for length of run
                for ones in range(intreqs[rem_runs]):
                    intlist.append(1)
                intlist.append(0)
            if intlist[-1] == 0:
                intlist.pop()
            intlistlist.append(intlist)
        #Generate the rest of the combinations
        #For comb each z_comb
        holes = len(intreqs) + 1
        z_inter_list = [0 for _ in range(zeros)]
        z_combs = sorted_k_partitions(z_inter_list, holes)
        if not zeros < holes:
            for hole in range(holes):
            #For comb each z_comb
                for comb in z_combs:
                    intlist = []
                    #For each 0 run in one comb
                    for z_run in range(len(comb)):
                        used_run = (z_run+hole)%holes
                        #Add that many zeros to the list
                        intlist.extend([0 for _ in range(len(comb[used_run]))])
                        #For each 1 run in intreqs
                        if not z_run == len(intreqs):
                            #Add that many ones to the list
                            intlist.extend([1 for _ in range(intreqs[z_run])])
                    intlistlist.append(intlist)
        z_combs_less = sorted_k_partitions(z_inter_list, holes-1)
        for hole in range(holes):
            for comb in z_combs_less:
                intlist = []
                #For each 0 run in one comb
                for z_run in range(len(comb)):
                    used_run = (z_run+hole)%(holes-1)
                    #Add that many zeros to the list
                    intlist.extend([0 for _ in range(len(comb[used_run]))])
                    #For each 1 run in intreqs
                    if not z_run == len(intreqs):
                        #Add that many ones to the list
                        intlist.extend([1 for _ in range(intreqs[z_run])])
                intlistlist.append(intlist)
        for hole in range(holes):
            for comb in z_combs_less:
                intlist = []
                #For each 0 run in one comb
                for z_run in range(len(comb)):
                    used_run = (z_run+hole)%(holes-1)
                    #Add that many zeros to the list
                    intlist.extend([0 for _ in range(len(comb[used_run]))])
                    #For each 1 run in intreqs
                    if not z_run == len(intreqs):
                        #Add that many ones to the list
                        intlist.extend([1 for _ in range(intreqs[z_run])])
                intlistlist.append(intlist)
    return intlistlist

#Inputs: matchlist: list of positions that all intlists must have set
#        intlistlist: list of generated intlists that haven't been filtered
#Returns: list of intlists with non-matching intlists removed
def remove_nonmatches(matchlist, intlistlist):
    filtered_intlistlist = []
    for intlist in intlistlist:
        if match(matchlist, intlist):
            filtered_intlistlist.append(intlist)
    return filtered_intlistlist

#Inputs: intlist: list of 0/1 integers, 
#        intreqs: ordered list for order and length of runs
#Process: generates list of all possible bit strings that match requirements,
#         that also matches bits that are already there. Then calls common to
#         find the bits that are common to all bit strings. These are ones we
#         know are correct.
#Returns: list of 0/1 integers, hopefully partially solved, but not all will be
def partial_solve_array(intlist, intreqs):
    intlistlist = intlist_gen(len(intlist), intreqs)
    if intlistlist == []:
        return intlist
    print("Intlistlist before filtering: ", intlistlist)
    intlistlist = remove_nonmatches(intlist, intlistlist)
    if intlistlist == []:
        return intlist
    print("Intlistlist before calling common: "+str(intlistlist))
    commonbits = common(intlistlist)
    print(commonbits)
    return commonbits

def partial_solve_gridd(griddler):
    for row in range(griddler.get_rows()):
        oldrow = griddler.get_row_gridd(row)
        newrow = partial_solve_array(oldrow, griddler.get_row_reqs(row))
        griddler.set_row_gridd(row, list(newrow))
    for col in range(griddler.get_cols()):
        oldcol = griddler.get_col_gridd(col)
        newcol = partial_solve_array(oldcol, griddler.get_col_reqs(col))
        griddler.set_col_gridd(col, list(newcol))

def example_commands():
    pear = griddler.Griddler("pear_small_unsolved.gridd")
    peach = pear
    partial_solve_gridd(pear)
    # while(not pear == peach):
    for i in range(10):
        peach = pear
        partial_solve_gridd(pear)
    pear.save_to_file()

example_commands()

