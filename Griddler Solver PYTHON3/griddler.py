import ast
import numpy as np

class Griddler:
    solved = False
    def __init__(self, gridd_file):
        with open(gridd_file, 'r') as f:
            dimensions = ast.literal_eval(f.readline())
            row_reqs = ast.literal_eval(f.readline())
            col_reqs = ast.literal_eval(f.readline())
            gridd = f.readline()
            self.rows = dimensions[0]
            self.cols = dimensions[1]
            self.row_reqs = row_reqs
            self.col_reqs = col_reqs
            self.name = gridd_file
            if gridd:
                self.gridd = ast.literal_eval(gridd)
            else:
                self.gridd = np.zeros((self.rows, self.cols), dtype=np.int)
            
    def save_to_file(self):
        if not self.solved:
            newname = self.name.replace("unsolved", "startsolved")
        else:
           newname = self.name.replace("unsolved", "solved") 
        with open(newname, 'w') as f:
            dimensions = [self.rows, self.cols]
            f.write(str(dimensions) + "\n")
            f.write(str(self.row_reqs) + "\n")
            f.write(str(self.col_reqs) + "\n")
            f.write(str(self.gridd)+ "\n")
    
    def get_gridd(self):
        return self.gridd

    def get_rows(self):
        return self.rows

    def get_cols(self):
        return self.cols

    def set_row_gridd(self, index, intlist):
        self.gridd[index] = intlist

    def set_col_gridd(self, index, intlist):
        self.gridd.T[index] = intlist

    def get_row_gridd(self, index):
        return self.gridd[index]

    def get_row_gridd_as_bin(self, index):
        return ''.join(str(e) for e in self.gridd[index])
    
    def get_row_reqs(self, index):
        return self.row_reqs[index]

    def get_col_gridd(self, index):
        return self.gridd.T[index]

    def get_col_gridd_as_bin(self, index):
        return ''.join(str(e) for e in self.gridd.T[index])

    def get_col_reqs(self, index):
        return self.col_reqs[index]

    def mark_solved(self):
        self.solved = True
        self.save_to_file()
    
    def __eq__(self, other):
        return np.array_equal(self.get_gridd(), other.get_gridd())

